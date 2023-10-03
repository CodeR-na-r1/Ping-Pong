require "board"
require "puck"

function love.load()

    love.window.setTitle("Ping&Pong")

    width = love.graphics.getWidth()
    height = love.graphics.getHeight()

    love.graphics.setBackgroundColor(240 / 255, 190 / 255, 172 / 255)

    puck = Puck:create(Vector:create(width / 2, height / 2), 15)

    leftBoard = Board:create(Vector:create(25, height /2 - 75), Vector:create(30, 150))
    rightBoard = Board:create(Vector:create(width - 25 - 30, height /2 - 75), Vector:create(30, 150))

end

function love.update()



end

function love.draw()

    love.graphics.line(width / 2, 0, width / 2, height)

    puck:draw()

    leftBoard:draw()
    rightBoard:draw()

end