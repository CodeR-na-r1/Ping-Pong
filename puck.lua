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

    self:checkBoundaries()

end

function Puck:draw()

    love.graphics.circle("fill", self.vLocation.x, self.vLocation.y, self.iSize)

end

function Puck:checkBoundaries()

    if self.vLocation.x - self.iSize < self.vMinXY.x then

        self.vLocation.x = self.vMinXY.x + self.iSize
        self.vVelocity.x = self.vVelocity.x * -1
        self.staticVAcceleration.x = self.staticVAcceleration.x * -1
    elseif self.vLocation.x + self.iSize > self.vMaxXY.x then
        
        self.vLocation.x = self.vMaxXY.x - self.iSize
        self.vVelocity.x = self.vVelocity.x * -1
        self.staticVAcceleration.x = self.staticVAcceleration.x * -1
    end

    if self.vLocation.y - self.iSize < self.vMinXY.y then

        self.vLocation.y = self.vMinXY.y + self.iSize
        self.vVelocity.y = self.vVelocity.y * -1
        self.staticVAcceleration.y = self.staticVAcceleration.y * -1
    elseif self.vLocation.y + self.iSize > self.vMaxXY.y then
        
        self.vLocation.y = self.vMaxXY.y - self.iSize
        self.vVelocity.y = self.vVelocity.y * -1
        self.staticVAcceleration.y = self.staticVAcceleration.y * -1
    end

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