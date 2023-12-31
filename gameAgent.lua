require "textFormatter"

-- Class description: counting the game score

GameAgent = {}
GameAgent.__index = GameAgent

function GameAgent:create(font)

    local gameAgent = {}
    setmetatable(gameAgent, GameAgent)

    gameAgent.leftScore = 0
    gameAgent.rightScore = 0

    gameAgent.font = font

    return gameAgent
end

function GameAgent:incLeftScore()

    self.leftScore = self.leftScore + 1
end

function GameAgent:incRightScore()

    self.rightScore = self.rightScore + 1
end

function GameAgent:isEndParty(scoresValue)

    if self.leftScore >= scoresValue or self.rightScore >= scoresValue then
        return true
    else
        return false
    end

end

function GameAgent:isLeftWin()

    return self.leftScore > self.rightScore

end

function GameAgent:reset()

    self.leftScore = 0
    self.rightScore = 0
end

function GameAgent:draw()

    drawCenteredText(self.leftScore .. " : " .. self.rightScore, width / 2, 50, self.font)
end