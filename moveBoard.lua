require "vector"

-- Class description: implementaion of the board object

MoveBoard = {}
MoveBoard.__index = MoveBoard

function MoveBoard:create(texture, vLocation, vSize, vMinXY, vMaxXY, maxVelocity)
    
    local moveBoard = {}
    setmetatable(moveBoard, MoveBoard)

    moveBoard.texture = texture

    moveBoard.vLocation = vLocation
    moveBoard.vSize = vSize

    moveBoard.vMinXY = vMinXY
    moveBoard.vMaxXY = vMaxXY

    moveBoard.maxVelocity = maxVelocity or 3

    moveBoard.isMove = false
    moveBoard.iCounter = 0

    moveBoard.iSlowdownRatio = 0.2

    moveBoard.vVelocity = Vector:create(0, 0)
    moveBoard.vAcceleration = Vector:create(0, 0)

    moveBoard.animationScale = 5

    moveBoard.framesCounts = 10

    return moveBoard

end

function MoveBoard:update(dt)

    if self.isMove then

        self.vVelocity = self.vVelocity + self.vAcceleration
        self.vVelocity = self.vVelocity:limit(self.maxVelocity)
        self.vLocation = self.vLocation + self.vVelocity * dt

        self:checkBoundaries()

        if self.iCounter < self.framesCounts then
            self.vAcceleration = self.vAcceleration / self.animationScale

        elseif self.iCounter < self.framesCounts*2 then
            if self.iCounter == self.framesCounts then
                self.vAcceleration = self.vAcceleration * -1
            end

            self.vAcceleration = self.vAcceleration * self.animationScale

        else
            self.vVelocity = self.vVelocity * 0
            self.iCounter = 0
            self.isMove = false
        end

        self.iCounter = self.iCounter + 1

    end
        
end

function MoveBoard:draw()

    -- love.graphics.rectangle("fill", self.vLocation.x, self.vLocation.y, self.vSize.x, self.vSize.y)
    love.graphics.draw(self.texture, self.vLocation.x - 14, self.vLocation.y - 12)--, 0, self.vSize.x, self.vSize.y)

end

function MoveBoard:applyForce(vForce)

    self.isMove = true
    self.iCounter = 0

    if self.vVelocity.y * vForce.y < 0 then -- если разное направление
        self.vVelocity = self.vVelocity * 0.1 -- self.vVelocity + vForce -- * 0.2
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

function MoveBoard:setMaxVelocity(vValue)
    self.maxVelocity = vValue
end

function MoveBoard:setAcceleration(vValue)
    self.vAcceleration = vValue
end