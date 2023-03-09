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
    ["register_off"] = dxCreateTexture("files/img/register_off.png", "argb", true, "wrap"),
    ["edit"] = dxCreateTexture("files/img/editbox.png", "argb", true, "wrap"),
    ["edit_active"] = dxCreateTexture("files/img/editbox_active.png", "argb", true, "wrap"),
    ["checkbox"] = dxCreateTexture("files/img/checkbox.png", "argb", true, "wrap"),
    ["checkbox_hover"] = dxCreateTexture("files/img/checkbox_hover.png", "argb", true, "wrap"),
    ["checkbox_active"] = dxCreateTexture("files/img/checkbox_active.png", "argb", true, "wrap"),
    ["button"] = dxCreateTexture("files/img/login_button.png", "argb", true, "wrap"),
    ["button_active"] = dxCreateTexture("files/img/login_button_active.png", "argb", true, "wrap")
}

GUI.scale = {
    ["panel_bg"] = {w=1395/zoom, h=947/zoom},
    ["panel_bg_left"] = {w=538/zoom, h=967/zoom},
    ["online"] = {w=32/zoom, h=32/zoom},
    ["login"] = {w=182/zoom, h=45/zoom},
    ["register"] = {w=189/zoom, h=45/zoom},
    ["edit"] = {w=731/zoom, h=132/zoom},
    ["checkbox"] = {w=48/zoom, h=48/zoom},
    ["button"] = {w=527/zoom, h=128/zoom}
}

GUI.pos = {
    ["panel_bg"] = {x=sW/2-GUI.scale.panel_bg.w/2, y = sH/2-GUI.scale.panel_bg.h/2},
    ["panel_bg_left"] = {x=0,y=GUI.scale.panel_bg.h/2-GUI.scale.panel_bg_left.h/2},
    ["counter_label"] = {x=GUI.scale.panel_bg.w-139/zoom,y=120/zoom},
    ["online_label"] = {x=GUI.scale.panel_bg.w-139/zoom,y=178/zoom},
    ["online"] = {x=GUI.scale.panel_bg.w-224/zoom,y=180/zoom},
    ["login"] = {x=565/zoom,y=285/zoom},
    ["register"] = {x=772/zoom,y=285/zoom},
    ["edit_login"] = {x=530/zoom,y=350/zoom},
    ["edit_password"] = {x=530/zoom,y=350/zoom+GUI.scale.edit.h+20/zoom},
    ["checkbox"] = {x=540/zoom,y=350/zoom+GUI.scale.edit.h+20/zoom+GUI.scale.checkbox.h*2+20/zoom},
    ["button"] = {x=540/zoom+GUI.scale.edit.w/2-GUI.scale.button.w/2,y=350/zoom+GUI.scale.edit.h+20/zoom+GUI.scale.checkbox.h*2+20/zoom+50/zoom},
}

GUI.fonts = {
    ["font_18"] = dxCreateFont("files/fonts/TiltWarp_PL.ttf", 18.03/zoom, false),
    ["font_50"] = dxCreateFont("files/fonts/TiltWarp_PL.ttf", 50.48/zoom, false),
    ["font_32"] = dxCreateFont("files/fonts/TiltWarp_PL.ttf", 32.72/zoom, false)
}

GUI.timers = {}

GUI.vars = {}

GUI.elements = {}
