addCommandHandler("do", function(plr, cmd, ...)
    local message = table.concat({...}, " ")
	local name = exports.entityData:getEntityData(plr, "ch-name")
	if not name then return end
    plr:sendChat(message, "do", 12)
end)

addCommandHandler("k", function(plr, cmd, ...)
    local message = table.concat({...}, " ")
	local name = exports.entityData:getEntityData(plr, "ch-name")
	if not name then return end
    plr:sendChat(message, "k", 16)
end)

addCommandHandler("c", function(plr, cmd, ...)
    local message = table.concat({...}, " ")
	local name = exports.entityData:getEntityData(plr, "ch-name")
	if not name then return end
    plr:sendChat(message, "c", 2)
end)