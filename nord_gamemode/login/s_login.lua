
--Dodać usuwanie z tablicy online po wyjściu
--Dodać sprawdzanie czy to konto jest już online
--Dodać ustawianie elementdat zew. zasobem
--Powiadomienia:
--Konto o podanych danych nie istnieje(bez rozróżnienia na nick/hasło)
--Konto nie posiada postaci

local onlinePlayers = {}

addEvent("onLoginRequest", true)
addEventHandler("onLoginRequest", resourceRoot, function(name, pass, remember, token)
    print("SName: "..name)
    forumAccountsModel:sync()
    authTokenModel:sync()
    local user = forumAccountsModel:findOne({where = {name = name}})
    if (not user) then
        error("User not found!")
    else
        print("The name of user is: "..user.name)
    end
    local authToken = authTokenModel:findByPk(user.member_id)
    local plr = client
    if(onlinePlayers[user.name]) then 
        triggerClientEvent(plr, "onClientLoginRequest", plr, false, "user_logged")
        return
    end
    if(authToken[1].token == token) then
        authToken = randomString(100)
        local newToken = authTokenModel:update({token = authToken}, {
            where ={
                id = user.member_id
            }
        })
        print("Loging with token")
        charactersModel:sync()
        local characters = charactersModel:findAll({where = {owner_id = user.member_id, blocked=0}})
        if (not characters) then
            error("Characters not found!")
            triggerClientEvent(plr, "onClientLoginRequest", plr, false, "no_characters")
        else
            print("Found characters")
            onlinePlayers[user.name] = true
            triggerClientEvent(plr, "onClientLoginRequest", plr, true, "", characters, authToken)
            exports.entityData:setEntityData(plr, "member_points", user.pp_reputation_points)
            exports.entityData:setEntityData(plr, "username", user.name)
        end
        return
    end
    passwordVerify(pass, user.members_pass_hash, {}, function(pass)
        if (not pass) then
            error("Wrong password!")
        else
            if (#authToken == 0) then
                authToken = randomString(100)
                local newToken = authTokenModel:create({id = user.id, token = token})
                if newToken then
                    print("Token inserted")
                else
                    print("Token insert failed")
                end
                DBConn:sync()
            else
                authToken = randomString(100)
                local newToken = authTokenModel:update({token = authToken}, {
                    where ={
                        id = user.member_id
                    }
                })
                if newToken then
                    print("Token updated")
                else
                    print("Token update failed")
                end
            end
            print("Password correct!")
            charactersModel:sync()
            local characters = charactersModel:findAll({where = {owner_id = user.member_id}})
            if (not characters) then
                error("Characters not found!")
                triggerClientEvent(plr, "onClientLoginRequest", plr, false, "no_characters")
            else
                onlinePlayers[user.name] = true
                print("Found characters")
                triggerClientEvent(plr, "onClientLoginRequest", plr, true, "", characters, authToken)
                exports.entityData:setEntityData(plr, "member_points", user.pp_reputation_points)
                exports.entityData:setEntityData(plr, "username", user.name)
            end
        end
    end)
end)

addEventHandler("onPlayerQuit", getRootElement(), function()
    local name = exports.entityData:getEntityData(source, "username")
    print(name)
    if name then
        onlinePlayers[name] = nil
        local characterData = exports.entityData:getEntityData(source, "ch-id")
        print("test2")
        iprint(characterData)
        if characterData then
            print("test")
            charactersModel:update({online=0}, {
                where={
                    id=characterData
                }
            })
            charactersModel:sync()
        end
    end
end)

addEvent("onCharacterSelection", true)
addEventHandler("onCharacterSelection", resourceRoot, function(characterId)
    local character = charactersModel:findByPk(characterId)
    local character = character[1]
    exports.entityData:setEntityData(client, "ch-id", characterId)
    exports.entityData:setEntityData(client, "ch-name", character.name)
    exports.entityData:setEntityData(client, "ch-surname", character.surname)
    exports.entityData:setEntityData(client, "ch-skin", character.skin)
    exports.entityData:setEntityData(client, "ch-money", character.money)
    exports.entityData:setEntityData(client, "ch-bankmoney", character.bankmoney)
    exports.entityData:setEntityData(client, "ch-age", character.age)
    exports.entityData:setEntityData(client, "ch-sex", character.sex)
    exports.entityData:setEntityData(client, "ch-strength", character.strength)
    exports.entityData:setEntityData(client, "ch-psyche", character.psyche)
    print(character.health)
    charactersModel:update({online=1}, {
        where={
            id=characterId
        }
    })
    charactersModel:sync()
    spawnPlayer(client, 0,0,3,0,character.skin,0,0)
    client:setHealth(character.health)
    client:fadeCamera(true, 0.5)
    client:setCameraTarget(client)
    showCursor(client, false)
    showChat(client, true)
end)


local charset = {}  do -- [0-9a-zA-Z]
    for c = 48, 57  do table.insert(charset, string.char(c)) end
    for c = 65, 90  do table.insert(charset, string.char(c)) end
    for c = 97, 122 do table.insert(charset, string.char(c)) end
end

function randomString(length)
    if not length or length <= 0 then return '' end
    math.randomseed(os.clock()^5)
    return randomString(length - 1) .. charset[math.random(1, #charset)]
end
