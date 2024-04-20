-- Tavernlight Games Q5
-- Misha Desear

--[[ 
	This spell randomly creates ice tornadoes at different locations within a 3x3 combat area 
	when the player enters "frigo" into the chat. Activation of the spell upon chat input was 
	done in the spells.xml file.
	
	A strange discrepancy I noticed between the video example and my replication is that the 
	ice tornado sprites do not seem to render correctly, even though the combat area is the
	same. This is apparently a known issue with the version of OTClient that I am using (see
	https://otland.net/threads/issue-on-the-animation-of-eternal-winter.281595/).
]]--

local combat = Combat() 
combat:setParameter(COMBAT_PARAM_TYPE, COMBAT_ICEDAMAGE)
combat:setArea(createCombatArea({
	{0, 0, 0, 1, 0, 0, 0},
	{0, 0, 1, 1, 1, 0, 0},
	{0, 1, 1, 1, 1, 1, 0},
	{1, 1, 1, 2, 1, 1, 1},
	{0, 1, 1, 1, 1, 1, 0},
	{0, 0, 1, 1, 1, 0, 0},
	{0, 0, 0, 1, 0, 0, 0}
}))

-- Create ice tornadoes at random intervals & locations within combat area
function frigoEffect(position, count)
	-- Range of ms to wait for next ice tornado
	local minWait = 250
	local maxWait = 1000
	-- # of times to do the spell effect
	local amount = 5 

	-- Randomly create an ice tornado
	if math.random(0, 1) == 1 then
		position:sendMagicEffect(CONST_ME_ICETORNADO)
	end
	
	-- Recursively call frigoEffect until count = amount
	if count < amount then
		count = count + 1
		addEvent(frigoEffect, math.random(minWait, maxWait), position, count)
	end
end

-- Activate spell effect at player position
function onTargetTile(creature, position)
	frigoEffect(position, 0)
end

combat:setCallback(CALLBACK_PARAM_TARGETTILE, "onTargetTile")

function onCastSpell(creature, variant)
	return combat:execute(creature, variant)
end
