require "vector"

MoveBoard = {}
MoveBoard.__index = MoveBoard

function MoveBoard:create(vLocation, vSize, vMinXY, vMaxXY)
    
    local moveBoard = {}
    setmetatable(moveBoard, MoveBoard)

    moveBoard.vLocation = vLocation
    moveBoard.vSize = vSize

    moveBoard.vMinXY = vMinXY
    moveBoard.vMaxXY = vMaxXY

    moveBoard.isMove = false
    moveBoard.iCounter = 0

    moveBoard.iSlowdownRatio = 0.2

    moveBoard.vVelocity = Vector:create(0, 0)
    moveBoard.vAcceleration = Vector:create(0, 0)

    return moveBoard

end

function MoveBoard:update()

    if self.isMove then

        self.vVelocity = self.vVelocity + self.vAcceleration
        self.vLocation = self.vLocation + self.vVelocity

        self:checkBoundaries()

        if self.iCounter < 30 then
            self.vAcceleration = self.vAcceleration * 0.2

        elseif self.iCounter < 60 then
            if self.iCounter == 30 then
                self.vAcceleration = self.vAcceleration * -1
            end

            self.vAcceleration = self.vAcceleration * 5

        else
            self.vVelocity = self.vVelocity * 0
            self.iCounter = 0
            self.isMove = false
        end

        self.iCounter = self.iCounter + 1

    end
        
end

function MoveBoard:draw()

    love.graphics.rectangle("fill", self.vLocation.x, self.vLocation.y, self.vSize.x, self.vSize.y)

end

function MoveBoard:applyForce(vForce)

    self.isMove = true
    self.iCounter = 0

    if self.vVelocity.y * vForce.y < 0 then -- если разное направление
        self.vVelocity = self.vVelocity * 0 -- self.vVelocity + vForce -- * 0.2
    end

    self.vAcceleration = vForce
    -- self.vVelocity = self.vVelocity * 0 -- 

end

function MoveBoard:checkBoundaries()

    if self.vLocation.y < self.vMinXY.y then

        self.vLocation.y = self.vMinXY.y
        self.vVelocity = self.vVelocity * 0
    elseif self.vLocation.y + self.vSize.y > self.vMaxXY.y then
        
        self.vLocation.y = self.vMaxXY.y - self.vSize.y
        self.vVelocity = self.vVelocity * 0
    end

end

function MoveBoard:getVelocity()
    return self.vVelocity
end

function MoveBoard:getAcceleration()
    return self.vAcceleration
end

function MoveBoard:setVelocity(vValue)
    self.vVelocity = vValue
end

function MoveBoard:setAcceleration(vValue)
    self.vAcceleration = vValue
end