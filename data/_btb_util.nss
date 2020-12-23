
/** Given a creature and a tag return if it has at least one matching item in
 *  its inventory.  Return 1 for true 0 for false.
 */
int HasItemInInventory(object creature, string tag) {
    object oItem = GetFirstItemInInventory(creature);
    while(GetIsObjectValid(oItem)) {
        if(GetTag(oItem) == tag) {
            return 1;
        }
        GetNextItemInInventory(creature);
    }
    return 0;
}

/** Destroy x number of items from inventory.
 */

void DestroyItemsInInventory(object creature, string tag, int destroyNum) {
    int curDestroyed = 0;
    object oItem = GetFirstItemInInventory(creature);
    while(GetIsObjectValid(oItem)) {
        if(GetTag(oItem) == tag) {
            DestroyObject(oItem);
            ++curDestroyed;
        }
        if(curDestroyed >= destroyNum) {
            return;
        }
        GetNextItemInInventory(creature);
    }
}

/**
 * This may need some adjustment right now im using the standard dnd suggested
 * wealth values to start but may need adjustment for alfa evntually.
*/
int getWealthTableValue(int charLvl) {
    switch (charLvl)
    {
        case 1:
             return 500;
        case 2:
             return 1000;
        case 3:
             return 3000;
        case 4:
             return 6000;
        case 5:
             return 10000;
        case 6:
             return 15000;
        case 7:
             return 21000;
        case 8:
             return 28000;
        case 9:
             return 36000;
        case 10:
             return 45000;
        case 11:
             return 55000;
        case 12:
             return 66000;
        case 13:
             return 78000;
        case 14:
             return 91000;
        case 15:
             return 105000;
        case 16:
             return 120000;
        case 17:
             return 136000;
        case 18:
             return 153000;
        case 19:
             return 171000;
        case 20:
             return 190000;
        default:
             return 1;
    }

    return 200000;
}

int getXPTableValueCore(int charLvl) {
    switch (charLvl)
    {
        case 1:
             return 300;
        case 2:
             return 900;
        case 3:
             return 2700;
        case 4:
             return 5400;
        case 5:
             return 9000;
        case 6:
             return 13000;
        case 7:
             return 19000;
        case 8:
             return 27000;
        case 9:
             return 36000;
        case 10:
             return 49000;
        case 11:
             return 66000;
        case 12:
             return 88000;
        case 13:
             return 110000;
        case 14:
             return 150000;
        case 15:
             return 200000;
        case 16:
             return 260000;
        case 17:
             return 340000;
        case 18:
             return 440000;
        case 19:
             return 580000;
        case 20:
             return 760000;
        default:
             return 1;
    }

    return 1;
}

/** This must be seeded with GetFirstPCInArea()
 */
object GetFirstPCInArea(object oAreaTest)
{
    object oPCTestValid = GetFirstPC();
    while(GetArea(oPCTestValid)!=oAreaTest&&GetIsObjectValid(oPCTestValid))
        oPCTestValid = GetNextPC();
    return(oPCTestValid);
}

/** This must be seeded with GetFirstPCInArea()
 */
object GetNextPCInArea(object oAreaTest)
{
    object oPCTestValid = GetNextPC();
    while(GetArea(oPCTestValid)!=oAreaTest&&GetIsObjectValid(oPCTestValid))
        oPCTestValid = GetNextPC();
    return(oPCTestValid);
}

