function Element.getAllWithinPosition(position, range, dim, int, type, returnDistance)
    local dim = dim or 0
    local int = int or 0
    local range = range or 20
    local type = type or "player"
    local returnDistance = returnDistance or false
    local elementsToReturn = {}
    for i,v in pairs(Element.getAllByType(type)) do
        if v:getDistanceToPosition(position) <= range and v.dimension == dim and v.interior == int then
            if returnDistance then
                table.insert(elementsToReturn, {element=v, distance=v:getDistanceToPosition(position)})
            else
                table.insert(elementsToReturn, {element=v})
            end
        end
    end
    return elementsToReturn
end

function Element:getDistanceToElement(element)
	local element1 = self.position
	local element2 = element.position
	local distance = getDistanceBetweenPoints3D( element1,element2 )
	return distance
end

function Element:getDistanceToPosition(position)
    local selfPosition = self.position
    return getDistanceBetweenPoints3D(selfPosition, position)
end