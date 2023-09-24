local vehicleMaxSpeed = false
local SPEEDO = {}
local sW, sH = guiGetScreenSize()
SPEEDO.circleShader = dxCreateShader("vehicleSystem/fx/circle.fx")

dxSetShaderValue ( SPEEDO.circleShader, "sAngleStart", math.rad( 45 ) - math.pi );
dxSetShaderValue ( SPEEDO.circleShader, "sAngleEnd", math.rad( 315 ) - math.pi );
dxSetShaderValue ( SPEEDO.circleShader, "sCircleColor", fromcolor(tocolor(0,0,0)) );

SPEEDO.maskShader = dxCreateShader("vehicleSystem/fx/hud_mask.fx")

SPEEDO.maskTexture = dxCreateTexture("vehicleSystem/img/speedo_mask.png", "argb", true, "clamp");
SPEEDO.circleTexture = dxCreateTexture("vehicleSystem/img/speedo_circle.png", "argb", true, "clamp");
SPEEDO.circleOutTexture = dxCreateTexture("vehicleSystem/img/speedo_out_circle.png", "argb", true, "clamp");
SPEEDO.arrowTexture = dxCreateTexture("vehicleSystem/img/speedo_arrow.png", "argb", true, "clamp");

SPEEDO.handbrakeTextureOff = dxCreateTexture("vehicleSystem/img/handbrake_icon_off.png", "argb", true, "clamp");
SPEEDO.handbrakeTextureOn = dxCreateTexture("vehicleSystem/img/handbrake_icon_on.png", "argb", true, "clamp");

SPEEDO.engineTextureOff = dxCreateTexture("vehicleSystem/img/engine_icon_off.png", "argb", true, "clamp");
SPEEDO.engineTextureOn = dxCreateTexture("vehicleSystem/img/engine_icon_on.png", "argb", true, "clamp");

SPEEDO.brokenTextureOff = dxCreateTexture("vehicleSystem/img/broken_icon_off.png", "argb", true, "clamp");
SPEEDO.brokenTextureOn = dxCreateTexture("vehicleSystem/img/broken_icon_on.png", "argb", true, "clamp");

SPEEDO.tireTextureOff = dxCreateTexture("vehicleSystem/img/tire_icon_off.png", "argb", true, "clamp");
SPEEDO.tireTextureOn = dxCreateTexture("vehicleSystem/img/tire_icon_on.png", "argb", true, "clamp");

SPEEDO.fuelTextureOff = dxCreateTexture("vehicleSystem/img/fuel_icon_off.png", "argb", true, "clamp");
SPEEDO.fuelTextureOn = dxCreateTexture("vehicleSystem/img/fuel_icon_on.png", "argb", true, "clamp");

SPEEDO.fuelTextureEmpty = dxCreateTexture("vehicleSystem/img/fuel_level_empty.png", "argb", true, "clamp");
SPEEDO.fuelTextureFull = dxCreateTexture("vehicleSystem/img/fuel_level_full.png", "argb", true, "clamp");

SPEEDO.fuelIndicatorsTexture = dxCreateTexture("vehicleSystem/img/fuel_indicators.png", "argb", true, "clamp");


SPEEDO.circleRT = dxCreateRenderTarget(350*zoom, 350*zoom, true)
SPEEDO.maskRT = dxCreateRenderTarget(350*zoom, 350*zoom, true)

SPEEDO.regular_10 = dxCreateFont("vehicleSystem/fonts/tommy_regular.otf", 10.5*zoom)
SPEEDO.regular_8 = dxCreateFont("vehicleSystem/fonts/tommy_regular.otf", 9*zoom)
SPEEDO.black_45 = dxCreateFont("vehicleSystem/fonts/tommy_black.otf", 45.43*zoom)

