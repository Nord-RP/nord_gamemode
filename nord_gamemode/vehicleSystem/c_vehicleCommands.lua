--TODO ZNISZCZENIE STWORZONYCH DO PODGLĄDU POJAZDOW
local sW,sH = guiGetScreenSize()
local isMenuOpen = false
local currentSelectedVehicle = 0
local vehMenuGUI = {}
dgsLocateObjectPreviewResource("object_preview")  -- Locate resource object preview ( Ensure that object preview is running)


vehMenuGUI.scale = {
    ["menu_bg"] = {w=469*zoom, h=331*zoom},
    ["item"] = {w=469*zoom, h=138*zoom},
    ["heart"] = {w=21*zoom, h=19*zoom},
    ["color"] = {w=165*zoom, h=10*zoom},
    ["buttons"] = {w=213*zoom, h=29*zoom},
}

vehMenuGUI.pos = {
    ["menu_bg"] = {x=sW-469*zoom, y=sH/2-((331*zoom)/2)}
}

vehMenuGUI.txt = {
    ["menu_bg"] = dxCreateTexture("vehicleSystem/img/vehPanel/panel_bg.png", "argb", true, "clamp"),
    ["item_selected"] = dxCreateTexture("vehicleSystem/img/vehPanel/item_selected.png", "argb", true, "clamp"),
    ["item_unselected"] = dxCreateTexture("vehicleSystem/img/vehPanel/item_unselected.png", "argb", true, "clamp"),
    ["heart"] = dxCreateTexture("vehicleSystem/img/vehPanel/icon_heart.png", "argb", true, "clamp"),
    ["heart_on"] = dxCreateTexture("vehicleSystem/img/vehPanel/icon_heart_on.png", "argb", true, "clamp"),
    ["color"] = dxCreateTexture("vehicleSystem/img/vehPanel/color_gradient_left.png", "argb", true, "clamp"),
    ["color_right"] = dxCreateTexture("vehicleSystem/img/vehPanel/color_gradient_right.png", "argb", true, "clamp"),
    ["locate_vehicle"] = dxCreateTexture("vehicleSystem/img/vehPanel/locate_vehicle.png", "argb", true, "clamp"),
    ["spawn_vehicle"] = dxCreateTexture("vehicleSystem/img/vehPanel/spawn_vehicle.png", "argb", true, "clamp"),
}

vehMenuGUI.fonts = {
    ["roboto_medium_17"] = dxCreateFont("resources/fonts/Roboto-Medium.ttf", 14*zoom, false, "cleartype"),
    ["roboto_regular_10"] = dxCreateFont("resources/fonts/Roboto-Regular.ttf", 10*zoom, false, "cleartype"),
    ["roboto_regular_11"] = dxCreateFont("resources/fonts/Roboto-Regular.ttf", 11*zoom, false, "cleartype"),
    ["roboto_thin_8"] = dxCreateFont("resources/fonts/Roboto-Thin.ttf", 8*zoom, false, "cleartype"),
}

vehMenuGUI.shaders = {}

vehMenuGUI.el = {
    ["image"] = {}
}

