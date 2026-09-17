BMBridge = {}

local function detectFramework()
    if Config.framework ~= 'auto' then return Config.framework end
    if GetResourceState('qbx_core') == 'started' then return 'qbx' end
    if GetResourceState('qb-core') == 'started' then return 'qb' end
    if GetResourceState('es_extended') == 'started' then return 'esx' end
    return 'standalone'
end

local function detectInventory()
    if Config.inventory ~= 'auto' then return Config.inventory end
    if GetResourceState('ox_inventory') == 'started' then return 'ox_inventory' end
    if GetResourceState('qb-inventory') == 'started' then return 'qb-inventory' end
    return 'ox_inventory'
end

local framework = detectFramework()
local inventory = detectInventory()

local QBCore, qbxExport, ESX

local function ensureCore()
    if framework == 'qb' and not QBCore then
        QBCore = exports['qb-core']:GetCoreObject()
    elseif framework == 'qbx' and not qbxExport then
        qbxExport = exports.qbx_core
    elseif framework == 'esx' and not ESX then
        ESX = exports['es_extended']:getSharedObject()
    end
end

function BMBridge.getIdentifier(source)
    ensureCore()
    if framework == 'qb' and QBCore then
        local Player = QBCore.Functions.GetPlayer(source)
        return Player and Player.PlayerData.citizenid or nil
    elseif framework == 'qbx' and qbxExport then
        local Player = qbxExport:GetPlayer(source)
        return Player and Player.PlayerData.citizenid or nil
    elseif framework == 'esx' and ESX then
        local xPlayer = ESX.GetPlayerFromId(source)
        return xPlayer and xPlayer.identifier or nil
    end

    return source and ('standalone:' .. tostring(source)) or nil
end

function BMBridge.getBalance(source, account)
    ensureCore()
    if framework == 'qb' and QBCore then
        local Player = QBCore.Functions.GetPlayer(source)
        return Player and Player.PlayerData.money[account] or 0
    elseif framework == 'qbx' and qbxExport then
        local Player = qbxExport:GetPlayer(source)
        return Player and Player.PlayerData.money[account] or 0
    elseif framework == 'esx' and ESX then
        local xPlayer = ESX.GetPlayerFromId(source)
        local acc = xPlayer and xPlayer.getAccount(account)
        return acc and acc.money or 0
    end
    return nil
end

function BMBridge.removeMoney(source, account, amount)
    ensureCore()
    if amount <= 0 then return true end
    if framework == 'qb' and QBCore then
        local Player = QBCore.Functions.GetPlayer(source)
        return Player ~= nil and Player.Functions.RemoveMoney(account, amount, 'blackmarket') == true
    elseif framework == 'qbx' and qbxExport then
        local Player = qbxExport:GetPlayer(source)
        return Player ~= nil and Player.Functions.RemoveMoney(account, amount, 'blackmarket') == true
    elseif framework == 'esx' and ESX then
        local xPlayer = ESX.GetPlayerFromId(source)
        if not xPlayer then return false end
        local acc = xPlayer.getAccount(account)
        if not acc or acc.money < amount then return false end
        xPlayer.removeAccountMoney(account, amount)
        return true
    end

    return true
end

function BMBridge.addMoney(source, account, amount)
    ensureCore()
    if amount <= 0 then return true end
    if framework == 'qb' and QBCore then
        local Player = QBCore.Functions.GetPlayer(source)
        if not Player then return false end
        Player.Functions.AddMoney(account, amount, 'blackmarket-refund')
        return true
    elseif framework == 'qbx' and qbxExport then
        local Player = qbxExport:GetPlayer(source)
        if not Player then return false end
        Player.Functions.AddMoney(account, amount, 'blackmarket-refund')
        return true
    elseif framework == 'esx' and ESX then
        local xPlayer = ESX.GetPlayerFromId(source)
        if not xPlayer then return false end
        xPlayer.addAccountMoney(account, amount)
        return true
    end
    return true
end

function BMBridge.getItemCount(source, item)
    if inventory == 'ox_inventory' then
        local ok, count = pcall(function() return exports.ox_inventory:Search(source, 'count', item) end)
        return ok and (count or 0) or 0
    elseif inventory == 'qb-inventory' then
        local ok, it = pcall(function() return exports['qb-inventory']:GetItemByName(source, item) end)
        return ok and it and (it.amount or it.count or 0) or 0
    end
    return 0
end

function BMBridge.addItem(source, item, count)
    count = count or 1
    if inventory == 'ox_inventory' then
        local ok, result = pcall(function() return exports.ox_inventory:AddItem(source, item, count) end)
        return ok and result and true or false
    elseif inventory == 'qb-inventory' then
        local ok = pcall(function() exports['qb-inventory']:AddItem(source, item, count) end)
        return ok
    end
    return false
end

function BMBridge.removeItem(source, item, count)
    count = count or 1
    if inventory == 'ox_inventory' then
        local ok, result = pcall(function() return exports.ox_inventory:RemoveItem(source, item, count) end)
        return ok and result and true or false
    elseif inventory == 'qb-inventory' then
        local ok = pcall(function() exports['qb-inventory']:RemoveItem(source, item, count) end)
        return ok
    end
    return false
end

function BMBridge.getSlotMetadata(source, slot)
    if inventory == 'ox_inventory' and slot then
        local ok, data = pcall(function() return exports.ox_inventory:GetSlot(source, slot) end)
        return ok and data and data.metadata or nil
    end
    return nil
end

function BMBridge.setSlotMetadata(source, slot, metadata)
    if inventory == 'ox_inventory' and slot then
        pcall(function() exports.ox_inventory:SetMetadata(source, slot, metadata) end)
    end
end

function BMBridge.registerNoteUsable(onUse)
    if inventory == 'ox_inventory' then
        AddEventHandler('ox_inventory:usedItem', function(playerId, name, slotId)
            if name == Config.stickyNote.item then onUse(playerId, slotId) end
        end)
    elseif inventory == 'qb-inventory' then
        if GetResourceState('qb-core') == 'started' then
            local QBCoreObj = exports['qb-core']:GetCoreObject()
            QBCoreObj.Functions.CreateUseableItem(Config.stickyNote.item, function(source)
                onUse(source, nil)
            end)
        end
    end
end

return BMBridge
