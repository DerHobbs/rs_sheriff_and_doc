local VorpCore = {}

TriggerEvent("getCore",function(core)
    VorpCore = core
end)

RegisterServerEvent("rs_sheriff:checkjob")
AddEventHandler("rs_sheriff:checkjob", function()
    local _source = source
    local Character = VorpCore.getUser(_source).getUsedCharacter
    local job = Character.job
    if job == "sheriffval" then
        TriggerClientEvent('rs_sheriff:open', _source)
	elseif job == "sheriffrho" then
        TriggerClientEvent('rs_sheriff:open', _source)
        elseif job == "sheriffbw" then
        TriggerClientEvent('rs_sheriff:open', _source)
	elseif job == "sheriffstr" then
        TriggerClientEvent('rs_sheriff:open', _source)
	elseif job == "sherifftum" then
        TriggerClientEvent('rs_sheriff:open', _source)
	elseif job == "sheriffsd" then
        TriggerClientEvent('rs_sheriff:open', _source)
	elseif job == "sheriffann" then
        TriggerClientEvent('rs_sheriff:open', _source)		
    end
end)

RegisterServerEvent('rs_sheriff:drag')
AddEventHandler('rs_sheriff:drag', function(target)
    local _source = source
    local _target = target
    if _target then
        if _target ~= _source then
            TriggerClientEvent("rs_sheriff:drag", _target, _source)
        end
    end
end)

RegisterServerEvent('rs_sheriff:cuffplayer')
AddEventHandler('rs_sheriff:cuffplayer', function(target)
    TriggerClientEvent('rs_sheriff:cuff', target)
end)

RegisterServerEvent('rs_sheriff:uncuffplayer')
AddEventHandler('rs_sheriff:uncuffplayer', function(target)
    local _source = source
    TriggerClientEvent('rs_sheriff:uncuff', target)
end)
