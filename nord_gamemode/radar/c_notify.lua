local NOTIFY_STACK = {}
local sW, sH = guiGetScreenSize()
local hudMaskShader = dxCreateShader("radar/files/shaders/hud_mask.fx")
local maskTexture = dxCreateTexture("radar/files/img/notifymask.png");
dxSetShaderValue( hudMaskShader, "sMaskTexture", maskTexture )

function addNotification(type, header, desc, time)
    if not type or not header then return end
    if not time then time = 1000 end
    time=time+1000
    table.insert(NOTIFY_STACK, {type=type, header=header, desc=desc or false, time=time, startTime=getTickCount(), endTime=getTickCount()+500, animated=false, rT=dxCreateRenderTarget(RADAR_GUI.scale.notify_bg.w, RADAR_GUI.scale.notify_bg.h, true),rTMask=dxCreateRenderTarget(RADAR_GUI.scale.notify_mask.w, RADAR_GUI.scale.notify_mask.h, true)})
    playSound("resources/sounds/"..type..".mp3")
end

addEventHandler("onClientRender", getRootElement(), function()
    for i,v in pairs(NOTIFY_STACK) do
        local timerProgress = 0
        x = RADAR_GUI.pos.notify.w
        y = RADAR_GUI.pos.notify.y-(RADAR_GUI.scale.notify_bg.h*i)
        if NOTIFY_STACK[i-1] then
            local nextNotifyTime = NOTIFY_STACK[i-1].startTime+NOTIFY_STACK[i-1].time
            if getTickCount() > nextNotifyTime then
                for i2, v2 in pairs(NOTIFY_STACK) do
                    if not(i2 == i-1) and not (i2 == 1) then
                        v2.dropDownStart = getTickCount()
                        v2.dropDownEnd = v2.dropDownStart+500 
                        v2.dropDownInitial = RADAR_GUI.pos.notify.y-(RADAR_GUI.scale.notify_bg.h*i2)
                        v2.dropDownDest = RADAR_GUI.pos.notify.y-(RADAR_GUI.scale.notify_bg.h*(i2-1))
                    end
                end
            end
        end
        if(v.dropDownStart) then
            local startTime = v.dropDownStart
            local endTime = v.dropDownEnd
            local now = getTickCount()
            local elapsedTime = now - startTime
            local duration = endTime - startTime
            local progress = elapsedTime / duration
            y = interpolateBetween(Vector3(v.dropDownInitial,0,0), Vector3(v.dropDownDest, 0, 0), progress, "Linear")
            if progress > 1 then
                v.dropDownStart = false
            end
        end
        if getTickCount() > v.startTime+v.time then
            local startTime = v.startTime+v.time
            local endTime = v.startTime+v.time+500
            local now = getTickCount()
            local elapsedTime = now - startTime
            local duration = endTime - startTime
            local progress = elapsedTime / duration
            x = interpolateBetween(Vector3(RADAR_GUI.pos.notify.w,0,0), Vector3(-RADAR_GUI.scale.notify_bg.w, 0, 0), progress, "InOutQuad")
            if progress > 1 then
                table.remove(NOTIFY_STACK, i)
            end
        else
            local now = getTickCount()
            local elapsedTime = now - v.startTime
            local duration = v.endTime - v.startTime
            local progress = elapsedTime / duration
            x = interpolateBetween(Vector3(-RADAR_GUI.scale.notify_bg.w, 0, 0), Vector3(RADAR_GUI.pos.notify.w,0,0), progress, "InOutQuad")
        end

        local now = getTickCount()
        local startTime = v.startTime
        local endTime = v.startTime+v.time
        local elapsedTime = now - startTime
        local duration = endTime - startTime
        local timerProgress = 1-(elapsedTime / duration)

        dxSetRenderTarget(v.rTMask, true)
            if v.type == "info" then
                color = tocolor(66,151,239)
            elseif v.type == "ok" then
                color = tocolor(4, 192, 128)
            else
                color = tocolor(234, 70, 67)
            end
            dxDrawRectangle(1,RADAR_GUI.scale.notify_mask.h-4*zoom, RADAR_GUI.scale.notify_mask.w*timerProgress, 10*zoom, color)
        dxSetRenderTarget()
        dxSetShaderValue( hudMaskShader, "sPicTexture", v.rTMask )
        dxSetRenderTarget(v.rT)
            dxDrawImage(0, 0, RADAR_GUI.scale.notify_bg.w, RADAR_GUI.scale.notify_bg.h, RADAR_GUI.txt.notify_bg)
            dxDrawImage(20*zoom, 0+(RADAR_GUI.scale.notify_bg.h/2)-(RADAR_GUI.scale.notify_icon.h/2), RADAR_GUI.scale.notify_icon.w, RADAR_GUI.scale.notify_icon.h, RADAR_GUI.txt[v.type])
            if not (v.desc) then
                dxDrawText(v.header, 0+85*zoom, 0+(RADAR_GUI.scale.notify_bg.h/2), null, null, tocolor(255, 255, 255), 1, RADAR_GUI.fonts.medium_15, "left", "center")
            else
                dxDrawText(v.header, 0+85*zoom, 0+(RADAR_GUI.scale.notify_bg.h/2)-dxGetFontHeight(1, RADAR_GUI.fonts.medium_20)/2, null, null, tocolor(255, 255, 255), 1, RADAR_GUI.fonts.medium_20, "left", "center")            
                formatted = wordWrap(v.desc, 400*zoom, 1, RADAR_GUI.fonts.medium_10, true)
                for i,v in pairs(formatted) do
                    dxDrawText(formatted[i], 0+85*zoom, 0+(RADAR_GUI.scale.notify_bg.h/2)+4*zoom+((i-1)*dxGetFontHeight()), null, null, tocolor(255, 255, 255), 1, RADAR_GUI.fonts.medium_10, "left", "center", false, false, false, true)            
                end
            end
            dxDrawImage(9*zoom, 9*zoom, RADAR_GUI.scale.notify_mask.w, RADAR_GUI.scale.notify_mask.h, hudMaskShader)
        dxSetRenderTarget()

        
        dxDrawImage(x, y, RADAR_GUI.scale.notify_bg.w, RADAR_GUI.scale.notify_bg.h, v.rT)
    end
end)

