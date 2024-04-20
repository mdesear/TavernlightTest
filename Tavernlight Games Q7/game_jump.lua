-- Tavernlight Games Q7
-- Misha Desear

--[[ 
	This module creates a window with a moving button that 
	says "Jump!" The button will tandomize its Y-position 
	when it hits the left edge of the window. It will also 
	randomize Y-position when clicked.
]]--

-- Local vars to store the window and button
local jumpWindow = nil
local jumpBtn = nil
-- Event to make the button scroll
local clickEvent = nil 

-- The # of pixels the button moves at a time
local scrollIncrement = 5 
-- The # of ms that pass between each movement
local scrollSpeed = 65 

-- Padding to keep the button within bounds
local leftPadding = 15
local rightPadding = 60
local topBtmPadding = 20

function init()
    connect(g_game, {
        onGameStart = onLogin,
        onGameEnd = onLogout
    })
	-- Create the window based on the OTUI code, then hide it
	jumpWindow = g_ui.displayUI('game_jump', modules.game_interface.getRightPanel())
	jumpWindow:hide()
	jumpBtn = jumpWindow:getChildById('jumpButton')
end

function terminate()
    disconnect(g_game, {
        onGameStart = onLogin,
        onGameEnd = onLogout
    })
	
	-- Destroy the window on exit
	jumpWindow:destroy()
end

function onLogin()
	-- Show the jump window on login
	jumpWindow:show()
	btnReset()
	clickEvent = cycleEvent(btnMove, scrollSpeed)
end

-- On logout, stop animating the button and reset the window
function onLogout()

	removeEvent(clickEvent)
	jumpReset()
end

-- Makes the button reset its position to the right 
-- edge of the window at a random Y-position
function btnReset()
    local position = jumpWindow:getPosition()
	-- Initialize X-position with padding so it doesn't leave the window
    position.x = position.x + jumpWindow:getWidth() - rightPadding
	-- Randomize Y-position within the bounds of the window's height
	position.y = position.y + math.random(topBtmPadding, (jumpWindow:getHeight() - topBtmPadding))
	jumpBtn:setPosition(position)
end

-- Makes the button scroll from right to left
function btnMove()
	local position = jumpBtn:getPosition()
	position.x = position.x - scrollIncrement
	
	if position.x < jumpWindow:getPosition().x + leftPadding then
		btnReset()
	else
		jumpBtn:setPosition(position)
	end
end

-- Hides the window and stops the animation
function jumpReset()
	jumpWindow:hide()
	
	if clickEvent then
		removeEvent(clickEvent)
	end
end
