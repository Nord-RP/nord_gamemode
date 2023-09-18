
--Dodać 'zapomniałem hasła' - skopiowanie linku do forum+powiadomienie
    
local sW, sH = guiGetScreenSize()
local login = false
local passLen = false
local remembered = false
local token = false
local fakePass = ""

addEventHandler("onClientResourceStart", resourceRoot, function()
    if (exports.entityData:getEntityData(localPlayer, "ch-id")) then return end
    GUI = LOGIN_GUI
    Camera.fade(true)
    showChat(false)
    showCursor(true)
    setPlayerHudComponentVisible("all", false);
    local file = (File.exists('@:nord_gamemode/remember_me.xml') and XML.load("@:nord_gamemode/remember_me.xml") or false)
    if (file) then 
        local remember = file:findChild("remember", 0)
        if(remember:getValue() == "true") then
            loginNode = file:findChild("name", 0)
            passLenNode = file:findChild("hiddenData", 0)
            tokenNode = file:findChild("token", 0)
            login = loginNode:getValue()
            passLen = passLenNode:getValue()
            token = tokenNode:getValue()
            file:unload()
            remembered = true
            for i = 0, passLen, 1 do
                fakePass = fakePass.."*"
            end
        end
    end

    if (not DEV_MODE) then
        GUI.elements.sound = Sound("login/files/sounds/bg_music.mp3", true);
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
    login, false, nil, false, 1, GUI.txt.editbox, tocolor(255, 255, 255));
    GUI.elements.edit_login:setProperty("placeHolder", "Wpisz swój login...")
    GUI.elements.edit_login:setProperty("placeHolderFont", GUI.fonts.regular_20)
    GUI.elements.edit_login:setProperty("caretHeight", 0.5)
    GUI.elements.edit_login:setProperty("padding",{35*zoom,0})
    GUI.elements.edit_login:setParent(GUI.elements.bg);
    GUI.elements.edit_login:setFont(GUI.fonts.medium_20);

    GUI.elements.edit_password = dgsEdit(GUI.pos.edit_password.x, GUI.pos.edit_password.y, GUI.scale.edit.w, GUI.scale.edit.h,
    fakePass, false, nil, false, 1, GUI.txt.editbox, tocolor(255, 255, 255));
    GUI.elements.edit_password:setProperty("placeHolder", "Hasło")
    GUI.elements.edit_password:setProperty("placeHolderFont", GUI.fonts.regular_20)
    GUI.elements.edit_password:setProperty("caretHeight", 0.5)
    GUI.elements.edit_password:setProperty("padding",{35*zoom,0})
    GUI.elements.edit_password:setProperty("masked", true)
    GUI.elements.edit_password:setParent(GUI.elements.bg);
    GUI.elements.edit_password:setFont(GUI.fonts.medium_20);


    GUI.elements.checkbox = dgsCheckBox(GUI.pos.checkbox.x, GUI.pos.checkbox.y, GUI.scale.checkbox.w, GUI.scale.checkbox.h, "Zapamiętaj hasło", false, false, nil, false, 1, GUI.txt.checkbox, GUI.txt.checkbox_hover, GUI.txt.checkbox_active, false, false, false, GUI.txt.checkbox_active, GUI.txt.checkbox_active, GUI.txt.checkbox)
    GUI.elements.checkbox:setParent(GUI.elements.bg);
    GUI.elements.checkbox:setProperty("buttonSize",{GUI.scale.checkbox.w, GUI.scale.checkbox.h, false});
    GUI.elements.checkbox:setProperty("textOffset",{10*zoom, 0, false});
    GUI.elements.checkbox:setFont(GUI.fonts.bold_14)

    if (token ~= "") then
        GUI.elements.checkbox:setSelected(true)
    end

    GUI.elements.button = dgsButton(GUI.pos.button.x, GUI.pos.button.y, GUI.scale.button.w,
    GUI.scale.button.h, "", false, nil, tocolor(255, 255, 255), 1, GUI.txt.button, GUI.txt.button_active,
    GUI.txt.button, tocolor(255, 255, 255), tocolor(200, 200, 200), tocolor(255, 255, 255));
    GUI.elements.button:setParent(GUI.elements.bg)

    GUI.elements.error = dgsImage(GUI.pos.login_error.x, GUI.pos.login_error.y, GUI.scale.login_error.w, GUI.scale.login_error.h, GUI.txt.login_error, false)
    GUI.elements.error:setParent(GUI.elements.bg)
    GUI.elements.error:setVisible(false)
    local label = dgsLabel(GUI.pos.label_error.x, GUI.pos.label_error.y,0, 0, "Logowanie się nie udało!", false, tocolor(255,255,255), 1, 1, nil, nil, nil, "left", "center")
    label:setParent(GUI.elements.error)
    label:setFont(GUI.fonts.medium_20)
    local label2 = dgsLabel(GUI.pos.label_error2.x, GUI.pos.label_error2.y,0, 0, "Złe hasło lub login, spróbuj ponownie.", false, tocolor(255,255,255), 1, 1, nil, nil, nil, "left", "center")
    label2:setParent(GUI.elements.error)
    label2:setFont(GUI.fonts.medium_12)

    GUI.elements.ok = dgsImage(GUI.pos.login_ok.x, GUI.pos.login_ok.y, GUI.scale.login_ok.w, GUI.scale.login_ok.h, GUI.txt.login_ok, false)
    GUI.elements.ok:setParent(GUI.elements.bg)
    GUI.elements.ok:setVisible(false)
    local label = dgsLabel(GUI.pos.label_ok.x, GUI.pos.label_ok.y,0, 0, "Zalogowałeś się na konto!", false, tocolor(255,255,255), 1, 1, nil, nil, nil, "left", "center")
    label:setParent(GUI.elements.ok)
    label:setFont(GUI.fonts.medium_20)

    addEventHandler("onDgsFocus", root, dgsFocus)
    addEventHandler("onDgsBlur", root, dgsBlur)
    addEventHandler("onDgsTextChange", root, dgsEditChange)
    addEventHandler ( "onDgsMouseClick", root, loginUser )
