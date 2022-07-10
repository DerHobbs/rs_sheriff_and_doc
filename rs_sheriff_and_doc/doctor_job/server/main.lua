local VorpCore = {}

TriggerEvent("getCore",function(core)
    VorpCore = core
end)

RegisterServerEvent("rs_doctor:checkjob")
AddEventHandler("rs_doctor:checkjob", function()
    local _source = source
    local Character = VorpCore.getUser(_source).getUsedCharacter
    local job = Character.job
    if job == 'doctorstr' then
        TriggerClientEvent('rs_doctor:open', _source)
	elseif job == 'doctorval' then
        TriggerClientEvent('rs_doctor:open', _source)
	elseif job == 'doctorbw' then
        TriggerClientEvent('rs_doctor:open', _source)
	elseif job == 'doctorrho' then
        TriggerClientEvent('rs_doctor:open', _source)
	elseif job == 'doctorsd' then
        TriggerClientEvent('rs_doctor:open', _source)
    end
end)

RegisterServerEvent( 'rs_doctor:reviveplayer' )
AddEventHandler( 'rs_doctor:reviveplayer', function (target)
    TriggerClientEvent('vorp:resurrectPlayer', target)
end)

RegisterServerEvent( 'rs_doctor:healplayer' )
AddEventHandler( 'rs_doctor:healplayer', function (target)
	TriggerClientEvent('rs_doctor:healed', target)
end)