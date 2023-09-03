function Player:getAdminLevel()
    return exports.entityData:getEntityData(self, "ch-id");
end