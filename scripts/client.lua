local Framework = require 'framework.client'

-- Locals and tables
local SoldPeds = {}
local CurrentZone = nil
local AllowedTarget = (not Config.ShouldToggleSelling)
local InitiateSellProgress = false

-- Cut shorts the decimalPlaces to given position or else removes them
local function round(num, numDecimalPlaces)
	if not numDecimalPlaces then return math.floor(num + 0.5) end
	return tonumber(string.format("%." .. (numDecimalPlaces or 0) .. "f", num))
end

-- Play five animation for both player and ped
local function playGiveAnim(tped)
	local pid = cache.ped
	lib.requestAnimDict('mp_common')
	FreezeEntityPosition(pid, true)
	TaskPlayAnim(pid, "mp_common", "givetake2_a", 8.0, -8, 2000, 0, 1, 0,0,0)
	TaskPlayAnim(tped, "mp_common", "givetake2_a", 8.0, -8, 2000, 0, 1, 0,0,0)
	FreezeEntityPosition(pid, false)
end

-- Add Old Ped to table
local function addSoldPed(entity)
    SoldPeds[entity] = true
end

-- Check if ped is in table
local function hasSoldPed(entity)
    return SoldPeds[entity] ~= nil
end

local function showSellMenu(ped, item, amt, price)
	InitiateSellProgress = true
	lib.registerMenu({
		id = 'caddrugsales_menu',
		title = ('%dx of %s for %d$'):format(amt, Framework:GetItemLabel(item), round(amt * price, 0)),
		position = 'top-right',
		onClose = function(keyPressed)
			if keyPressed then
				TriggerEvent('cad-drugsales:salesinitiate', { type = 'close', tped = ped })
			end
		end,
		options = {
			{label = 'Accept Offer', args = { type = 'buy', item = item, price = price, amt = amt, tped = ped }},
			{label = 'Decline Offer', args = { type = 'close', tped = ped }},
		}
	}, function(selected, scrollIndex, args)
		TriggerEvent('cad-drugsales:salesinitiate', args)
	end)
	lib.showMenu('caddrugsales_menu')
	SetTimeout(Config.SellTimeout*1000, function()
		if InitiateSellProgress then
			InitiateSellProgress = false
			lib.hideMenu()
			Framework:Notify("You wasted time so the person left")
			SetPedAsNoLongerNeeded(ped)
		end
	end)
end

