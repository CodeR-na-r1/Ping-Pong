Menu = {}
Menu.__index = Menu

-- Enum class description: provides a list of possible menu states

StateMenu = {
    START = 1,
    CHOISE = 2,
    PLAYING = 3,
    WIN = 4,
    FAIL = 5,
    RESTART = 6,
}

-- Class description: displaying the desired menu items

function Menu:create(state, startBackgroundImg, onePlayerBtn, twoPlayerBtn, onePlayerBtnHover, twoPlayerBtnHover, startBtn, startBtnHover, yesBtn, yesBtnHover, noBtn, noBtnHover)

    local menu = {}
    setmetatable(menu, Menu)

    menu.state = state

    menu.startBackgroundImg = startBackgroundImg

    menu.onePlayerBtn = onePlayerBtn
    menu.twoPlayerBtn = twoPlayerBtn
    menu.onePlayerBtnHover = onePlayerBtnHover
    menu.twoPlayerBtnHover = twoPlayerBtnHover

    menu.startBtn = startBtn
    menu.startBtnHover = startBtnHover

    menu.yesBtn = yesBtn
    menu.yesBtnHover = yesBtnHover
    menu.noBtn = noBtn
    menu.noBtnHover = noBtnHover

    return menu
end

function Menu:update(dt)



end

function Menu:draw()



end