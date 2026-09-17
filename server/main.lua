local RESOURCE = GetCurrentResourceName()

local function loadJson(file, fallback)
    local raw = LoadResourceFile(RESOURCE, file)
    if not raw or raw == '' then return fallback end
    local ok, decoded = pcall(json.decode, raw)
    return (ok and type(decoded) == 'table') and decoded or fallback
end

local function saveJson(file, tbl)
    SaveResourceFile(RESOURCE, file, json.encode(tbl), -1)
end

local notes  = loadJson('blackmarket_notes.json', {})
local stages = loadJson('blackmarket_stages.json', {})
local orders = loadJson('blackmarket_orders.json', {})

local function saveNotes()  saveJson('blackmarket_notes.json', notes) end
local function saveStages() saveJson('blackmarket_stages.json', stages) end
local function saveOrders() saveJson('blackmarket_orders.json', orders) end

local function digits(v)
    return (tostring(v or '')):gsub('%D', '')
end

local function normalizedNumber(v)
    local d = digits(v)
    if #d == 11 and d:sub(1, 1) == '0' then d = d:sub(2) end
    return d
end

local function formatUkNumber(v)
    local d = digits(v)
    if #d ~= 10 then return d end
    return ('0%s %s'):format(d:sub(1, 4), d:sub(5))
end

local function isVetted(cid)
    return stages[cid] == true
end

