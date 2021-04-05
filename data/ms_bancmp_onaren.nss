#include "alfa_wealth_inc"
#include "nwnx_time"
#include "nw_o0_itemmaker"
#include "alfa_ms_config"
#include "_btb_util"
#include "nwnx_area"
#include "_btb_ban_util"
#include "_btb_random_loot"
#include "nwnx_time"
#include "nwnx_data"

int getRandomDimensionOffBorder(int dimension, int buffer) {
    int doubleBuffer = 2 * buffer;
    // if you ask for a buffer larger than your dimension its meaningless so
    // we will just give you a random loction sorry.
    if(dimension <= doubleBuffer) {
        return Random(dimension);
    }
    return Random(dimension - doubleBuffer) + buffer;
}

/**
 *  Pick a random structure by resref
 */

string pickStructureObject() {
    switch(Random(12) + 1)
    {
        case 1:
            return "banditcampbed1";
        case 2:
            return "banditcampbench1";
        case 3:
            return "banditcampcook1";
        case 4:
            return "banditcamphide1";
        case 5:
            return "banditcamptent1";
        case 6:
            return "banditcamptent2";
        case 7:
            return "banditcamptent3";
        case 8:
            return "banditcamptent1";
        case 9:
            return "banditcamptent2";
        case 10:
            return "banditcamptent3";
        case 11:
            return "banditcampwood1";
        case 12:
            return "banditcampskin1";
    }

    return "";
}

/**
 *  Pick a random structure by resref
 */

string pickChestObject() {
    switch(Random(3) + 1)
    {
        case 1:
            return "banditcamplgches";
        case 2:
            return "banditcampmedche";
        case 3:
            return "banditcampsmches";
    }

    return "";
}

int isTent(object obj){
    string objResref = GetResRef(obj);

    if(objResref == "banditcamptent1") {
        return 1;
    }
    if(objResref == "banditcamptent2") {
        return 1;
    }
    if(objResref == "banditcamptent3") {
        return 1;
    }

    return 0;

}

/**
 *  Select a random valid Location in camp.
 */
location selectLocationInCamp(object oArea, location campfireLoc,
                              int circle_min, int circle_max,
                              float min_buffer) {
    int radius = 5 * (Random(circle_max - circle_min) + circle_min);
    int radSqr = radius * radius;
    int xsqr = Random(radSqr);
    int ysqr = radSqr - xsqr;

    float x = sqrt(IntToFloat(xsqr));
    float y = sqrt(IntToFloat(ysqr));

    if(Random(2) == 1) {
        x = x * -1;
    }

    if(Random(2) == 1) {
        y = y * -1;
    }

    vector campfireVector = GetPositionFromLocation(campfireLoc);
    location possibleStructureLoc = Location(oArea,
        Vector(campfireVector.x + x, campfireVector.y+ y, 0.0), 0.0);
    float z = GetGroundHeight(possibleStructureLoc);

    possibleStructureLoc = Location(oArea,
        Vector(campfireVector.x + x, campfireVector.y+ y, z),
            getBanditFacing(campfireVector,
                GetPositionFromLocation(possibleStructureLoc)));

    // If we dont have enough room dont spawn and try again.
    object nearestObj = GetNearestObjectToLocation(OBJECT_TYPE_PLACEABLE,
        possibleStructureLoc);
    if(GetDistanceBetweenLocations(GetLocation(nearestObj),
        possibleStructureLoc) < min_buffer) {
        //writeToLog("Too close.");
        return GetLocation(OBJECT_INVALID);
    }

    if(isHeightWrong(possibleStructureLoc)) {
        //writeToLog("Height problem at location.");
        return GetLocation(OBJECT_INVALID);
    }

    return possibleStructureLoc;
}

/**
 *  Create a random bandit strucuture.
 */
object createBanditStructure(object oArea, location campfireLoc,
                            int circle_min, int circle_max) {

    location possibleStructureLoc =
                selectLocationInCamp(oArea, campfireLoc, circle_min,
                                     circle_max, 2.0);

    // Check if we got a valid location back
    if(GetAreaFromLocation(possibleStructureLoc) == OBJECT_INVALID) {
        return OBJECT_INVALID;
    }

    string resref = pickStructureObject();
    writeToLog("Create: " + resref);
    return CreateObject(OBJECT_TYPE_PLACEABLE, resref, possibleStructureLoc,
                  FALSE, resref);
}

/**
 *  Make sure our campfire location is valid.
 */
int campfireLocationGood(location campfireLoc) {
    // If we dont have enough room dont spawn and try again.
    object nearestObj = GetNearestObjectToLocation(OBJECT_TYPE_PLACEABLE,
        campfireLoc);
    if(GetDistanceBetweenLocations(GetLocation(nearestObj), campfireLoc) < 2.0){
        //writeToLog("Campfire - Too close.");
        return 0;
    }

    if(isHeightWrong(campfireLoc)) {
        //writeToLog("Campfire - Height problem at location.");
        return 0;
    }

    return 1;
}

