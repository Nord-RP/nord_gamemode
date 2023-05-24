local NOTIFY_STACK = {}
local sW, sH = guiGetScreenSize()

function addNotification(type, header, desc, time)
    time=time+1000
    table.insert(NOTIFY_STACK, {type=type, header=header, desc=desc, time=time, startTime=getTickCount(), endTime=getTickCount()+500, animated=false, rT=dxCreateRenderTarget(RADAR_GUI.scale.notify_bg.w, RADAR_GUI.scale.notify_bg.h, true)})
    playSound("resources/sounds/"..type..".mp3")
end


addEventHandler("onClientRender", getRootElement(), function()
    local iT = 1
    for i,v in pairs(NOTIFY_STACK) do
        x = RADAR_GUI.pos.notify.w
        if not animated then
            local now = getTickCount()
            local elapsedTime = now - v.startTime
            local duration = v.endTime - v.startTime
            local progress = elapsedTime / duration
            x = interpolateBetween(Vector3(-RADAR_GUI.scale.notify_bg.w, 0, 0), Vector3(RADAR_GUI.pos.notify.w,0,0), progress, "InOutQuad")
            if progress == 100 then
                v.animated = false
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
                table.remove(NOTIFY_STACK, iT)
            end
        end
        dxSetRenderTarget(v.rT)
            dxDrawImage(0, 0, RADAR_GUI.scale.notify_bg.w, RADAR_GUI.scale.notify_bg.h, RADAR_GUI.txt.notify_bg)
            dxDrawImage(20*zoom, 0+(RADAR_GUI.scale.notify_bg.h/2)-(RADAR_GUI.scale.notify_icon.h/2), RADAR_GUI.scale.notify_icon.w, RADAR_GUI.scale.notify_icon.h, RADAR_GUI.txt[v.type])
            if not (v.desc) then
                dxDrawText(v.header, 0+85*zoom, 0+(RADAR_GUI.scale.notify_bg.h/2), null, null, tocolor(255, 255, 255), 1, RADAR_GUI.fonts.medium_15, "left", "center")
            else
                dxDrawText(v.header, 0+85*zoom, 0+(RADAR_GUI.scale.notify_bg.h/2)-dxGetFontHeight(1, RADAR_GUI.fonts.medium_20)/2, null, null, tocolor(255, 255, 255), 1, RADAR_GUI.fonts.medium_20, "left", "center")            
                formatted = wordWrap(v.desc, 400, 1, RADAR_GUI.fonts.medium_10, true)
                for i,v in pairs(formatted) do
                    dxDrawText(formatted[i], 0+85*zoom, 0+(RADAR_GUI.scale.notify_bg.h/2)+5*zoom+((i-1)*dxGetFontHeight()), null, null, tocolor(255, 255, 255), 1, RADAR_GUI.fonts.medium_10, "left", "center", false, false, false, true)            
                end
            end
        dxSetRenderTarget()
        dxDrawImage(x, RADAR_GUI.pos.notify.y-(RADAR_GUI.scale.notify_bg.h*iT), RADAR_GUI.scale.notify_bg.w, RADAR_GUI.scale.notify_bg.h, v.rT)
        iT=iT+1
    end
end)

addCommandHandler("testNotify", function()
    addNotification("info", "Informacja", "Oto krótka informacja dla gracza", 2000)
    setTimer(function()
        addNotification("error", "Błąd", "Oto opis błędu w czynności", 2000)
    end,500,1)    
    setTimer(function()
        addNotification("ok", "Powodzenie", "Operacja się powiodła, gratulacje! Twoje konto bankowe zostało zasilone kwotą #85bb65$500.000#FFFFFF.", 2000)
    end,1000,1)
end)


function wordWrap(text, maxwidth, scale, font, colorcoded)
    local lines = {}
    local words = split(text, " ") -- this unfortunately will collapse 2+ spaces in a row into a single space
    local line = 1 -- begin with 1st line
    local word = 1 -- begin on 1st word
    local endlinecolor
    while (words[word]) do -- while there are still words to read
        repeat
            if colorcoded and (not lines[line]) and endlinecolor and (not string.find(words[word], "^#%x%x%x%x%x%x")) then -- if on a new line, and endline color is set and the upcoming word isn't beginning with a colorcode
                lines[line] = endlinecolor -- define this line as beginning with the color code
            end
            lines[line] = lines[line] or "" -- define the line if it doesnt exist

            if colorcoded then
                local rw = string.reverse(words[word]) -- reverse the string
                local x, y = string.find(rw, "%x%x%x%x%x%x#") -- and search for the first (last) occurance of a color code
                if x and y then
                    endlinecolor = string.reverse(string.sub(rw, x, y)) -- stores it for the beginning of the next line
                end
            end
      
            lines[line] = lines[line]..words[word] -- append a new word to the this line
            lines[line] = lines[line] .. " " -- append space to the line

            word = word + 1 -- moves onto the next word (in preparation for checking whether to start a new line (that is, if next word won't fit)
        until ((not words[word]) or dxGetTextWidth(lines[line].." "..words[word], scale, font, colorcoded) > maxwidth) -- jumps back to 'repeat' as soon as the code is out of words, or with a new word, it would overflow the maxwidth
    
        lines[line] = string.sub(lines[line], 1, -2) -- removes the final space from this line
        if colorcoded then
            lines[line] = string.gsub(lines[line], "#%x%x%x%x%x%x$", "") -- removes trailing colorcodes
        end
        line = line + 1 -- moves onto the next line
    end -- jumps back to 'while' the a next word exists
    return lines
end