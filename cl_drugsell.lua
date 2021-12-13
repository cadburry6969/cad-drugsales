local QBCore = exports['qb-core']:GetCoreObject()
selling = false

function IsInSellingZone()
	local PlayerCoords = GetEntityCoords(PlayerPedId(), false)
	for a=1, #Config.SellingDrugs, 1 do						
		-- if #(vector3(Config.SellingDrugs[a].coords.x, Config.SellingDrugs[a].coords.y, Config.SellingDrugs[a].coords.z)-vector3(PlayerCoords.x, PlayerCoords.y, PlayerCoords.z)) < Config.SellingDrugs[a].radius then			
		-- 	return true, Config.SellingDrugs[a].item, a				
		if IsEntityInZone(PlayerPedId(), Config.SellingDrugs[a].zone) then
			return true, Config.SellingDrugs[a].item, a	
		else
			return false, Config.SellingDrugs[a].item, a
		end
	end
end

function GetPedInFront()
	local player = PlayerId()
	local plyPed = GetPlayerPed(player)
	local plyPos = GetEntityCoords(plyPed, false)
	local plyOffset = GetOffsetFromEntityInWorldCoords(plyPed, 0.0, 1.3, 0.0)
	local rayHandle = StartShapeTestCapsule(plyPos.x, plyPos.y, plyPos.z, plyOffset.x, plyOffset.y, plyOffset.z, 1.0, 12, plyPed, 7)
	local _, _, _, _, ped = GetShapeTestResult(rayHandle)
	return ped
end

function InteractPed(issell, drug, drugid)
	Playerjob = QBCore.Functions.GetPlayerData().job	
	oldped = ped	
	SetEntityAsMissionEntity(ped)	
	local px,py,pz=table.unpack(GetGameplayCamCoords())
	TaskTurnPedToFaceCoord(ped, px, py, pz, 10000)
	Wait(1000)	
	if Playerjob.name == 'police' then
		TriggerEvent('QBCore:Notify', 'The buyer has seen you before, they know you\'re a cop!')
		SetPedAsNoLongerNeeded(oldped)
		selling = false
		return
	end

	if ped ~= oldped then
		TriggerEvent('QBCore:Notify', 'You acted sketchy (moved far away) and the buyer was no longer interested.')
		SetPedAsNoLongerNeeded(oldped)
		selling = false
		return
	end

	local percent = math.random(1, 100)

	if percent < 30 then
		TriggerEvent('QBCore:Notify', 'The buyer was not interested.')
	elseif percent < 70 then
		TriggerEvent("cad-drugsales:anim")
		Wait(1500)
		QBCore.Functions.TriggerCallback('QBCore:HasItem', function(result)
			if result and issell then				
				TriggerServerEvent('cad-drugsales:server:startdeal', drug, 1, drugid)
			else
				TriggerEvent('QBCore:Notify', 'You have nothing to sell.')
			end			
		end, drug)
	else
		TriggerEvent('QBCore:Notify', 'The buyer is calling the police!')
		TaskUseMobilePhoneTimed(ped, 5000)
		local playerCoords = GetEntityCoords(PlayerPedId())
		-- Add your police notify alert here
	end
	
	selling = false
	SetPedAsNoLongerNeeded(oldped)
end

CreateThread(function()
	while true do
		Wait(4)
		local inRange = false		
		if ped ~= 0 then 
			local cansell, drugname, drugid = IsInSellingZone()						
			if not IsPedDeadOrDying(ped) and not IsPedInAnyVehicle(ped) and cansell then
				inRange = true
                local pedType = GetPedType(ped)
				if ped ~= oldped and not selling and (IsPedAPlayer(ped) == false and pedType ~= 28) then
					local pos = GetEntityCoords(ped)
					QBCore.Functions.DrawText3D(pos.x, pos.y, pos.z, 'Press ~g~E~w~ to sell drugs')
					if IsControlJustPressed(0, 38) and not selling then						
						selling = true
						InteractPed(cansell, drugname, drugid)
					end
				end			
			end		
		end
		if not inRange then
			Wait(1000)
		end
	end
end)

CreateThread(function()
	while true do
		Wait(1000)
		local playerPed = PlayerPedId()
		if not IsPedInAnyVehicle(playerPed) or not IsPedDeadOrDying(playerPed) then
			ped = GetPedInFront()
		else
			Wait(500)
		end
    end
end)

RegisterNetEvent('cad-drugsales:anim', function()
	local pid = PlayerPedId()	
	FreezeEntityPosition(pid, true)		
	RequestAnimDict("mp_common")		
	TaskPlayAnim(pid, "mp_common", "givetake2_a", 8.0, -8, -1, 0, 0, 0, 0, 0)    
	TaskPlayAnim(ped, "mp_common", "givetake2_a", 8.0, -8, -1, 0, 0, 0, 0, 0)    	
	Wait(2000)
	FreezeEntityPosition(pid, false)	
	StopAnimTask(pid, "mp_common", "givetake2_a", 1.0)
	StopAnimTask(ped, "mp_common", "givetake2_a", 1.0)
end)
