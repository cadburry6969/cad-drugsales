local Framework = {}

if Config.Framework == 'qb' then
    local QBCore = exports['qb-core']:GetCoreObject()

    function Framework:GetCops()
        local amount = 0
        for _, v in pairs(QBCore.Functions.GetPlayers()) do
            local Player = QBCore.Functions.GetPlayer(v)
            if Player ~= nil then
                if Player.PlayerData.job.name == "police" and Player.PlayerData.job.onduty then
                    amount = amount + 1
                end
            end
        end
        return amount
    end

    function Framework:GetCopBonus(price)
        local copsamount = Framework:GetCops()
        if copsamount > 0 and copsamount < 3 then
			price = price * 1.2
		elseif copsamount >= 3 and copsamount <= 6 then
			price = price * 1.5
		elseif copsamount >= 7 then
			price = price * 2.0
		end
        return price
    end

    function Framework:AddMoney(source, type, amount, reason)
        local player = QBCore.Functions.GetPlayer(source)
        if not player then return false end
        return player.Functions.AddMoney(type, amount, reason)
    end

    function Framework:RemoveMoney(source, type, amount, reason)
        local player = QBCore.Functions.GetPlayer(source)
        if not player then return false end
        return player.Functions.RemoveMoney(type, amount, reason)
    end
end

if Config.Framework == 'esx' then
    local ESX = exports.es_extended:getSharedObject()

    function Framework:GetCops()
        local amount = 0
        for _, v in pairs(ESX.GetPlayers()) do
            local player = ESX.GetPlayerFromId(v)
            if player then
                if player.job.name == "police" then
                    amount = amount + 1
                end
            end
        end
        return amount
    end

    function Framework:GetCopBonus(price)
        local copsamount = Framework:GetCops()
        if copsamount > 0 and copsamount < 3 then
			price = price * 1.2
		elseif copsamount >= 3 and copsamount <= 6 then
			price = price * 1.5
		elseif copsamount >= 7 and copsamount <= 10 then
			price = price * 2.0
		end
        return price
    end

    function Framework:AddMoney(source, type, amount, reason)
        local player = ESX.GetPlayerFromId(source)
        if not player then return false end
        player.addMoney(amount)
        return true
    end

    function Framework:RemoveMoney(source, type, amount, reason)
        local player = ESX.GetPlayerFromId(source)
        if not player then return false end
        if player.getAccount('cash').money < amount then return false end
        player.removeMoney(amount)
        return true
    end
end

if Config.Inventory == 'ox' then
    function Framework:AddItem(source, item, amount)
        return exports.ox_inventory:AddItem(source, item, amount)
    end

    function Framework:RemoveItem(source, item, amount)
        return exports.ox_inventory:RemoveItem(source, item, amount)
    end
end

if Config.Inventory == 'qb' then
    function Framework:AddItem(source, item, amount)
        exports['qb-inventory']:AddItem(source, item, amount)
    end

    function Framework:RemoveItem(source, item, amount)
        return exports['qb-inventory']:RemoveItem(source, item, amount)
    end
end

if Config.Inventory == 'ps' then
    function Framework:AddItem(source, item, amount)
        exports['ps-inventory']:AddItem(source, item, amount)
    end

    function Framework:RemoveItem(source, item, amount)
        return exports['ps-inventory']:RemoveItem(source, item, amount)
    end
end

return Framework