addEventHandler("onClientRender", getRootElement(), function()
    if not SPEEDO.circleShader then return false end
    if not vehicleMaxSpeed then return end
    local veh = localPlayer:getOccupiedVehicle()
    if not veh then return end
    local speed = veh:getSpeed("km/h")
    local speedPercent = speed/vehicleMaxSpeed
    local drawAngle = (315-45)*speedPercent
    local mileage = string.format("%03d",exports.entityData:getEntityData(veh, "v-mileage"))
    dxSetShaderValue ( SPEEDO.circleShader, "sAngleEnd", math.rad( 45+drawAngle ) - math.pi );
    dxSetRenderTarget(SPEEDO.circleRT, true)
        dxDrawImage(0, 0, 350*zoom, 350*zoom, SPEEDO.circleShader, 0, 0, 0, tocolor(255,255,255))
    dxSetRenderTarget()

    dxSetRenderTarget(SPEEDO.maskRT, true)
        dxDrawImage(0, 0, 350*zoom, 350*zoom, SPEEDO.circleRT, 0, 0, 0, tocolor(255,255,255))
    dxSetRenderTarget()

    dxSetShaderValue( SPEEDO.maskShader, "sMaskTexture", SPEEDO.maskRT)
    dxSetShaderValue( SPEEDO.maskShader, "sPicTexture", SPEEDO.circleTexture)

    dxDrawImage(sW-364*zoom, sH-333*zoom, 331*zoom, 331*zoom, SPEEDO.maskShader, 0, 0, 0, tocolor(255,255,255))
    dxDrawImage(sW-364*zoom, sH-333*zoom, 331*zoom, 331*zoom, SPEEDO.circleOutTexture, 0, 0, 0, tocolor(255,255,255))
    -- -135
    local speedoX, speedoY = (sW-364*zoom)+(331*zoom)/2-(158*zoom)/2, (sH-333*zoom)+(331*zoom)/2-(305*zoom)/2
    dxDrawImage(speedoX, speedoY, 158*zoom, 305*zoom, SPEEDO.arrowTexture, -135+270*speedPercent)
    dxDrawText("kmh", speedoX+158*zoom/2, speedoY+305*zoom/2-45*zoom, nil, nil, tocolor(191, 191, 191), 1, SPEEDO.regular_10, "center", "center")
    dxDrawText(math.floor(speed), speedoX+158*zoom/2, speedoY+305*zoom/2, nil, nil, tocolor(255, 255, 255), 1, SPEEDO.black_45, "center", "center")
    dxDrawText(mileage, speedoX+158*zoom/2, speedoY+305*zoom/2+45*zoom, nil, nil, tocolor(191, 191, 191), 1, SPEEDO.regular_10, "center", "center")
    dxDrawText("km", speedoX+158*zoom/2, speedoY+305*zoom/2+45*zoom+dxGetFontHeight(SPEEDO.regular_13), nil, nil, tocolor(191, 191, 191), 1, SPEEDO.regular_8, "center", "center")
    if not veh.frozen then
        dxDrawImage(speedoX+158*zoom/2-(30*zoom*2)-5*zoom, speedoY+305*zoom-72*zoom, 30*zoom, 30*zoom, SPEEDO.handbrakeTextureOff)
    else
        dxDrawImage(speedoX+158*zoom/2-(30*zoom*2)-5*zoom, speedoY+305*zoom-72*zoom, 30*zoom, 30*zoom, SPEEDO.handbrakeTextureOn)
    end
    if not veh.engineState then
        dxDrawImage(speedoX+158*zoom/2-(30*zoom), speedoY+305*zoom-72*zoom, 30*zoom, 30*zoom, SPEEDO.engineTextureOff)
    else
        dxDrawImage(speedoX+158*zoom/2-(30*zoom), speedoY+305*zoom-72*zoom, 30*zoom, 30*zoom, SPEEDO.engineTextureOn)
    end
    if veh.health < 400 then
        dxDrawImage(speedoX+158*zoom/2+5*zoom, speedoY+305*zoom-72*zoom, 30*zoom, 30*zoom, SPEEDO.brokenTextureOn)
    else
        dxDrawImage(speedoX+158*zoom/2+5*zoom, speedoY+305*zoom-72*zoom, 30*zoom, 30*zoom, SPEEDO.brokenTextureOff)
    end
    local fLeft, rLeft, fRight, rRight = veh:getWheelStates()
    if fLeft ~= 0 or rLeft ~= 0 or fRight ~= 0 or rRight ~= 0 then
        dxDrawImage(speedoX+158*zoom/2+30*zoom+10*zoom, speedoY+305*zoom-72*zoom, 30*zoom, 30*zoom, SPEEDO.tireTextureOn)
    else
        dxDrawImage(speedoX+158*zoom/2+30*zoom+10*zoom, speedoY+305*zoom-72*zoom, 30*zoom, 30*zoom, SPEEDO.tireTextureOff)
    end
    dxDrawImage((sW-364*zoom)+(331*zoom/2)-(146*zoom/2), speedoY+305*zoom-20*zoom, 146*zoom, 9*zoom, SPEEDO.fuelIndicatorsTexture)
    local fuelLevel = exports.entityData:getEntityData(veh, "v-fuel")
    local fuelPercent = fuelLevel/100
    local fuelX, fuelY = (sW-364*zoom)+(331*zoom/2)-(139*zoom/2), speedoY+305*zoom-30*zoom
    dxDrawImage(fuelX, fuelY, 139*zoom, 2*zoom, SPEEDO.fuelTextureEmpty)

    dxDrawImageSection(fuelX, fuelY, 139*zoom*fuelPercent, 2*zoom, 0, 0, 139*zoom*fuelPercent, 2, SPEEDO.fuelTextureFull)
    if fuelLevel < 25 then
        dxDrawImage((sW-364*zoom)+(331*zoom/2)-(10*zoom/2), speedoY+305*zoom-20*zoom, 10*zoom, 11*zoom, SPEEDO.fuelTextureOn)
    else
        dxDrawImage((sW-364*zoom)+(331*zoom/2)-(10*zoom/2), speedoY+305*zoom-20*zoom, 10*zoom, 11*zoom, SPEEDO.fuelTextureOff)
    end
end)



