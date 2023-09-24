function Vehicle:createNew(vehData)
    local vehModel = vehData.model
    local vehPositionTable = vehData.spawn_position
    local vehPosition = Vector3(vehPositionTable.x,vehPositionTable.y,vehPositionTable.z)
    local vehRotation = Vector3(vehPositionTable.rx,vehPositionTable.ry,vehPositionTable.rz)
    local vehPlate = vehData.plate
    local veh = Vehicle(vehModel, vehPosition, vehRotation, vehPlate)
    exports.entityData:setEntityData(veh, "v-uid", 0)
    exports.entityData:setEntityData(veh, "v-mileage", 0)
    exports.entityData:setEntityData(veh, "v-fuel", 100)
    exports.entityData:setEntityData(veh, "v-owner", -1)
    exports.entityData:setEntityData(veh, "v-ownertype", -1)
    return veh 
end