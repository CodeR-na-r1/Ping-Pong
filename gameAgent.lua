require "textFormatter"

GameAgent = {}
GameAgent.__index = GameAgent

function GameAgent:create()

    local gameAgent = {}
    setmetatable(gameAgent, GameAgent)

    gameAgent.leftScore = 0
    gameAgent.rightScore = 0

    return gameAgent
end

function GameAgent:incLeftScore()

    self.leftScore = self.leftScore + 1
end

function GameAgent:incRightScore()

    self.rightScore = self.rightScore + 1
end

function GameAgent:draw()

    drawCenteredText(self.leftScore .. " : " .. self.rightScore, width / 2, 50, 100)
end