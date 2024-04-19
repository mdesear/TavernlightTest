// Tavernlight Games Q4
// Misha Desear 2024

/* 
    The method below is used to add an item to a
    player's inventory. We begin by creating a pointer
    to the player information using the string that 
    represents the recipient's name. If no player with
    that name exists, we create a new player with a 
    null pointer since there is no existing player
    info. If we can't load a player by that name, we
    return and exit the method there.

    If a player is successfully loaded, we then create
    an instance of the item to add to the player by 
    creating a pointer to the corresponding item using
    its itemId. If no item exists with that ID or if
    the pointer returns false, we return, exiting the
    method there.

    If we can successfully point to the item, we add
    the item to the player's inbox at a random index. 

    Finally, if the player is offline, we save the
    player's information so that the item can be found
    in their inbox upon login.

    The memory leak issues here occur because memory is
    not being freed following the use of operator "new",
    which allocates heap memory. Additionally, once a
    dynamic variable becomes disassociated from its
    pointer, it becomes impossible to erase due to 
    potential access violations. Even though the
    pointers here are being assigned locally, they
    will persist if not deleted even after exiting the
    method. "delete" should be used in order to free
    up memory once the pointers are no longer needed.
*/

void Game::addItemToPlayer(const std::string& recipient, uint16_t itemId)
{
    Player* player = g_game.getPlayerByName(recipient);
    if (!player) {
        player = new Player(nullptr);
        if (!IOLoginData::loadPlayerByName(player, recipient)) {
            // If we fail to load the player by name, 
            // delete player pointer before returning.
            delete player;
            return;
        }
    }

    Item* item = Item::CreateItem(itemId);
    if (!item) {
        // If we fail to find an item with this ID,
        // delete item pointer before returning.
        delete item;
        return;
    }

    g_game.internalAddItem(player->getInbox(), item, INDEX_WHEREEVER, FLAG_NOLIMIT);

    // Since we've added the item to the inbox,
    // we no longer need the item pointer.
    delete item;

    if (player->isOffline()) {
        IOLoginData::savePlayer(player);
    }

    // We can safely delete the player pointer now
    // that we've added the item to their inbox.
    delete player;
}
