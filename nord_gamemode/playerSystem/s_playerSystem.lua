function Player:getNearestVehicle(distance)
	local lastMinDis = distance-0.0001
	local nearestVeh = false
	local plrPos = self:getPosition()
	local plrInt = self:getInterior()
	local plrDim = self:getDimension()

	for _,v in pairs(getElementsByType("vehicle")) do
		local vehInt,vehDim = v:getInterior(),v:getDimension()
		if vehInt == plrInt and vehDim == plrDim then
            local vehPos = v:getPosition()
			local dis = getDistanceBetweenPoints3D(plrPos.x,plrPos.y,plrPos.z,vehPos.x,vehPos.y,vehPos.z)
			if dis < distance then
				if dis < lastMinDis then 
					lastMinDis = dis
					nearestVeh = v
				end
			end
		end
	end
	return nearestVeh
end