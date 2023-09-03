--Timeouty, co by nie klikac zbyt szybko
--Zapamietywanie ostatniej postaci
--GUI

addEventHandler("onResourceStart", resourceRoot, function()
    local entityDataResource = Resource.getFromName("entityData")
    local resourceStatus = entityDataResource:getState()
    if (resourceStatus ~= "running") then
        restartResource(getThisResource())
    end
end)

local selectionCharacters = {}
local charactersT
local currentCharacter = 1
function displayCharacterSelection(characters)
    charactersT = characters
    Camera.setMatrix(217, 77.5, 1005.5, 215, 77.5, 1005.5)
    localPlayer:setInterior(6, 246, 62, 1002)
    for i,v in pairs(characters) do
        selectionCharacters[i] = {
            element = false,
        }
    end
    local ped = Ped(characters[1].skin, 215, 77.5, 1005, -90)
    selectionCharacters[1].element = ped
    ped:setInterior(6, 215, 77.5, 1005)
    bindKey("arrow_l", "down", moveCharacter)
    bindKey("arrow_r", "down", moveCharacter)
    Timer(function()
        removeWorldModel(14846, 10000, 213, 80, 1009, 6)
    end,100,1)
    
    drawCharacterSelection()
end

function drawCharacterSelection()

    local object = Object(2680, 215, 77.5, 1005.5)
    object:setDoubleSided(true)
    object:setInterior(6, 216, 77.5, 1004)
    
    GUI.elements.ch_select = dgsImage(GUI.pos.select_bg.x, GUI.pos.select_bg.y, GUI.scale.select_bg.w, GUI.scale.select_bg.h, GUI.txt.select_bg, false)
    GUI.elements.ch_enter = dgsImage(GUI.pos.key_enter.x, GUI.pos.key_enter.y, GUI.scale.key_enter.w, GUI.scale.key_enter.h, GUI.txt.key_enter, false)
    GUI.elements.ch_enter:setParent(GUI.elements.ch_select)
    --Boxy
    for i=0, 3 do
        local box_x = 0
        if (i == 0) then
            box_x = GUI.pos.select_box.x
        else
            box_x = GUI.pos.select_box.x+(GUI.scale.select_box.w*i)+((20*zoom)*i)
        end
        GUI.elements.select_box[i] = dgsImage(box_x, GUI.pos.select_box.y, GUI.scale.select_box.w, GUI.scale.select_box.h, GUI.txt.select_box, false)
        local image = GUI.elements.select_box[i]
        image:setParent(GUI.elements.ch_select)

        local label_name = ""
        local label_content = ""
        local label_description = ""
        if(i == 0) then
            label_name = "Konto bankowe"
            label_content = "#83d19b$#cac9cc"..formatNumber(charactersT[1].bank_money, ",")
            label_description = "#83d19bPieniądze w banku"
        elseif(i==1) then
            label_name = "Gotówka"
            label_content = "#83d19b$#cac9cc"..formatNumber(charactersT[1].money, ",")
            label_description = "#83d19bPieniądze w portfelu"
        elseif(i==2) then
            label_name = "Punkty"
            local points = exports.entityData:getEntityData(localPlayer, "member_points") or 0
            label_content = "#7a79b5"..points
            label_description = "#7a79b5NordPoints"
        elseif(i==3) then
            local game_h, game_m = msToGameTime(charactersT[1].playtime)
            label_name = "Czas gry"
            label_content = "#799eb5"..game_h.."h "..game_m.."m"
            label_description = "#799eb5Czas przegrany na postaci"
        end
        local label = dgsLabel(GUI.pos.box_header_label.x, GUI.pos.box_header_label.y, 0, 0, label_name, false, tocolor(155, 152, 162))
        label:setParent(image)
        label:setFont(GUI.fonts.poppins_regular_22)

        local fontHeight = GUI.fonts.poppins_regular_22:getHeight()
        local label = dgsLabel(GUI.pos.box_header_label.x, GUI.pos.box_header_label.y+fontHeight/2+5*zoom, 0, 0, label_content, false, tocolor(155, 152, 162))
        label:setParent(image)
        label:setFont(GUI.fonts.poppins_medium_37)
        label:setProperty("colorCoded", true)

        local fontHeightNew = GUI.fonts.poppins_light_15:getHeight()
        local label = dgsLabel(GUI.pos.box_header_label.x, GUI.pos.box_header_label.y+fontHeight/2+5*zoom+fontHeightNew+30*zoom, 0, 0, label_description, false, tocolor(155, 152, 162))
        label:setProperty("colorCoded", true)
        label:setParent(image)
        label:setFont(GUI.fonts.poppins_light_15)
    end
    --Progress bary/slidery
    for i=0, 2 do
        local slider_y = 0;
        if(i == 0) then
            slider_y = GUI.pos.slider_box.y
        else
            slider_y = GUI.pos.slider_box.y-(9*i*zoom)-GUI.scale.slider_box.h*i
        end
        GUI.elements.slider_box[i] = dgsImage(GUI.pos.slider_box.x, slider_y, GUI.scale.slider_box.w, GUI.scale.slider_box.h, GUI.txt.slider_box, false)
        local slider_bg = GUI.elements.slider_box[i]
        slider_bg:setParent(GUI.elements.ch_select)

        local color = false
        local text = ""
        local progress = 0
        if(i == 0) then
            color = tocolor(130, 209, 154)
            text = "Zdrowie"
            progress = charactersT[1].health
        elseif(i == 1) then
            color = tocolor(105, 173, 188)
            text = "Psychika"
            progress = charactersT[1].psyche
        else
            color = tocolor(81, 83, 176)
            text = "Siła"
            progress = charactersT[1].strength
        end
        local slider = dgsProgressBar(GUI.pos.slider.x, GUI.pos.slider.y, GUI.scale.slider.w, GUI.scale.slider.h, false, GUI.txt["slider_bg"..i+1], tocolor(255,255,255), GUI.txt.slider_fill, color, true)
        slider:setParent(slider_bg)
        slider:setProperty("padding", {0,0})
        slider:setProgress(progress)

        local fontHeight = GUI.fonts.poppins_regular_14:getHeight()
        local label = dgsLabel(GUI.pos.slider_label.x, GUI.pos.slider_label.y, 0, 0, text, false, tocolor(155, 152, 162))
        label:setParent(slider_bg)
        label:setProperty("alignment", {"center","center"})
        label:setFont(GUI.fonts.poppins_regular_14)
    end
    --local x,y,z = selectionCharacters[1].element:getBonePosition()
    GUI.elements.ch_name[1] = dgs3DInterface(215, 77.5, 1005.5, 0.15*2.69,0.15,GUI.scale.character_name.w, GUI.scale.character_name.h,tocolor(255,255,255,255))
    local ch_name = GUI.elements.ch_name[1]
    ch_name:attachToElement(selectionCharacters[1].element,0,0,1)
    local image = dgsImage(0,0,1,1, GUI.txt.character_name, tocolor(255,255,255), false)
    image:setParent(ch_name)
        
    local fontHeight = GUI.fonts.poppins_medium_32:getHeight()
    local label = dgsLabel(GUI.scale.character_name.w/2, fontHeight-30*zoom, 0, 0, "#cac9cc"..charactersT[1].name.." "..charactersT[1].surname, false, tocolor(155, 152, 162))
    label:setParent(image)
    label:setProperty("alignment", {"center","center"})
    label:setFont(GUI.fonts.poppins_medium_32)
    label:setProperty("colorCoded", true)

    local label = dgsLabel(GUI.scale.character_name.w/2, fontHeight+30*zoom, 0, 0, "#cac9ccUID "..charactersT[1].id, false, tocolor(155, 152, 162))
    label:setParent(image)
    label:setProperty("alignment", {"center","center"})
    label:setFont(GUI.fonts.poppins_light_18)
    label:setProperty("colorCoded", true)
    bindKey("enter", "down", selectCharacter)