local function initiateSell(ped)
	if not CurrentZone and not Config.SellAnywhere then return end
	local items = Framework:GetSellItems(CurrentZone)
	if not items then return end
	local randamt = math.random(Config.RandomSell.min, Config.RandomSell.max)
	local itemCount = #items
	local hasSold = false
	for i=1, itemCount, 1 do
		Wait(200) -- don't change this
		local data = items[math.random(1, #items)]
		local amount = Framework:GetItemCount(data.item)
		local price = data.price
		if amount then
			if amount > 0 then
				if randamt > amount then randamt = amount end
				hasSold = true
				showSellMenu(ped, data.item, randamt, price)
				break
			end
		end
	end
	if not hasSold then
		SetPedAsNoLongerNeeded(ped)
		Framework:Notify('Person was interested to buy, but you dint have enough to sell!')
		if Config.Debug then print('You dont have anything to sell') end
	end
end

-- Interact with the ped
local function InteractPed(ped)
	local Playerjob = Framework:GetCurrentJob()
	SetEntityAsMissionEntity(ped, true, true)
	TaskTurnPedToFaceEntity(ped, cache.ped, Config.SellTimeout*1000)
	Wait(500)
	if Playerjob.name == 'police' then
		Framework:Notify('Locals hate cops!')
		SetPedAsNoLongerNeeded(ped)
		if Config.Debug then print('Police Not allowed') end
		return
	end
	local percent = math.random(1, 100)
	if percent < Config.ChanceSell then
		initiateSell(ped)
	else
		if Config.Debug then print('Police has been notified') end
		Framework:Notify('The buyer is calling the police!')
		TaskUseMobilePhoneTimed(ped, 8000)
		Framework:PoliceAlert()
		SetPedAsNoLongerNeeded(ped)
	end
end

-- Initialize the drug sales
local function initiateSales(entity)
	local count = lib.callback.await('cad-drugsales:getCops', false)
	if count < Config.MinimumCops then
		Framework:Notify('Buyer is not interested to buy now!')
		if Config.Debug then print('Not Enough Cops') end
	else
		local netId = NetworkGetNetworkIdFromEntity(entity)
		local isSoldtoPed = hasSoldPed(netId)
		if isSoldtoPed then Framework:Notify('You already spoke with this local') return false end
		addSoldPed(netId)
		InteractPed(entity)
		if Config.Debug then print('Drug Sales Initiated now proceding to interact') end
	end
end

-- Blacklist Ped Models
local function isPedBlacklisted(ped)
	local model = GetEntityModel(ped)
	for i = 1, #Config.BlacklistPeds do
		if model == GetHashKey(Config.BlacklistPeds[i]) then
			return true
		end
	end
	return false
end

local function canTarget(entity)
	if not CurrentZone and not Config.SellAnywhere then return false end
	local isVehicle = Config.SellPedOnVehicle or not IsPedInAnyVehicle(entity, false)
	if not IsPedDeadOrDying(entity, false) and isVehicle and (GetPedType(entity)~=28) and (not IsPedAPlayer(entity)) and (not isPedBlacklisted(entity)) and not IsPedInAnyVehicle(cache.ped, false) then
		return true
	end
end

-- Sell Drugs to peds inside the sellzone
local function createTarget()
	Framework:AddGlobalPed({
		{
			name = 'drugTalkPed',
			label = 'Talk',
			icon = 'fas fa-comments',
			distance = 4,
			-- for 'qb-target'
			action = function(entity)
				initiateSales(entity)
			end,
			-- for 'ox_target'
			onSelect = function(data)
				local entity = data.entity
				initiateSales(entity)
			end,
			canInteract = canTarget,
		}
	})
	if Config.SellPedOnVehicle then
		Framework:AddGlobalVehicle({
			{
				name = 'drugTalkVehicle',
				label = 'Talk',
				icon = 'fas fa-comments',
				-- for 'qb-target'
				action = function(entity)
					local ped = GetPedInVehicleSeat(entity, -1)
					if ped == 0 then return end
					initiateSales(ped)
				end,
				-- for 'ox_target'
				onSelect = function(data)
					local entity = data.entity
					local ped = GetPedInVehicleSeat(entity, -1)
					if ped == 0 then return end
					initiateSales(ped)
				end,
				canInteract = function(entity)
					local ped = GetPedInVehicleSeat(entity, -1)
					if ped == 0 then return false end
					return canTarget(ped)
				end,
			}
		})
	end
end
exports('CreateTarget', createTarget)

-- Remove Sell Drugs to peds inside the sellzone
local function removeTarget()
	Framework:RemoveGlobalPed({'Talk', 'drugTalkPed'})
	if Config.SellPedOnVehicle then Framework:RemoveGlobalVehicle({'Talk', 'drugTalkVehicle'}) end
end
exports('RemoveTarget', removeTarget)

-- This will toggle allowing/disallowing target even if inside zone
local function IsTargetAllowed(value)
	AllowedTarget = value
end
exports('ToggleTarget', IsTargetAllowed)

-- Notify event for client/server
RegisterNetEvent('cad-drugsales:notify', function(msg)
	Framework:Notify(msg)
	if Config.Debug then print('Notify:'..msg) end
end)

-- event handler to server (execute server side)
RegisterNetEvent('cad-drugsales:salesinitiate', function(cad)
	if cad.type == 'close' then
		InitiateSellProgress = false
		lib.hideMenu()
		Framework:Notify("You rejected the offer")
		SetPedAsNoLongerNeeded(cad.tped)
	else
		InitiateSellProgress = false
		playGiveAnim(cad.tped)
		TriggerServerEvent("cad-drugsales:initiatedrug", cad)
		SetPedAsNoLongerNeeded(cad.tped)
	end
end)

-- Toggle selling (radialmenu)
if Config.ShouldToggleSelling then
RegisterNetEvent('cad-drugsales:toggleselling', function()
	AllowedTarget = not AllowedTarget
	if AllowedTarget then
		createTarget()
		Framework:Notify("Enabled Selling")
	else
		removeTarget()
		Framework:Notify("Disabled Selling")
	end
end)

Framework:AddRadial()

RegisterCommand('cornersell', function(source)
	TriggerEvent("cad-drugsales:toggleselling")
end, false)
TriggerEvent('chat:addSuggestion', '/cornersell', 'Toggle corner selling (Zone Only)')
end

-- Create Zones for the drug sales
if Config.SellAnywhere then
	if not Config.ShouldToggleSelling and Config.Target then
		createTarget()
	end
else
for k, v in pairs(Config.SellZones) do
    lib.zones.poly({
		points = v.points,
		thickness = v.thickness or 60.0,
		debug = Config.Debug,
		onEnter = function()
			CurrentZone = v
			if not Config.ShouldToggleSelling and Config.Target then createTarget() end
			if Config.Debug then print("Target Added ["..k.."]") end
			if Config.Debug then print(json.encode(CurrentZone)) end
		end,
		onExit = function()
			if not CurrentZone then return end
			CurrentZone = nil
			if not Config.ShouldToggleSelling and Config.Target then removeTarget() end
			if Config.Debug then print("Target Removed ["..k.."]") end
		end
	})
end
end

-- Create target on ped if target is disabled
if not Config.Target then
CreateThread(function()
	local success = false
	while true do
		Wait(10)
		local handle, ped = FindFirstPed()
		repeat
			success, ped = FindNextPed(handle)
			if not cache.vehicle then
				if DoesEntityExist(ped) and canTarget(ped) then
					local myPos = GetEntityCoords(cache.ped)
					local pedPos = GetEntityCoords(ped)
					local distance = #(vec3(myPos.x, myPos.y, myPos.z)- vec3(pedPos.x, pedPos.y, pedPos.z))
					if distance < 2 and ped ~= cache.ped and not hasSoldPed(ped) then
						Framework:DrawText3D(pedPos.x, pedPos.y, pedPos.z, '[E] Talk')
						if IsControlJustPressed(0, 38) then
							initiateSales(ped)
						end
					end
				end
			end
		until not success
		EndFindPed(handle)
	end
end)
end