require "moveBoard"
require "puck"

function love.load()

    love.window.setTitle("Ping&Pong")

    width = love.graphics.getWidth()
    height = love.graphics.getHeight()

    love.graphics.setBackgroundColor(240 / 255, 190 / 255, 172 / 255)

    puck = Puck:create(Vector:create(width / 2, height / 2), 30, Vector:create(0, 0), Vector:create(width, height))

    leftBoard = MoveBoard:create(Vector:create(25, height /2 - 75), Vector:create(30, 150), Vector:create(0, 0), Vector:create(width, height))
    rightBoard = MoveBoard:create(Vector:create(width - 25 - 30, height /2 - 75), Vector:create(30, 150), Vector:create(0, 0), Vector:create(width, height))

end

function love.update(dt)

    leftBoard:update(dt)
    rightBoard:update(dt)

    -- if leftBoard:isInside(puck:getVLocation()) then

    -- end


end

function love.draw()

    love.graphics.line(width / 2, 0, width / 2, height)

    puck:draw()

    leftBoard:draw()
    rightBoard:draw()

    -- print(rightBoard:getVelocity())

end

function love.keypressed(key)
    -- print(key)

    if key == 'w' then
        leftBoard:applyForce(Vector:create(0, -150))
    end
    if key == 's' then
        leftBoard:applyForce(Vector:create(0, 150))
    end

    if key == 'up' then
        rightBoard:applyForce(Vector:create(0, -150))
    end
    if key == 'down' then
        rightBoard:applyForce(Vector:create(0, 150))
    end

end