local vehList = {}

--vehID, model, position, plate
function Vehicle:createPersonal(vehID, ...)
    if vehID ~= 0 then
        if vehList[vehID] then return "exists" end
        vehiclesModel:sync()
        local vehData = vehiclesModel:findByPk(tonumber(vehID))[1]
        if not vehData then return false end
        local vehPosition = vehData.spawn_position
        local veh = Vehicle(vehData.model, Vector3(vehPosition.x, vehPosition.y, vehPosition.z), Vector3(vehPosition.rx, vehPosition.ry, vehPosition.rz), vehData.plate)
        exports.entityData:setEntityData(veh, "v-uid", vehData.id)
        exports.entityData:setEntityData(veh, "v-mileage", vehData.mileage)
        exports.entityData:setEntityData(veh, "v-fuel", vehData.fuel)
        exports.entityData:setEntityData(veh, "v-owner", vehData.owner)
        exports.entityData:setEntityData(veh, "v-ownertype", vehData.ownertype)
        veh:setData("v-access",{
            [vehData.owner] = true,
        })
        veh:setOverrideLights(1)
        vehList[vehData.id] = veh
        veh:setLocked(true)
    else
        local args = {...}
        local vehModel = tonumber(args[1])
        local vehPosition = Vector3(args[2].x,args[2].y,args[2].z)
        local vehRotation = Vector3(args[2].rx,args[2].ry,args[2].rz)
        local vehPlate = args[3]
        local veh = Vehicle(vehModel, vehPosition, vehRotation, vehPlate)
        exports.entityData:setEntityData(veh, "v-uid", 0)
        exports.entityData:setEntityData(veh, "v-mileage", 0)
        exports.entityData:setEntityData(veh, "v-fuel", 100)
        exports.entityData:setEntityData(veh, "v-owner", -1)
        exports.entityData:setEntityData(veh, "v-ownertype", -1)
    end
    return veh 
end

--TODO algorytm tego czy silnik zapali czy nie
function startVehicleEngine(player)
    local veh = player:getOccupiedVehicle()
    if not veh then return end
    local engineState = veh:getEngineState()
    if exports.entityData:getEntityData(veh, "v-uid") == 0 then 
        for i,v in pairs(Element.getWithinRange(veh:getPosition(), 10, "player"), veh.interior, veh.dimension) do
            triggerClientEvent(v, "client:playCarIgnitionSound", v, veh)
        end
        Timer(function()
            veh:setEngineState(true)
        end, 3200, 1)
        return
    end
    if engineState then
        veh:setEngineState(false)
    else
        local vehicleAccess = veh:getData("v-access")
        local characterId = exports.entityData:getEntityData(player, "ch-id")
        if vehicleAccess[characterId] then
            for i,v in pairs(Element.getWithinRange(veh:getPosition(), 10, "player"), veh.interior, veh.dimension) do
                triggerClientEvent(v, "client:playCarIgnitionSound", v, veh)
            end
            Timer(function()
                veh:setEngineState(true)
            end, 3200, 1)
        end
    end
end

--TODO Podtrzymanie silnika przez 1 minutę, jeśli w tym czasie ktoś w siądzie, nie gasić silnika[kradzież pojazdu]
addEventHandler ( "onPlayerVehicleEnter", getRootElement(), function(veh, seat) 
    veh:setEngineState(false)
end)