addCommandHandler("testNotify", function()
    addNotification("info", "Informacja", "Oto krótka informacja dla gracza", 2000)
    Timer(function()
        addNotification("error", "Błąd", "Oto opis błędu w czynności", 5000)
    end,500,1)    
    Timer(function()
        addNotification("ok", "Powodzenie", "Operacja się powiodła, gratulacje! Twoje konto bankowe zostało zasilone kwotą #85bb65$500.000#FFFFFF.", 2000)
    end,1000,1)
    Timer(function()
        addNotification("error", "Błąd", "Oto opis błędu w czynności", 5000)
    end,1500,1)    
    Timer(function()
        addNotification("ok", "Powodzenie", "Operacja się powiodła, gratulacje! Twoje konto bankowe zostało zasilone kwotą #85bb65$500.000#FFFFFF.", 2000)
    end,2000,1)
end)

addEvent("client:notification", true)
addEventHandler("client:notification", getRootElement(), function(type, header, desc, time)
    addNotification(type, header, desc, time)
end)

function wordWrap(text, maxwidth, scale, font, colorcoded)
    local lines = {}
    local words = split(text, " ") -- this unfortunately will collapse 2+ spaces in a row into a single space
    local line = 1 -- begin wih 1st line
    local word = 1 -- begin on 1st word
    local endlinecolor
    while (words[word]) do -- while there are still words to read
        repeat
            if colorcoded and (not lines[line]) and endlinecolor and (not string.find(words[word], "^#%x%x%x%x%x%x")) then -- if on a new line, and endline color is set and the upcoming word isn't beginning wih a colorcode
                lines[line] = endlinecolor -- define this line as beginning wih the color code
            end
            lines[line] = lines[line] or "" -- define the line if i doesnt exist

            if colorcoded then
                local rw = string.reverse(words[word]) -- reverse the string
                local x, y = string.find(rw, "%x%x%x%x%x%x#") -- and search for the first (last) occurance of a color code
                if x and y then
                    endlinecolor = string.reverse(string.sub(rw, x, y)) -- stores i for the beginning of the next line
                end
            end
      
            lines[line] = lines[line]..words[word] -- append a new word to the this line
            lines[line] = lines[line] .. " " -- append space to the line

            word = word + 1 -- moves onto the next word (in preparation for checking whether to start a new line (that is, if next word won't fi)
        until ((not words[word]) or dxGetTextWidth(lines[line].." "..words[word], scale, font, colorcoded) > maxwidth) -- jumps back to 'repeat' as soon as the code is out of words, or wih a new word, i would overflow the maxwidth
    
        lines[line] = string.sub(lines[line], 1, -2) -- removes the final space from this line
        if colorcoded then
            lines[line] = string.gsub(lines[line], "#%x%x%x%x%x%x$", "") -- removes trailing colorcodes
        end
        line = line + 1 -- moves onto the next line
    end -- jumps back to 'while' the a next word exists
    return lines
end