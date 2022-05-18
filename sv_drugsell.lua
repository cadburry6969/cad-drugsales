local QBCore = exports[Config.Core]:GetCoreObject()

RegisterNetEvent('cad-drugsales:initiatedrug', function(ZoneDrug)	
	local Player = QBCore.Functions.GetPlayer(source)
	if Player then		
		local price = ZoneDrug.price				
		Player.Functions.RemoveItem(ZoneDrug.item, 1)
       	TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items[ZoneDrug.item], "remove", 1)		
		Wait(500) -- Just to make sure the item is removed and them money is provided to the player		
		Player.Functions.AddMoney("cash", price)
		TriggerClientEvent('cad-drugsales:notify', source, 'You recieved $'..price)
		if Config.Debug then print('You got 1 '..ZoneDrug.item..' for $'..price) end
	end
end)
