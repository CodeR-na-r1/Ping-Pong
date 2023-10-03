Puck = {}
Puck.__index = Puck

function Puck:create(vLocation, iSize)
    local puck = {}
    setmetatable(puck, Puck)

    puck.vLocation = vLocation
    puck.iSize = iSize

    return puck
end

function Puck:draw()

    love.graphics.circle("fill", self.vLocation.x, self.vLocation.y, self.iSize)

end