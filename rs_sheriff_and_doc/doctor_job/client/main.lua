Citizen.CreateThread(function()
    while true do
        local ped = GetPlayerPed()
        local coords = GetEntityCoords(PlayerPedId())
        if whenKeyJustPressed(0x3C3DD371) then
            TriggerServerEvent("rs_doctor:checkjob")
        end
        Citizen.Wait(5)
    end
end)

function openMedicmenu()
	MenuData.CloseAll()
	local ped = GetPlayerPed()
	local coords = GetEntityCoords(PlayerPedId())
	local elements = {
		{label = "Heal", value = 'med1' , desc = "Heal the person closest to you"},
		{label = "Revive", value = 'med2' , desc = "Revive the person closest to you"},
	}
	MenuData.Open('default', GetCurrentResourceName(), 'menuapi',
	{
		title    = "doctor menu",
		subtext  = "What would you like to do?",
		align    = 'top-left',
		elements = elements,
	},
	function(data, menu)
		if  (data.current.value == 'med1') then
			local closestPlayer, closestDistance = GetClosestPlayer()
			if closestPlayer ~= -1 and closestDistance <= 2.0 then
                TaskStartScenarioInPlace(PlayerPedId(), GetHashKey('WORLD_HUMAN_CROUCH_INSPECT'), 10000, true, false, false, false)
                TriggerEvent("vorp:TipBottom", 'wounds are treated', 10000)
                Wait(10000)
                TriggerServerEvent("rs_doctor:healplayer", GetPlayerServerId(closestPlayer))
                ClearPedTasksImmediately(PlayerPedId())
			end
        elseif (data.current.value == 'med2') then
			local closestPlayer, closestDistance = GetClosestPlayer()
			if closestPlayer ~= -1 and closestDistance <= 2.0 then
                local dic = "mech_revive@unapproved"
                local anim = "revive"
                loadAnimDict(dic)
                TaskPlayAnim(PlayerPedId(), dic, anim, 1.0, 8.0, 3000, 31, 0, true, true, false, false, true)
                TriggerEvent("vorp:TipBottom", 'revival is in progress', 3000)
                Wait(3000)
                ClearPedTasksImmediately(PlayerPedId())
			    TriggerServerEvent("rs_doctor:reviveplayer", GetPlayerServerId(closestPlayer))
			end
		end
	end,
	function(data, menu)
		menu.close()
	end)
end

RegisterNetEvent("rs_doctor:open")
AddEventHandler("rs_doctor:open", function(cb)
    openMedicmenu()
end)

Citizen.CreateThread(function()
    for k, v in pairs(ConfigD.blip) do
        local blip = N_0x554d9d53f696d002(1664425300, v.Pos.x, v.Pos.y, v.Pos.z)
        SetBlipSprite(blip, -1739686743, 1)
        Citizen.InvokeNative(0x9CB1A1623062F402, blip, "Doctor")
    end
end)

RegisterNetEvent('rs_doctor:healed')
AddEventHandler('rs_doctor:healed', function()
    local closestPlayer, closestDistance = GetClosestPlayer()
    if closestPlayer ~= -1 and closestDistance <= 2.0 then
    local Health = GetAttributeCoreValue(PlayerPedId(), 0)
    local newHealth = Health + 75
    local Stamina = GetAttributeCoreValue(PlayerPedId(), 1)
    local newStamina = Stamina + 50
    local Health2 = GetEntityHealth(PlayerPedId())
    local newHealth2 = Health2 + 75
    Citizen.InvokeNative(0xC6258F41D86676E0, PlayerPedId(), 0, newHealth) --core
    Citizen.InvokeNative(0xC6258F41D86676E0, PlayerPedId(), 1, newStamina) --core
    SetEntityHealth(PlayerPedId(), newHealth2)
    print ("Person geheilt")
    end
end)

function loadAnimDict(dict)
	RequestAnimDict(dict)
	while not HasAnimDictLoaded(dict) do
		Citizen.Wait(500)
	end
end

TriggerEvent("menuapi:getData",function(call)
    MenuData = call
end)