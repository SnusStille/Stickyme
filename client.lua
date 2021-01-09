local stickies = {}
local drawdistance = 20

local DrawText3D = function(coords, text)
    SetDrawOrigin(coords)

    SetTextScale(0.35, 0.35)
    SetTextFont(4)
    SetTextEntry('STRING')
    SetTextCentre(1)
    AddTextComponentString(text)
    DrawText(0.0, 0.0)
    DrawRect(0.0, 0.0125, 0.015 + text:gsub("~.-~", ""):len() / 370, 0.03, 41, 11, 41, 68)

    ClearDrawOrigin()
end

CreateThread(function()
    while not NetworkIsSessionStarted() do Wait(250) end
    Wait(5000)
    TriggerServerEvent('3dme:fetch')

    while true do
        local sleep = 500
        
        for k, v in pairs(stickies) do
            local src = tonumber(k)

            local pped = GetPlayerPed(GetPlayerFromServerId(src))

            if #(GetEntityCoords(pped) - GetEntityCoords(PlayerPedId())) <= drawdistance then
                if IsPedDeadOrDying(pped) then
                    DrawText3D(GetOffsetFromEntityInWorldCoords(pped, 0.0, 0.0, 0.2), v)
                else
                    DrawText3D(GetOffsetFromEntityInWorldCoords(pped, 0.0, 0.0, 1.0), v)
                end
                sleep = 0
            end
        end

        Wait(sleep)
    end
end)

RegisterCommand("sme", function(source, args, rawCommand)
    if #args > 0 then
        local msg = ''
        for i = 1, #args do
            msg = msg .. args[i] .. ' '
        end

        TriggerServerEvent('3dme', msg)
    else
        TriggerServerEvent('3dme', nil)
    end
end, false)

RegisterNetEvent('3dme:update')
AddEventHandler('3dme:update', function(new)
    stickies = new
end)