/**
 *  Create a random bandit traps.
 */
object createBanditTrap(object oArea, location campfireLoc, int circle_min,
                            int circle_max, object bandit, int difficulty_lvl) {

    location possibleTrapLoc =
                selectLocationInCamp(oArea, campfireLoc, circle_max + 1,
                                     circle_max + 2, 2.0);

    // Check if we got a valid location back
    if(GetAreaFromLocation(possibleTrapLoc) == OBJECT_INVALID) {
        return OBJECT_INVALID;
    }

    string resref = pickStructureObject();
    writeToLog("Trap: " + resref);
    return CreateTrapAtLocation(randomBanditTrap(difficulty_lvl),
                                  possibleTrapLoc, 2.0, "bandit_trap",
                                  STANDARD_FACTION_HOSTILE, "", "");
}

object createBanditChest(object oArea, location campfireLoc, int circle_min,
                            int circle_max) {

    location possibleChestLoc =
                selectLocationInCamp(oArea, campfireLoc, circle_max ,
                                     circle_max, 2.0);

    // Check if we got a valid location back
    if(GetAreaFromLocation(possibleChestLoc) == OBJECT_INVALID) {
        return OBJECT_INVALID;
    }

    string resref = pickChestObject();
    writeToLog("Chest: " + resref);

    object chest = CreateObject(OBJECT_TYPE_PLACEABLE, resref, possibleChestLoc,
                                    FALSE, resref);
    CreateTrapOnObject(randomBanditTrap(circle_max), chest,
        STANDARD_FACTION_HOSTILE);
    SetLocked(chest, TRUE);
    SetLockUnlockDC(chest, 8 * circle_max);

    return chest;
}


