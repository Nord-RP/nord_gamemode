loadstring(exports.dgs:dgsImportOOPClass(true))()-- load OOP class
local sW,sH = guiGetScreenSize()
DEV_MODE = true
local zoom = sW/1920
local drawFont = dxCreateFont("resources/fonts/Poppins-Medium.ttf", 50*zoom, false)


addEventHandler("onClientRender", getRootElement(), function()
    if DEV_MODE then
        dxDrawText("DEVELOPER PREVIEW\nDOES NOT REPRESENT THE FINAL LOOK", sW/2, drawFont:getHeight(), nil, nil, tocolor(255,255,255,255*0.1), 1, drawFont, "center", "center")
    end
end)