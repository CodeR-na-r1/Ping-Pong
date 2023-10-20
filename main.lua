require "menu"

require "puck"
require "moveBoard"

require "textFormatter"

require "game"
require "gameAgent"
require "artificalPlayer"

function love.load()

    -- window settings

    love.window.setTitle("Ping&Pong")

    width = love.graphics.getWidth()
    height = love.graphics.getHeight()

    -- love.graphics.setBackgroundColor(240 / 255, 190 / 255, 172 / 255)

    -- load resources

    backgroundImg = love.graphics.newImage('resources/img/background.png')
    local startBackgroundImg = love.graphics.newImage('resources/img/startBackground.png')

    local onePlayerBtn = love.graphics.newImage('resources/img/1player.png')
    local twoPlayerBtn = love.graphics.newImage('resources/img/2player.png')
    local onePlayerBtnHover = love.graphics.newImage('resources/img/1playerHover.png')
    local twoPlayerBtnHover = love.graphics.newImage('resources/img/2playerHover.png')

    local startBtn = love.graphics.newImage('resources/img/start.png')
    local startBtnHover = love.graphics.newImage('resources/img/startHover.png')

    local yesBtn = love.graphics.newImage('resources/img/yes.png')
    local yesBtnHover = love.graphics.newImage('resources/img/yesHover.png')
    local noBtn = love.graphics.newImage('resources/img/no.png')
    local noBtnHover = love.graphics.newImage('resources/img/noHover.png')

    puckImg = love.graphics.newImage("resources/img/puckImg.png") 
    moveBoardImg = love.graphics.newImage("resources/img/boardImg.png")

    font = love.graphics.newFont("resources/font/SPACE.ttf", 32)
    fontScore = love.graphics.newFont("resources/font/SPACE.ttf", 50)
    love.graphics.setFont(font)

    -- init game objects

    menu = Menu:create(StateMenu.START, pngstartBackgroundImg, onePlayerBtn, twoPlayerBtn, onePlayerBtnHover, twoPlayerBtnHover, startBtn, startBtnHover, yesBtn, yesBtnHover, noBtn, noBtnHover)

    puck = Puck:create(puckImg, Vector:create(width / 2, height / 2), 30, Vector:create(0, 0), Vector:create(width, height), 450)
    puck:setVAcceleration(Vector:create(-10, love.math.random(-5, 5)))

    leftBoard = MoveBoard:create(moveBoardImg, Vector:create(25, height /2 - 75), Vector:create(30, 150), Vector:create(0, 0), Vector:create(width, height), 600)
    rightBoard = MoveBoard:create(moveBoardImg, Vector:create(width - 25 - 30, height /2 - 75), Vector:create(30, 150), Vector:create(0, 0), Vector:create(width, height), 600)

    game = Game:create(puck, leftBoard, rightBoard)

    gameAgent = GameAgent:create(fontScore)

    artificalPlayer = ArtificalPlayer:create(puck, leftBoard)

    isOnePlayer = true

    isStopGame = true
    isReInit = true

end

function love.update(dt)

    if isStopGame == false then

        puck:update(dt)

        leftBoard:update(dt)
        rightBoard:update(dt)

        if puck.vLocation.x - puck.iSize < leftBoard.vLocation.x + leftBoard.vSize.x then

            game:update(dt)
            
            if game._isInside then
                puck:invertVVelocity()
                puck:randomizeYDirection()
                if puck.maxVelocity < 1000 then
                    puck:setMaxVelocity(puck.maxVelocity * 1.04)
                    leftBoard:setMaxVelocity(puck.maxVelocity * 1.3)
                end
            end

            if puck.vLocation.x - puck.iSize < leftBoard.vLocation.x then
                isStopGame = true
            end

        elseif puck.vLocation.x + puck.iSize > rightBoard.vLocation.x then

            game:update(dt)
            
            if game._isInside then
                puck:invertVVelocity()
                puck:randomizeYDirection()
                if puck.maxVelocity < 1000 then
                    puck:setMaxVelocity(puck.maxVelocity * 1.04)
                    rightBoard:setMaxVelocity(puck.maxVelocity * 1.3)
                end
            end

            if puck.vLocation.x + puck.iSize > rightBoard.vLocation.x + rightBoard.vSize.x then
                isStopGame = true
            end
        
        end

        keyboardEvent()

        if isOnePlayer == true then
            artificalPlayer:update(dt)
        end

    else    -- prepare (reInit) objects for new game

        if isReInit == false then
            if game:isLeftDir() == true then
                gameAgent:incRightScore()
            else
                gameAgent:incLeftScore()
            end

            puck = Puck:create(puckImg, Vector:create(width / 2, height / 2), 30, Vector:create(0, 0), Vector:create(width, height), 450)
            puck:setVAcceleration(Vector:create(-10, love.math.random(-5, 5)))
        
            leftBoard = MoveBoard:create(moveBoardImg, Vector:create(25, height /2 - 75), Vector:create(30, 150), Vector:create(0, 0), Vector:create(width, height), 600)
            rightBoard = MoveBoard:create(moveBoardImg, Vector:create(width - 25 - 30, height /2 - 75), Vector:create(30, 150), Vector:create(0, 0), Vector:create(width, height), 600)
            
            game = Game:create(puck, leftBoard, rightBoard)

            artificalPlayer = ArtificalPlayer:create(puck, leftBoard)

            isReInit = true
        end

        -- check finish game (score > 10) + init menu
    end
  
end

function love.draw()
    
    love.graphics.draw(backgroundImg)

    -- love.graphics.line(width / 2, 0, width / 2, height)

    gameAgent:draw()

    puck:draw()

    leftBoard:draw()
    rightBoard:draw()

    game:draw()
    
    if isReInit == true then

        -- menu action

	    drawCenteredText("PRESS ANY KEY FOR START", width /2, height /4)
    end

end

function keyboardEvent()

    if isOnePlayer == false then
        if love.keyboard.isDown('w') then
            leftBoard:applyForce(Vector:create(0, -150))
        end
        if love.keyboard.isDown('s') then
            leftBoard:applyForce(Vector:create(0, 150))
        end
    end

    if love.keyboard.isDown('up') then
        rightBoard:applyForce(Vector:create(0, -150))
    end
    if love.keyboard.isDown('down') then
        rightBoard:applyForce(Vector:create(0, 150))
    end

end

function love.keypressed(key)
    if isReInit == true then

        isStopGame = false
        isReInit = false
    end
end