--Timeouty, co by nie klikac zbyt szybko
--Zapamietywanie ostatniej postaci
--GUI

local selectionCharacters = {}
local charactersT
local currentCharacter = 1
function displayCharacterSelection(characters)
    charactersT = characters
    Camera.setMatrix(217, 78, 1005.5, 215, 78, 1005.5)
    localPlayer:setInterior(6, 246, 62, 1002)
    for i,v in pairs(characters) do
        selectionCharacters[i] = {
            element = false,
        }
    end
    local ped = Ped(characters[1].skin, 215, 77.5, 1005, -90)
    selectionCharacters[1].element = ped
    ped:setInterior(6, 215, 77.5, 1005)
    bindKey("arrow_l", "down", moveCharacter)
    bindKey("arrow_r", "down", moveCharacter)
end


function moveCharacter(key)
    if(key == "arrow_l") then
        local ped = selectionCharacters[currentCharacter].element
        ped:setRotation(0, 0, 180, "default", true)
        setPedAnalogControlState(ped, "forwards", 0.5)

        if(currentCharacter+1 > #charactersT) then
            currentCharacter=1
        else
            currentCharacter=currentCharacter+1
        end

        local newPed = Ped(charactersT[currentCharacter].skin, 214.5, 79.5, 1005, 180)
        newPed:setInterior(6, 214.7, 79.5, 1005)
        selectionCharacters[currentCharacter].element = newPed
        setPedAnalogControlState(newPed, "forwards", 0.5)

        setTimer(destroyElement, 1000, 1, ped)
        setTimer(function()
            setPedAnalogControlState(newPed, "forwards", 0)
            newPed:setRotation(0,0,-90,"default", true)
        end, 1170, 1)
    else
        local ped = selectionCharacters[currentCharacter].element
        ped:setRotation(0, 0, 0, "default", true)
        setPedAnalogControlState(ped, "forwards", 0.5)

        if(currentCharacter-1 < 1) then
            currentCharacter=#charactersT
        else
            currentCharacter=currentCharacter-1
        end

        local newPed = Ped(charactersT[currentCharacter].skin, 214.5, 75.5, 1005, 0)
        newPed:setInterior(6, 214.7, 75.5, 1005)
        selectionCharacters[currentCharacter].element = newPed

        setPedAnalogControlState(newPed, "forwards", 0.5)
        setTimer(destroyElement, 1000, 1, ped)
        setTimer(function()
            setPedAnalogControlState(newPed, "forwards", 0)
            newPed:setRotation(0,0,-90,"default", true)
        end, 1170, 1)
    end
end