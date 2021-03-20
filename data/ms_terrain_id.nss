#include "nwnx_regex"

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

// tno01_p02_01 - tno01_p[0-9]{2}_[0-9]{2} - TERRAIN_FIELD
// tno01_r01_01 - tno01_r[0-9]{2}_[0-9]{2} - TERRAIN_ROCKY
// tno01_a21_01 - tno01_a[0-9]{2}_[0-9]{2} - TERRAIN_HILL
// tno01_b01_02 - tno01_b[0-9]{2}_[0-9]{2} - TERRAIN_FRESH_WATER
// tno01_q03_01 - tno01_q[0-9]{2}_[0-9]{2} - TERRAIN_FIELD
// tno01_x01_01 - tno01_x[0-9]{2}_[0-9]{2} - TERRAIN_CITY
// tno01_h02_01 - tno01_h[0-9]{2}_[0-9]{2} - TERRAIN_ROAD
// tno01_o01_01 - tno01_o[0-9]{2}_[0-9]{2} - TERRAIN_FIELD

string GetTerrainTypeFromResRef(string resRef) {

    if(NWNX_Regex_Search(resRef, "tno01_p[0-9]{2}_[0-9]{2}") == TRUE) {
        return TERRAIN_FIELD;
    }
    if(NWNX_Regex_Search(resRef, "tno01_r[0-9]{2}_[0-9]{2}") == TRUE) {
        return TERRAIN_ROCKY;
    }
    if(NWNX_Regex_Search(resRef, "tno01_a[0-9]{2}_[0-9]{2}") == TRUE) {
        return TERRAIN_HILL;
    }
    if(NWNX_Regex_Search(resRef, "tno01_b[0-9]{2}_[0-9]{2}") == TRUE) {
        return TERRAIN_FRESH_WATER;
    }
    if(NWNX_Regex_Search(resRef, "tno01_q[0-9]{2}_[0-9]{2}") == TRUE) {
        return TERRAIN_FIELD;
    }
    if(NWNX_Regex_Search(resRef, "tno01_x[0-9]{2}_[0-9]{2}") == TRUE) {
        return TERRAIN_CITY;
    }
    if(NWNX_Regex_Search(resRef, "tno01_h[0-9]{2}_[0-9]{2}") == TRUE) {
        return TERRAIN_ROAD;
    }
    if(NWNX_Regex_Search(resRef, "tno01_o[0-9]{2}_[0-9]{2}") == TRUE) {
        return TERRAIN_FIELD;
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
        if(NWNX_Regex_Search(GetTag(obj), "(?i)(tree)") == TRUE
           || NWNX_Regex_Search(GetName(obj), "(?i)(tree)") == TRUE) {
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