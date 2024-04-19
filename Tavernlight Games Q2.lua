-- Tavernlight Games Q2
-- Misha Desear 2024

--[[ 
    The purpose of the method below is to obtain the 
    names of all of the guilds that have a max member 
    count of less than the value of the variable 
    memberCount. To do this, we query the guilds table
    and select the names of all entries that have a 
    max_members value that is less than memberCount.
    
    We first check if the resultId returns true, as 
    that means that we got a result from our query. 
    If false, we print out a message stating that no 
    guilds were found. If true, we print the names 
    from our result.
    
    Because the output we receive is tabular data, 
    the original version of the method would only 
    print out the first row of data or the first 
    guild name in the table. To fix this, we use a 
    repeat-until loop to print the name of the guild 
    on the current row, then move the pointer to the 
    next row using result.next. We do this until 
    result.next returns false, meaning that there are
    no more rows in the result table.
    
    At the end of the repeat-until loop, we use 
    result.free to reset the global storeQuery 
    variable for later use.
--]]

-- Print names of all guilds with less than memberCount max members
function printSmallGuildNames(memberCount)
    local selectGuildQuery = "SELECT `name` FROM `guilds` WHERE `max_members`" .. db.escapeString(memberCount) .. ";"
    local resultId = db.storeQuery(selectGuildQuery)
    -- If resultId true, then print out all names from result
    if resultId then
        repeat
            local guildName = result.getString(resultId, "name")
            print(guildName)
        until not result.next(resultId)
        result.free(resultId)
    -- If resultId false, print that no guilds were found
    else
        print("No guilds found.")
    end
end
