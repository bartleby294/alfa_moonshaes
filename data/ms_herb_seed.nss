#include "ms_herb_declare"
#include "ms_location_util"
#include "nwnx_area"
#include "ms_terrain_id"
#include "ms_herb_structs"
#include "_btb_util"
#include "nwnx_object"
#include "nwnx_visibility"
#include "nwnx_data"
#include "x0_i0_stringlib"

void CleanHerbInventory(object oHerb) {
    object herb = GetFirstItemInInventory(oHerb);
    while(herb != OBJECT_INVALID) {
        DestroyObject(herb, 0.1);
        herb = GetNextItemInInventory(oHerb);
    }
}

void HerbTearDown(object oArea) {
    int cnt = 1;
    object baseObj = GetFirstObjectInArea(oArea);

    // Clean up any old herbs.
    object curHerb = GetNearestObjectByTag(MS_HERB_CONTAINER, baseObj, cnt);
    while(curHerb != OBJECT_INVALID) {
         cnt++;
         CleanHerbInventory(curHerb);
         WriteTimestampedLogEntry("MS HERBS: Destroying an herb - cnt:" + IntToString(cnt));
         DestroyObject(curHerb, 0.2);
         curHerb = GetNearestObjectByTag(MS_HERB_CONTAINER, baseObj, cnt);
    }
}

int CreateHerb(struct Herb herbStruct, location loc) {

    /* If we cant walk to the point need to find some where we can.*/
    int newLocTry = 0;
    if(GetIsLocationWalkable(loc) == FALSE) {
        vector locPos = GetPositionFromLocation(loc);
        int baseX = FloatToInt(locPos.x/10.0);
        int baseY = FloatToInt(locPos.y/10.0);
        float baseXf = baseX * 10.0;
        float baseYf = baseY * 10.0;
        while(newLocTry < 40 && GetIsLocationWalkable(loc) == FALSE) {
            newLocTry++;
            float randXf = baseX + IntToFloat(Random(100))/10;
            float randYf = baseY + IntToFloat(Random(100))/10;
            loc = Location(GetAreaFromLocation(loc),
                           Vector(randXf, randYf, locPos.z), 0.0);
        }
    }

    if(newLocTry >= 40) {
        return FALSE;
    }

    object oHerb = CreateObject(OBJECT_TYPE_PLACEABLE,
                                herbStruct.containerResRef,
                                loc,
                                FALSE,
                                MS_HERB_CONTAINER);
    NWNX_Object_SetPlaceableIsStatic(oHerb, FALSE);
    SetUseableFlag(oHerb, TRUE);
    SetName(oHerb, herbStruct.containerName);
    /* Set it as a container just in case its not */
    NWNX_Object_SetHasInventory(oHerb, TRUE);
    /* Set its visibility to DM Only */
    NWNX_Visibility_SetVisibilityOverride(OBJECT_INVALID, oHerb,
                                          NWNX_VISIBILITY_DM_ONLY);
    /* Create herb item on container */
    CreateItemOnObject(herbStruct.itemResRef, oHerb, 1,
                       "ms_herb_item" + herbStruct.itemResRef);

    return TRUE;
}

int CreateHerbForTerrainType(location loc, string terrainType) {
    if (terrainType == TERRAIN_FRESH_WATER) {
        return CreateHerb(GetLesserRandomFreshWaterHerb(), loc);
    } else if (terrainType == TERRAIN_SALT_WATER) {
        return CreateHerb(GetLesserRandomSaltWaterHerb(), loc);
    } else if (terrainType == TERRAIN_FIELD) {
        return CreateHerb(GetLesserRandomFieldHerb(), loc);
    } else if (terrainType == TERRAIN_FOREST) {
        return CreateHerb(GetLesserRandomForestHerb(), loc);
    } else if (terrainType == TERRAIN_MOUNTAIN) {
        return CreateHerb(GetLesserRandomMountainHerb(), loc);
    } else if (terrainType == TERRAIN_ROCKY) {
        return CreateHerb(GetLesserRandomRockyHerb(), loc);
    } else if (terrainType == TERRAIN_HILL) {
        return CreateHerb(GetLesserRandomFieldHerb(), loc);
    }

    return FALSE;
}

void SeedRandomHerbsOLD(object oArea, int maxHerbs) {
    int i = 0;
    int attempts = 0;
    while(i < maxHerbs && attempts < 60) {
        attempts++;
        location randomLoc = GetLocationInAreaWithBuffer(oArea, 20);
        vector randomLocVec = GetPositionFromLocation(randomLoc);
        string tileResRef = NWNX_Area_GetTileModelResRef(oArea,
                                                         randomLocVec.x,
                                                         randomLocVec.y);
        string terrainType = GetTerrainType(tileResRef, randomLoc);
        int herbCreated = CreateHerbForTerrainType(randomLoc, terrainType);
        if(herbCreated == TRUE) {
            i++;
        }
    }
}

