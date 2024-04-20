-- Tavernlight Games Q3
-- Misha Desear

--[[
    The purpose of the method below is to remove a 
    member of a player's party by name. For this 
    reason, we can rename this method to 
    "removePlayerPartyMember".

    Several values can be stored as local variables 
    for faster access. As a result, the player's party 
    and party members are stored as local vars. 

    The original method does not check if the player
    is in a party. We will do this first and notify
    the player if they are not in a party, returning
    and ending the method if no party is found. If 
    they are in a party, we will check if any of the
    members match the name inputted using a for loop. 
    A boolean value named matchFound will keep track
    of whether or not a member was found with a
    matching name.

    If a member with a matching name was found in the
    party, we will remove the member from the party,
    setting matchFound to true and breaking to exit
    the for loop. If not, matchFound will stay false.

    We then check matchFound in order to send an
    appropriate message to the player regarding member
    removal. If matchFound is true, we will notify 
    them that member removal was successful. If it is
    false, we will state that a player with the
    inputted name was not found in their party.
]]--

-- Remove member from player party by name
function removePlayerPartyMember(playerId, membername)
    local player = Player(playerId)
    local party = player:getParty()
    local members = party:getMembers()
    -- Bool to check if member with matching name was found
    local matchFound = false

    -- If no player party found, notify the player
    if not party then
        player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You are not currently in a party.")
        return true
    end

    -- For loop to check if member with matching name exists
    -- If yes, remove the member and set matchFound to true
    for _, member in pairs(members) do
        if member == Player(membername) then
            party:removeMember(Player(membername))
            matchFound = true
            break
        end
    end

    -- Send a message stating whether or not removal was a success
    if matchFound then
        player:sendTextMessage(MESSAGE_EVENT_ADVANCE, membername .. " has been removed from the party.")
    else
        player:sendTextMessage(MESSAGE_EVENT_ADVANCE, membername .. " is not a part of your party.")
    end
end
