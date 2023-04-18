--[[
    @Author: Maciej "bover." Grzymkowski
    Zacznijmy wymagać więcej ~ Xyrusek

    Kontakt mailowo: biznes.bover@gmail.com
    Kontakt discord: bover.#1765
]]--

local settings = {}

HUD = {}
HUD.__index = HUD

function HUD:create()
    local instance = {}
    setmetatable(instance, HUD)

    if (instance:constructor()) then 
        return instance 
    end 

    return false
end

function HUD:constructor()
    self.functions = {}
    self.functions.render = self:render()

    addEventHandler("onClientRender", root, self.functions.render)

    return true
end 

function HUD:render()
end

addEventHandler('onClientResourceStart', resourceRoot, function()
    settings.hud = HUD:create()
end)