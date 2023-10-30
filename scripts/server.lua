local Framework = require 'framework.server'

lib.callback.register('cad-drugsales:getCops', function(source)
    return Framework:GetCops() or 0
end)

RegisterNetEvent('cad-drugsales:initiatedrug', function(data)
	local src = source
	local price = data.price * data.amt
	if Config.GiveBonusOnPolice then
		price = Framework:GetCopBonus(price)
	end
	price = math.floor(price)
	local item = tostring(data.item)
	if Framework:RemoveItem(src, item, data.amt) then
		Framework:AddMoney(src, "cash", price)
		TriggerClientEvent('cad-drugsales:notify', src, 'You recieved $' .. price)
		if Config.Debug then print('You got ' .. data.amt .. ' ' .. data.item .. ' for $' .. price) end
	else
		TriggerClientEvent('cad-drugsales:notify', src, 'You could not sell ' .. data.item .. ' (not enough item)')
	end
end)