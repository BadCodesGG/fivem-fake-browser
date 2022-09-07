local tablet = false
local tabletDict = "amb@code_human_in_bus_passenger_idles@female@tablet@base"
local tabletAnim = "base"
local tabletProp = `prop_cs_tablet`
local tabletBone = 60309
local tabletOffset = vector3(0.03, 0.002, -0.0)
local tabletRot = vector3(10.0, 160.0, 0.0)

function OpenTablet(openUI)
	local isInVeh = IsPedInAnyVehicle(PlayerPedId(), false)
	if not isInVeh then
		SetPlayerControl(PlayerId(), 0, 0)
	end
	SetNuiFocus(true,true)
	SendNUIMessage({openUI = true, menu = openUI})
	ToggleTablet(true)
end

function CloseTablet()
	SetNuiFocus(false,false)
	ToggleTablet(false)
	Wait(250)
	ClearPedTasks(PlayerPedId())
	SetPlayerControl(PlayerId(), 1, 0)
end

RegisterNetEvent('fivem-tablet:open-tablet')
AddEventHandler('fivem-tablet:open-tablet', function(menuType)
	OpenTablet(menuType)
end)

RegisterNetEvent('fivem-tablet:close-tablet')
AddEventHandler('fivem-tablet:close-tablet', function()
	CloseTablet()
	SendNUIMessage({
		closeUI = true
	})
end)

RegisterNUICallback('close', function(data, cb)
	CloseTablet()
	cb('ok')
end)

function ToggleTablet(toggle)
	if toggle and not tablet then
		tablet = true

		Citizen.CreateThread(function()
			RequestAnimDict(tabletDict)

			while not HasAnimDictLoaded(tabletDict) do
				Citizen.Wait(150)
			end

			RequestModel(tabletProp)

			while not HasModelLoaded(tabletProp) do
				Citizen.Wait(150)
			end

			local playerPed = PlayerPedId()
			local tabletObj = CreateObject(tabletProp, 0.0, 0.0, 0.0, true, true, false)
			local tabletBoneIndex = GetPedBoneIndex(playerPed, tabletBone)

			SetCurrentPedWeapon(playerPed, `weapon_unarmed`, true)
			AttachEntityToEntity(tabletObj, playerPed, tabletBoneIndex, tabletOffset.x, tabletOffset.y, tabletOffset.z, tabletRot.x, tabletRot.y, tabletRot.z, true, false, false, false, 2, true)
			SetModelAsNoLongerNeeded(tabletProp)

			while tablet do
				Citizen.Wait(100)
				print('tablet', tablet)
				playerPed = PlayerPedId()

				if not IsEntityPlayingAnim(playerPed, tabletDict, tabletAnim, 3) then
					TaskPlayAnim(playerPed, tabletDict, tabletAnim, 3.0, 3.0, -1, 49, 0, 0, 0, 0)
				end
			end

			ClearPedSecondaryTask(playerPed)

			Citizen.Wait(450)

			DetachEntity(tabletObj, true, false)
			DeleteEntity(tabletObj)
		end)
	elseif not toggle and tablet then
		tablet = false
	end
end

RegisterCommand("browser", function()
	TriggerEvent("fivem-tablet:open-tablet", "browser")
end)