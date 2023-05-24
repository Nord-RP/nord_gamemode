local sW, sH = guiGetScreenSize()
hudMaskShader = dxCreateShader("radar/files/shaders/hud_mask.fx")
maskTexture = dxCreateTexture("radar/files/img/radar_mask.png");
radarBg = dxCreateTexture("radar/files/img/radar_bg.png");
dxSetShaderValue( hudMaskShader, "sMaskTexture", maskTexture )
local GUI = RADAR_GUI
local time = getRealTime()
local hours = string.format("%02d", time.hour)
local minutes = string.format("%02d", time.minute)
local money = exports.entityData:getEntityData(localPlayer, "ch-money")

setTimer(function()
	local time = getRealTime()
	hours = string.format("%02d", time.hour)
	minutes = string.format("%02d", time.minute)
end,60000, 0)

function onClientEntityDataChange(theKey, oldValue, newValue, dataType)
	if theKey == "ch-money" then
		money = newValue
	end
end
addEventHandler("onClientEntityDataChange", root, onClientEntityDataChange)

addEventHandler('onClientHUDRender', root,
	function()
		if money then
        renderRadar()
		renderHUD()

		end
    end
)

function renderHUD()
	dxDrawImage(GUI.pos.top_bar.x, GUI.pos.top_bar.y, GUI.scale.top_bar.w, GUI.scale.top_bar.h, GUI.txt.top_bar)
	dxDrawImage(GUI.pos.bottom_bar.x, GUI.pos.bottom_bar.y, GUI.scale.bottom_bar.w, GUI.scale.bottom_bar.h, GUI.txt.bottom_bar)
	dxDrawText(math.floor(localPlayer.health), GUI.pos.bottom_bar.x+50*zoom, GUI.pos.bottom_bar.y+GUI.scale.bottom_bar.h/2, nil, nil, tocolor(186, 186, 186), 1, GUI.fonts.bold_19, "left", "center")
	dxDrawText("$"..money, GUI.pos.bottom_bar.x+150*zoom, GUI.pos.bottom_bar.y+GUI.scale.bottom_bar.h/2, nil, nil, tocolor(186, 186, 186), 1, GUI.fonts.bold_19, "left", "center")
	dxDrawText(hours..":"..minutes, GUI.pos.bottom_bar.x+300*zoom, GUI.pos.bottom_bar.y+GUI.scale.bottom_bar.h/2, nil, nil, tocolor(186, 186, 186), 1, GUI.fonts.bold_19, "left", "center")
	dxDrawText("26°C", GUI.pos.bottom_bar.x+415*zoom, GUI.pos.bottom_bar.y+GUI.scale.bottom_bar.h/2, nil, nil, tocolor(186, 186, 186), 1, GUI.fonts.bold_19, "left", "center")
end

function renderRadar()
	if (Radar.Visible) then
		if(localPlayer.interior == 0) then 
			dxDrawImage(Radar.PosX, Radar.PosY, Radar.Width, Radar.Height, radarBg, 0,0,0, tocolor(255,255,255,255*0.8))
			--dxDrawBorder(Radar.PosX, Radar.PosY, Radar.Width, Radar.Height, 2, tocolor(0, 0, 0, 200));

			Radar.InVehicle = localPlayer.vehicle
			playerX, playerY, playerZ = localPlayer.position:getX(), localPlayer.position:getY(), localPlayer.position:getZ()

			local playerRotation = localPlayer:getRotation():getZ()
			local playerMapX, playerMapY = (2995 + playerX) / 6000 * Radar.TxtSize, (3010 - playerY) / 6000 * Radar.TxtSize;
			local streamDistance, pRotation = getRadarRadius(), getRotation();
			local mapRadius = streamDistance / 6000 * Radar.TxtSize * Radar.CurrentZoom;
			local mapX, mapY, mapWidth, mapHeight = playerMapX - mapRadius, playerMapY - mapRadius, mapRadius * 2, mapRadius * 2;

			dxSetRenderTarget(Radar.MapTarget, true);
			dxDrawImageSection(0, 0, Radar.BiggerTargetSize, Radar.BiggerTargetSize, mapX, mapY, mapWidth, mapHeight, Radar.MapTexture, 0, 0, 0, tocolor(255, 255, 255, Radar.Alpha), false);
			
			dxSetShaderValue( hudMaskShader, "sPicTexture", Radar.MapTarget )

			dxSetRenderTarget(Radar.RenderTarget, true);                
			dxDrawImage(Radar.NormalTargetSize / 2, Radar.NormalTargetSize / 2, Radar.BiggerTargetSize, Radar.BiggerTargetSize, hudMaskShader, math.deg(-pRotation), 0, 0, tocolor(255, 255, 255, 255), false);


			dxSetRenderTarget(Radar.FinalTarget);
			dxDrawImageSection(0,0, Radar.Width, Radar.Height, Radar.NormalTargetSize / 2 + (Radar.BiggerTargetSize / 2) - (Radar.Width / 2), Radar.NormalTargetSize / 2 + (Radar.BiggerTargetSize / 2) - (Radar.Height / 2), Radar.Width, Radar.Height, Radar.RenderTarget, 0, -90, 0, tocolor(255, 255, 255, 255));
			dxSetRenderTarget()

			dxSetShaderValue( hudMaskShader, "sPicTexture", Radar.FinalTarget )
			dxDrawImage(Radar.PosX, Radar.PosY, Radar.Width, Radar.Height, hudMaskShader)
			dxDrawImage((Radar.PosX + (Radar.Width / 2)) - 10, (Radar.PosY + (Radar.Height / 2)) - 10, 20, 20, 'radar/files/img/player.png', math.deg(-pRotation) - playerRotation);
		end
	end