addEvent("client:playCarLockSound", true)
addEventHandler("client:playCarLockSound", getRootElement(), function(vehicle)
    local position = vehicle:getPosition()
    Sound3D("vehicleSystem/sounds/carLock.mp3", position, false, false)
end)

addEvent("client:playCarIgnitionSound", true)
addEventHandler("client:playCarIgnitionSound", getRootElement(), function(vehicle)
    local position = vehicle:getPosition()
    Sound3D("vehicleSystem/sounds/engineIgnitionStart.wav", position, false, false)
end)

addEventHandler("onClientVehicleEnter", getRootElement(), function()
    local veh = localPlayer:getOccupiedVehicle()
    if not veh then return end
    vehicleMaxSpeed = veh.handling.maxVelocity
end)

function Vehicle:getSpeed(unit)
    -- Check arguments for errors
    assert(isElement(self), "Bad argument 1 @ getElementSpeed (element expected, got " .. type(theElement) .. ")")
    local elementType = self:getType()
    assert(elementType == "player" or elementType == "ped" or elementType == "object" or elementType == "vehicle" or elementType == "projectile", "Invalid element type @ getElementSpeed (player/ped/object/vehicle/projectile expected, got " .. elementType .. ")")
    assert((unit == nil or type(unit) == "string" or type(unit) == "number") and (unit == nil or (tonumber(unit) and (tonumber(unit) == 0 or tonumber(unit) == 1 or tonumber(unit) == 2)) or unit == "m/s" or unit == "km/h" or unit == "mph"), "Bad argument 2 @ getElementSpeed (invalid speed unit)")
    -- Default to m/s if no unit specified and 'ignore' argument type if the string contains a number
    unit = unit == nil and 0 or ((not tonumber(unit)) and unit or tonumber(unit))
    -- Setup our multiplier to convert the velocity to the specified unit
    local mult = (unit == 0 or unit == "m/s") and 50 or ((unit == 1 or unit == "km/h") and 180 or 111.84681456)
    -- Return the speed by calculating the length of the velocity vector, after converting the velocity to the specified unit
    return (Vector3(self.velocity) * mult).length
end


function Player:addPlayerLoginBinds()
    --Odpalanie pojazdu
    bindKey("lalt", "down",vehicleHandbrake)
    bindKey("space", "down",vehicleHandbrake)
end

function vehicleHandbrake()
    if getKeyState("lalt") and getKeyState("space") then
        local veh = localPlayer:getOccupiedVehicle()
        if not veh then return end
        veh:setFrozen(not veh.frozen)
        playSound("vehicleSystem/sounds/handbrake.mp3", false, false)
    end
end

