local sW, sH = guiGetScreenSize()
zoom = sW/1920

LOGIN_GUI = {}

LOGIN_GUI.txt = {
    ["panel_bg"] = dxCreateTexture("login/files/img/bg.png", "argb", true, "wrap"),
    ["editbox"] = dxCreateTexture("login/files/img/editbox.png", "argb", true, "wrap"),
    ["editbox_active"] = dxCreateTexture("login/files/img/editbox_active.png", "argb", true, "wrap"),
    ["button"] = dxCreateTexture("login/files/img/button_login.png", "argb", true, "wrap"),
    ["button_active"] = dxCreateTexture("login/files/img/button_login.png", "argb", true, "wrap"),
    ["checkbox"] = dxCreateTexture("login/files/img/checkbox.png", "argb", true, "wrap"),
    ["checkbox_active"] = dxCreateTexture("login/files/img/checkbox_active.png", "argb", true, "wrap"),
    ["checkbox_hover"] = dxCreateTexture("login/files/img/checkbox_hover.png", "argb", true, "wrap"),
}

LOGIN_GUI.scale = {
    ["panel_bg"] = {w=1466/zoom, h=744/zoom},
    ["edit"] = {w=535/zoom, h=50/zoom},
    ["button"] = {w=535/zoom, h=70/zoom},
    ["checkbox"] = {w=18/zoom, h=18/zoom},
}

LOGIN_GUI.pos = {
    ["panel_bg"] = {x=sW/2-LOGIN_GUI.scale.panel_bg.w/2, y = sH/2-LOGIN_GUI.scale.panel_bg.h/2},
    ["edit_login"] = {x=882/zoom, y = 297/zoom},
    ["edit_password"] = {x=882/zoom, y = 399/zoom},
    ["checkbox"] = {x=882/zoom, y = 470/zoom},
    ["button"] = {x=882/zoom, y = 519/zoom},
}


LOGIN_GUI.fonts = {
    ["medium_20"] = dxCreateFont("login/files/fonts/Roboto-Medium.ttf", 20.83/zoom, false),
    ["regular_20"] = dxCreateFont("login/files/fonts/Roboto-Regular.ttf", 20.83/zoom, false),
    ["bold_14"] = dxCreateFont("login/files/fonts/Roboto-Bold.ttf", 14.37/zoom, false),
}

LOGIN_GUI.timers = {}

LOGIN_GUI.vars = {}

LOGIN_GUI.elements = {}