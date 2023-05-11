local sW, sH = guiGetScreenSize()
Radar = {}

Radar.Width = 464/zoom;
Radar.Height = 247/zoom;
Radar.PosX = 9/zoom;
Radar.PosY = ((sH - 56/zoom) - Radar.Height)/zoom;
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
}

RADAR_GUI.scale = {
    ["top_bar"] = {w=481/zoom, h=53/zoom},
    ["bottom_bar"] = {w=481/zoom, h=53/zoom},
}

RADAR_GUI.pos = {
    ["top_bar"] = {x=Radar.PosX-8/zoom, y=Radar.PosY-8/zoom},
    ["bottom_bar"] = {x=Radar.PosX-8/zoom, y=Radar.PosY+Radar.Height+5/zoom},
}

RADAR_GUI.fonts = {
    ["bold_19"] = dxCreateFont("resources/fonts/Roboto-Bold.ttf", 15/zoom, false),
}