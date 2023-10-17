function drawCenteredText(text, x, y, frontSize)

	frontSize = frontSize or nil

	local fontCopy = love.graphics.getFont()
	local textWidth = fontCopy:getWidth(text)
	local textHeight = fontCopy:getHeight()

	if fontSize == nil then
		print("nill")
	else
		print("not nill")
		love.graphics.setFont(fontCopy, fontSize)
	end


	love.graphics.print(text, x - textWidth/2, y - textHeight/2)

	if fontSize == nil then
		print("nill")
	else
		print("not nill")
		love.graphics.setFont(fontCopy)
	end
end