ArtificalPlayer = {}
ArtificalPlayer.__index = ArtificalPlayer

-- Class description: implementation of a computer opponent

function ArtificalPlayer:create(puckObj, boardObj, latency)

    local artificalPlayer = {}
    setmetatable(artificalPlayer, ArtificalPlayer)

    artificalPlayer.puckObj = puckObj
    artificalPlayer.boardObj = boardObj

    artificalPlayer.maxForce = 3000

    artificalPlayer.latency = latency or 0.02
    artificalPlayer.timeCoutner = 0

    self.predictYCoord = 0

    self.precentError = 0
    self.failStrategy = false

    return artificalPlayer
end

function ArtificalPlayer:update(dt)
    
    self.timeCoutner = self.timeCoutner + dt

    if self.timeCoutner >= self.latency then

        self.timeCoutner = 0
        self:__doAction()
    end

end

function ArtificalPlayer:draw()

    love.graphics.circle("fill", 55, self.predictYCoord, 4)
end

function ArtificalPlayer:increasingError()

    self.precentError = self.precentError + 1

end

function ArtificalPlayer:rethinkTactics()

    local p = love.math.random(0, 100)
    if p < self.precentError then
        self.failStrategy = true
    end

    -- print(self.precentError)
    -- print(self.failStrategy)
end

function ArtificalPlayer:__doAction()

    if self.puckObj.vVelocity.x < 0 then

        -- predict y coord
        local boardX = self.boardObj.vLocation.x + self.boardObj.vSize.x
        local predictYRatio = math.abs((self.puckObj.vLocation.x - boardX) / self.puckObj.vVelocity.x)
        self.predictYCoord = self.puckObj.vLocation.y + self.puckObj.vVelocity.y * predictYRatio

        -- if the tactics are losing, then we distort the end point
        local assignPredict = math.abs(self.predictYCoord) / self.predictYCoord
        if self.failStrategy then
            self.predictYCoord = self.predictYCoord + (self.boardObj.vSize.y * 1.1) * assignPredict
        end
        
        if self.predictYCoord < 0 then
            self.predictYCoord = -self.predictYCoord
        elseif self.predictYCoord > height then
            self.predictYCoord = height - (self.predictYCoord % height)
        end

        -- strive for this point
        
        local desiredY = self.predictYCoord - self.boardObj.vSize.y /2  - self.boardObj.vLocation.y

        assignDesired = math.abs(desiredY) / desiredY

        -- magic constant 40 == quantity of pixels to target point
        if math.abs(desiredY) < 40 then
            desiredY = math.map(math.abs(desiredY), 0, 40, 0, self.boardObj.maxVelocity) * assignDesired
            -- print(desiredY)
        else
            desiredY = self.boardObj.maxVelocity * assignDesired
            -- print(desiredY)
        end

        local steerY = desiredY - self.boardObj.vVelocity.y

        assignSteer = math.abs(steerY) / steerY
        if math.abs(steerY) > self.maxForce then
            steerY = self.maxForce * assignSteer
        end

        self.boardObj:setAcceleration(Vector:create(0, steerY))
        
    end

end