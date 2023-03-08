loadstring(exports.dgs:dgsImportOOPClass(true))()-- load OOP class



addEventHandler("onClientResourceStart", resourceRoot, function()
    print("Start");
    showChat(false);
    setPlayerHudComponentVisible("all", false);

    GUI.elements.bg = dgsImage(GUI.pos.panel_bg.x,GUI.pos.panel_bg.y, GUI.scale.panel_bg.w, GUI.scale.panel_bg.h, GUI.txt.panel_bg);
    GUI.elements.bg_left = dgsImage(GUI.pos.panel_bg_left.x,GUI.pos.panel_bg_left.y, GUI.scale.panel_bg_left.w, GUI.scale.panel_bg_left.h, GUI.txt.panel_bg_left);
    GUI.elements.bg_left:setParent(GUI.elements.bg);
    GUI.elements.online_label = dgsLabel(GUI.pos.online_label.x, GUI.pos.online_label.y, 0, 0, "Online", false, tocolor(255,255,255), 1, 1, nil, nil, nil, "right" , "top")
    GUI.elements.online_label:setParent(GUI.elements.bg);
    GUI.elements.online_label:setFont(GUI.fonts.font_4);

    GUI.elements.counter_label = dgsLabel(GUI.pos.counter_label.x, GUI.pos.counter_label.y, 0, 0, "194", false, tocolor(255,255,255), 1, 1, nil, nil, nil, "right" , "top")
    GUI.elements.counter_label:setParent(GUI.elements.bg);
    GUI.elements.counter_label:setFont(GUI.fonts.font_12);

    GUI.elements.online = dgsImage(GUI.pos.online.x,GUI.pos.online.y, GUI.scale.online.w, GUI.scale.online.h, GUI.txt.online);
    GUI.elements.online:setParent(GUI.elements.bg);
    GUI.elements.online_blink = dgsImage(GUI.pos.online.x,GUI.pos.online.y, GUI.scale.online.w, GUI.scale.online.h, GUI.txt.online_blink);
    GUI.elements.online_blink:setParent(GUI.elements.bg);
    GUI.elements.online_blink:setAlpha(0);
    GUI.vars.online = false;

    GUI.timers.online = setTimer(function()
        if(GUI.vars.online == false) then
            GUI.elements.online_blink:alphaTo(1, "Linear", 500); 
            GUI.vars.online = true
        else
            GUI.elements.online_blink:alphaTo(0, "Linear", 500); 
            GUI.vars.online = false
        end
    end, 1000, 0);
end)