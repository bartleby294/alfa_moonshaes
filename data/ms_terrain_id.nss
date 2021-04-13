#include "nwnx_regex"
#include "nwnx_area"
#include "nwnx_data"
#include "nwnx_util"

const string AREA_TERRAIN_MAPPED_STATE = "area_terrain_mapped_state";

const string TERRAIN_UNKNOWN = "terrain_unknown";
const string TERRAIN_FRESH_WATER = "terrain_fresh_water";
const string TERRAIN_SALT_WATER = "terrain_salt_water";
const string TERRAIN_FIELD = "terrain_field";
const string TERRAIN_FOREST = "terrain_forest";
const string TERRAIN_MOUNTAIN = "terrain_mountain";
const string TERRAIN_ROCKY = "terrain_rocky";
const string TERRAIN_HILL = "terrain_hill";
const string TERRAIN_CITY = "terrain_city";
const string TERRAIN_ROAD = "terrain_road";

struct Terrain
{
    int x;
    int y;
    string terrain;
};

string GetRandomTerrainType() {
    switch(Random(7)){
        case 0:
            return TERRAIN_FRESH_WATER;
        case 1:
            return TERRAIN_SALT_WATER;
        case 2:
            return TERRAIN_FIELD;
        case 3:
            return TERRAIN_FOREST;
        case 4:
            return TERRAIN_MOUNTAIN;
        case 5:
            return TERRAIN_ROCKY;
        case 6:
            return TERRAIN_HILL;
    }

    return TERRAIN_FIELD;
}

// tno01_p02_01 - tno01_p[0-9]{2}_[0-9]{2} - TERRAIN_FIELD
// tno01_r01_01 - tno01_r[0-9]{2}_[0-9]{2} - TERRAIN_ROCKY
// tno01_a21_01 - tno01_a[0-9]{2}_[0-9]{2} - TERRAIN_HILL
// tno01_b01_02 - tno01_b[0-9]{2}_[0-9]{2} - TERRAIN_FRESH_WATER
// tno01_q03_01 - tno01_q[0-9]{2}_[0-9]{2} - TERRAIN_FIELD
// tno01_x01_01 - tno01_x[0-9]{2}_[0-9]{2} - TERRAIN_CITY
// tno01_h02_01 - tno01_h[0-9]{2}_[0-9]{2} - TERRAIN_ROAD
// tno01_o01_01 - tno01_o[0-9]{2}_[0-9]{2} - TERRAIN_FIELD
// tno01_v24_01 - tno01_v[0-9]{2}_[0-9]{2} - TERRAIN_SALT_WATER

string GetTerrainTypeFromResRef(string resRef) {

    if(TestStringAgainstPattern("tno01_p**", resRef) == TRUE) {
        return TERRAIN_FIELD;
    }
    if(TestStringAgainstPattern("tno01_r**", resRef) == TRUE) {
        return TERRAIN_ROCKY;
    }
    if(TestStringAgainstPattern("tno01_a**", resRef) == TRUE) {
        return TERRAIN_HILL;
    }
    if(TestStringAgainstPattern("tno01_b**", resRef) == TRUE) {
        return TERRAIN_FRESH_WATER;
    }
    if(TestStringAgainstPattern("tno01_q**", resRef) == TRUE) {
        return TERRAIN_FIELD;
    }
    if(TestStringAgainstPattern("tno01_x**", resRef) == TRUE) {
        return TERRAIN_CITY;
    }
    if(TestStringAgainstPattern("tno01_h**", resRef) == TRUE) {
        return TERRAIN_ROAD;
    }
    if(TestStringAgainstPattern("tno01_o**", resRef) == TRUE) {
        return TERRAIN_FIELD;
    }
    if(TestStringAgainstPattern("tno01_v**", resRef) == TRUE) {
        return TERRAIN_SALT_WATER;
    }

    return TERRAIN_UNKNOWN;
}

int NearByTreeCount(location tileLoc){
    int i = 0;
    int treeCount = 0;
    object obj = GetNearestObjectToLocation(OBJECT_TYPE_PLACEABLE, tileLoc, i);
    // loop through all the objects within 10 units of location.
    while(obj != OBJECT_INVALID
          && GetDistanceBetweenLocations(tileLoc, GetLocation(obj)) < 10.0) {
        // if we have tree in the name or tag close enough its a tree.
        if(TestStringAgainstPattern("**tree**", GetTag(obj)) == TRUE
           || TestStringAgainstPattern("**tree**", GetName(obj)) == TRUE) {
            treeCount++;
        }
        i++;
        obj = GetNearestObjectToLocation(OBJECT_TYPE_PLACEABLE, tileLoc, i);
    }
    return treeCount;
}

