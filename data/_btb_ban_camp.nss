#include "alfa_wealth_inc"
#include "nwnx_time"
#include "nw_o0_itemmaker"
#include "alfa_ms_config"
#include "_btb_util"
#include "nwnx_area"

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

string pickStructureObject() {
    switch(Random(8) + 1)
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
            return "banditcampwood1";
    }

    return "";
}

/** Create a random bandit strucuture.
 *
 */
int createBanditStructure(object oArea, location campfireLoc, int circles) {
    int radius = 5 * circles;
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
        Vector(campfireVector.x + x, campfireVector.y+ y, z), 0.0);

    // If we dont have enough room dont spawn and try again.
    object nearestObj = GetNearestObjectToLocation(OBJECT_TYPE_PLACEABLE,
        possibleStructureLoc);
    if(GetDistanceBetweenLocations(GetLocation(nearestObj),
        possibleStructureLoc) < 2.0) {
        writeToLog("Too close.");
        return 0;
    }

    string resref = pickStructureObject();
    CreateObject(OBJECT_TYPE_PLACEABLE, resref, possibleStructureLoc, FALSE, resref);
    writeToLog("Create: " + resref);

    return 1;
}

void SetupCamp(object oArea, int maxStructures, int minStructures, int circles){
    // each area size if 10m so multiply by 10
    int areaHeight = GetAreaSize(AREA_HEIGHT, oArea) * 10;
    int areaWidth = GetAreaSize(AREA_WIDTH, oArea) * 10;

    float randX = IntToFloat(getRandomDimensionOffBorder(areaHeight, 100));
    float randY = IntToFloat(getRandomDimensionOffBorder(areaHeight, 100));
    float randZ = GetGroundHeight(
        Location(oArea, Vector(randX, randY, 0.0), 0.0));

    writeToLog("randX: " + FloatToString(randX));
    writeToLog("randY: " + FloatToString(randY));
    writeToLog("randZ: " + FloatToString(randY));
    writeToLog("Camp fire created.");

    location campfireLoc = Location(oArea, Vector(randX, randY, randZ), 0.0);
    CreateObject(OBJECT_TYPE_PLACEABLE, "banditcampfire1", campfireLoc,
        FALSE, "banditcampfire1");

    int structureCnt = Random(maxStructures - minStructures) + minStructures;

    while(structureCnt > 0) {
        structureCnt = structureCnt
            - createBanditStructure(oArea, campfireLoc, circles);
    }
}

void main()
{

    /*int bandSpot = 3;
    int bandListen = 4;
    int bandAppraise = 1;
    int bandHide = 3;
    int bandMoveSilently = 3;
    int bandSenseMotive = 2;
    int bandXPAllocation=1800;
    int minLvl = 1;*/

    int maxStructures = 5;
    int minStructures = 3;
    int circles = 1;
    // Get what type of bandit party this is and set specifics for that party.
    // Default above is for bandit_look_sm
    if(GetTag(OBJECT_SELF) == "bandit_look_md") {

    } else if(GetTag(OBJECT_SELF) == "bandit_look_lg") {

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
        SetupCamp(oArea, maxStructures, minStructures, circles);
    }
}
