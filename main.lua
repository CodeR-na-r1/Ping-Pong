require "menu"

require "puck"
require "moveBoard"

require "textFormatter"

require "game"
require "gameAgent"
require "artificalPlayer"

function love.load()

    -- constants

    MAX_SCORE_PARTY = 3

    -- window settings

    love.window.setTitle("Ping&Pong")

    width = love.graphics.getWidth()
    height = love.graphics.getHeight()

    -- love.graphics.setBackgroundColor(240 / 255, 190 / 255, 172 / 255)

    -- load resources

    musicBackground = love.audio.newSource("resources/music/musicBackground.mp3", "stream")
    musicBackground:setVolume(0.2) -- one octave lower

    backgroundImg = love.graphics.newImage('resources/img/background.png')
    local choiseBackgroundImg = love.graphics.newImage('resources/img/startBackground.png')
    local backgroundMaskImg = love.graphics.newImage('resources/img/backgroundMask.png')

    local onePlayerBtn = love.graphics.newImage('resources/img/1player.png')
    local twoPlayerBtn = love.graphics.newImage('resources/img/2player.png')
    local onePlayerBtnHover = love.graphics.newImage('resources/img/1playerHover.png')
    local twoPlayerBtnHover = love.graphics.newImage('resources/img/2playerHover.png')

    local startBtn = love.graphics.newImage('resources/img/start.png')
    local startBtnHover = love.graphics.newImage('resources/img/startHover.png')

    local gameTitleText = love.graphics.newImage('resources/img/gameTitle.png')
    local gameWinText = love.graphics.newImage('resources/img/youWin.png')
    local gameOverText = love.graphics.newImage('resources/img/gameOver.png')
    local LeftWinText = love.graphics.newImage('resources/img/leftWin.png')
    local RightWinText = love.graphics.newImage('resources/img/rightWin.png')
    local tryAgainText = love.graphics.newImage('resources/img/tryAgain.png')

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

    isOnePlayer = true

    menu = Menu:create(StateMenu.START, "resources/font/SPACE.ttf", isOnePlayer, backgroundImg, choiseBackgroundImg, backgroundMaskImg, onePlayerBtn, twoPlayerBtn, onePlayerBtnHover, twoPlayerBtnHover, startBtn, startBtnHover, gameTitleText, gameWinText, gameOverText, LeftWinText, RightWinText, tryAgainText, yesBtn, yesBtnHover, noBtn, noBtnHover)

    puck = Puck:create(puckImg, Vector:create(width / 2, height / 2), 30, Vector:create(0, 0), Vector:create(width, height), 450)
    local puckDir = love.math.random(0, 1)
    print(puckDir)
    if puckDir == 0 then
        puckDir = -1
    end
    puck:setVAcceleration(Vector:create(-10, love.math.random(3, 7) * puckDir))

    leftBoard = MoveBoard:create(moveBoardImg, Vector:create(25, height /2 - 75), Vector:create(30, 150), Vector:create(0, 0), Vector:create(width, height), 600)
    rightBoard = MoveBoard:create(moveBoardImg, Vector:create(width - 25 - 30, height /2 - 75), Vector:create(30, 150), Vector:create(0, 0), Vector:create(width, height), 600)

    game = Game:create(puck, leftBoard, rightBoard)

    gameAgent = GameAgent:create(fontScore)

    artificalPlayer = ArtificalPlayer:create(puck, leftBoard)

    isReInitObjects = true
    isStopGame = true
    isReInit = true

end

function love.update(dt)

    if not musicBackground:isPlaying() then
		love.audio.play(musicBackground)
	end

    if isStopGame == false then

        puck:update(dt)

        leftBoard:update(dt)
        rightBoard:update(dt)

        if puck.vLocation.x - puck.iSize < leftBoard.vLocation.x + leftBoard.vSize.x then

            game:update(dt)
            
            if game._isInside then
                puck:invertVVelocity()
                -- puck:randomizeYDirection()
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
                -- puck:randomizeYDirection()
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

        menu:update(dt)

        if menu.state == StateMenu.START then
            gameAgent:reset()
        end

        if isReInit == false then

            if game:isLeftDir() == true then
                gameAgent:incRightScore()
            else
                gameAgent:incLeftScore()
            end

            menu:changeState(StateMenu.INTERMEDIATE)

            if gameAgent:isEndParty(MAX_SCORE_PARTY) then   -- check finish game (score > 10) + init menu
                if gameAgent:isLeftWin() then
                    if isOnePlayer == true then
                        menu:changeState(StateMenu.FAIL)
                    else
                        menu:changeState(StateMenu.LEFT_WIN)
                    end
                else
                    if isOnePlayer == true then
                        menu:changeState(StateMenu.WIN)
                    else
                        menu:changeState(StateMenu.RIGHT_WIN)
                    end
                end
            end

            isReInit = true
        end

        if isReInitObjects == false then
            
            puck = Puck:create(puckImg, Vector:create(width / 2, height / 2), 30, Vector:create(0, 0), Vector:create(width, height), 450)
            local puckDir = love.math.random(0, 1)
            print(puckDir)
            if puckDir == 0 then
                puckDir = -1
            end
            puck:setVAcceleration(Vector:create(-10, love.math.random(3, 7) * puckDir))
        
            leftBoard = MoveBoard:create(moveBoardImg, Vector:create(25, height /2 - 75), Vector:create(30, 150), Vector:create(0, 0), Vector:create(width, height), 600)
            rightBoard = MoveBoard:create(moveBoardImg, Vector:create(width - 25 - 30, height /2 - 75), Vector:create(30, 150), Vector:create(0, 0), Vector:create(width, height), 600)
            
            game = Game:create(puck, leftBoard, rightBoard)

            artificalPlayer = ArtificalPlayer:create(puck, leftBoard)

            if gameAgent:isEndParty(MAX_SCORE_PARTY) then
                
                gameAgent:reset()
            end
            
            isStopGame = false
            isReInit = false
            menu.state = StateMenu.PLAYING

            isReInitObjects = true

        end

    end
  
end

function love.draw()
    
    love.graphics.draw(backgroundImg)

    -- love.graphics.line(width / 2, 0, width / 2, height)

    gameAgent:draw()

    puck:draw()

    leftBoard:draw()
    rightBoard:draw()

    -- game:draw()
    
    menu:draw()

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

function love.mousemoved(x, y, dx, dy, istouch)
    
    menu.x = x
    menu.y = y

end

function love.keypressed(key)
    if menu.state == StateMenu.INTERMEDIATE then

        isReInitObjects = false
    end
end