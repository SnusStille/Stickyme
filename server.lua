local stickies = {}

RegisterServerEvent('3dme')
AddEventHandler('3dme', function(text)
    local src = source

    if text and type(text) == 'string' then
        stickies[tostring(src)] = text
    else
        stickies[tostring(src)] = nil
    end

    TriggerClientEvent('3dme:update', -1, stickies)
end)

RegisterServerEvent('3dme:fetch')
AddEventHandler('3dme:fetch', function()
    TriggerClientEvent('3dme:update', -1, stickies)
end)

AddEventHandler('playerDropped', function()
    local src = source

    stickies[tostring(src)] = nil
    TriggerClientEvent('3dme:update', -1, stickies)
end)