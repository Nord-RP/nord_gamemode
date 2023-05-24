local sW, sH = guiGetScreenSize()
Radar = {}

Radar.Width = 464*zoom;
Radar.Height = 247*zoom;
Radar.PosX = 9*zoom;
Radar.PosY = ((sH - 56*zoom) - Radar.Height);
Radar.InVehicle = false


Radar.NormalTargetSize, Radar.BiggerTargetSize = Radar.Width, Radar.Width * 2;
Radar.MapTarget = dxCreateRenderTarget(Radar.BiggerTargetSize, Radar.BiggerTargetSize, true);
Radar.RenderTarget = dxCreateRenderTarget(Radar.NormalTargetSize * 3, Radar.NormalTargetSize * 3, true);
Radar.FinalTarget = dxCreateRenderTarget(Radar.Width, Radar.Height, true);
Radar.MapTexture = svgCreate(3072, 3072, "radar/files/img/map.svg");



Radar.Visible = true
Radar.TxtSize = 3080
Radar.WaterColor = {125, 168, 210};
Radar.Alpha = 255*0.9;

Radar.MapUnit = Radar.TxtSize / 6000;

Radar.CurrentZoom = 2;
Radar.MaximumZoom = 10;
Radar.MinimumZoom = 1;

RADAR_GUI = {}
RADAR_GUI.txt = {
    ["top_bar"] = dxCreateTexture("radar/files/img/top_bar.png"),
    ["bottom_bar"] = dxCreateTexture("radar/files/img/bottom_bar.png"),
    ["notify_bg"] = dxCreateTexture("radar/files/img/notification_bg.png", "argb", true, "wrap"),
    ["error"] = dxCreateTexture("radar/files/img/error.png", "argb", true, "wrap"),
    ["ok"] = dxCreateTexture("radar/files/img/ok.png", "argb", true, "wrap"),
    ["info"] = dxCreateTexture("radar/files/img/info.png", "argb", true, "wrap"),
}

RADAR_GUI.scale = {
    ["top_bar"] = {w=481*zoom, h=53*zoom},
    ["bottom_bar"] = {w=481*zoom, h=53*zoom},
    ["notify_bg"] = {w= 481*zoom, h= 89*zoom},
    ["notify_icon"] = {w= 45*zoom, h= 45*zoom},
}

RADAR_GUI.pos = {
    ["top_bar"] = {x=Radar.PosX-8*zoom, y=Radar.PosY-8*zoom},
    ["bottom_bar"] = {x=Radar.PosX-8*zoom, y=Radar.PosY+Radar.Height+5*zoom},
    ["notify"] = {x=Radar.PosX-8*zoom, y=Radar.PosY-16*zoom},
    ["notify_icon"] = {x=Radar.PosX-8*zoom, y=Radar.PosY-16*zoom},
}

RADAR_GUI.fonts = {
    ["bold_19"] = dxCreateFont("resources/fonts/Roboto-Bold.ttf", 15*zoom, false),
    ["medium_15"] = dxCreateFont("resources/fonts/Roboto-Medium.ttf", 15*zoom, false),
    ["medium_20"] = dxCreateFont("resources/fonts/Roboto-Medium.ttf", 20*zoom, false),
    ["medium_10"] = dxCreateFont("resources/fonts/Roboto-Medium.ttf", 10*zoom, false),
}
