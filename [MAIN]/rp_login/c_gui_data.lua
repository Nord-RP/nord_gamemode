local sW, sH = guiGetScreenSize()
local zoom = sW/1920

GUI = {}
GUI.txt = {
    ["panel_bg"] = dxCreateTexture("files/img/panel_bg.png", "argb", true, "wrap"),
    ["panel_bg_left"] = dxCreateTexture("files/img/panel_bg_left.png", "argb", true, "wrap"),
    ["online"] = dxCreateTexture("files/img/online.png", "argb", true, "wrap"),
    ["online_blink"] = dxCreateTexture("files/img/online_blink.png", "argb", true, "wrap")
}

GUI.scale = {
    ["panel_bg"] = {w=1395/zoom, h=947/zoom},
    ["panel_bg_left"] = {w=538/zoom, h=967/zoom},
    ["online"] = {w=32/zoom, h=32/zoom}
}

GUI.pos = {
    ["panel_bg"] = {x=sW/2-GUI.scale.panel_bg.w/2, y = sH/2-GUI.scale.panel_bg.h/2},
    ["panel_bg_left"] = {x=0,y=GUI.scale.panel_bg.h/2-GUI.scale.panel_bg_left.h/2},
    ["online_label"] = {x=GUI.scale.panel_bg.w-96/zoom,y=138/zoom},
    ["counter_label"] = {x=GUI.scale.panel_bg.w-96/zoom,y=80/zoom},
    ["online"] = {x=GUI.scale.panel_bg.w-180/zoom,y=139/zoom}
}

GUI.fonts = {
    ["font_4"] = dxCreateFont("files/fonts/TiltWarp_PL.ttf", 18.03/zoom, false),
    ["font_12"] = dxCreateFont("files/fonts/TiltWarp_PL.ttf", 50.48/zoom, false)
}

GUI.timers = {}

GUI.vars = {}

GUI.elements = {}