local function randomPhrase()
    local pool = Config.stickyNote.phrases
    return pool[math.random(1, #pool)]
end

local function newNoteId()
    return ('note_%08x_%04x'):format(os.time(), math.random(0, 0xffff))
end

local function reply(playerNumber, body)
    if not playerNumber or playerNumber == '' then return end
    local delayCfg = Config.conversation.replyDelay or {}
    local minMs = tonumber(delayCfg.min) or 5000
    local maxMs = tonumber(delayCfg.max) or 20000
    local longChance = tonumber(delayCfg.longPauseChance) or 0
    local longMin = tonumber(delayCfg.longMin) or minMs
    local longMax = tonumber(delayCfg.longMax) or maxMs
    local delay
    if longChance > 0 and math.random() < longChance then
        delay = math.random(longMin, longMax)
    else
        delay = math.random(minMs, maxMs)
    end
    CreateThread(function()
        Wait(delay)
        exports['sd-phone']:sendSystemMessage(Config.dealer.number, Config.dealer.name, playerNumber, body)
    end)
end

local function sendDropLocation(playerNumber, order)
    exports['sd-phone']:sendLocation(Config.dealer.number, Config.dealer.name, playerNumber,
        order.coords.x, order.coords.y, {
            label = 'Drop point',
            icon  = 'MapPin',
            color = '#e5484d',
            body  = 'Here. Don\'t hang about.',
        })
end

local function catalogSummary()
    local parts = {}
    for _, entry in ipairs(Config.catalog) do
        parts[#parts + 1] = ('%s - $%d'):format(entry.label, entry.price)
    end
    return table.concat(parts, '  |  ')
end

local function matchCatalogItem(body)
    local lower = body:lower()
    for _, entry in ipairs(Config.catalog) do
        if lower:find(entry.id, 1, true) or lower:find(entry.label:lower(), 1, true) then
            return entry
        end
        if entry.aliases then
            for _, alias in ipairs(entry.aliases) do
                if lower:find(alias:lower(), 1, true) then return entry end
            end
        end
    end
    return nil
end

local function parseQuantity(body)
    local n = tonumber(body:match('%d+'))
    if not n then return 1 end
    n = math.floor(n)
    if n < 1 then return 1 end
    local cap = Config.order.maxQuantity or 10
    return n > cap and cap or n
end

local function findUnredeemedPhraseMatch(body)
    local lower = body:lower()
    for noteId, note in pairs(notes) do
        if not note.redeemed then
            local key = note.name or note.phrase
            if key and lower:find(key:lower(), 1, true) then
                return noteId
            end
        end
    end
    return nil
end

local function ensureNoteMeta(source, slot)
    local meta = BMBridge.getSlotMetadata(source, slot)
    if meta and meta.bmNoteId and notes[meta.bmNoteId] then
        local note = notes[meta.bmNoteId]

        if slot and not meta.description then
            meta.description = ('%s\n"%s"'):format(formatUkNumber(Config.dealer.number), note.phrase)
            BMBridge.setSlotMetadata(source, slot, meta)
        end
        return meta.bmNoteId, note.phrase
    end

    local noteId = newNoteId()
    local entry  = randomPhrase()
    notes[noteId] = { phrase = entry.text, name = entry.name, redeemed = false }
    saveNotes()

    if slot then
        local merged = meta or {}
        merged.bmNoteId = noteId

        merged.description = ('%s\n"%s"'):format(formatUkNumber(Config.dealer.number), entry.text)
        BMBridge.setSlotMetadata(source, slot, merged)
    end

    return noteId, entry.text
end

BMBridge.registerNoteUsable(function(source, slot)
    local cid = BMBridge.getIdentifier(source)
    if not cid then return end

    local _, phrase = ensureNoteMeta(source, slot)

    if Config.stickyNote.consumeOnUse or not slot then
        BMBridge.removeItem(source, Config.stickyNote.item, 1)
    end

    TriggerClientEvent('as_blackmarket:client:notify', source, {
        number = formatUkNumber(Config.dealer.number),
        phrase = phrase,
    })
end)

local wrongPhraseCooldown = {}
local nextOrderAllowedAt  = {}

local function handleVettingMessage(cid, playerNumber, body)
    local now = GetGameTimer()
    if wrongPhraseCooldown[cid] and now < wrongPhraseCooldown[cid] then return end

    local matchedNoteId = findUnredeemedPhraseMatch(body)
    if matchedNoteId then
        notes[matchedNoteId].redeemed   = true
        notes[matchedNoteId].redeemedBy = cid
        notes[matchedNoteId].redeemedAt = os.time()
        saveNotes()

        stages[cid] = true
        saveStages()

        reply(playerNumber, Config.conversation.vettedIntro .. ' ' .. catalogSummary())
    else
        wrongPhraseCooldown[cid] = now + Config.conversation.wrongPhraseCooldownMs
        local lines = Config.conversation.strangerReplies
        reply(playerNumber, lines[math.random(1, #lines)])
    end
end

local function handleOrderMessage(source, cid, playerNumber, body)
    if orders[cid] then
        reply(playerNumber, BMT('alreadyHaveOrder'))
        return
    end

    local now = os.time()
    if nextOrderAllowedAt[cid] and now < nextOrderAllowedAt[cid] then
        reply(playerNumber, BMT('orderCooldown'))
        return
    end

    local entry = matchCatalogItem(body)
    if not entry then
        reply(playerNumber, Config.conversation.vettedFallback)
        return
    end

    nextOrderAllowedAt[cid] = now + math.floor(Config.order.cooldownMs / 1000)

    local quantity = parseQuantity(body)
    local displayLabel = quantity > 1 and ('%dx %s'):format(quantity, entry.label) or entry.label
    local spot = Config.order.dropSpots[math.random(1, #Config.order.dropSpots)]
    local order = {
        citizenid    = cid,
        source       = source,
        playerNumber = playerNumber,
        itemId       = entry.id,
        label        = entry.label,
        displayLabel = displayLabel,
        item         = entry.item,
        price        = entry.price * quantity,
        quantity     = quantity,
        coords       = { x = spot.x, y = spot.y, z = spot.z },
        createdAt    = now,
        expiresAt    = now + Config.order.expirySeconds,
    }
    orders[cid] = order
    saveOrders()

    reply(playerNumber, BMT('orderConfirmed', displayLabel))
    sendDropLocation(playerNumber, order)

    TriggerClientEvent('as_blackmarket:client:order', source, {
        itemId = order.itemId, label = displayLabel, price = order.price,
        coords = order.coords, expiresAt = order.expiresAt,
    })
end

AddEventHandler('sd-phone:server:messages:sent', function(payload)
    if type(payload) ~= 'table' then return end
    if payload.system or payload.group then return end
    if payload.targetCitizenid then return end
    if payload.kind ~= 'text' then return end
    if normalizedNumber(payload.targetNumber) ~= normalizedNumber(Config.dealer.number) then return end

    local source = payload.source

    local cid = source and BMBridge.getIdentifier(source)
    local playerNumber = payload.senderNumber
    if not cid or not source or not playerNumber then return end

    local body = tostring(payload.body or '')
    if body == '' then return end

    if isVetted(cid) then
        handleOrderMessage(source, cid, playerNumber, body)
    else
        handleVettingMessage(cid, playerNumber, body)
    end
end)

local function chargePlayer(source, price)
    if price <= 0 then return true end
    if Config.payment.mode == 'item' then
        if BMBridge.getItemCount(source, Config.payment.cashItem) < price then return false end
        return BMBridge.removeItem(source, Config.payment.cashItem, price)
    end
    local balance = BMBridge.getBalance(source, Config.payment.account)
    if balance ~= nil and balance < price then return false end
    return BMBridge.removeMoney(source, Config.payment.account, price)
end

lib.callback.register('as_blackmarket:getOrder', function(source)
    local cid = BMBridge.getIdentifier(source)
    local order = cid and orders[cid]
    if not order then return nil end
    return { itemId = order.itemId, label = order.displayLabel or order.label, price = order.price,
             coords = order.coords, expiresAt = order.expiresAt }
end)

lib.callback.register('as_blackmarket:collect', function(source)
    local cid = BMBridge.getIdentifier(source)
    local order = cid and orders[cid]
    if not order then return { ok = false, error = BMT('collectNoOrder') } end

    local ped = GetPlayerPed(source)
    local pos = (ped and ped ~= 0) and GetEntityCoords(ped) or nil
    if not pos then return { ok = false, error = BMT('collectNoOrder') } end

    local dropVec = vector3(order.coords.x, order.coords.y, order.coords.z)
    if #(pos - dropVec) > Config.order.collectDistance then
        return { ok = false, error = BMT('collectTooFar') }
    end

    if not chargePlayer(source, order.price) then
        return { ok = false, error = BMT('collectNotEnoughCash') }
    end

    BMBridge.addItem(source, order.item, order.quantity or 1)
    orders[cid] = nil
    saveOrders()

    return { ok = true }
end)

CreateThread(function()
    while true do
        Wait(5000)
        local now = os.time()
        local changed = false
        for cid, order in pairs(orders) do
            if now > order.expiresAt then
                orders[cid] = nil
                changed = true
                reply(order.playerNumber, BMT('orderExpiredNotice'))
                if order.source then
                    TriggerClientEvent('as_blackmarket:client:orderCleared', order.source)
                end
            end
        end
        if changed then saveOrders() end
    end
end)
