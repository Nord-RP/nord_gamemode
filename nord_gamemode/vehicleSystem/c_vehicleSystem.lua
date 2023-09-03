local vehicleMaxSpeed = false
local SPEEDO = {}
local sW, sH = guiGetScreenSize()
SPEEDO.circleShader = dxCreateShader("vehicleSystem/fx/circle.fx")

dxSetShaderValue ( SPEEDO.circleShader, "sAngleStart", math.rad( 45 ) - math.pi );
dxSetShaderValue ( SPEEDO.circleShader, "sAngleEnd", math.rad( 315 ) - math.pi );
dxSetShaderValue ( SPEEDO.circleShader, "sCircleColor", fromcolor(tocolor(255,255,0)) );



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
    local vehicleMaxSpeed = veh.handling.maxVelocity
end)

addEventHandler("onClientRender", getRootElement(), function()
    if not SPEEDO.circleShader then return false end
    dxDrawImage(sW-364*zoom, sH-333*zoom, 331*zoom, 331*zoom, SPEEDO.circleShader)
    dxDrawImage(sW-364*zoom, sH-333*zoom, 331*zoom, 331*zoom, "vehicleSystem/img/speedo_circle.png")
end)

