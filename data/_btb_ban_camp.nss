#include "alfa_wealth_inc"
#include "nwnx_time"
#include "nw_o0_itemmaker"
#include "alfa_ms_config"
#include "_btb_util"
#include "nwnx_area"
#include "_btb_ban_util"

void writeToLog(string str) {
    string oAreaName = GetName(GetArea(OBJECT_SELF));
    WriteTimestampedLogEntry("Bandit Camp: " + oAreaName + ": " +  str);
}

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
    switch(Random(11) + 1)
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


float getFacing(vector campfireVector, vector possibleStructureVector) {

    vector direction = Vector(possibleStructureVector.x - campfireVector.x,
                              possibleStructureVector.y - campfireVector.y,
                              0.0);
    return VectorToAngle(direction);
}

/**
 *  Make sure we have valid heights around the location and that they valid
 *  Locations.
 */
int isHeightWrong(location possibleStructureLoc){
    vector possibleStructureVec = GetPositionFromLocation(possibleStructureLoc);
    object oArea = GetAreaFromLocation(possibleStructureLoc);

    float negx = GetGroundHeight(Location(oArea,
                Vector(possibleStructureVec.x - 1.0,
                        possibleStructureVec.y, 0.0), 0.0));

    float negy = GetGroundHeight(Location(oArea,
                Vector(possibleStructureVec.x,
                        possibleStructureVec.y - 1.0, 0.0), 0.0));

    float posx = GetGroundHeight(Location(oArea,
            Vector(possibleStructureVec.x + 1.0,
                    possibleStructureVec.y, 0.0), 0.0));

    float posy = GetGroundHeight(Location(oArea,
                Vector(possibleStructureVec.x,
                        possibleStructureVec.y + 1.0, 0.0), 0.0));
    // GetGroundHeight returns -6.0 for invalid locations.
    if(negx == -6.0 || negx == -6.0 || negx == -6.0 ||negx == -6.0) {
        return 1;
    }

    // if there is too much of a difference in height look for some where else.
    if(absFloat(possibleStructureVec.z - negx) > 1.0
        || absFloat(possibleStructureVec.z - negy) > 1.0
        || absFloat(possibleStructureVec.z - posx) > 1.0
        || absFloat(possibleStructureVec.z - posy) > 1.0) {
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
            getFacing(campfireVector,
                GetPositionFromLocation(possibleStructureLoc)));

    // If we dont have enough room dont spawn and try again.
    object nearestObj = GetNearestObjectToLocation(OBJECT_TYPE_PLACEABLE,
        possibleStructureLoc);
    if(GetDistanceBetweenLocations(GetLocation(nearestObj),
        possibleStructureLoc) < min_buffer) {
        writeToLog("Too close.");
        return GetLocation(OBJECT_INVALID);
    }

    if(isHeightWrong(possibleStructureLoc)) {
        writeToLog("Height problem at location.");
        return GetLocation(OBJECT_INVALID);
    }

    return possibleStructureLoc;
}

/**
 *  Create a random bandit traps.
 */
