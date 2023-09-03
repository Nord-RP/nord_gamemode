addCommandHandler("a", function(plr, cmd, type)
    if not type then return end -- gui z listą adminów
    if type == "duty" then
        local adminLevel = plr:getAdminLevel()
        if adminLevel == false or adminLevel < 0 then
            local userid = exports.entityData:getEntityData(plr, "userid");
            adminsModel:sync()
            local adminData = adminsModel:findOne({where = {user_id = userid}})
            if adminData then
                plr:setAdminLevel(adminData.level)
                triggerClientEvent(plr, "client:notification", plr, "ok", "Zalogowano jako admin", "Level uprawnień: "..adminData.level..".")
            end
        else
            plr:setAdminLevel(-1)
            triggerClientEvent(plr, "client:notification", plr, "ok", "Wylogowano jako admin")
        end
    end
end)

addCommandHandler("cc", function(plr,cmd)
    local adminLevel = plr:getAdminLevel()
    if adminLevel and adminLevel >= 8 then
        clearChatBox()
        outputChatBox("Chat został wyczyszczony, stare wiadomości znajdują sie w konsoli(klawisz F8).", root, 255, 0, 0)
    end
end)