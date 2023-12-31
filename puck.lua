Puck = {}
Puck.__index = Puck

-- Class description: implementaion of the puck object

function Puck:create(texture, vLocation, iSize, vMinXY, vMaxXY, maxVelocity)

    local puck = {}
    setmetatable(puck, Puck)

    puck.texture = texture

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

    -- print("puck speed = ")
    -- print(self.vVelocity * dt)
    self.vLocation = self.vLocation + self.vVelocity * dt
    
    self.vAcceleration = self.vAcceleration * 0

    self:checkBoundaries()

end

function Puck:draw()

    love.graphics.draw(self.texture, self.vLocation.x - self.iSize - 17, self.vLocation.y - self.iSize - 17, 0, 1, 1)
    -- love.graphics.circle("fill", self.vLocation.x, self.vLocation.y, self.iSize)

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

function Puck:setMaxVelocity(value)

    self.maxVelocity = value

end

-- selectors

function Puck:getVLocation()

    return self.vLocation

end

function Puck:invertVVelocity()

        self.vVelocity.x = self.vVelocity.x * -1
        self.staticVAcceleration.x = self.staticVAcceleration.x * -1

end

-- function Puck:randomizeYDirection()

--     yRatio = math.random(1, 10)

--     newDir = self.vVelocity:norm()
--     newDir.y = newDir.y * yRatio
--     newDir = newDir:norm()

--     sum = math.abs(self.vVelocity.x + self.vVelocity.y)

--     -- self.vVelocity.x = self.vVelocity.x * math.abs(newDir.x)
--     -- self.vVelocity.y = self.vVelocity.y * math.abs(newDir.y)

--     self.vVelocity.x = sum * newDir.x
--     self.vVelocity.y = sum * newDir.y

-- end

function Puck:randomizeYDirection()

    yRatio = math.random(1, 10)

    newDir = self.vVelocity:norm()
    speed = self.vVelocity:mag()

    newDir.y = newDir.y * yRatio
    newDir = newDir:norm()

    self.vVelocity = newDir * speed

end