end)

function dgsEditChange()
    if (source == GUI.elements.edit_password:getElement()) or (source == GUI.elements.edit_login:getElement()) then
        if remembered then
            remembered = false
            token = false
            GUI.elements.edit_password:setText("")
        end
    end
end

function loginUser(button, state)
    if not (source == GUI.elements.button:getElement()) then return end
    if(state == "down") then return end
    login = GUI.elements.edit_login:getText()
    local pass = GUI.elements.edit_password:getText()
    if (not remembered) then
        passLen = string.len(pass)
    end
    local remember = GUI.elements.checkbox:getSelected()
    triggerServerEvent("server:loginRequest", resourceRoot, login, pass, remember, token)
end


addEvent("client:loginRequest", true)
addEventHandler("client:loginRequest", getRootElement(), function(status, errorCode, characters, token)
    GUI.elements.error:setVisible(false)
    GUI.elements.ok:setVisible(false)
    if not(status) then 
        playSound("resources/sounds/error.mp3")
        local children = GUI.elements.error:getChildren()
        if(errorCode == "wrong_pass") then
            children[2]:setText("Złe hasło lub login, spróbuj ponownie.")
        elseif(errorCode == "no_characters") then
            children[2]:setText("Brak aktywnych postaci, stwórz nowe na forum!")
        elseif(errorCode == "user_logged") then
            children[2]:setText("Ktoś już jest zalogowany na to konto!")
        end
        GUI.elements.error:setVisible(true)
    return end
    if token then
        local file = XML( "@:nord_gamemode/remember_me.xml", "root")
        local rememberNode = file:createChild("remember")
        local tokenNode = file:createChild("token")
        local nameNode = file:createChild("name")
        local passLenNode = file:createChild("hiddenData")
        rememberNode:setValue("true")
        tokenNode:setValue(token)
        nameNode:setValue(login)
        passLenNode:setValue(passLen)
        file:saveFile()
        file:unload()
    else
        local file = XML( "@:nord_gamemode/remember_me.xml", "root")
        local rememberNode = file:createChild("remember")
        local tokenNode = file:createChild("token")
        rememberNode:setValue("false")
        tokenNode:setValue("")
        file:saveFile()
        file:unload()
    end
    GUI.elements.ok:setVisible(true)
    local black = dgsImage(0, 0, sW, sH, nil, false, tocolor(0,0,0,255))
    black:setAlpha(0)
    black:setLayer("top")
    black:alphaTo(1, "Linear", 1000)
    playSound("resources/sounds/ok.mp3")
    Timer(function()
        GUI.elements.browser_image:getElement():destroy()
        GUI.elements.browser:destroy()
        displayCharacterSelection(characters)
        black:alphaTo(0, "Linear", 1000)
        Timer(function()
            black:getElement():destroy()
        end, 1000, 1)
    end,1000,1)
end)

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

addEventHandler("onClientResourceStart", resourceRoot, function()
    local characterId = exports.entityData:getEntityData(localPlayer, "ch-id")
    if not characterId then return end
    localPlayer:addPlayerLoginBinds()
end)