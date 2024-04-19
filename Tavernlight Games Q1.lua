-- Tavernlight Games Q1
-- Misha Desear 2024

--[[ 
    The purpose of the original methods is to release 
    the player's storage or memory upon logout. We do 
    this by calling onLogout and checking the value of 
    the storage with ID 1000 to see if it is equal to 
    1. If so, we set the value of the storage with 
    that ID to -1 by calling releaseStorage.
    
    The releaseStorage method is redundant as it uses 
    the already-existing setStorageValue method and 
    does not add any other functionality. Calling 
    addEvent adds a small delay of 1000 ms before 
    calling releaseStorage, but this doesn't seem 
    necessary. Instead, we can just directly set the 
    storage value in the onLogout method after 
    checking the value of the storage with ID 1000.
    
    We can also store the storage ID in a local 
    variable for ease of access. With this, the ID 
    can be changed whenever necessary by changing a 
    single variable.
--]]

-- Free player storage on logout
function onLogout(player)
    -- Set a local storageId for faster access
    local storageId = 1000
    -- Check if storageId == 1 then set to -1
    if player:getStorageValue(storageId) == 1 then
        player:setStorageValue(storageId, -1)
    end
    return true
end
