exports(Config.stickyNote.item, function(data, slot)
    exports.ox_inventory:useItem(data, function() end)
end)

local activeOrder = nil
local dropPed = nil
local TARGET_OPTION = 'sd_blackmarket:collect'

local function ensureDropPed()
    if dropPed and DoesEntityExist(dropPed) then return end
    if not activeOrder or not activeOrder.coords then return end

    local models = Config.order.npcModels
    local model = (models and #models > 0) and models[math.random(1, #models)] or 'a_m_m_skidrow_01'
    model = type(model) == 'string' and joaat(model) or model

    lib.requestModel(model, 5000)
    local coords = activeOrder.coords
    local ped = CreatePed(4, model, coords.x, coords.y, coords.z - 1.0, 0.0, false, false)
    SetEntityAsMissionEntity(ped, true, true)
    FreezeEntityPosition(ped, true)
    SetEntityInvincible(ped, true)
    SetBlockingOfNonTemporaryEvents(ped, true)
    SetPedCanRagdoll(ped, false)
    SetPedDiesWhenInjured(ped, false)
    SetPedCanBeTargetedByPlayer(ped, PlayerId(), false)

    if Config.order.npcScenario and Config.order.npcScenario ~= '' then
        TaskStartScenarioInPlace(ped, Config.order.npcScenario, 0, true)
    end

    SetModelAsNoLongerNeeded(model)
    dropPed = ped

    exports.ox_target:addLocalEntity(dropPed, {
        {
            name = TARGET_OPTION,
            icon = 'fa-solid fa-box',
            label = 'Collect Order',
            distance = 2.0,
            onSelect = function()
                local result = lib.callback.await('sd_blackmarket:collect', false)
                if result and result.ok then
                    lib.notify({ description = BMT('collectSuccess') })
                    activeOrder = nil
                    removeDropPed()
                elseif result then
                    lib.notify({ description = result.error or 'Failed', type = 'error' })
                end
            end,
        },
    })
end

function removeDropPed()
    if dropPed and DoesEntityExist(dropPed) then
        exports.ox_target:removeLocalEntity(dropPed, TARGET_OPTION)
        DeleteEntity(dropPed)
    end
    dropPed = nil
end

RegisterNetEvent('sd_blackmarket:client:order', function(order)
    activeOrder = order
    ensureDropPed()
end)

RegisterNetEvent('sd_blackmarket:client:orderCleared', function()
    activeOrder = nil
    removeDropPed()
    pcall(lib.hideTextUI)
end)

RegisterNetEvent('sd_blackmarket:client:notify', function(data)
    if type(data) ~= 'table' then return end
    SendNUIMessage({
        action   = 'sd_blackmarket:note',
        number   = data.number,
        phrase   = data.phrase,
        duration = 9000,
    })
end)

CreateThread(function()
    while true do
        Wait(15000)
        if not activeOrder then
            local order = lib.callback.await('sd_blackmarket:getOrder', false)
            if order then
                activeOrder = order
                ensureDropPed()
            end
        elseif not (dropPed and DoesEntityExist(dropPed)) then
            ensureDropPed()
        end
    end
end)