end

function selectCharacter()
    GUI.elements.ch_select:destroy()
    for i,v in pairs(GUI.elements.ch_name) do
        v:destroy()
    end
    Camera.fade(false, 1)
    triggerServerEvent("server:characterSelection", resourceRoot, charactersT[currentCharacter].id)
    for i,v in pairs(selectionCharacters) do
        if isElement(v.element) then
            v.element:destroy()
        end
    end
end

function updateLabels()
    for i=0, 3 do
        local children = GUI.elements.select_box[i]:getChildren()
        local label_content = ""
        if(i == 0) then
            label_content = "#83d19b$#cac9cc"..formatNumber(charactersT[currentCharacter].bank_money, ",")
        elseif(i==1) then
            label_content = "#83d19b$#cac9cc"..formatNumber(charactersT[currentCharacter].money, ",")
        elseif(i==2) then
            label_content = "#7a79b5"..exports.entityData:getEntityData(localPlayer, "member_points")
        elseif(i==3) then
            local game_h, game_m = msToGameTime(charactersT[currentCharacter].playtime)
            label_content = "#799eb5"..game_h.."h "..game_m.."m"
        end
        children[2]:setText(label_content)
    end
    for i=0, 2 do
        local children = GUI.elements.slider_box[i]:getChildren()
        local progress = 0
        if(i == 0) then
            progress = charactersT[currentCharacter].health
        elseif(i == 1) then
            progress = charactersT[currentCharacter].psyche
        else
            progress = charactersT[currentCharacter].strength
        end
        children[1]:setProgress(progress)
    end
