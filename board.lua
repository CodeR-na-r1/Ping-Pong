require "vector"

Board = {}
Board.__index = Board

function Board:create(vLocation, vSize)
    
    local board = {}
    setmetatable(board, Board)

    board.vLocation = vLocation
    board.vSize = vSize

    board.vVelocity = Vector:create(0, 0)

    return board

end

function Board:draw()

    love.graphics.rectangle("fill", self.vLocation.x, self.vLocation.y, self.vSize.x, self.vSize.y)

end

function Board:update()

    

end