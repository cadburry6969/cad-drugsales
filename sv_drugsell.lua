local QBCore = exports[Config.Core]:GetCoreObject()

QBCore.Functions.CreateCallback('cad-drugsales:server:GetCops', function(source, cb)
    local amount = 0
    local players = QBCore.Functions.GetQBPlayers()
    for k, v in pairs(players) do
        if (v.PlayerData.job.name == "police" or v.PlayerData.job.name == "bcso") and v.PlayerData.job.onduty then
            amount = amount + 1
        end
    end
    cb(amount)
end)

RegisterNetEvent('cad-drugsales:initiatedrug', function(cad)	
	local src = source
	local Player = QBCore.Functions.GetPlayer(src)
	if Player then		
		local ZoneDrug = cad.data
		local price = math.floor(ZoneDrug.price * cad.amt)
		if Player.Functions.GetItemByName(tostring(ZoneDrug.item)) then		
			if Player.Functions.RemoveItem(tostring(ZoneDrug.item), cad.amt) then
				TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[tostring(ZoneDrug.item)], "remove", cad.amt)				
				Player.Functions.AddMoney("cash", price)
				TriggerClientEvent('cad-drugsales:notify', src, 'You recieved $'..price)
				if Config.Debug then print('You got '..cad.amt..' '..ZoneDrug.item..' for $'..price) end
			else				
				TriggerClientEvent('cad-drugsales:notify', src, 'You could not sell your '..ZoneDrug.item..'!')
			end
		else
			TriggerClientEvent('cad-drugsales:notify', src, 'You do not have any '..ZoneDrug.item..' to sell!')
		end		
	end
end)
