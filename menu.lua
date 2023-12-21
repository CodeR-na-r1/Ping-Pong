require "textFormatter"

Menu = {}
Menu.__index = Menu

-- Enum class description: provides a list of possible menu states

StateMenu = {
    START = 1,
    CHOISE = 2,

    INTERMEDIATE = 3,

    WIN = 4,
    FAIL = 5,
    LEFT_WIN = 6,
    RIGHT_WIN = 7,

    PLAYING = 8,
}

-- Class description: displaying the desired menu items

function Menu:create(state, fontSrc, isOnePlayer, startBackgroundImg, choiseBackgroundImg, backgroundMask, onePlayerBtn, twoPlayerBtn, onePlayerBtnHover, twoPlayerBtnHover, startBtn, startBtnHover, gameTitleText, gameWinText, gameOverText, LeftWinText, RightWinText, tryAgainText, yesBtn, yesBtnHover, noBtn, noBtnHover)

    local menu = {}
    setmetatable(menu, Menu)

    menu.state = state
    menu.isInput = false

    menu.fontSrc = fontSrc

    menu.isOnePlayer = isOnePlayer

    menu.x = 0
    menu.y = 0

    menu.titleFont = love.graphics.newFont("resources/font/SPACE.ttf", 80)

    menu.startBackgroundImg = startBackgroundImg
    menu.choiseBackgroundImg = choiseBackgroundImg
    menu.backgroundMask = backgroundMask

    menu.onePlayer = onePlayerBtn
    menu.twoPlayer = twoPlayerBtn

    menu.onePlayerBtn = onePlayerBtn
    menu.twoPlayerBtn = twoPlayerBtn
    menu.onePlayerBtnHover = onePlayerBtnHover
    menu.twoPlayerBtnHover = twoPlayerBtnHover

    menu.start = startBtn

    menu.startBtn = startBtn
    menu.startBtnHover = startBtnHover

    menu.gameTitleText = gameTitleText
    menu.gameWinText = gameWinText
    menu.gameOverText = gameOverText
    menu.LeftWinText = LeftWinText
    menu.RightWinText = RightWinText

    menu.tryAgainText = tryAgainText

    menu.yes = yesBtn
    menu.no = noBtn

    menu.yesBtn = yesBtn
    menu.yesBtnHover = yesBtnHover
    menu.noBtn = noBtn
    menu.noBtnHover = noBtnHover

    return menu
end

function Menu:changeState(stateValue)

    self.state = stateValue

end

function Menu:update(dt)

    if love.mouse.isDown("1") and self.isInput then
        return
    else
        self.isInput = false
    end

    if self.state == StateMenu.START then

	    if menu:isInside(width / 2 - self.startBtn:getWidth() /2 + 49, height * (6/8) - self.startBtn:getHeight() /2 + 49, self.startBtn:getWidth() - 98, self.startBtn:getHeight() - 98) then
            menu.start = menu.startBtnHover
            if love.mouse.isDown("1") then
                self.isInput = true
                self.state = StateMenu.CHOISE
            end
        else
            menu.start = menu.startBtn
        end

    elseif self.state == StateMenu.CHOISE then

        -- 1 player btn handler
        if menu:isInside(width / 2 - self.onePlayerBtn:getWidth() + 49, height * (7/12) + 49, self.onePlayerBtn:getWidth() - 98, self.onePlayerBtn:getHeight() - 98) then
            menu.onePlayer = menu.onePlayerBtnHover
            if love.mouse.isDown("1") then
                self.isInput = true
                isOnePlayer = true
                self.state = StateMenu.INTERMEDIATE
            end
        else
            menu.onePlayer = menu.onePlayerBtn
        end

        -- 2 player btn handler
        if menu:isInside(width / 2 + 49, height * (7/12) + 49, self.twoPlayer:getWidth() - 98, self.twoPlayer:getHeight() - 98) then
            menu.twoPlayer = menu.twoPlayerBtnHover
            if love.mouse.isDown("1") then
                self.isInput = true
                isOnePlayer = false
                self.state = StateMenu.INTERMEDIATE
            end
        else
            menu.twoPlayer = menu.twoPlayerBtn
        end

    elseif self.state == StateMenu.INTERMEDIATE then

        -- nothing

    elseif self.state == StateMenu.WIN or self.state == StateMenu.FAIL or self.state == StateMenu.LEFT_WIN or self.state == StateMenu.RIGHT_WIN then

        -- yes btn handler
        if menu:isInside(width / 2 - self.yes:getWidth() + 49, height * (68/100) + 49, self.yes:getWidth() - 98, self.yes:getHeight() - 98) then
            menu.yes = menu.yesBtnHover
            if love.mouse.isDown("1") then
                self.isInput = true
                self.state = StateMenu.INTERMEDIATE
            end
        else
            menu.yes = menu.yesBtn
        end

        -- no btn handler
        if menu:isInside(width / 2 + 49, height * (68/100) + 49, self.no:getWidth() - 98, self.no:getHeight() - 98) then
            menu.no = menu.noBtnHover
            if love.mouse.isDown("1") then
                self.isInput = true
                self.state = StateMenu.START
            end
        else
            menu.no = menu.noBtn
        end

    end