addEvent("client:openVehicleMenu", true)
addEventHandler("client:openVehicleMenu", getRootElement(), function(vehicles)
    if not isMenuOpen then
        vehMenuGUI.el.main = dgsImage(vehMenuGUI.pos.menu_bg.x, vehMenuGUI.pos.menu_bg.y, vehMenuGUI.scale.menu_bg.w, vehMenuGUI.scale.menu_bg.h, vehMenuGUI.txt.menu_bg, false, nil, tocolor(255,255,255))
        vehMenuGUI.el.scrollPane = dgsScrollPane(0, 50*zoom, vehMenuGUI.scale.menu_bg.w, vehMenuGUI.scale.menu_bg.h-50*zoom, false)
        vehMenuGUI.el.scrollPane:setParent(vehMenuGUI.el.main)
        vehMenuGUI.el.scrollPane:setProperty("scrollBarThick", 0)
        local iT = 0
        for i,v in pairs(vehicles) do
            if iT == 0 then
                currentSelectedVehicle = v.id
            end
            vehMenuGUI.el.image[v.id] = dgsImage(0, iT*vehMenuGUI.scale.item.h, vehMenuGUI.scale.item.w, vehMenuGUI.scale.item.h, iT == 0 and vehMenuGUI.txt.item_selected or vehMenuGUI.txt.item_unselected, false, nil, tocolor(255,255,255))
            vehMenuGUI.el.image[v.id]:setParent(vehMenuGUI.el.scrollPane)
            exports.entityData:setEntityData(vehMenuGUI.el.image[v.id]:getElement(), "gui-vehicle-id", v.id)

            local veh = Vehicle:createNew(v)
            veh:setPosition(0,0,3)
            veh:setFrozen(true)
            objPrev = dgsCreateObjectPreviewHandle(veh,0,0,140)
            local previewImage = dgsImage(0,vehMenuGUI.scale.item.h/2-100.5*zoom/2,226.5*zoom,100.5*zoom,_,false,wind)
            previewImage:setParent(vehMenuGUI.el.image[v.id])
            dgsAttachObjectPreviewToImage(objPrev,previewImage:getElement())

            local favorite_txt = v.favorite == 0 and vehMenuGUI.txt.heart or vehMenuGUI.txt.heart_on
            local favorite_txt_click = v.favorite == 0 and vehMenuGUI.txt.heart_on or vehMenuGUI.txt.heart
            local button = dgsButton(0+vehMenuGUI.scale.heart.w, 0+vehMenuGUI.scale.heart.h, vehMenuGUI.scale.heart.w, vehMenuGUI.scale.heart.h, "", false, nil, tocolor(255,255,255,255), 1, favorite_txt, favorite_txt, favorite_txt_click, tocolor(255,255,255), tocolor(255,255,255, 155), tocolor(255,255,255) )
            button:setParent(vehMenuGUI.el.image[v.id])

            local nameLabel = dgsLabel(215*zoom, 24*zoom, 0, 0, getVehicleNameFromModel(v.model), false, nil)
            nameLabel:setParent(vehMenuGUI.el.image[v.id])
            nameLabel:setProperty("alignment", {"left", "center"})
            nameLabel:setFont(vehMenuGUI.fonts.roboto_medium_17)
            

            local idLabel = dgsLabel(400*zoom, 24*zoom, 0, 0, "#bababaID "..v.id, false, nil)
            idLabel:setParent(vehMenuGUI.el.image[v.id])
            idLabel:setProperty("alignment", {"right", "center"})
            idLabel:setProperty("colorCoded", true)
            idLabel:setFont(vehMenuGUI.fonts.roboto_regular_10)

            local healthLabel = dgsLabel(420*zoom, 24*zoom, 0, 0, "#bababa"..math.floor(v.health/10).."%", false, nil)
            healthLabel:setParent(vehMenuGUI.el.image[v.id])
            healthLabel:setProperty("alignment", {"left", "center"})
            healthLabel:setProperty("colorCoded", true)
            healthLabel:setFont(vehMenuGUI.fonts.roboto_regular_10)

            local mileageLabel = dgsLabel(240*zoom, 55*zoom, 0, 0, v.mileage.." km", false, nil)
            mileageLabel:setParent(vehMenuGUI.el.image[v.id])
            mileageLabel:setProperty("alignment", {"left", "center"})
            mileageLabel:setFont(vehMenuGUI.fonts.roboto_regular_10)

            local fuelLabel = dgsLabel(240*zoom, 76*zoom, 0, 0, v.fuel.."/60 L", false, nil)
            fuelLabel:setParent(vehMenuGUI.el.image[v.id])
            fuelLabel:setProperty("alignment", {"left", "center"})
            fuelLabel:setFont(vehMenuGUI.fonts.roboto_regular_10)

            local bottomLabel = dgsLabel(469*zoom/2, vehMenuGUI.scale.item.h-20*zoom, 0, 0, "#bababaKliknij aby skopiować HEX koloru", false, nil)
            bottomLabel:setParent(vehMenuGUI.el.image[v.id])
            bottomLabel:setProperty("colorCoded", true)
            bottomLabel:setProperty("alignment", {"center", "center"})
            bottomLabel:setFont(vehMenuGUI.fonts.roboto_thin_8)

            local color1 = v.color[1]
            local color2 = v.color[2]
            local maskShaderLeft = dxCreateShader("vehicleSystem/fx/hud_mask.fx")
            local maskShaderRight = dxCreateShader("vehicleSystem/fx/hud_mask.fx")

            dxSetShaderValue(maskShaderLeft, "sMaskTexture", vehMenuGUI.txt.color)
            dxSetShaderValue(maskShaderRight, "sMaskTexture", vehMenuGUI.txt.color_right)
            local maskRTLeft = dxCreateRenderTarget(vehMenuGUI.scale.color.w, vehMenuGUI.scale.color.h, true)
            local maskRTRight = dxCreateRenderTarget(vehMenuGUI.scale.color.w, vehMenuGUI.scale.color.h, true)
            dxSetRenderTarget(maskRTLeft, true)
                dxDrawRectangle(0, 0, vehMenuGUI.scale.color.w, vehMenuGUI.scale.color.h, tocolor(color1.r, color1.g, color1.b))
            dxSetRenderTarget()
            dxSetShaderValue(maskShaderLeft, "sPicTexture", maskRTLeft)

            dxSetRenderTarget(maskRTRight, true)
            dxDrawRectangle(0, 0, vehMenuGUI.scale.color.w, vehMenuGUI.scale.color.h, tocolor(color2.r, color2.g, color2.b))
            dxSetRenderTarget()
            dxSetShaderValue(maskShaderRight, "sPicTexture", maskRTRight)

            local color_left = dgsButton(9*zoom, vehMenuGUI.scale.item.h-vehMenuGUI.scale.color.h-9*zoom, vehMenuGUI.scale.color.w, vehMenuGUI.scale.color.h, "", false, nil, tocolor(0,0,255), 1, maskShaderLeft, maskShaderLeft,maskShaderLeft, tocolor(255,255,255),tocolor(255,255,255),tocolor(255,255,255))
            color_left:setParent(vehMenuGUI.el.image[v.id])

            local color_right = dgsButton(vehMenuGUI.scale.item.w-9*zoom-vehMenuGUI.scale.color.w, vehMenuGUI.scale.item.h-vehMenuGUI.scale.color.h-9*zoom, vehMenuGUI.scale.color.w, vehMenuGUI.scale.color.h,"", false, nil, tocolor(0,0,0), 1, maskShaderRight, maskShaderRight, maskShaderRight, tocolor(255,255,255),tocolor(255,255,255),tocolor(255,255,255))
            color_right:setParent(vehMenuGUI.el.image[v.id])

            exports.entityData:setEntityData(button:getElement(), "gui-favorite-id", v.id)
            exports.entityData:setEntityData(button:getElement(), "gui-favorite", tonumber(v.favorite))
            
            exports.entityData:setEntityData(color_left:getElement(), "gui-veh-color1", toJSON(color1))
            exports.entityData:setEntityData(color_right:getElement(), "gui-veh-color2", toJSON(color2))
            
            iT=iT+1
        end
        vehMenuGUI.el.locate = dgsButton(vehMenuGUI.pos.menu_bg.x+9*zoom, vehMenuGUI.pos.menu_bg.y+vehMenuGUI.scale.menu_bg.h, vehMenuGUI.scale.buttons.w, vehMenuGUI.scale.buttons.h, "", false, nil, tocolor(0,0,0), 1, vehMenuGUI.txt.locate_vehicle, vehMenuGUI.txt.locate_vehicle, vehMenuGUI.txt.locate_vehicle, tocolor(255,255,255),tocolor(255,255,255),tocolor(255,255,255))
        vehMenuGUI.el.spawn = dgsButton(vehMenuGUI.pos.menu_bg.x+vehMenuGUI.scale.menu_bg.w-vehMenuGUI.scale.buttons.w-9*zoom, vehMenuGUI.pos.menu_bg.y+vehMenuGUI.scale.menu_bg.h, vehMenuGUI.scale.buttons.w, vehMenuGUI.scale.buttons.h, "", false, nil, tocolor(0,0,0), 1, vehMenuGUI.txt.spawn_vehicle, vehMenuGUI.txt.spawn_vehicle, vehMenuGUI.txt.spawn_vehicle, tocolor(255,255,255),tocolor(255,255,255),tocolor(255,255,255))
        isMenuOpen = true
        showCursor(true)
    else
        if isElement(vehMenuGUI.el.main:getElement()) then
            vehMenuGUI.el.main:getElement():destroy()
            vehMenuGUI.el.locate:getElement():destroy()
            vehMenuGUI.el.spawn:getElement():destroy()
            isMenuOpen = false
            showCursor(false)
        end
    end
end)

