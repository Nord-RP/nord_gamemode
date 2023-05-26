local font = dxCreateFont("resources/fonts/LATOWEB-SEMIBOLD.TTF", 11)
local cachedNames = {}
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
    end
end)

function onClientEntityDataChange(theKey, oldValue, newValue, dataType)
    if source ~= localPlayer then return end
	if theKey == "ch-name" then
        cachedNames[localPlayer] = {
            name= exports.entityData:getEntityData(localPlayer, "ch-name"),
            surname= exports.entityData:getEntityData(localPlayer, "ch-surname"),
            id= exports.entityData:getEntityData(localPlayer, "p-id") or false,
        }
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
end)

addEventHandler("onClientElementStreamOut", root, function()
    if source:getType() == "player" or source:getType() == "ped" then
        if exports.entityData:getEntityData(source, "ch-name") then
            cachedNames[source] = nil
        end
    end
end)


addEventHandler("onClientRender", root, function()
    local px, py, pz, tx, ty, tz, dist
    px,py,pz = getCameraMatrix()
    for player,v in pairs(cachedNames) do
        tx, ty, tz = getElementPosition(player)
        dist = math.sqrt( ( px - tx ) ^ 2 + ( py - ty ) ^ 2 + ( pz - tz ) ^ 2 )
        if dist <= 20.0 then
            if isLineOfSightClear( px, py, pz, tx, ty, tz, true, false, false, true, false, false, false,localPlayer ) then
                local sx, sy, sz = getPedBonePosition(player, 5 )
                local x,y = getScreenFromWorldPosition( sx, sy, sz + 0.3 )
                if x then -- getScreenFromWorldPosition returns false if the point isn't on screen
                    local text = "[#c7c6c5"..v.id.."#ffffff] "..v.name.." "..v.surname
                    local alpha = 255 - ((dist - 10) * (255 / 10))
                    dxDrawText( text, x, y, x, y, tocolor(255, 255, 255, math.max(0, math.min(alpha, 255))), 0.85 + ( 15 - dist ) * 0.02, font, "center", "center", false, false, false, true)
                end
            end
        end
    end
end)

function renderName(element)

end