end

function moveCharacter(key)
    if(key == "arrow_l") then
        local ped = selectionCharacters[currentCharacter].element
        Timer(destroyElement, 1000,1, GUI.elements.ch_name[currentCharacter]:getElement())
        ped:setRotation(0, 0, 180, "default", true)
        setPedAnalogControlState(ped, "forwards", 0.5)

        if(currentCharacter+1 > #charactersT) then
            currentCharacter=1
        else
            currentCharacter=currentCharacter+1
        end

        local newPed = Ped(charactersT[currentCharacter].skin, 214.5, 79.5, 1005, 180)
        newPed:setInterior(6, 214.4, 79.5, 1005)
        selectionCharacters[currentCharacter].element = newPed
        setPedAnalogControlState(newPed, "forwards", 0.5)

        GUI.elements.ch_name[currentCharacter] = dgs3DInterface(215, 77.5, 1005.5, 0.15*2.69,0.15,GUI.scale.character_name.w, GUI.scale.character_name.h,tocolor(255,255,255,255))
        local ch_name = GUI.elements.ch_name[currentCharacter]
        ch_name:attachToElement(selectionCharacters[currentCharacter].element,0,0,1)
        local image = dgsImage(0,0,1,1, GUI.txt.character_name, tocolor(255,255,255), false)
        image:setParent(ch_name)
            
        local fontHeight = GUI.fonts.poppins_medium_32:getHeight()
        local label = dgsLabel(GUI.scale.character_name.w/2, fontHeight-30*zoom, 0, 0, "#cac9cc"..charactersT[currentCharacter].name.." "..charactersT[currentCharacter].surname, false, tocolor(155, 152, 162))
        label:setParent(image)
        label:setProperty("alignment", {"center","center"})
        label:setFont(GUI.fonts.poppins_medium_32)
        label:setProperty("colorCoded", true)
    
        local label = dgsLabel(GUI.scale.character_name.w/2, fontHeight+30*zoom, 0, 0, "#cac9ccUID "..charactersT[currentCharacter].id, false, tocolor(155, 152, 162))
        label:setParent(image)
        label:setProperty("alignment", {"center","center"})
        label:setFont(GUI.fonts.poppins_light_18)
        label:setProperty("colorCoded", true)

        Timer(destroyElement, 1000, 1, ped)
        Timer(function()
            setPedAnalogControlState(newPed, "forwards", 0)
            newPed:setRotation(0,0,-90,"default", true)
            bindKey("arrow_r", "down", moveCharacter)
            bindKey("arrow_l", "down", moveCharacter)
        end, 1180, 1)
        unbindKey("arrow_r", "down", moveCharacter)
        unbindKey("arrow_l", "down", moveCharacter)
        updateLabels()
    else
        local ped = selectionCharacters[currentCharacter].element
        Timer(destroyElement, 1000,1, GUI.elements.ch_name[currentCharacter]:getElement())
        ped:setRotation(0, 0, 0, "default", true)
        setPedAnalogControlState(ped, "forwards", 0.5)

        if(currentCharacter-1 < 1) then
            currentCharacter=#charactersT
        else
            currentCharacter=currentCharacter-1
        end

        local newPed = Ped(charactersT[currentCharacter].skin, 214.5, 75.5, 1005, 0)
        newPed:setInterior(6, 214.7, 75.5, 1005)
        selectionCharacters[currentCharacter].element = newPed

        GUI.elements.ch_name[currentCharacter] = dgs3DInterface(215, 77.5, 1005.5, 0.15*2.69,0.15,GUI.scale.character_name.w, GUI.scale.character_name.h,tocolor(255,255,255,255))
        local ch_name = GUI.elements.ch_name[currentCharacter]
        ch_name:attachToElement(selectionCharacters[currentCharacter].element,0,0,1)
        local image = dgsImage(0,0,1,1, GUI.txt.character_name, tocolor(255,255,255), false)
        image:setParent(ch_name)
            
        local fontHeight = GUI.fonts.poppins_medium_32:getHeight()
        local label = dgsLabel(GUI.scale.character_name.w/2, fontHeight-30*zoom, 0, 0, "#cac9cc"..charactersT[currentCharacter].name.." "..charactersT[currentCharacter].surname, false, tocolor(155, 152, 162))
        label:setParent(image)
        label:setProperty("alignment", {"center","center"})
        label:setFont(GUI.fonts.poppins_medium_32)
        label:setProperty("colorCoded", true)
    
        local label = dgsLabel(GUI.scale.character_name.w/2, fontHeight+30*zoom, 0, 0, "#cac9ccUID "..charactersT[currentCharacter].id, false, tocolor(155, 152, 162))
        label:setParent(image)
        label:setProperty("alignment", {"center","center"})
        label:setFont(GUI.fonts.poppins_light_18)
        label:setProperty("colorCoded", true)

        setPedAnalogControlState(newPed, "forwards", 0.5)
        Timer(destroyElement, 1000, 1, ped)
        Timer(function()
            setPedAnalogControlState(newPed, "forwards", 0)
            newPed:setRotation(0,0,-90,"default", true)
            bindKey("arrow_r", "down", moveCharacter)
            bindKey("arrow_l", "down", moveCharacter)
        end, 1170, 1)
        unbindKey("arrow_r", "down", moveCharacter)
        unbindKey("arrow_l", "down", moveCharacter)
        updateLabels()
    end
end

function formatNumber(number, sep)
	assert(type(tonumber(number))=="number", "Bad argument @'formatNumber' [Expected number at argument 1 got "..type(number).."]")
	assert(not sep or type(sep)=="string", "Bad argument @'formatNumber' [Expected string at argument 2 got "..type(sep).."]")
	local money = number
	for i = 1, tostring(money):len()/3 do
		money = string.gsub(money, "^(-?%d+)(%d%d%d)", "%1"..sep.."%2")
	end
	return money
end

function msToGameTime(ms)
    local hours = math.floor(ms / (1000 * 60 * 60))
    local minutes = math.floor((ms % (1000 * 60 * 60)) / (1000 * 60))
    return hours, minutes
  end