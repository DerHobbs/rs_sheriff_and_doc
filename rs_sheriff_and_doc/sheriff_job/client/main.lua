local draggedBy = -1
local drag = false
local wasDragged = false

RegisterNetEvent("rs_sheriff:drag")
AddEventHandler("rs_sheriff:drag", function(_source)
    draggedBy = _source
    drag = not drag
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        if drag then
            wasDragged = true
            AttachEntityToEntity(PlayerPedId(), GetPlayerPed(GetPlayerFromServerId(draggedBy)), 4103, 11816, 0.48, 0.00, 0.0, 0.0, 0.0, 0.0, false, false, false, false, 2, true)
        else
            if wasDragged then
                wasDragged = false
                DetachEntity(PlayerPedId(), true, false)    
            end
        end
    end
end)

Citizen.CreateThread(function()
    while true do
        local ped = GetPlayerPed()
        local coords = GetEntityCoords(PlayerPedId())
        if whenKeyJustPressed(0x3C3DD371) then
            TriggerServerEvent("rs_sheriff:checkjob")
        end
        Citizen.Wait(5)
    end
end)

function openPolicemenu()
	MenuData.CloseAll()
	local elements = {
        {label = "Sheriff star on", value = 'star' , desc = "Sheriff star put on"},
        {label = "Sheriff star off", value = 'unstar' , desc = "Sheriff star put off"},
        {label = "Put on handcuffs", value = 'cuff' , desc = "Handcuffs on"},
        {label = "Put off handcuffs", value = 'uncuff' , desc = "Handcuffs off"},
        {label = "Escort", value = 'drag' , desc = "Escort the citizen"}
    }
    MenuData.Open('default', GetCurrentResourceName(), 'menuapi',
    {
		title    = "Sheriff menu",
		subtext  = "Sheriff Interactions",
		align    = 'top-left',
		elements = elements,
	},
	function(data, menu)
        if (data.current.value == 'star') then
            Citizen.InvokeNative(0xD710A5007C2AC539, PlayerPedId(), 0x3F7F3587, 0)
            Citizen.InvokeNative(0xCC8CA3E88256E58F, PlayerPedId(), 0, 1, 1, 1, 0)
            if IsPedMale(ped) then
                Citizen.InvokeNative(0xD3A7B003ED343FD9, PlayerPedId(), 0x1FC12C9C,true,true,true)
            else
                Citizen.InvokeNative(0xD3A7B003ED343FD9, PlayerPedId(), 0x1FC12C9C,true,true,true)
            end
            TriggerEvent("vorp:TipRight", "Sheriff star put on", 3000)
        elseif
            (data.current.value == 'unstar') then 
        if not IsPedMale(ped) then
            Citizen.InvokeNative(0xD710A5007C2AC539, PlayerPedId(), 0x3F7F3587, 0)
            Citizen.InvokeNative(0xCC8CA3E88256E58F, PlayerPedId(), 0, 1, 1, 1, 0)
        end
        TriggerEvent("vorp:TipRight", "Sheriff star put off", 3000)

        elseif 
            (data.current.value == 'cuff') then
            local closestPlayer, closestDistance = GetClosestPlayer()
            if closestPlayer ~= -1 and closestDistance <= 1.0 then
                TriggerServerEvent("rs_sheriff:cuffplayer", GetPlayerServerId(closestPlayer))
                TriggerEvent("vorp:TipRight", "Handcuffs on", 3000)
            end

        elseif
            (data.current.value == 'uncuff') then
            local closestPlayer, closestDistance = GetClosestPlayer()
            if closestPlayer ~= -1 and closestDistance <= 1.0 then
                TriggerServerEvent("rs_sheriff:uncuffplayer", GetPlayerServerId(closestPlayer))
                TriggerEvent("vorp:TipRight", "Handcuffs off", 3000)
            end

        elseif
            (data.current.value == 'drag') then
            local closestPlayer, closestDistance = GetClosestPlayer()
            if closestPlayer ~= -1 and closestDistance <= 1.0 then
                TriggerServerEvent("rs_sheriff:drag", GetPlayerServerId(closestPlayer))
                TriggerEvent("vorp:TipRight", "Escort the citizen", 3000)
            end
        end
    end,
    function(data, menu)
        menu.close()
    end)
end

RegisterNetEvent("rs_sheriff:open")
AddEventHandler("rs_sheriff:open", function(cb)
    openPolicemenu()
end)

function whenKeyJustPressed(key)
    if Citizen.InvokeNative(0x580417101DDB492F, 0, key) then
        return true
    else
        return false
    end
end

function GetClosestPlayer()
    local players, closestDistance, closestPlayer = GetActivePlayers(), -1, -1
    local playerPed, playerId = PlayerPedId(), PlayerId()
    local coords, usePlayerPed = coords, false

    if coords then
        coords = vector3(coords.x, coords.y, coords.z)
    else
        usePlayerPed = true
        coords = GetEntityCoords(playerPed)
    end

    for i = 1, #players, 1 do
        local tgt = GetPlayerPed(players[i])

        if not usePlayerPed or (usePlayerPed and players[i] ~= playerId) then
            local targetCoords = GetEntityCoords(tgt)
            local distance = #(coords - targetCoords)

            if closestDistance == -1 or closestDistance > distance then
                closestPlayer = players[i]
                closestDistance = distance
            end
        end
    end
    return closestPlayer, closestDistance
end

RegisterNetEvent("rs_sheriff:cuff")
AddEventHandler("rs_sheriff:cuff", function()
    local playerPed = PlayerPedId()
    SetEnableHandcuffs(playerPed, true)
end)

RegisterNetEvent("rs_sheriff:uncuff")
AddEventHandler("rs_sheriff:uncuff", function()
    local playerPed = PlayerPedId()
    UncuffPed(playerPed)
end)

Citizen.CreateThread(function()
    for k, v in pairs(Config.blip) do
        local blip = N_0x554d9d53f696d002(1664425300, v.Pos.x, v.Pos.y, v.Pos.z)
        SetBlipSprite(blip, 1047294027, 1)
        Citizen.InvokeNative(0x9CB1A1623062F402, blip, "Sheriff's office")
    end
end)

TriggerEvent("menuapi:getData",function(call)
    MenuData = call
end)