end

function Menu:draw()

    if self.state == StateMenu.START then

        love.graphics.draw(self.startBackgroundImg)
        love.graphics.draw(self.gameTitleText, width /2 - self.gameTitleText:getWidth() /2, height /2 - self.gameTitleText:getHeight())
        love.graphics.draw(self.start, width / 2 - self.startBtn:getWidth() /2, height * (6/8) - self.startBtn:getHeight() /2)

    elseif self.state == StateMenu.CHOISE then

        love.graphics.draw(self.choiseBackgroundImg)
        love.graphics.draw(self.onePlayer, width /2 - self.onePlayerBtn:getWidth(), height * (7/12))
        love.graphics.draw(self.twoPlayer, width /2, height * (7/12))

    elseif self.state == StateMenu.INTERMEDIATE then

	    drawCenteredText("PRESS ANY KEY FOR START", width /2, height /4)

    elseif self.state == StateMenu.WIN then

        love.graphics.draw(self.backgroundMask)

        love.graphics.draw(self.gameWinText, width /2 - self.gameWinText:getWidth() /2, height * (25/100))
        love.graphics.draw(self.tryAgainText, width /2 - self.tryAgainText:getWidth() /2, height * (56/100))
        love.graphics.draw(self.yes, width /2 - self.yes:getWidth(), height * (68/100))
        love.graphics.draw(self.no, width /2, height * (68/100))

    elseif self.state == StateMenu.FAIL then

        love.graphics.draw(self.backgroundMask)

        love.graphics.draw(self.gameOverText, width /2 - self.gameOverText:getWidth() /2, height * (25/100))
        love.graphics.draw(self.tryAgainText, width /2 - self.tryAgainText:getWidth() /2, height * (56/100))
        love.graphics.draw(self.yes, width /2 - self.yes:getWidth(), height * (68/100))
        love.graphics.draw(self.no, width /2, height * (68/100))

    elseif self.state == StateMenu.LEFT_WIN then

        love.graphics.draw(self.backgroundMask)

        love.graphics.draw(self.LeftWinText, width /2 - self.LeftWinText:getWidth() /2, height * (25/100))
        love.graphics.draw(self.tryAgainText, width /2 - self.tryAgainText:getWidth() /2, height * (56/100))
        love.graphics.draw(self.yes, width /2 - self.yes:getWidth(), height * (68/100))
        love.graphics.draw(self.no, width /2, height * (68/100))

    elseif self.state == StateMenu.RIGHT_WIN then

        love.graphics.draw(self.backgroundMask)

        love.graphics.draw(self.RightWinText, width /2 - self.RightWinText:getWidth() /2, height * (25/100))
        love.graphics.draw(self.tryAgainText, width /2 - self.tryAgainText:getWidth() /2, height * (56/100))
        love.graphics.draw(self.yes, width /2 - self.yes:getWidth(), height * (68/100))
        love.graphics.draw(self.no, width /2, height * (68/100))

    end
end

function Menu:isInside(x, y, w, h)

    if self.x > x and self.x < x+w and self.y > y and self.y < y+h then
        return true
    else
        return false
    end

end