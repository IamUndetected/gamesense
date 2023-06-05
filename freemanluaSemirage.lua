--[[
Freeeman Semirage

Created by: mrfreeman
Created on the: 4th of June 2023
Created for: Learning lua and giving the community a free lua


Yes i know that most of this is shit code, yes i know that a lot of it is pasted but yk i guess it works? :)
--]]



--[[
STRUCTURE:

1. Setups




--]]


--Setups
local ECLIB = require "gamesense/engineclient" --  https://gamesense.pub/forums/viewtopic.php?id=42362
local images = require "gamesense/images" --  https://gamesense.pub/forums/viewtopic.php?id=22917
local js = panorama.open()


local lua_name = "freeman.lua"

local user = entity.get_player_name(entity.get_local_player())

local build = "dev"
local tab, container = "MISC", "Settings"


local welcomeText = string.format("Welcome back %s, %s is now loaded. You are currently on build type: %s", user, lua_name, build)
print(welcomeText)


--Setupps DONE


--Get Watermark stuff for future

local steamid64 = js.MyPersonaAPI.GetXuid()
local avatar = images.get_steam_avatar(steamid64)


--Watermark stuff done.

local label = ui.new_label(tab, container, "Freeman.lua - Semirage")

local refs = {
    awall = ui.reference('rage', 'other', 'automatic penetration'),
    ashoot = ui.reference('rage', 'other', 'automatic fire')
}

local menu = {
    awallBind = ui.new_hotkey ("MISC", "Settings", 'Automatic penetration'),
    ashootBind = ui.new_hotkey ("MISC", "Settings", 'automatic fire')
}

client.set_event_callback('setup_command', function ()
    ui.set(refs.awall, ui.get(menu.awallBind))
    ui.set(refs.ashoot, ui.get(menu.ashootBind))
end)



client.set_event_callback("paint", function()

    if ui.get(refs.awall) == true then
        renderer.indicator(255,255,255,255, "Automatic Penetration")
    end

    if ui.get(refs.ashoot) == true then
        renderer.indicator(255,255,255,255, "Automatic Fire")
    end
end)