local ffi = require "ffi"
local js = panorama.open()

local engineclient = require "gamesense/engineclient" or error "https://gamesense.pub/forums/viewtopic.php?id=42362" -- EngineClient Interface by h4x0r1337 (https://gamesense.pub/forums/profile.php?id=12351)
local images = require "gamesense/images" or error "https://gamesense.pub/forums/viewtopic.php?id=22917" -- Images library by sapphyrus (https://gamesense.pub/forums/profile.php?id=561)

local name, xuid = js.MyPersonaAPI.GetName(), js.MyPersonaAPI.GetXuid()
local avatar = images.get_steam_avatar(xuid)

local tab, container = "LUA", "B"
local master_switch = ui.new_checkbox(tab, container, "Freeman - Semirage")

local cache = {}

local menu = {
    automatic_fire = ui.new_hotkey(tab, container, "Automatic fire", false),
    automatic_penetration = ui.new_hotkey(tab, container, "Automatic penetration", false)
}

local references = {
    automatic_fire = ui.reference("RAGE", "Other", "Automatic fire"),
    automatic_penetration = ui.reference("RAGE", "Other", "Automatic penetration")
}

local paint = function(ctx)
    local local_player = entity.get_local_player()
    if local_player == nil or not entity.is_alive(local_player) then return end

    if cache[references.automatic_fire] then
        renderer.indicator(255, 255, 255, 240, "AF")
    end

    if cache[references.automatic_penetration] then
        renderer.indicator(255, 255, 255, 240, "AW")
    end
end

local run_command = function(cmd)
    ui.set(references.automatic_fire, ui.get(menu.automatic_fire))
    ui.set(references.automatic_penetration, ui.get(menu.automatic_penetration))
end

local wrapper = function(self) cache[self] = ui.get(self) end

local ui_callback = function(self)
    local enabled = ui.get(self)
    local updatecallback = enabled and client.set_event_callback or client.unset_event_callback

    for k, v in pairs(menu) do ui.set_visible(v, enabled) end

    updatecallback("paint", paint)
    updatecallback("run_command", run_command)
end

ui.set_callback(master_switch, ui_callback)
ui.set_callback(references.automatic_fire, wrapper)
ui.set_callback(references.automatic_penetration, wrapper)

ui_callback(master_switch)
wrapper(references.automatic_fire)
wrapper(references.automatic_penetration)

print(string.format("Welcome back %s, freeman-semirage is now loaded. you're currently on the %s build", name, "XAXA"))
