local Framework = {}

if Config.Framework == 'qb' then
    local QBCore = exports['qb-core']:GetCoreObject()
    local PlayerData = QBCore.Functions.GetPlayerData()

    function Framework:Notify(text)
        return QBCore.Functions.Notify(text)
    end

    function Framework:GetCurrentJob()
        return PlayerData.job
    end

    RegisterNetEvent('QBCore:Player:SetPlayerData', function(val)
        PlayerData = val
    end)

    if Config.Inventory ~= 'ox' then
        function Framework:GetItemLabel(item)
            return QBCore.Shared.Items[item]['label'] or 'Unknown'
        end

        function Framework:GetItemCount(item)
            local amount = 0
            for _, v in pairs(PlayerData.items) do
                if v.name == item then
                    amount = v.amount
                    break
                end
            end
            return amount
        end
    end
end

if Config.Framework == 'esx' then
    local ESX = exports.es_extended:getSharedObject()

    function Framework:Notify(text)
        ESX.ShowNotification(text, 'success', 3000)
    end

    function Framework:GetCurrentJob()
        local playerData = ESX.GetPlayerData()
        return playerData.job
    end
end

if Config.Inventory == 'ox' then
    local items = exports.ox_inventory:Items()

    function Framework:GetItemLabel(item)
        return items[item].label or 'Unknown'
    end

    function Framework:GetItemCount(item)
		return exports.ox_inventory:Search('count', item)
    end
end

if Config.Target == 'ox' then
    function Framework:AddGlobalPed(options)
        exports.ox_target:addGlobalPed(options)
    end

    function Framework:AddGlobalVehicle(options)
        exports.ox_target:addGlobalVehicle(options)
    end

    function Framework:RemoveGlobalPed(optionNames)
        exports.ox_target:removeGlobalPed(optionNames)
    end

    function Framework:RemoveGlobalVehicle(optionNames)
        exports.ox_target:removeGlobalVehicle(optionNames)
    end
end

if Config.Target == 'qb' then
    function Framework:AddGlobalPed(options)
        exports['qb-target']:AddGlobalPed({
            options = options,
            distance = 4,
        })
    end

    function Framework:AddGlobalVehicle(options)
        exports['qb-target']:AddGlobalVehicle({
			options = options,
			distance = 4,
		})
    end

    function Framework:RemoveGlobalPed(optionNames)
        exports['qb-target']:RemoveGlobalPed(optionNames)
    end

    function Framework:RemoveGlobalVehicle(optionNames)
        exports['qb-target']:RemoveGlobalVehicle(optionNames)
    end
end

if not Config.Target then
    function Framework:DrawText3D(x, y, z, text)
        local _, _x, _y=World3dToScreen2d(x,y,z)
		SetTextScale(0.35, 0.35)
		SetTextFont(4)
		SetTextProportional(1)
		SetTextColour(255, 255, 255, 215)
		SetTextEntry("STRING")
		SetTextCentre(1)
		AddTextComponentString(text)
		DrawText(_x,_y)
		local factor = (string.len(text)) / 370
		DrawRect(_x,_y+0.0125, 0.015+ factor, 0.03, 41, 11, 41, 68)
    end
end

if Config.Radial == 'qb' then
    function Framework:AddRadial()
        exports['qb-radialmenu']:AddOption({
            id = 'caddrugsales',
            title = 'Corner Selling',
            icon = 'cannabis',
            type = 'client',
            event = 'cad-drugsales:toggleselling',
            shouldClose = true
        })
    end
end

if Config.Radial == 'ox' then
    function Framework:AddRadial()
        lib.addRadialItem({
            id = 'caddrugsales',
            label = 'Corner Selling',
            icon = 'cannabis',
            event = 'cad-drugsales:toggleselling'
        })
    end
end

if Config.Dispatch == 'ps' then
    function Framework:PoliceAlert()
        exports['ps-dispatch']:DrugSale()
    end
end

if Config.Dispatch == 'qb' then
    function Framework:PoliceAlert()
        TriggerServerEvent('police:server:policeAlert', 'Drug sale in progress')
    end
end

if Config.Dispatch == 'moz' then
    function Framework:PoliceAlert()
        exports['moz-dispatch']:SuspiciousHandoff()
    end
end

if Config.Dispatch == 'cd' then
    function Framework:PoliceAlert()
        local data = exports['cd_dispatch']:GetPlayerInfo()
        TriggerServerEvent('cd_dispatch:AddNotification', {
            job_table = { 'police' },
            coords = data.coords,
            title = '10-38 Suspicious Handoff',
            message = 'A '..data.sex..' found with a suspious package at '..data.street,
            flash = 0,
            unique_id = data.unique_id,
            sound = 1,
            blip = {
                sprite = 51,
                scale = 1.2,
                colour = 1,
                flashes = false,
                text = '10-38 Suspicious Handoff',
                time = 5,
                radius = 0,
            }
        })
    end
end

if Config.Dispatch == 'custom' then
    function Framework:PoliceAlert()
        -- add your custom dispatch alert here
    end
end

function Framework:GetSellItems(zone)
    if Config.SellAnywhere then
        return Config.SellItems
    else
        return zone.items
    end
end

function Framework:GetRandomSell(zone)
    if Config.SellAnywhere then
        return Config.RandomSell
    else
        return zone.randomSellAmount
    end
end

return Framework