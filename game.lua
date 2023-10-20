Game = {}
Game.__index = Game

-- Class description: checking the conditions of hitting the puck by the player

function Game:create(puckObj, moveBoardLeft, moveBoardRight)
    local game = {}
    setmetatable(game, Game)

    game.puckObj = puckObj

    game.moveBoardLeft = moveBoardLeft
    game.moveBoardRight = moveBoardRight

    game.qPoints = 100
    game.points = {}
    game.angles = {}
    for i = 0, game.qPoints do

        game.points[i] = {0, 0} -- x, y
        game.angles[i] = math.rad(360 * (i / game.qPoints))
    end

    game._isInside = false

    game.__initPoints = 0

    return game
end

function Game:update(dt)

    self._isInside = false
    
    -- updates points position
    for i = 0, self.qPoints do

        self.points[i][0] = self.puckObj.iSize * math.cos(self.angles[i]) + self.puckObj.vLocation.x
        self.points[i][1] = self.puckObj.iSize * math.sin(self.angles[i]) + self.puckObj.vLocation.y

        if self:isInside(i) then
            
            self._isInside = true
            self.__initPoints = i
            break
        end
    end
    
    if self._isInside == false then
        
        self.__initPoints = self.qPoints
    end

end

function Game:draw()

    if self.__initPoints == 0 then
        return
    end

    local r, g, b, a = love.graphics.getColor()
    love.graphics.setColor(255/255, 119/255, 190/255, 0.5)

    for i = 0, self.__initPoints - 1 do

        love.graphics.circle("fill", self.points[i][0], self.points[i][1], 4)
    end

    self.__initPoints = 0
    
    love.graphics.setColor(r, g, b, a)

end

function Game:isInside(countPoint)

    local xyBoard = nil
    local maxxyBoard = nil

    if self.puckObj.vVelocity.x < 0 then -- check left board
        xyBoard = self.moveBoardLeft.vLocation
        maxxyBoard = self.moveBoardLeft.vSize
    else 
        xyBoard = self.moveBoardRight.vLocation
        maxxyBoard = self.moveBoardRight.vSize
    end

    local point = self.points[countPoint]

    if (point[0] > xyBoard.x and point[0] < xyBoard.x + maxxyBoard.x
        and point[1] > xyBoard.y and point[1] < xyBoard.y + maxxyBoard.y) then

        return true
    end

    return false
end

function Game:isLeftDir()

    if self.puckObj.vVelocity.x < 0 then

        return true
    end

    return false
end