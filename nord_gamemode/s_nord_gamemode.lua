DBConn = DBManager:new({
    dialect = "mysql",
    host = "127.0.0.1",
    port = 3307,
    username = "root",
    password = "",
    database = "forum",
})

-- check if connection is successful
-- "getConnection" is a function that returns a boolean value indicating if the connection was successful 
-- [check the documentation for more information]
if (not DBConn:getConnection()) then
    error("DBManager: Connection failed", 2)
end