ESX = nil
ESX = exports["es_extended"]:getSharedObject()

RegisterServerEvent('q:log:send')
AddEventHandler('q:log:send', function(t, message, source)
    SendToDiscord(t, message, source)
end)

function SendToDiscord(t, m, source)
    local webhook = q.TypeToLog[t]
    local identifiers = GetPlayerIdentifiers(source)
    local discord = "Failed to fetch identifier"
    local license = "Failed to fetch identifier"
    local xbl = "Failed to fetch identifier"
    local live = "Failed to fetch identifier"
    local fivem = "Failed to fetch identifier"
    local steam = "Failed to fetch identifier"
    local ip = "Failed to fetch identifier"
    local name = GetPlayerName(source)
    local id = source

    for _, identifier in ipairs(identifiers) do
        if string.find(identifier, "discord:") then
            discord = string.sub(identifier, 9)
        elseif string.find(identifier, "license:") then
            license = string.sub(identifier, 9)
        elseif string.find(identifier, "xbl:") then
            xbl = string.sub(identifier, 5)
        elseif string.find(identifier, "live:") then
            live = string.sub(identifier, 6)
        elseif string.find(identifier, "fivem:") then
            fivem = string.sub(identifier, 7)
        elseif string.find(identifier, "steam:") then
            steam = string.sub(identifier, 7)
        elseif string.find(identifier, "ip:") then
            ip = string.sub(identifier, 4)
        end
    end

    local connect = {
        title = "New log message",
        description = "```".. m .. "```",
        color = q.Color,
        fields = {
            { name = "**Player Information**", value = "```Name: " .. name .. "\nPlayer ID: " .. id .. "``` ", inline = false },
            { name = "**Identifiers**", value = "```Discord: " .. discord .. "\nLicense: " .. license .. "\nXBL: " .. xbl .. "\nLive: " .. live .. "\nFiveM: " .. fivem .. "\nSteam: " .. steam .. "\nIP: " .. ip .."```", inline = false }
        },
        author = { name = "Q-LOGS - V1.0"},
        footer = { text = os.date("Date: %d.%m.%Y \nClock: %X") },
    }

    PerformHttpRequest(webhook,
        function(err, text, headers)
        end,
        'POST',
        json.encode({ embeds = { connect } }),
        { ['Content-Type'] = 'application/json' }
    )
end



