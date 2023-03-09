local sW, sH = guiGetScreenSize()
zoom = sW/1920

GUI = {}
GUI.txt = {
    ["panel_bg"] = dxCreateTexture("files/img/panel_bg.png", "argb", true, "wrap"),
    ["panel_bg_left"] = dxCreateTexture("files/img/panel_bg_left.png", "argb", true, "wrap"),
    ["online"] = dxCreateTexture("files/img/online.png", "argb", true, "wrap"),
    ["online_blink"] = dxCreateTexture("files/img/online_blink.png", "argb", true, "wrap"),
    --Login
    ["login"] = dxCreateTexture("files/img/login.png", "argb", true, "wrap"),
    ["login_hover"] = dxCreateTexture("files/img/login_hover.png", "argb", true, "wrap"),
    ["login_off"] = dxCreateTexture("files/img/login_off.png", "argb", true, "wrap"),
    --Register
    ["register"] = dxCreateTexture("files/img/register.png", "argb", true, "wrap"),
    ["register_hover"] = dxCreateTexture("files/img/register_hover.png", "argb", true, "wrap"),
    ["register_off"] = dxCreateTexture("files/img/register_off.png", "argb", true, "wrap")
}

GUI.scale = {
    ["panel_bg"] = {w=1395/zoom, h=947/zoom},
    ["panel_bg_left"] = {w=538/zoom, h=967/zoom},
    ["online"] = {w=32/zoom, h=32/zoom},
    ["login"] = {w=182/zoom, h=45/zoom},
    ["register"] = {w=189/zoom, h=45/zoom}
}

GUI.pos = {
    ["panel_bg"] = {x=sW/2-GUI.scale.panel_bg.w/2, y = sH/2-GUI.scale.panel_bg.h/2},
    ["panel_bg_left"] = {x=0,y=GUI.scale.panel_bg.h/2-GUI.scale.panel_bg_left.h/2},
    ["counter_label"] = {x=GUI.scale.panel_bg.w-139/zoom,y=120/zoom},
    ["online_label"] = {x=GUI.scale.panel_bg.w-139/zoom,y=178/zoom},
    ["online"] = {x=GUI.scale.panel_bg.w-224/zoom,y=180/zoom},
    ["login"] = {x=565/zoom,y=285/zoom},
    ["register"] = {x=772/zoom,y=285/zoom}
}

GUI.fonts = {
    ["font_4"] = dxCreateFont("files/fonts/TiltWarp_PL.ttf", 18.03/zoom, false),
    ["font_12"] = dxCreateFont("files/fonts/TiltWarp_PL.ttf", 50.48/zoom, false)
}

GUI.timers = {}

GUI.vars = {}

GUI.elements = {}