object createBanditTrap(object oArea, location campfireLoc,
                            int circle_min, int circle_max) {

    location possibleStructureLoc =
                selectLocationInCamp(oArea, campfireLoc,circle_min,
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
 *  Create a random bandit strucuture.
 */
object createBanditStructure(object oArea, location campfireLoc,
                            int circle_min, int circle_max) {

    location possibleStructureLoc =
                selectLocationInCamp(oArea, campfireLoc,circle_min,
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
        writeToLog("Campfire - Too close.");
        return 0;
    }

    if(isHeightWrong(campfireLoc)) {
        writeToLog("Campfire - Height problem at location.");
        return 0;
    }

    return 1;
}

void SetupCamp(object oArea, int maxStructures, int minStructures,
                int min_traps, int max_traps, int circle_min, int circle_max){
    // each area size if 10m so multiply by 10
    int areaHeight = GetAreaSize(AREA_HEIGHT, oArea) * 10;
    int areaWidth = GetAreaSize(AREA_WIDTH, oArea) * 10;

    int maxTry = 0;
    int campfireCreated = 0;
    location campfireLoc = Location(oArea, Vector(0.0, 0.0, 0.0), 0.0);

    // Find and create our camp center
    while(campfireCreated == 0) {
       // Exit out if we cant find a location in a reasonable time.
       if(maxTry >= 20) {
            return;
        }
        float randX = IntToFloat(getRandomDimensionOffBorder(areaHeight, 100));
        float randY = IntToFloat(getRandomDimensionOffBorder(areaHeight, 100));
        float randZ = GetGroundHeight(
            Location(oArea, Vector(randX, randY, 0.0), 0.0));

        writeToLog("randX: " + FloatToString(randX));
        writeToLog("randY: " + FloatToString(randY));
        writeToLog("randZ: " + FloatToString(randY));
        writeToLog("Camp fire created.");

        campfireLoc = Location(oArea, Vector(randX, randY, randZ), 0.0);
        if(campfireLocationGood(campfireLoc) == 1) {
            CreateObject(OBJECT_TYPE_PLACEABLE, "banditcampfire1", campfireLoc,
                FALSE, "banditcampfire1");
                campfireCreated = 1;
        }
        maxTry++;
    }

    // Add our structures to the camp count up tents.
    int cnt = 0;
    int tentCnt = 0;
    int structureCnt = Random(maxStructures - minStructures) + minStructures;
    while(structureCnt > 0 && cnt < 50) {
        object objCreated = createBanditStructure(oArea, campfireLoc,
                                                  circle_min, circle_max);
        if(objCreated != OBJECT_INVALID) {
            structureCnt--;
        }

        if(isTent(objCreated)) {
            tentCnt++;
        }

        cnt++;
    }

    // Add our bandits
    cnt = 0;
    int banditCnt = tentCnt * 2;
    object bandit = OBJECT_INVALID;
    while(banditCnt > 0 && cnt < 50) {
        // pick gender (will put in after the rest is tested)
        string race = pickRace();
        string class = pickClass();
        string resref = race + class + "m_bandit_1";
        int banditLvl =Random(circle_max) + 1;
        writeToLog("bandit type: " + resref + " lvl: " + IntToString(banditLvl));
        location spawnLoc = selectLocationInCamp(oArea, campfireLoc, circle_min,
                                                 circle_max, 2.0);
        if(GetAreaFromLocation(spawnLoc) != OBJECT_INVALID) {
            bandit = spawnBandit(resref, race, class, spawnLoc, banditLvl);
            banditCnt--;
        }
        cnt++;
    }

    // Add traps to the camp
    /*cnt = 0;
    int trapCnt = Random(max_traps - min_traps) + min_traps;
    while(trapCnt > 0 && cnt < 50) {
        object trapCreated = createBanditTrap(oArea, campfireLoc,
                                              circle_min, circle_max);
        if(trapCreated != OBJECT_INVALID) {
            trapCnt--;
        }
        cnt++;
    }*/
}

void main()
{
    int maxStructures = 6;
    int minStructures = 4;
    int min_traps = 3;
    int max_traps = 5;
    int circle_min = 1;
    int circle_max = 1;
    // Get what type of bandit party this is and set specifics for that party.
    // Default above is for bandit_look_sm
    if(GetTag(OBJECT_SELF) == "bandit_look_md") {
        maxStructures = 10;
        minStructures = 7;
        int min_traps = 4;
        int max_traps = 6;
        circle_min = 1;
        circle_max = 2;
    } else if(GetTag(OBJECT_SELF) == "bandit_look_lg") {
        maxStructures = 15;
        minStructures = 9;
        int min_traps = 5;
        int max_traps = 8;
        circle_min = 1;
        circle_max = 3;
    }

    writeToLog("===================================");
    writeToLog("BANDIT CAMP HEARTBEAT");
    object oArea = GetArea(OBJECT_SELF);
    object campFire = GetNearestObjectByTag("banditcampfire1", OBJECT_SELF);
    // If camp is already spawned dont spawn a new one.
    if(campFire != OBJECT_INVALID) {
        writeToLog("Camp is currently spawned.");
    } else {
        writeToLog("Setting up camp.");
        SetupCamp(oArea, maxStructures, minStructures, min_traps, max_traps,
                   circle_min, circle_max);
    }
}
