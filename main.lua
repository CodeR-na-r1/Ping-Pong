require "puck"
require "moveBoard"

require "game"

function love.load()

    love.window.setTitle("Ping&Pong")

    backgroundImg = love.graphics.newImage('resources/img/background.png')
    puckImg = love.graphics.newImage("resources/img/puckImg.png") 
    moveBoardImg = love.graphics.newImage("resources/img/boardImg.png") 

    width = love.graphics.getWidth()
    height = love.graphics.getHeight()

    love.graphics.setBackgroundColor(240 / 255, 190 / 255, 172 / 255)

    puck = Puck:create(puckImg, Vector:create(width / 2, height / 2), 30, Vector:create(0, 0), Vector:create(width, height), 300)
    puck:setVAcceleration(Vector:create(-10, 03))

    leftBoard = MoveBoard:create(moveBoardImg, Vector:create(25, height /2 - 75), Vector:create(30, 150), Vector:create(0, 0), Vector:create(width, height), 600)
    rightBoard = MoveBoard:create(moveBoardImg, Vector:create(width - 25 - 30, height /2 - 75), Vector:create(30, 150), Vector:create(0, 0), Vector:create(width, height), 600)

    game = Game:create(puck, leftBoard, rightBoard)

    stopGame = false

end

function love.update(dt)

    puck:update(dt)

    leftBoard:update(dt)
    rightBoard:update(dt)

    if puck.vLocation.x - puck.iSize < leftBoard.vLocation.x + leftBoard.vSize.x then

        game:update(dt)
        
        if game._isInside then
            puck:invertVVelocity()
        end

        if puck.vLocation.x - puck.iSize < leftBoard.vLocation.x then
            stopGame = true
        end

    elseif puck.vLocation.x + puck.iSize > rightBoard.vLocation.x then

        game:update(dt)
        
        if game._isInside then
            puck:invertVVelocity()
        end

        if puck.vLocation.x + puck.iSize > rightBoard.vLocation.x + rightBoard.vSize.x then
            stopGame = true
        end
    
    end

    keyboardEvent()

    -- print("stopGame = ")
    -- print(stopGame)

end

function love.draw()
    
    love.graphics.draw(backgroundImg)

    love.graphics.line(width / 2, 0, width / 2, height)

    puck:draw()

    leftBoard:draw()
    rightBoard:draw()

    game:draw()

end

-- function love.keypressed(key)

--     if key == 'w' then
--         leftBoard:applyForce(Vector:create(0, -150))
--     end
--     if key == 's' then
--         leftBoard:applyForce(Vector:create(0, 150))
--     end

--     if key == 'up' then
--         rightBoard:applyForce(Vector:create(0, -150))
--     end
--     if key == 'down' then
--         rightBoard:applyForce(Vector:create(0, 150))
--     end

-- end

function keyboardEvent()

    if love.keyboard.isDown('w') then
        leftBoard:applyForce(Vector:create(0, -150))
    end
    if love.keyboard.isDown('s') then
        leftBoard:applyForce(Vector:create(0, 150))
    end

    if love.keyboard.isDown('up') then
        rightBoard:applyForce(Vector:create(0, -150))
    end
    if love.keyboard.isDown('down') then
        rightBoard:applyForce(Vector:create(0, 150))
    end

end