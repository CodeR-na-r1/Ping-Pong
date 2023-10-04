Puck = {}
Puck.__index = Puck

function Puck:create(vLocation, iSize, vMinXY, vMaxXY, maxVelocity)
    local puck = {}
    setmetatable(puck, Puck)

    puck.vLocation = vLocation
    puck.iSize = iSize

    puck.vMinXY = vMinXY
    puck.vMaxXY = vMaxXY

    puck.maxVelocity = maxVelocity or 3

    puck.isMove = false
    puck.iCounter = 0

    puck.iSlowdownRatio = 0.2

    puck.vVelocity = Vector:create(0, 0)
    puck.vAcceleration = Vector:create(0, 0)

    puck.staticVAcceleration = Vector:create(0, 0)

    return puck
end

function Puck:update(dt)

    self.vAcceleration = self.vAcceleration + self.staticVAcceleration

    self.vVelocity = self.vVelocity + self.vAcceleration
    self.vVelocity = self.vVelocity:limit(self.maxVelocity)

    self.vLocation = self.vLocation + self.vVelocity * dt
    
    self.vAcceleration = self.vAcceleration * 0

end

function Puck:draw()

    love.graphics.circle("fill", self.vLocation.x, self.vLocation.y, self.iSize)

end

function Puck:setVAcceleration(value)

    self.staticVAcceleration = value

end

function Puck:resetVAcceleration()

    self.staticVAcceleration = Vector:create(0, 0)

end

function setMaxVelocity(value)

    self.maxVelocity = value

end

-- selectors

function Puck:getVLocation()

    return self.vLocation

end

function Puck:invertVVelocity()

    self.vVelocity = self.vVelocity * -1

end