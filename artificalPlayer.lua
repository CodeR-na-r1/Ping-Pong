ArtificalPlayer = {}
ArtificalPlayer.__index = ArtificalPlayer

-- Class description: implementation of a computer opponent

function ArtificalPlayer:create(puckObj, boardObj, latency)

    local artificalPlayer = {}
    setmetatable(artificalPlayer, ArtificalPlayer)

    artificalPlayer.puckObj = puckObj
    artificalPlayer.boardObj = boardObj

    artificalPlayer.latency = latency or 0
    artificalPlayer.timeCoutner = 0

    return artificalPlayer
end

function ArtificalPlayer:update(dt)
    
    self.timeCoutner = self.timeCoutner + dt

    if self.timeCoutner >= self.latency then

        self.timeCoutner = 0
        self:__doAction()
    end

end

function ArtificalPlayer:__doAction()

    if self.puckObj.vVelocity.x < 0 then

        local speedY = self.puckObj.vLocation.y - (self.boardObj.vLocation.y + self.boardObj.vSize.y / 2)

        if self.boardObj.vLocation.y - 10 > self.puckObj.vLocation.y then
            -- self.boardObj.vLocation.y = self.boardObj.vLocation.y - 2
            self.boardObj:applyForce(Vector:create(0, speedY /5))
        elseif self.boardObj.vLocation.y + self.boardObj.vSize.y + 10 < self.puckObj.vLocation.y then
            -- self.boardObj.vLocation.y = self.boardObj.vLocation.y + 2
            self.boardObj:applyForce(Vector:create(0, speedY /5))
        end
        -- self.boardObj.vLocation = Vector:create(self.boardObj.vLocation.x, speedY)

        -- local maxSpeed = math.abs(self.puckObj.maxVelocity)
        -- if maxSpeed < 100 then
        --     maxSpeed = 100
        -- end
        -- print(maxSpeed)

        -- if math.abs(speedY) > maxSpeed then

        --     if speedY < 0 then
        --         speedY = -maxSpeed
        --     else
        --         speedY = maxSpeed
        --     end
        -- end

        -- self.boardObj:setVelocity(Vector:create(0, speedY))

    end

end