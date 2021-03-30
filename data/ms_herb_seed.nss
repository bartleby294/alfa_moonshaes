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

void CreateHerbTrigger(struct Herb herbStruct, location loc){
    vector locVec = GetPositionFromLocation(loc);
    object trigger = NWNX_Area_CreateGenericTrigger(GetAreaFromLocation(loc),
                                                    locVec.x,
                                                    locVec.y,
                                                    locVec.z,
                                                    MS_HERB_CONTAINER,
                                                    9.0f);
    // For now lets leave them squares
    //NWNX_Object_SetTriggerGeometry(trigger,
    //                               "{1.0, 1.0}{4.0, 1.0}{4.0, 4.0}{1.0, 4.0}");
    //WriteTimestampedLogEntry("CreateHerbTrigger: at x: "
    //                         + FloatToString(locVec.x) + " y: "
    //                         + FloatToString(locVec.y) + " z: "
    //                         + FloatToString(locVec.z));
    SetEventScript(trigger, EVENT_SCRIPT_TRIGGER_ON_OBJECT_ENTER,
                   "ms_herb_trigger");
    SetLocalInt(trigger, MS_HERB_TRIGGER_SEARCH_DIFF, 12);
    SetLocalInt(trigger, MS_HERB_TRIGGER_LORE_DIFF, 12);
}

int CreateHerb(struct Herb herbStruct, location loc) {

    /* If we cant walk to the point need to find some where we can.*/
    int newLocTry = 0;
    if(GetIsLocationWalkable(loc) == FALSE) {
        vector locPos = GetPositionFromLocation(loc);
        int baseX = FloatToInt(locPos.x/10.0);
        int baseY = FloatToInt(locPos.y/10.0);
        //WriteTimestampedLogEntry("locPos.x: " + FloatToString(locPos.x));
        //WriteTimestampedLogEntry("locPos.y: " + FloatToString(locPos.y));
        //WriteTimestampedLogEntry("baseX: " + IntToString(baseX));
        //WriteTimestampedLogEntry("baseY: " + IntToString(baseY));
        float baseXf = baseX * 10.0;
        float baseYf = baseY * 10.0;
        //WriteTimestampedLogEntry("baseXf: " + FloatToString(baseXf));
        //WriteTimestampedLogEntry("baseYf: " + FloatToString(baseYf));
        while(newLocTry < 40 && GetIsLocationWalkable(loc) == FALSE) {
            newLocTry++;
            float randXf = baseXf + IntToFloat(Random(100))/10;
            float randYf = baseYf + IntToFloat(Random(100))/10;
            //WriteTimestampedLogEntry("randXf: " + FloatToString(randXf));
            //WriteTimestampedLogEntry("randYf: " + FloatToString(randYf));
            loc = Location(GetAreaFromLocation(loc),
                           Vector(randXf, randYf, locPos.z), 0.0);
            loc = Location(GetAreaFromLocation(loc),
                           Vector(randXf, randYf, GetGroundHeight(loc)), 0.0);
        }
    }

    if(newLocTry >= 40) {
        return FALSE;
    }
    vector pos = GetPositionFromLocation(loc);
    WriteTimestampedLogEntry("MS HERBS: CreateHerb: " + herbStruct.containerResRef +
                             " - at x: " + FloatToString(pos.x) + " y: " +
                             FloatToString(pos.y)+ " z: " +
                             FloatToString(pos.z));
    object oHerb = CreateObject(OBJECT_TYPE_PLACEABLE,
                                herbStruct.containerResRef,
                                loc,
                                FALSE,
                                MS_HERB_CONTAINER);
    CreateHerbTrigger(herbStruct, loc);
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
        //WriteTimestampedLogEntry("CreateHerbForTerrainType: " +  TERRAIN_FRESH_WATER);
        return CreateHerb(GetLesserRandomFreshWaterHerb(), loc);
    } else if (terrainType == TERRAIN_SALT_WATER) {
        //WriteTimestampedLogEntry("CreateHerbForTerrainType: " +  TERRAIN_SALT_WATER);
        return CreateHerb(GetLesserRandomSaltWaterHerb(), loc);
    } else if (terrainType == TERRAIN_FIELD) {
        //WriteTimestampedLogEntry("CreateHerbForTerrainType: " +  TERRAIN_FIELD);
        return CreateHerb(GetLesserRandomFieldHerb(), loc);
    } else if (terrainType == TERRAIN_FOREST) {
        //WriteTimestampedLogEntry("CreateHerbForTerrainType: " +  TERRAIN_FOREST);
        return CreateHerb(GetLesserRandomForestHerb(), loc);
    } else if (terrainType == TERRAIN_MOUNTAIN) {
        //WriteTimestampedLogEntry("CreateHerbForTerrainType: " +  TERRAIN_MOUNTAIN);
        return CreateHerb(GetLesserRandomMountainHerb(), loc);
    } else if (terrainType == TERRAIN_ROCKY) {
        //WriteTimestampedLogEntry("CreateHerbForTerrainType: " +  TERRAIN_ROCKY);
        return CreateHerb(GetLesserRandomRockyHerb(), loc);
    } else if (terrainType == TERRAIN_HILL) {
        //WriteTimestampedLogEntry("CreateHerbForTerrainType: " +  TERRAIN_HILL);
        return CreateHerb(GetLesserRandomFieldHerb(), loc);
    }

    return FALSE;
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
    randomLoc =  Location(oArea,
                          Vector(randX, randY, GetGroundHeight(randomLoc)),
                          0.0);
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

    //WriteTimestampedLogEntry("CreateOneOfEachTerrainType Start");
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
    //WriteTimestampedLogEntry("CreateOneOfEachTerrainType End");

    return i;
}

void SeedRandomHerbs(object oArea, int maxHerbs) {
    int i = CreateOneOfEachTerrainType(oArea, maxHerbs);
    int attempts = 0;

    // spend the rest randomly
    while(i < maxHerbs && attempts < 120) {
        attempts++;
        string randTerrianType = GetRandomTerrainType();
        //WriteTimestampedLogEntry("SeedRandomHerbs for: " + randTerrianType);
        if(CreateHerbByTerrianType(oArea, randTerrianType) == TRUE) {
            i++;
        }
    }
}


