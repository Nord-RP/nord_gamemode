addCommandHandler("v", function(plr, cmd, type, ...)
    if not type then return end -- gui pojazdów
    if type == "lista" then
        vehiclesModel:sync()
        local characterId = exports.entityData:getEntityData(plr, "ch-id")
        local vehicles = vehiclesModel:findAll({where = {owner = characterId, owner_type=0}})
        if not vehicles or #vehicles == 0 then
            return triggerClientEvent(plr, "client:notification", plr, "error", "Nie znaleziono pojazdów.", "Twoja postać nie posiada żadnych pojazdów.")
        else
            outputChatBox("#4297EF[*] #FFFFFFLista pojazdów:", plr, 255, 255, 255, true)
            for i,v in pairs(vehicles) do
                outputChatBox("  #E9D502[-]#FFFFFF ID: "..v.id.." | Model: "..Vehicle.getNameFromModel(v.model).." | Rejestracja: "..v.plate, plr, 255, 255, 255, true)
            end
        end
    elseif type == "create" then
        --vehModel
        if plr:getAdminLevel() < 13 then return end
        local args = {...}
        local vehModel = args[1]
        if not getVehicleNameFromModel(vehModel) then return triggerClientEvent(plr, "client:notification", plr, "error", "Nie znaleziono pojazdu.", "Nie istnieje pojazd o takim ID") end
        Vehicle:createPersonal(0, vehModel, Vector3(0,0, 3), "test")
    elseif type == "spawn" then
        --vehID
        local args = {...}
        local vehID = tonumber(args[1])
        vehiclesModel:sync()
        local vehData = vehiclesModel:findByPk(vehID)
        if not vehData then return end
        if not vehData.ownertype == 0 then return triggerClientEvent(plr, "client:notification", plr, "error", "Nie znaleziono pojazdu.", "Pojazd o tym ID nie należy do ciebie") end
        local veh = Vehicle:createPersonal(vehID)
        if veh == "exists" then return triggerClientEvent(plr, "client:notification", plr, "error", "Pojazd już istnieje", "Pojazd o tym ID już jest zespawnowany") end
    elseif type == "z" or type == "zamknij" then
        local veh = plr:getNearestVehicle(5)
        if not veh then return end
        local vehAccess = veh:getData("v-access")
        if not vehAccess then return end
        local characterId =  exports.entityData:getEntityData(plr, "ch-id")
        if not vehAccess[characterId] then return end
        veh:setLocked(not veh.locked)
        Timer(function()
                local currentState = veh:getOverrideLights()
                if currentState == 1 then newState = 2 else newState = 1 end
                veh:setOverrideLights(newState)
        end, 100, 4)
        for i,v in pairs(Element.getWithinRange(veh:getPosition(), 10, "player"), veh.interior, veh.dimension) do
            triggerClientEvent(v, "client:playCarLockSound", v, veh)
        end
    elseif type == "info" then
        local veh = plr:getNearestVehicle(5)
        if not veh then return end
        local vUID = exports.entityData:getEntityData(veh, "v-uid")
        local vModel = Vehicle.getNameFromModel(veh.model)
        local vPlate = veh:getPlateText()
        outputChatBox("#4297EF[*] #FFFFFFInformacje o pojeździe:", plr, 255, 255, 255, true)
        outputChatBox("  #E9D502[-]#FFFFFF ID: "..vUID.." | Model: "..vModel.." | Rejestracja: "..vPlate, plr, 255, 255, 255, true)
    end
    return true
end)