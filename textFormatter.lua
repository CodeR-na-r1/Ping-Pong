-- output formatted text

function drawCenteredText(text, x, y, font)

	_font = nil or font

	local fontCopy = love.graphics.getFont()
	local textWidth = nil
	local textHeight = nil

	if _font == nil then
		textWidth = fontCopy:getWidth(text)
		textHeight = fontCopy:getHeight()
	else
		love.graphics.setFont(_font)
		textWidth = _font:getWidth(text)
		textHeight = _font:getHeight()
	end

	love.graphics.print(text, x - textWidth/2, y - textHeight/2)

	if _font ~= nil then
		love.graphics.setFont(fontCopy)
	end
end