end

function doesCollide(x1, y1, w1, h1, x2, y2, w2, h2)
	local horizontal = (x1 < x2) ~= (x1 + w1 < x2) or (x1 > x2) ~= (x1 > x2 + w2);
	local vertical = (y1 < y2) ~= (y1 + h1 < y2) or (y1 > y2) ~= (y1 > y2 + h2);
	
	return (horizontal and vertical);
end


function getRadarRadius()
	if (not Radar.InVehicle) then
		return 180;
	else
		local vehicleX, vehicleY, vehicleZ = getElementVelocity(Radar.InVehicle);
		local currentSpeed = (1 + (vehicleX ^ 2 + vehicleY ^ 2 + vehicleZ ^ 2) ^ (0.5)) / 2;
	
		if (currentSpeed <= 0.5) then
			return 180;
		elseif (currentSpeed >= 1) then
			return 360;
		end
		
		local distance = currentSpeed - 0.5;
		local ratio = 180 / 0.5;
		
		return math.ceil((distance * ratio) + 180);
	end
end

function getPointFromDistanceRotation(x, y, dist, angle)
	local a = math.rad(90 - angle);
	local dx = math.cos(a) * dist;
	local dy = math.sin(a) * dist;
	
	return x + dx, y + dy;
end

function getVectorRotation(X, Y, X2, Y2)
	local rotation = 6.2831853071796 - math.atan2(X2 - X, Y2 - Y) % 6.2831853071796;
	
	return -rotation;
end

function getRotation()
	local cameraX, cameraY, _, rotateX, rotateY = getCameraMatrix();
	local camRotation = getVectorRotation(cameraX, cameraY, rotateX, rotateY);
	
	return camRotation;
end

function getMapFromWorldPosition(worldX, worldY)
	local mapX = (Bigmap.PosX + Bigmap.Width / 2) + ((worldX - playerX) * Bigmap.CurrentZoom) * Radar.MapUnit;
	local mapY = (Bigmap.PosY + Bigmap.Height / 2) - ((worldY - playerY) * Bigmap.CurrentZoom) * Radar.MapUnit;
	
	return mapX, mapY;
end

function getWorldFromMapPosition(mapX, mapY)
	local worldX = playerX + ((mapX - (Bigmap.PosX + Bigmap.Width / 2)) / Bigmap.CurrentZoom) / Radar.MapUnit;
	local worldY = playerY - ((mapY - (Bigmap.PosY + Bigmap.Height / 2)) / Bigmap.CurrentZoom) / Radar.MapUnit;
	
	return worldX, worldY;
end

function dxDrawBorder(x, y, w, h, size, color, postGUI)
	size = size or 2;
	
	dxDrawRectangle(x - size, y, size, h, color or tocolor(0, 0, 0, 180), postGUI);
	dxDrawRectangle(x + w, y, size, h, color or tocolor(0, 0, 0, 180), postGUI);
	dxDrawRectangle(x - size, y - size, w + (size * 2), size, color or tocolor(0, 0, 0, 180), postGUI);
	dxDrawRectangle(x - size, y + h, w + (size * 2), size, color or tocolor(0, 0, 0, 180), postGUI);
end