DBConn = DBManager:new({
    dialect = "mysql",
    host = "localhost",
    port = 3306,
    username = "root",
    password = "",
    database = "mta_nord_dev",
})

DEV_MODE = true

-- check if connection is successful
-- "getConnection" is a function that returns a boolean value indicating if the connection was successful 
-- [check the documentation for more information]
if (not DBConn:getConnection()) then
    error("DBManager: Connection failed", 2)
end


--OOP
function reserveID()
    local id = 1
    while getPlayerByID(id) do
        id = id+1
    end
    return id
end

function doCheckID( player )
    local id = exports.entityData:getEntityData( player, "p-id")
    if not id then
        exports.entityData:setEntityData( player, "p-id", reserveID())
    end
end

function getPlayer(data)
    if not data then return false end
    if tonumber(data) then
        local plr = getPlayerByID(tonumber(data))
        return plr
    else
        local plr = getPlayerFromPartialName(data)
        return plr
    end
end

function getPlayerByID( id )
    if not id or id == true then return false end
    if type(id) == "table" then return false end
    id = tonumber(id) or id
    if type(id) == "number" then
        for i,v in ipairs(getElementsByType("player")) do
            if getPlayerID(v) == id then
                return v
            end
        end
        return false
    else
        return false
    end
end

function getPlayerID( player )
    return exports.entityData:getEntityData( player, "p-id")
end

function getPlayerFromPartialName(name)
    local name = name and name:gsub("#%x%x%x%x%x%x", ""):lower() or nil
    if name then
        for _, player in ipairs(getElementsByType("player")) do
            local name_ = getPlayerName(player):gsub("#%x%x%x%x%x%x", ""):lower()
            if name_:find(name, 1, true) then
                return player
            end
        end
    end
end

addEventHandler("onPlayerCommand", root,
    function()
        local characterId = exports.entityData:getEntityData(source, "ch-id")
        if not characterId then return end
    end
)

addEventHandler("onResourceStart", resourceRoot, function()
    if DEV_MODE then
        print("!!DEV_MODE!!")
        Timer(function()
            Vehicle:createPersonal(0, 411, Vector3(0, 5, 3), "TEST")
        end, 500, 1)
    end
end)