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
    ["select_bg"] = dxCreateTexture("login/files/img/character_select_bg.png", "argb", true, "wrap"),
    ["select_box"] = dxCreateTexture("login/files/img/character_select_box.png", "argb", true, "wrap"),
    ["slider_box"] = dxCreateTexture("login/files/img/slider_box_bg.png", "argb", true, "wrap"),
    ["slider_bg3"] = dxCreateTexture("login/files/img/slider_bg_1.png", "argb", true, "wrap"),
    ["slider_bg2"] = dxCreateTexture("login/files/img/slider_bg_2.png", "argb", true, "wrap"),
    ["slider_bg1"] = dxCreateTexture("login/files/img/slider_bg_3.png", "argb", true, "wrap"),
    ["slider_fill"] = dxCreateTexture("login/files/img/slider_fill.png", "argb", true, "wrap"),
    ["key_enter"] = dxCreateTexture("login/files/img/key_enter.png", "argb", true, "wrap"),
    ["character_name"] = dxCreateTexture("login/files/img/character_name_bg.png", "argb", true, "wrap"),
}

LOGIN_GUI.scale = {
    ["panel_bg"] = {w= 1466/zoom, h= 744/zoom},
    ["edit"] = {w= 535/zoom, h= 50/zoom},
    ["button"] = {w= 535/zoom, h= 70/zoom},
    ["checkbox"] = {w= 18/zoom, h= 18/zoom},
    ["select_bg"] = {w= 1920/zoom, h= 449/zoom},
    ["select_box"] = {w= 281/zoom, h= 175/zoom},
    ["slider_box"] = {w= 364/zoom, h= 47/zoom},
    ["slider"] = {w= 223/zoom, h= 12/zoom},
    ["key_enter"] = {w= 126/zoom, h= 126/zoom},
    ["character_name"] = {w= 233/zoom*2, h= 83/zoom*2},
}

LOGIN_GUI.pos = {
    ["panel_bg"] = {x= sW/2-LOGIN_GUI.scale.panel_bg.w/2, y= sH/2-LOGIN_GUI.scale.panel_bg.h/2},
    ["edit_login"] = {x= 882/zoom, y= 297/zoom},
    ["edit_password"] = {x= 882/zoom, y= 399/zoom},
    ["checkbox"] = {x= 882/zoom, y= 470/zoom},
    ["button"] = {x= 882/zoom, y= 519/zoom},
    ["select_bg"] = {x=0, y= sH-LOGIN_GUI.scale.select_bg.h},
    ["select_box"] = {x=(106-18)/zoom, y=LOGIN_GUI.scale.select_bg.h-19/zoom-LOGIN_GUI.scale.select_box.h},
    ["box_header_label"] = {x=(18+27)/zoom, y=(25+9)/zoom},
    ["slider_box"] = {x=1313/zoom, y=LOGIN_GUI.scale.select_bg.h-34/zoom-LOGIN_GUI.scale.slider_box.h},
    ["slider"] = {x=100/zoom, y=(47/zoom)/2-6/zoom},
    ["slider_label"] = {x=(100/zoom)/2+7/zoom, y=(47/zoom)/2+2/zoom},
    ["key_enter"] = {x=LOGIN_GUI.scale.select_bg.w-LOGIN_GUI.scale.key_enter.w-50/zoom, y=LOGIN_GUI.scale.select_bg.h-50/zoom-LOGIN_GUI.scale.key_enter.h},
}

LOGIN_GUI.fonts = {
    ["medium_20"] = dxCreateFont("resources/fonts/Roboto-Medium.ttf", 20.83/zoom, false),
    ["regular_20"] = dxCreateFont("resources/fonts/Roboto-Regular.ttf", 20.83/zoom, false),
    ["bold_14"] = dxCreateFont("resources/fonts/Roboto-Bold.ttf", 14.37/zoom, false),
    ["poppins_regular_22"] = dxCreateFont("resources/fonts/Poppins-Regular.ttf", 22.95/zoom, false),
    ["poppins_medium_37"] = dxCreateFont("resources/fonts/Poppins-Medium.ttf", 37.56/zoom, false),
    ["poppins_medium_32"] = dxCreateFont("resources/fonts/Poppins-Medium.ttf", 31.95/zoom*1.7, false),
    ["poppins_regular_14"] = dxCreateFont("resources/fonts/Poppins-Medium.ttf", 14.78/zoom, false),
    ["poppins_light_15"] = dxCreateFont("resources/fonts/Poppins-Light.ttf", 15.77/zoom, false),
    ["poppins_light_18"] = dxCreateFont("resources/fonts/Poppins-Light.ttf", 18.34/zoom*1.7, false),
}

LOGIN_GUI.timers = {}

LOGIN_GUI.vars = {}

LOGIN_GUI.elements = {}
LOGIN_GUI.elements.select_box = {}
LOGIN_GUI.elements.slider_box = {}
LOGIN_GUI.elements.ch_name = {}