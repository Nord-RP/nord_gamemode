
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
    local authToken = authTokenModel:findByPk(user.member_id);
    local plr = client
    if(authToken[1].token == token) then
        authToken = randomString(100)
        local newToken = authTokenModel:update({token = authToken}, {
            where ={
                id = user.member_id
            }
        })
        print("Loging with token")
        charactersModel:sync()
        local characters = charactersModel:findAll({where = {owner_id = user.member_id}})
        if (not characters) then
            error("Characters not found!")
            triggerClientEvent(plr, "onClientLoginRequest", plr, false)
        else
            print("Found characters")
            triggerClientEvent(plr, "onClientLoginRequest", plr, true, characters, authToken)
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
                triggerClientEvent(plr, "onClientLoginRequest", plr, false)
            else
                print("Found characters")
                triggerClientEvent(plr, "onClientLoginRequest", plr, true, characters, authToken)
            end
        end
    end)
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

  