addEventHandler("onDgsMouseClick", root, function(button, state)
    if button == "left" and state == "down" then
        if source == vehMenuGUI.el.spawn:getElement() then
            triggerServerEvent("server:clientSpawnVehicle", localPlayer, currentSelectedVehicle)
        end
        if source == vehMenuGUI.el.locate:getElement() then
            for i,v in pairs(Element.getAllByType("vehicle")) do
                local id = exports.entityData:getEntityData(v, "v-uid")
                if id and id == currentSelectedVehicle then
                    local blip = Blip.createAttachedTo(v, 55)
                    blip:setData("exclusiveBlip", true)
                    blip:setData("blipIcon", "vehicle")
                    Timer(function()
                        blip:destroy()
                    end, 60000, 1)
                end
            end
        end
        local id = exports.entityData:getEntityData(source, "gui-vehicle-id")
        if not id then
            parent = dgsGetParent(source)
            id = exports.entityData:getEntityData(parent, "gui-vehicle-id")
        end
        if id then
                local old_image = vehMenuGUI.el.image[currentSelectedVehicle]
                local new_image = vehMenuGUI.el.image[id]
                old_image:setProperty("image", vehMenuGUI.txt.item_unselected)
                new_image:setProperty("image", vehMenuGUI.txt.item_selected)
                currentSelectedVehicle = id
        end
        local id = exports.entityData:getEntityData(source, "gui-favorite-id")
        if id then
            triggerServerEvent("server:onVehicleFavorite", localPlayer, id)
            
            local favorite = exports.entityData:getEntityData(source, "gui-favorite")
            local favorite_txt = favorite == 1 and vehMenuGUI.txt.heart or vehMenuGUI.txt.heart_on
            local favorite_txt_click = favorite == 1 and vehMenuGUI.txt.heart_on or vehMenuGUI.txt.heart

            dgsSetProperty(source, "image", {favorite_txt, favorite_txt, favorite_txt_click})

            local favorite_new = favorite == 0 and 1 or 0

            exports.entityData:setEntityData(source, "gui-favorite", favorite_new)
        end
        local color1 = exports.entityData:getEntityData(source, "gui-veh-color1")
        
        if color1 then
            local color1 = fromJSON(color1)
            local hex = RGBToHex(color1.r, color1.g, color1.b)
            setClipboard(hex)
            triggerEvent("client:notification", localPlayer, "ok", "Skopiowanio kolor [1] pojazdu", "W twoim schowku znajduje się kolor: "..hex.."▬▬▬▬")
        end
        local color2 = exports.entityData:getEntityData(source, "gui-veh-color2")
        if color2 then
            local color2 = fromJSON(color2)
            local hex = RGBToHex(color2.r, color2.g, color2.b)
            setClipboard(hex)
            triggerEvent("client:notification", localPlayer, "ok", "Skopiowanio kolor [2] pojazdu", "W twoim schowku znajduje się kolor: "..hex.."▬▬▬▬")
        end
    end
end)
