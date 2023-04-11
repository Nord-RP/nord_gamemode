local sW, sH = guiGetScreenSize()



addEventHandler("onClientResourceStart", resourceRoot, function()
    GUI = LOGIN_GUI
    showChat(false);
    showCursor(true);
    setPlayerHudComponentVisible("all", false);

    if (not DEV_MODE) then
        GUI.elements.sound = Sound("login/files/sounds/bg_music.mp3", true, false);
        GUI.elements.sound:setVolume(0.5);
    end

    GUI.elements.browser = dgsCreateMediaBrowser(sW, sH);
    dgsMediaLoadMedia(GUI.elements.browser, "login/files/movie/bg_video.webm", "video")
    GUI.elements.browser_image = dgsImage(0, 0, sW, sH, GUI.elements.browser, false);
    dgsMediaPlay(GUI.elements.browser);
    dgsMediaSetLooped(GUI.elements.browser, true);

    GUI.elements.bg = dgsImage(GUI.pos.panel_bg.x, GUI.pos.panel_bg.y, GUI.scale.panel_bg.w, GUI.scale.panel_bg.h,
    GUI.txt.panel_bg);
    GUI.elements.bg:setParent(GUI.elements.browser_image);

    GUI.elements.edit_login = dgsEdit(GUI.pos.edit_login.x, GUI.pos.edit_login.y, GUI.scale.edit.w, GUI.scale.edit.h,
    "", false, nil, false, 1, GUI.txt.editbox, tocolor(255, 255, 255));
    GUI.elements.edit_login:setProperty("placeHolder", "Wpisz swój login...")
    GUI.elements.edit_login:setProperty("placeHolderFont", GUI.fonts.regular_20)
    GUI.elements.edit_login:setProperty("caretHeight", 0.5)
    GUI.elements.edit_login:setProperty("padding",{35/zoom,0})
    GUI.elements.edit_login:setParent(GUI.elements.bg);
    GUI.elements.edit_login:setFont(GUI.fonts.medium_20);

    GUI.elements.edit_password = dgsEdit(GUI.pos.edit_password.x, GUI.pos.edit_password.y, GUI.scale.edit.w, GUI.scale.edit.h,
    "", false, nil, false, 1, GUI.txt.editbox, tocolor(255, 255, 255));
    GUI.elements.edit_password:setProperty("placeHolder", "Hasło")
    GUI.elements.edit_password:setProperty("placeHolderFont", GUI.fonts.regular_20)
    GUI.elements.edit_password:setProperty("caretHeight", 0.5)
    GUI.elements.edit_password:setProperty("padding",{35/zoom,0})
    GUI.elements.edit_password:setProperty("masked", true)
    GUI.elements.edit_password:setParent(GUI.elements.bg);
    GUI.elements.edit_password:setFont(GUI.fonts.medium_20);

    GUI.elements.button = dgsButton(GUI.pos.button.x, GUI.pos.button.y, GUI.scale.button.w,
    GUI.scale.button.h, "", false, nil, tocolor(255, 255, 255), 1, GUI.txt.button, GUI.txt.button_active,
    GUI.txt.button, tocolor(255, 255, 255), tocolor(200, 200, 200), tocolor(255, 255, 255));
    GUI.elements.button:setParent(GUI.elements.bg);

    addEventHandler("onDgsFocus", root, dgsFocus)
    addEventHandler("onDgsBlur", root, dgsBlur)
    addEventHandler ( "onDgsMouseClick", root, loginUser )

end)

function loginUser(button, state)
    if not (source == GUI.elements.button:getElement()) then return end
    if(state == "down") then return end
    local name = GUI.elements.edit_login:getText()
    print("Nazwa: "..name)
    triggerServerEvent("onLoginRequest", localPlayer, name)
end


function dgsFocus()
    if(source == GUI.elements.edit_login:getElement()) then
        GUI.elements.edit_login:setProperty("bgImage", GUI.txt.editbox_active)
    elseif(source == GUI.elements.edit_password:getElement()) then
        GUI.elements.edit_password:setProperty("bgImage", GUI.txt.editbox_active)
    end
end

function dgsBlur()
    if(source == GUI.elements.edit_login:getElement()) then
        GUI.elements.edit_login:setProperty("bgImage", GUI.txt.editbox)
    elseif(source == GUI.elements.edit_password:getElement()) then
        GUI.elements.edit_password:setProperty("bgImage", GUI.txt.editbox)
    end
end