float GetRandomXFrom(string xyStr) {
     int baseX = StringToInt(GetTokenByPosition(xyStr, "|", 0));
     return baseX + IntToFloat(Random(100))/10;
}

float GetRandomYFrom(string xyStr) {
     int baseY = StringToInt(GetTokenByPosition(xyStr, "|", 1));
     return baseY + IntToFloat(Random(100))/10;
}

int CreateHerbByTerrianType(object oArea, string terrainType) {
    int arraySize = NWNX_Data_Array_Size(NWNX_DATA_TYPE_STRING, oArea,
                                         terrainType);
    if(arraySize == 0) {
        return FALSE;
    }
    string xyStr = NWNX_Data_Array_At_Str(oArea, terrainType,Random(arraySize));
    float randX = GetRandomXFrom(xyStr);
    float randY = GetRandomYFrom(xyStr);
    location randomLoc = Location(oArea, Vector(randX, randY, 0.0), 0.0);
    return CreateHerbForTerrainType(randomLoc, terrainType);
}

int CreateOneOfEachTerrainType(object oArea, int maxHerbs) {
    int i = 0;
    int fWaterCnt = NWNX_Data_Array_Size(NWNX_DATA_TYPE_STRING, oArea,
                                         TERRAIN_FRESH_WATER);
    int sWaterCnt = NWNX_Data_Array_Size(NWNX_DATA_TYPE_STRING, oArea,
                                         TERRAIN_SALT_WATER);
    int fieldCnt = NWNX_Data_Array_Size(NWNX_DATA_TYPE_STRING, oArea,
                                         TERRAIN_FIELD);
    int forestCnt = NWNX_Data_Array_Size(NWNX_DATA_TYPE_STRING, oArea,
                                         TERRAIN_FOREST);
    int mountainCnt = NWNX_Data_Array_Size(NWNX_DATA_TYPE_STRING, oArea,
                                         TERRAIN_MOUNTAIN);
    int rockyCnt = NWNX_Data_Array_Size(NWNX_DATA_TYPE_STRING, oArea,
                                         TERRAIN_ROCKY);
    int hillCnt = NWNX_Data_Array_Size(NWNX_DATA_TYPE_STRING, oArea,
                                         TERRAIN_HILL);

    WriteTimestampedLogEntry("CreateOneOfEachTerrainType Start");
    if(fWaterCnt > 0 && i < maxHerbs) {
        if(CreateHerbByTerrianType(oArea, TERRAIN_FRESH_WATER) == TRUE) {
            i++;
        }
    }
    if(sWaterCnt > 0 && i < maxHerbs) {
        if(CreateHerbByTerrianType(oArea, TERRAIN_SALT_WATER) == TRUE) {
            i++;
        }
    }
    if(fieldCnt > 0 && i < maxHerbs) {
        if(CreateHerbByTerrianType(oArea, TERRAIN_FIELD) == TRUE) {
            i++;
        }
    }
    if(forestCnt > 0 && i < maxHerbs) {
        if(CreateHerbByTerrianType(oArea, TERRAIN_FOREST) == TRUE) {
            i++;
        }
    }
    if(mountainCnt > 0 && i < maxHerbs) {
        if(CreateHerbByTerrianType(oArea, TERRAIN_MOUNTAIN) == TRUE) {
            i++;
        }
    }
    if(rockyCnt > 0 && i < maxHerbs) {
        if(CreateHerbByTerrianType(oArea, TERRAIN_ROCKY) == TRUE) {
            i++;
        }
    }
    if(hillCnt > 0 && i < maxHerbs) {
        if(CreateHerbByTerrianType(oArea, TERRAIN_FIELD) == TRUE) {
            i++;
        }
    }
    WriteTimestampedLogEntry("CreateOneOfEachTerrainType End");

    return i;
}

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

void SeedRandomHerbs(object oArea, int maxHerbs) {
    int i = CreateOneOfEachTerrainType(oArea, maxHerbs);
    int attempts = 0;

    // spend the rest randomly
    while(i < maxHerbs && attempts < 120) {
        attempts++;
        string randTerrianType = GetRandomTerrainType();
        WriteTimestampedLogEntry("SeedRandomHerbs for: " + randTerrianType);
        if(CreateHerbByTerrianType(oArea, randTerrianType) == TRUE) {
            i++;
        }
    }
}