void SetupCamp(object oArea, int maxStructures, int minStructures,
                int min_traps, int max_traps, int circle_min, int circle_max,
                int difficulty_lvl){
    // each area size if 10m so multiply by 10
    int areaHeight = GetAreaSize(AREA_HEIGHT, oArea) * 10;
    int areaWidth = GetAreaSize(AREA_WIDTH, oArea) * 10;

    int maxTry = 0;
    location campfireLoc = Location(oArea, Vector(0.0, 0.0, 0.0), 0.0);

    object oCampfire = OBJECT_INVALID;

    // Find and create our camp center
    while(oCampfire == OBJECT_INVALID) {
       // Exit out if we cant find a location in a reasonable time.
       if(maxTry >= 20) {
            return;
        }
        float randX = IntToFloat(getRandomDimensionOffBorder(areaHeight, 100));
        float randY = IntToFloat(getRandomDimensionOffBorder(areaHeight, 100));
        float randZ = GetGroundHeight(
            Location(oArea, Vector(randX, randY, 0.0), 0.0));

        //writeToLog("randX: " + FloatToString(randX));
        //writeToLog("randY: " + FloatToString(randY));
        //writeToLog("randZ: " + FloatToString(randY));
        writeToLog("Camp fire created.");

        campfireLoc = Location(oArea, Vector(randX, randY, randZ), 0.0);
        if(campfireLocationGood(campfireLoc) == 1) {
           oCampfire = CreateObject(OBJECT_TYPE_PLACEABLE, "banditcampfire1",
                                    campfireLoc, FALSE, "banditcampfire1");
        }
        maxTry++;
    }

    // Save our chest so we can delete it later.
    NWNX_Data_Array_PushBack_Str(oCampfire , BANDIT_UUID_ARRAY,
                                 GetObjectUUID(oCampfire));

    // Create the main chest.
    int cnt = 0;
    int chestCnt = 1;
    object chestCreated = OBJECT_INVALID;
    while(chestCnt > 0 && cnt < 50) {
        chestCreated = createBanditChest(oArea, campfireLoc, circle_min,
                                                circle_min);
        if(chestCreated != OBJECT_INVALID) {
            chestCnt--;
        }
        cnt++;
    }

    // Save our chest so we can delete it later.
    NWNX_Data_Array_PushBack_Str(oCampfire , BANDIT_UUID_ARRAY,
                                 GetObjectUUID(chestCreated));

    // Add our structures to the camp count up tents.
    cnt = 0;
    int tentCnt = 0;
    int structureCnt = Random(maxStructures - minStructures) + minStructures;
    while(structureCnt > 0 && cnt < 50) {
        object objCreated = createBanditStructure(oArea, campfireLoc,
                                                  circle_min, circle_max);
        if(objCreated != OBJECT_INVALID) {
            // Save our object so we can delete it later.
            NWNX_Data_Array_PushBack_Str(oCampfire , BANDIT_UUID_ARRAY,
                                         GetObjectUUID(objCreated));
            structureCnt--;
        }

        if(isTent(objCreated)) {
            tentCnt++;
            SetLocalInt(objCreated, "circle_max", circle_max);
        }

        cnt++;
    }

    // Add our bandits
    cnt = 0;
    int sleepNum = 0;
    int patrolNum = 0;
    int banditCnt = tentCnt * 2;
    int totalBanditLvl = 0;
    object bandit = OBJECT_INVALID;
    while(banditCnt > 0 && cnt < 50) {
        // pick gender (will put in after the rest is tested)
        string race = pickRace();
        string class = pickClass();
        string resref = race + class + "m_bandit_1";
        int banditLvl = Random(difficulty_lvl) + 2;
        location spawnLoc = selectLocationInCamp(oArea, campfireLoc, circle_min,
                                                 circle_max, 2.0);
        if(GetAreaFromLocation(spawnLoc) != OBJECT_INVALID) {
            bandit = spawnBandit(resref, race, class, spawnLoc,
                                 banditLvl, "banditcamper");
            totalBanditLvl = totalBanditLvl +  banditLvl;
            SetLocalLocation(bandit, "campfireLoc", campfireLoc);
            SetLocalLocation(bandit, "spawnLoc", spawnLoc);
            SetLocalInt(bandit, "circle_max", circle_max);
            int randAction = Random(BANDIT_MAX_ACTION) + 1;
            while((randAction == BANDIT_PATROL_ACTION
                        && patrolNum > 1 * circle_max + 1)
                   || (randAction == BANDIT_SLEEP_ACTION
                        && sleepNum > 1 * circle_max + 1)) {
                randAction = Random(BANDIT_MAX_ACTION) + 1;
            }
            if(randAction == BANDIT_PATROL_ACTION) {
               patrolNum++;
            }
            if(randAction == BANDIT_SLEEP_ACTION) {
               sleepNum++;
            }
            SetLocalInt(bandit, "action", randAction);
            SetLocalInt(bandit, "banditId", banditCnt);
            // Save our bandit so we can delete it later.
            NWNX_Data_Array_PushBack_Str(oCampfire , BANDIT_UUID_ARRAY,
                                         GetObjectUUID(bandit));
            banditCnt--;
        }
        cnt++;
    }

    // Add traps to the camp
    cnt = 0;
    int trapCnt = Random(max_traps - min_traps) + min_traps;
    while(trapCnt > 0 && cnt < 50) {
        object trapCreated = createBanditTrap(oArea, campfireLoc, circle_min,
                                                circle_max, bandit,
                                                difficulty_lvl);
        if(trapCreated != OBJECT_INVALID) {
            // Save our trap so we can delete it later.
            NWNX_Data_Array_PushBack_Str(oCampfire , BANDIT_UUID_ARRAY,
                                         GetObjectUUID(trapCreated));
            trapCnt--;
        }
        cnt++;
    }

    // Add loot to chest
    int halfMaxLootGP = totalBanditLvl * 100;
    int lootGP = halfMaxLootGP + Random(halfMaxLootGP);
    generateLoot(lootGP, chestCreated, difficulty_lvl);
}

void SeedRandomBanditCamp(object oArea, int banditCampLvl)
{
    int maxStructures = 6;
    int minStructures = 4;
    int min_traps = 4;
    int max_traps = 6;
    int circle_min = 1;
    int circle_max = 1;
    int difficulty_lvl = 1;
    writeToLog("CREATING CAMP");

    // Get what type of bandit party this is and set specifics for that party.
    // Default above is for bandit_look_sm
    if(banditCampLvl == 2) {
        maxStructures = 10;
        minStructures = 7;
        int min_traps = 6;
        int max_traps = 10;
        circle_min = 1;
        circle_max = 2;
        difficulty_lvl = 2;
    } else if(banditCampLvl > 2) {
        maxStructures = 15;
        minStructures = 9;
        int min_traps = 8;
        int max_traps = 16;
        circle_min = 1;
        circle_max = 3;
        difficulty_lvl = 3;
    }

    // If camp is already spawned dont spawn a new one.
    object campFire = GetNearestObjectByTag("banditcampfire1", OBJECT_SELF);
    if(campFire == OBJECT_INVALID) {

        writeToLog("Setting up level " + IntToString(circle_max) + " camp.");
        writeToLog("maxStructures = " + IntToString(maxStructures));
        writeToLog("minStructures = " + IntToString(minStructures));
        writeToLog("min_traps = " + IntToString(min_traps));
        writeToLog("max_traps = " + IntToString(max_traps));
        writeToLog("circle_min = " + IntToString(circle_min));
        writeToLog("circle_max = " + IntToString(circle_max));

        SetupCamp(oArea, maxStructures, minStructures, min_traps, max_traps,
                   circle_min, circle_max, difficulty_lvl);
    }
}
