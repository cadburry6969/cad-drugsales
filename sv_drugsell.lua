local QBCore = exports[Config.Core]:GetCoreObject()

local function GetCops()
	local amount = 0
    local players = QBCore.Functions.GetQBPlayers()
    for k, v in pairs(players) do
        if (v.PlayerData.job.name == "police" or v.PlayerData.job.name == "bcso") and v.PlayerData.job.onduty then
            amount = amount + 1
        end
    end
	return amount
end

QBCore.Functions.CreateCallback('cad-drugsales:server:GetCops', function(source, cb)
    cb(GetCops())
end)

RegisterNetEvent('cad-drugsales:initiatedrug', function(ZoneDrug)	
	local src = source
	local Player = QBCore.Functions.GetPlayer(src)
	if Player then		
		local price = ZoneDrug.price				
		Player.Functions.RemoveItem(ZoneDrug.item, 1)
       	TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[ZoneDrug.item], "remove", 1)				
		-- \ Edit the below code as you wish (only do if you know what you are doing)
		if Config.GiveBonusOnPolice then
			local Cops = GetCops()
			if Cops >= 3 and Cops <= 6 then
				price = price * 1.1
			elseif Cops >= 7 and Cops <= 10 then
				price = price * 1.2            
			end
		end
		Wait(500) -- Just to make sure the item is removed and them money is provided to the player		
		Player.Functions.AddMoney("cash", price)
		TriggerClientEvent('cad-drugsales:notify', src, 'You recieved $'..price)
		if Config.Debug then print('You got 1 '..ZoneDrug.item..' for $'..price) end
	end
end)
