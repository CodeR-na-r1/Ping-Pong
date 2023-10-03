Puck = {}
Puck.__index = Puck

function Puck:create(vLocation, iSize, vMinXY, vMaxXY)
    local puck = {}
    setmetatable(puck, Puck)

    puck.vLocation = vLocation
    puck.iSize = iSize

    puck.vMinXY = vMinXY
    puck.vMaxXY = vMaxXY

    puck.isMove = false
    puck.iCounter = 0

    puck.iSlowdownRatio = 0.2

    puck.vVelocity = Vector:create(0, 0)
    puck.vAcceleration = Vector:create(0, 0)

    return puck
end

function Puck:update()



end

function Puck:draw()

    love.graphics.circle("fill", self.vLocation.x, self.vLocation.y, self.iSize)

end

function Puck:getVLocation()

    return self.vLocation

end