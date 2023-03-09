loadstring(exports.dgs:dgsImportOOPClass(true))()-- load OOP class
local sW,sH = guiGetScreenSize()
local dev = true

addEventHandler("onClientResourceStart", resourceRoot, function()
    showChat(false);
    showCursor(true);
    setPlayerHudComponentVisible("all", false);

    if(not dev) then
        GUI.elements.sound = Sound("files/sound/bg_music.mp3");
        GUI.elements.sound:setVolume(0.5);
    end
    GUI.elements.browser = dgsCreateMediaBrowser(sW,sH);
    dgsMediaLoadMedia(GUI.elements.browser,"files/movie/bg_video.webm", "video")
    GUI.elements.browser_image = dgsImage(0,0,sW,sH, GUI.elements.browser, false);
    dgsMediaPlay(GUI.elements.browser);

    GUI.elements.bg = dgsImage(GUI.pos.panel_bg.x,GUI.pos.panel_bg.y, GUI.scale.panel_bg.w, GUI.scale.panel_bg.h, GUI.txt.panel_bg);
    GUI.elements.bg:setParent(GUI.elements.browser_image);

    GUI.elements.bg_left = dgsImage(GUI.pos.panel_bg_left.x,GUI.pos.panel_bg_left.y, GUI.scale.panel_bg_left.w, GUI.scale.panel_bg_left.h, GUI.txt.panel_bg_left);
    GUI.elements.bg_left:setParent(GUI.elements.bg);

    GUI.elements.login_tab = dgsButton(GUI.pos.login.x-10/zoom, GUI.pos.login.y, GUI.scale.login.w, GUI.scale.login.h, "", false, nil, tocolor(255,255,255), 1, GUI.txt.login, GUI.txt.login_hover, GUI.txt.login, tocolor(255,255,255),tocolor(255,255,255),tocolor(255,255,255))
    GUI.elements.login_tab:setParent(GUI.elements.bg);

    GUI.elements.register_tab = dgsButton(GUI.pos.register.x, GUI.pos.register.y, GUI.scale.register.w, GUI.scale.register.h, "", false, nil, tocolor(255,255,255), 1, GUI.txt.register_off, GUI.txt.register_hover, GUI.txt.register_off, tocolor(255,255,255),tocolor(255,255,255),tocolor(255,255,255))
    GUI.elements.register_tab:setParent(GUI.elements.bg);

    GUI.vars.tab = "login";

    GUI.elements.online_label = dgsLabel(GUI.pos.online_label.x, GUI.pos.online_label.y, 0, 0, "Online", false, tocolor(255,255,255), 1, 1, nil, nil, nil, "right" , "top")
    GUI.elements.online_label:setParent(GUI.elements.bg);
    GUI.elements.online_label:setFont(GUI.fonts.font_4);

    GUI.elements.counter_label = dgsLabel(GUI.pos.counter_label.x, GUI.pos.counter_label.y, 0, 0, #getElementsByType("player"), false, tocolor(255,255,255), 1, 1, nil, nil, nil, "right" , "top")
    GUI.elements.counter_label:setParent(GUI.elements.bg);
    GUI.elements.counter_label:setFont(GUI.fonts.font_12);

    GUI.elements.online = dgsImage(GUI.pos.online.x,GUI.pos.online.y, GUI.scale.online.w, GUI.scale.online.h, GUI.txt.online);
    GUI.elements.online:setParent(GUI.elements.bg);
    GUI.elements.online_blink = dgsImage(GUI.pos.online.x,GUI.pos.online.y, GUI.scale.online.w, GUI.scale.online.h, GUI.txt.online_blink);
    GUI.elements.online_blink:setParent(GUI.elements.bg);
    GUI.elements.online_blink:setAlpha(0);
    GUI.vars.online = false;

    GUI.timers.online = setTimer(function()
        if(GUI.vars.online == false) then
            GUI.elements.online_blink:alphaTo(1, "Linear", 500); 
            GUI.vars.online = true
        else
            GUI.elements.online_blink:alphaTo(0, "Linear", 500); 
            GUI.vars.online = false
        end
        GUI.elements.counter_label:setProperty("text", #getElementsByType("player"));
    end, 1000, 0);

    addEventHandler("onDgsMouseEnter", root, dgsEnter)
    addEventHandler("onDgsMouseLeave", root, dgsLeave)
    addEventHandler("onDgsMouseClick", root, dgsClick)
    --addEventHandler("onClientRender", getRootElement(), renderSound)
end)

function dgsClick()
    if(source == GUI.elements.register_tab:getElement()) then
        if not (GUI.vars.tab == "register") then
            GUI.vars.tab = "register"
            GUI.elements.login_tab:moveTo(GUI.pos.login.x, GUI.pos.login.y, false, "Linear", 100);
            GUI.elements.register_tab:setProperty("image", {GUI.txt.register, GUI.txt.register_hover, GUI.txt.register})
            GUI.elements.login_tab:setProperty("image", {GUI.txt.login_off, GUI.txt.login_hover, GUI.txt.login_off})
        end
    elseif(source == GUI.elements.login_tab:getElement()) then
        if not (GUI.vars.tab == "login") then
            GUI.vars.tab = "login"
            GUI.elements.register_tab:moveTo(GUI.pos.register.x, GUI.pos.register.y, false, "Linear", 100);
            GUI.elements.register_tab:setProperty("image", {GUI.txt.register_off, GUI.txt.register_hover, GUI.txt.register_off})
            GUI.elements.login_tab:setProperty("image", {GUI.txt.login, GUI.txt.login_hover, GUI.txt.login})
        end
    end
end

function dgsEnter()
    if(source == GUI.elements.register_tab:getElement()) then
        if not (GUI.vars.tab == "register") then
            GUI.elements.register_tab:moveTo(GUI.pos.register.x+10/zoom, GUI.pos.register.y, false, "Linear", 100);
        end
    elseif(source == GUI.elements.login_tab:getElement()) then
        if not (GUI.vars.tab == "login") then
            GUI.elements.login_tab:moveTo(GUI.pos.login.x-10/zoom, GUI.pos.login.y, false, "Linear", 100);
        end
    end
end

function dgsLeave()
    if(source == GUI.elements.register_tab:getElement()) then
        if not (GUI.vars.tab == "register") then
            GUI.elements.register_tab:moveTo(GUI.pos.register.x, GUI.pos.register.y, false, "Linear", 100);
        end
    elseif(source == GUI.elements.login_tab:getElement()) then
        if not (GUI.vars.tab == "login") then
            GUI.elements.login_tab:moveTo(GUI.pos.login.x, GUI.pos.login.y, false, "Linear", 100);
        end
    end
end

function renderSound()
    if ( GUI.elements.sound ) then
        local soundFFT = GUI.elements.sound:getFFTData (2048, 256 )
	if ( soundFFT ) then
            for i = 0, 4 do -- Data starts from index 0
                dxDrawRectangle ( i*20, sH, 20, -(math.sqrt ( soundFFT[i] ) * 100) )
            end
        end
    end
end