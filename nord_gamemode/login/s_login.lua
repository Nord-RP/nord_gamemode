
addEvent("onLoginRequest", true)
addEventHandler("onLoginRequest", root, function(name, pass)
    print("SName: "..name)
    forumAccounts:sync()
    local user = forumAccounts:findOne({where = {name = name}})
    if (not user) then
        error("User not found!")
    else
        print("The name of user is: "..user.name) -- LODS
    end
end)