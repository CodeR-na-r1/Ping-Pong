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

    -- if self.puckObj.vVelocity.x < 0 then

    --     local middleBoard = self.boardObj.vLocation.y + self.boardObj.vSize.y /2

    --     if middleBoard < self.puckObj.vLocation.y then

    --         self.boardObj:applyForce(Vector:create(0, 150))

    --     elseif middleBoard > self.puckObj.vLocation.y then

    --         self.boardObj:applyForce(Vector:create(0, -150))
    --     end

    -- end

    if self.puckObj.vVelocity.x < 0 then

        local middleBoard = self.boardObj.vLocation.y + self.boardObj.vSize.y /2

        if self.boardObj.vLocation.y < self.puckObj.vLocation.y then

            self.boardObj:applyForce(Vector:create(0, 150))

        elseif self.boardObj.vLocation.y + self.boardObj.vSize.y > self.puckObj.vLocation.y then

            self.boardObj:applyForce(Vector:create(0, -150))
        end

    end

end