int NearByTreeCountDepreciated(location tileLoc){
    int i = 0;
    int treeCount = 0;
    object obj = GetNearestObjectToLocation(OBJECT_TYPE_PLACEABLE, tileLoc, i);
    // loop through all the objects within 10 units of location.
    while(obj != OBJECT_INVALID
          && GetDistanceBetweenLocations(tileLoc, GetLocation(obj)) < 10.0) {
        // if we have tree in the name or tag close enough its a tree.
        if(TestStringAgainstPattern("**tree**", GetTag(obj)) == TRUE
            || TestStringAgainstPattern("**tree**", GetName(obj)) == TRUE) {
            treeCount++;
        }
        i++;
        obj = GetNearestObjectToLocation(OBJECT_TYPE_PLACEABLE, tileLoc, i);
    }
    return treeCount;
}

string GetTerrainType(string resRef, location tileLoc) {

    string resRefTerrain = GetTerrainTypeFromResRef(resRef);

    /*
     *  If the terrain is field or hill check for tree density
     *  If there are 3 or more trees near by consider it to be forest instead.
     */
    if(resRefTerrain == TERRAIN_FIELD || resRefTerrain == TERRAIN_HILL) {
        if(NearByTreeCount(tileLoc) >= 3) {
            resRefTerrain = TERRAIN_FOREST;
        }
    }

    return resRefTerrain;
}

void PersistTerrainType(object oArea, string terrainType, int x, int y) {
    //WriteTimestampedLogEntry("PersistTerrainType Start");
    string xyStr = IntToString(x) + "|" + IntToString(y);
    NWNX_Data_Array_PushBack_Str(oArea, terrainType, xyStr);
    //WriteTimestampedLogEntry("PersistTerrainType End");
}

void MapAreaTerrain(object oArea) {

    if(GetLocalInt(oArea, AREA_TERRAIN_MAPPED_STATE) == TRUE) {
        return;
    }
    // This may take a while
    NWNX_Util_SetInstructionLimit(16777215);

    int x = 0;
    int y = 0;
    int areaHeight = GetAreaSize(AREA_HEIGHT, oArea);
    int areaWidth = GetAreaSize(AREA_WIDTH, oArea);

    //WriteTimestampedLogEntry("MapAreaTerrain Start");
    while(x < areaWidth) {
        //WriteTimestampedLogEntry("MapAreaTerrain x: " + IntToString(x));
        while (y < areaHeight) {
            //WriteTimestampedLogEntry("MapAreaTerrain y: " + IntToString(y));
            float curX = (x * 10.0) + 5.0;
            float curY = (y * 10.0) + 5.0;
            vector curPos = Vector(curX, curY, 0.0);
            location curLoc = Location(oArea, curPos, 0.0);
            string tileResRef = NWNX_Area_GetTileModelResRef(oArea, curX, curY);
            string terrainType = GetTerrainType(tileResRef, curLoc);
            PersistTerrainType(oArea, terrainType, x, y);
            y++;
        }
        y = 0;
        x++;
    }

    SetLocalInt(oArea, AREA_TERRAIN_MAPPED_STATE, TRUE);
    //WriteTimestampedLogEntry("MapAreaTerrain End");
    NWNX_Util_SetInstructionLimit(-1);
}

string GetTerrainObjectIsOn(object obj) {

    object oArea = GetArea(obj);
    location objLocation = GetLocation(obj);
    vector objLocationVector = GetPositionFromLocation(objLocation);

    string tileResRef = NWNX_Area_GetTileModelResRef(oArea,
                                                     objLocationVector.x,
                                                     objLocationVector.y);

    WriteTimestampedLogEntry("000000000000000");
    WriteTimestampedLogEntry(tileResRef);
    WriteTimestampedLogEntry("000000000000000");

    return GetTerrainTypeFromResRef(tileResRef);
}

int IsWaterTile(string terrainType) {
    WriteTimestampedLogEntry("77777777777777777");
    WriteTimestampedLogEntry(terrainType);
    WriteTimestampedLogEntry("77777777777777777");
    if(terrainType == TERRAIN_FRESH_WATER || terrainType == TERRAIN_SALT_WATER){
        return TRUE;
    }
    return FALSE;
}
