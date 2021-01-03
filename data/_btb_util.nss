float getFacing(vector centerPoint, vector otherPoint) {
    return VectorToAngle(Vector(otherPoint.x - centerPoint.x,
                                otherPoint.y - centerPoint.y,
                                0.0));
}

/**
    Return a location some units of distance away on a straight line taking
    rotations into account.
 */
location pickSpawnLoc(object oPC, object point, float offset, float rotation) {

    vector pointVector = GetPosition(point);
    vector pcVector = GetPosition(oPC);

    float x1 = pcVector.x - pointVector.x;
    float y1 = pcVector.y - pointVector.y;

    float angle = VectorToAngle(Vector(x1,  y1, 0.0));
    float x = offset * cos(angle + rotation);
    float y = offset * sin(angle + rotation);

    location loc = Location(GetArea(oPC),
        Vector(pointVector.x + x, pointVector.y+ y, 0.0), 0.0);
    float z = GetGroundHeight(loc);

    loc = Location(GetArea(oPC),
        Vector(pointVector.x + x, pointVector.y + y, z),
            getFacing(pointVector, GetPositionFromLocation(loc)));

    return loc;
}

/**
 * Why doesnt this already exist?
 */
float absFloat(float value) {
    if(value < 0.0) {
        return value * -1.0;
    }
    return value;
}

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

int getLevelXP(int charLvl) {
    switch (charLvl)
    {
        case 1: return 0;
        case 2: return 1000;
        case 3: return  3000;
        case 4: return  6000;
        case 5: return  10000;
        case 6: return  15000;
        case 7: return 21000;
        case 8: return  28000;
        case 9: return  36000;
        case 10:    return  45000;
        case 11:    return  55000;
        case 12:    return  66000;
        case 13:    return  78000;
        case 14:    return  91000;
        case 15:    return  105000;
        case 16:    return  120000;
        case 17:    return  136000;
        case 18:    return  153000;
        case 19:    return  171000;
        case 20:    return  190000;
        default: return 200000;
    }

    return 1;
}

int getXPForLevel(int xp) {
    if(xp >= 190000) return 20;
    if(xp >= 171000) return 19;
    if(xp >= 153000) return 18;
    if(xp >= 136000) return 17;
    if(xp >= 120000) return 16;
    if(xp >= 105000) return 15;
    if(xp >= 91000) return 14;
    if(xp >= 78000) return 13;
    if(xp >= 66000) return 12;
    if(xp >= 55000) return 11;
    if(xp >= 45000) return 10;
    if(xp >= 36000) return 9;
    if(xp >= 28000) return 8;
    if(xp >= 21000) return 7;
    if(xp >= 15000) return 6;
    if(xp >= 10000) return 5;
    if(xp >= 6000) return 4;
    if(xp >= 3000) return 3;
    if(xp >= 1000) return 2;
    return 1;
}

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

