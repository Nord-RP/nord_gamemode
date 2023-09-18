local font = dxCreateFont("resources/fonts/LATOWEB-SEMIBOLD.TTF", 11)
local cachedNames = {}
local cachedIcons = {}
local iconNames = {
    ["chat"] = "chat_icon.png",
    ["phone"] = "phone_icon.png",
}

addEventHandler("onClientResourceStart", resourceRoot, function()
    if(exports.entityData:getEntityData(localPlayer, "ch-name")) then
        cachedNames[localPlayer] = {
            name= exports.entityData:getEntityData(localPlayer, "ch-name"),
            surname= exports.entityData:getEntityData(localPlayer, "ch-surname"),
            id= exports.entityData:getEntityData(localPlayer, "p-id") or false,
        }
    end
    if DEV_MODE then
        print("NameTag ped created")
        local ped = Ped(0, 0, 0, 3)
        exports.entityData:setEntityData(ped, "ch-name", "John")
        exports.entityData:setEntityData(ped, "ch-surname", "Doe")
        exports.entityData:setEntityData(ped, "p-id", 21)
        exports.entityData:setEntityData(ped, "ch-icon-chat", true)
        exports.entityData:setEntityData(ped, "ch-icon-phone", true)
    end
end)

function onClientEntityDataChange(theKey, oldValue, newValue, dataType)
	if theKey == "ch-name" then
        if source ~= localPlayer then return end
        cachedNames[localPlayer] = {
            name= exports.entityData:getEntityData(localPlayer, "ch-name"),
            surname= exports.entityData:getEntityData(localPlayer, "ch-surname"),
            id= exports.entityData:getEntityData(localPlayer, "p-id") or false,
        }
    elseif string.find(theKey, "ch-icon", 1, true) then
        if not isElementStreamedIn(source) then return end
        local iconName = getLastWord(theKey)
        if iconNames[iconName] then
            if not cachedIcons[source] then
                cachedIcons[source] = {}
            end
            cachedIcons[source][iconName] = newValue
        end
	end
end
addEventHandler("onClientEntityDataChange", root, onClientEntityDataChange)


addEventHandler("onClientElementStreamIn", root, function()
    if source:getType() == "player" or source:getType() == "ped" then
        if exports.entityData:getEntityData(source, "ch-name") then
            cachedNames[source] = {
                name= exports.entityData:getEntityData(source, "ch-name"),
                surname= exports.entityData:getEntityData(source, "ch-surname"),
                id= exports.entityData:getEntityData(source, "p-id") or false,
            }
        end
    end
    for i,v in pairs(iconNames) do
        local iconStatus = exports.entityData:getEntityData(source, "ch-icon-"..i)
        if not cachedIcons[source] then
            cachedIcons[source] = {}
        end
        cachedIcons[source][i] = iconStatus
    end
end)

addEventHandler("onClientElementStreamOut", root, function()
    if source:getType() == "player" or source:getType() == "ped" then
        if exports.entityData:getEntityData(source, "ch-name") then
            cachedNames[source] = nil
        end
        cachedIcons[source] = nil
    end
end)


addEventHandler("onClientRender", root, function()
    local chatBoxOpen = GuiElement.isChatBoxInputActive()
    local chatBoxOpenData = exports.entityData:getEntityData(localPlayer, "ch-icon-chat")
    if chatBoxOpen and not chatBoxOpenData then
        outputChatBox("test2")
        exports.entityData:setEntityData(localPlayer, "ch-icon-chat", true)
    elseif not chatBoxOpen and chatBoxOpenData then
        outputChatBox("test3")
        exports.entityData:setEntityData(localPlayer, "ch-icon-chat", false)
    end

    local px, py, pz, tx, ty, tz, dist
    px,py,pz = getCameraMatrix()
    for player,v in pairs(cachedNames) do
        tx, ty, tz = getElementPosition(player)
        dist = math.sqrt( ( px - tx ) ^ 2 + ( py - ty ) ^ 2 + ( pz - tz ) ^ 2 )

        local progress = dist/20
        local scale = interpolateBetween (
            1,0,0,
            0.9,0,0,
            progress,"OutQuad"
        )

        local opdist = 20-(20/3)--options.distance-(options.distance/3)
        local progress2 = (dist-20/3)/opdist
        local textalpha = interpolateBetween (
            255,0,0,
            0,0,0,
            progress2,"InQuad"
        )

        local textHeight = dxGetFontHeight (scale,font)
        if dist <= 20.0 then
            if isLineOfSightClear( px, py, pz, tx, ty, tz, true, false, false, true, false, false, false,localPlayer ) then
                local bonePosition = player:getBonePosition(5)
                local sx,sy,sz = bonePosition.x, bonePosition.y, bonePosition.z
                x,y = getScreenFromWorldPosition( sx, sy, sz + 0.3, 25, false)
                
                if x then -- getScreenFromWorldPosition returns false if the point isn't on screen
                    posY = y-textHeight
                    local text = "[#c7c6c5"..v.id.."#ffffff] "..v.name.." "..v.surname
                    local alpha = 255 - ((dist - 10) * (255 / 10))
                    dxDrawText( text, x, posY, x, posY, tocolor(255, 255, 255, textalpha), scale, font, "center", "center", false, false, false, true)
                end
            end
        end
        if cachedIcons[player] then
            local iT = 0
            local totalIconsWidth = 0
            for i,v in pairs(cachedIcons[player]) do
                if not cachedIcons[player][i] then break end
                totalIconsWidth = totalIconsWidth+32*zoom
            end
            local prevWidth = 0

            local iconScale = 32*zoom*scale
            totalIconsWidth = totalIconsWidth*scale
            for i,v in pairs(cachedIcons[player]) do
                if not cachedIcons[player][i] then break end
                if dist <= 20.0 then
                    local bonePosition = player:getBonePosition(8)
                    local sx,sy,sz = bonePosition.x, bonePosition.y, bonePosition.z
                    local distMultiplier = dist/10
                    --local x,y = getScreenFromWorldPosition( sx, sy, sz, 25, false)

                    prevWidth = iconScale+prevWidth+5
                    if x then 
                        local ix,iy = x - totalIconsWidth/2 + prevWidth - iconScale, posY-iconScale-10
                        if ix then
                            dxDrawImage(ix, iy, iconScale, iconScale, "nametags/files/img/"..iconNames[i],0,0,0,tocolor(255,255,255,textalpha))
                        end
                    end
                end
            end
        end
    end
end)


function getLastWord(str)
    local words = {}
    for word in string.gmatch(str, "([^%-]+)") do
        table.insert(words, word)
    end
    return words[#words]
end