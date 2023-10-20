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

function Menu:create(state, fontSrc, isOnePlayer, startBackgroundImg, choiseBackgroundImg, onePlayerBtn, twoPlayerBtn, onePlayerBtnHover, twoPlayerBtnHover, startBtn, startBtnHover, yesBtn, yesBtnHover, noBtn, noBtnHover)

    local menu = {}
    setmetatable(menu, Menu)

    menu.state = state

    menu.fontSrc = fontSrc

    menu.isOnePlayer = isOnePlayer

    menu.x = 0
    menu.y = 0

    menu.titleFont = love.graphics.newFont("resources/font/SPACE.ttf", 80)

    menu.startBackgroundImg = startBackgroundImg
    menu.choiseBackgroundImg = choiseBackgroundImg

    menu.onePlayer = onePlayerBtn
    menu.twoPlayer = twoPlayerBtn

    menu.onePlayerBtn = onePlayerBtn
    menu.twoPlayerBtn = twoPlayerBtn
    menu.onePlayerBtnHover = onePlayerBtnHover
    menu.twoPlayerBtnHover = twoPlayerBtnHover

    menu.start = startBtn

    menu.startBtn = startBtn
    menu.startBtnHover = startBtnHover

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

    if self.state == StateMenu.START then

	    if menu:isInside(width / 2 - self.startBtn:getWidth() /2 + 49, height * (5/8) - self.startBtn:getHeight() /2 + 49, self.startBtn:getWidth() - 98, self.startBtn:getHeight() - 98) then
            menu.start = menu.startBtnHover
            if love.mouse.isDown("1") then
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
                isOnePlayer = false
                self.state = StateMenu.INTERMEDIATE
            end
        else
            menu.twoPlayer = menu.twoPlayerBtn
        end

    elseif self.state == StateMenu.INTERMEDIATE then



    end

end

function Menu:draw()

    if self.state == StateMenu.START then

        love.graphics.draw(self.startBackgroundImg)
	    drawCenteredText("PONG", width /2, height /4, self.titleFont)
        love.graphics.draw(self.start, width / 2 - self.startBtn:getWidth() /2, height * (5/8) - self.startBtn:getHeight() /2)

    elseif self.state == StateMenu.CHOISE then

        love.graphics.draw(self.choiseBackgroundImg)
        love.graphics.draw(self.onePlayer, width /2 - self.onePlayerBtn:getWidth(), height * (7/12))
        love.graphics.draw(self.twoPlayer, width /2, height * (7/12))

    elseif self.state == StateMenu.INTERMEDIATE then

	    drawCenteredText("PRESS ANY KEY FOR START", width /2, height /4)

    elseif self.state == StateMenu.WIN then

	   -- TODO

    elseif self.state == StateMenu.FAIL then

        -- TODO

    elseif self.state == StateMenu.LEFT_WIN then

        -- TODO

    elseif self.state == StateMenu.RIGHT_WIN then

        -- TODO

    end
end

function Menu:isInside(x, y, w, h)

    if self.x > x and self.x < x+w and self.y > y and self.y < y+h then
        return true
    else
        return false
    end

end