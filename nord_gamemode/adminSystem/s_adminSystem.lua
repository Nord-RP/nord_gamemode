function Player:getAdminLevel()
    return exports.entityData:getEntityData(self, "a-level");
end

function Player:setAdminLevel(level)
    return exports.entityData:setEntityData(self, "a-level", level);
end

