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


addEventHandler("onPlayerChat", root, function(message, type)
	local name = exports.entityData:getEntityData(source, "ch-name")
	if not name then cancelEvent() return end
	cancelEvent()
	if type == 0 then
		source:sendChat(message, "ic", 10)
	else
		source:sendChat(message, "me", 16)
	end
end)


function Player:sendChat(message, messageType, messageRange)
	if message and string.len(message) > 0 and type(messageRange) == "number" then
		local rangeMultiplier = {}

		local playerName = exports.entityData:getEntityData(self, "ch-name").." "..exports.entityData:getEntityData(self, "ch-surname")
		if messageType == "ic" then
			r, g, b = 255, 255, 255
			rangeMultiplier[1],rangeMultiplier[2],rangeMultiplier[3] = 110,110,110
			outputText = correctText(message)
			--TODO Sprawdzanie czy gada przez telefon
			outputText = playerName .. " mówi: " .. outputText
			iprint(outputText)
		elseif messageType == "me" then
			r,g,b = 220,162,244
			rangeMultiplier[1],rangeMultiplier[3] = 80,80
			rangeMultiplier[2] = 0
			
			local stars = "**"
			if scripted == true then
				stars = "*"
			end
			outputText = stars .. " " .. playerName .. " " .. message

			local endLetter = string.sub (outputText,string.len(outputText))
			if endLetter ~= "." and endLetter ~= "!" and endLetter ~= "?" then
				outputText = outputText .. "."
			end
		elseif messageType == "do" then
			r,g,b = 137,130,189--164,81,229
			rangeMultiplier[1],rangeMultiplier[3] = 80,80
			rangeMultiplier[2] = 0
			
			local stars = "**"
			if scripted == true then
				stars = "*"
			end

			outputText = correctText (message)
			outputText = stars .. " " .. outputText .. " (( " .. playerName .. " ))" .. stars
		elseif messageType == "k" then
			r,g,b = 255,255,255
			rangeMultiplier[1],rangeMultiplier[2],rangeMultiplier[3] = 110,110,110
			
			outputText = correctText (message .. "!")
			outputText = playerName .. " krzyczy: " .. outputText
			self:setAnimation("ON_LOOKERS", "shout_in", -1, false, false, false, false)
		elseif messageType == "c" then
			r,g,b = 255,255,255
			rangeMultiplier[1],rangeMultiplier[2],rangeMultiplier[3] = 110,110,110

			outputText = correctText (message)
			outputText = playerName .. " szepcze: " .. message
		end
		local playersInRange = Element.getAllWithinPosition(self.position, 20, self.dimension, self.interior, "player", true)
		if typ ~= "ooc" then
			for k,playerData in ipairs (playersInRange) do
				local v = playerData.element
				local dist = playerData.distance

				--TODO sprawdzanie BW i innych blokujacych
				if true then
					local r = r-(rangeMultiplier[1]/messageRange*dist)
					local g = g-(rangeMultiplier[2]/messageRange*dist)
					local b = b-(rangeMultiplier[3]/messageRange*dist)
					local formattedOutputText = outputText

					if typ == "ic" or typ == "k" or typ == "c" then
						local r2,g2,b2 = 220,162,244
						local r2 = r2-(rangeMultiplier[1]/messageRange*dist)
						local g2 = g2-(rangeMultiplier[2]/messageRange*dist)
						local b2 = b2-(rangeMultiplier[3]/messageRange*dist)
						formattedOutputText = string.gsub (formattedOutputText,"<",RGBToHex(r2,g2,b2) .. "*")
						formattedOutputText = string.gsub(formattedOutputText,">","*" .. RGBToHex(r,g,b))
					end
					outputChatBox(formattedOutputText, v, r, g, b, true)

				end
			end
		end
	end
end

function correctText (text)
	if text then
		text = text:gsub("^%l",string.upper, 1)
		local endLetter = string.sub (text,string.len(text))
		if endLetter ~= "." and endLetter ~= "!" and endLetter ~= "?" then
			text = text .. "."
		end
		return text
	end
end