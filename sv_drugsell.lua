local QBCore = exports['qb-core']:GetCoreObject()

RegisterServerEvent('cad-drugsales:server:startdeal')
AddEventHandler('cad-drugsales:server:startdeal', function(drugname, amount, drugid)	
	local xPlayer = QBCore.Functions.GetPlayer(source)
	if xPlayer ~= nil then		
		local price = Config.SellingDrugs[drugid].price		
		TriggerClientEvent('QBCore:Notify', source, 'You got $'..price)
		xPlayer.Functions.RemoveItem(drugname, amount)
       		TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items[drugname], "remove")
		Citizen.Wait(1500)		
		xPlayer.Functions.AddMoney("cash", price)
	end
end)
