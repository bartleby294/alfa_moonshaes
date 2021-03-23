#include "x0_i0_stringlib"
#include "nwnx_object"
#include "nwnx_data"
#include "nwnx_area"
#include "nwnx_visibility"

#include "_btb_util"
#include "ms_terrain_id"
#include "ms_treas_structs"
#include "ms_treas_declare"
#include "ms_location_util"


void CleanTreasureInventory(object oTreasure) {
    object treasure = GetFirstItemInInventory(oTreasure);
    while(treasure != OBJECT_INVALID) {
        DestroyObject(treasure, 0.1);
        treasure = GetNextItemInInventory(oTreasure);
    }
}

void TearTreasureDown(object oArea) {
    int cnt = 1;
    object baseObj = GetFirstObjectInArea(oArea);

    // Clean up any old treasure.
    object curTreasure = GetNearestObjectByTag(MS_TREASURE_CONTAINER, baseObj, cnt);
    while(curTreasure != OBJECT_INVALID) {
         cnt++;
         CleanTreasureInventory(curTreasure);
         WriteTimestampedLogEntry("MS TREASURE: Destroying treasure - cnt:" + IntToString(cnt));
         DestroyObject(curTreasure, 0.2);
         curTreasure = GetNearestObjectByTag(MS_TREASURE_CONTAINER, baseObj, cnt);
    }
}

void CreateTreasureTrigger(struct Treasure treasureStruct, location loc){
    vector locVec = GetPositionFromLocation(loc);
    object trigger = NWNX_Area_CreateGenericTrigger(GetAreaFromLocation(loc),
                                                    locVec.x,
                                                    locVec.y,
                                                    locVec.z,
                                                    MS_TREASURE_CONTAINER,
                                                    9.0f);
    //WriteTimestampedLogEntry("CreateTreasureTrigger: at x: "
    //                         + FloatToString(locVec.x) + " y: "
    //                        + FloatToString(locVec.y) + " z: "
    //                        + FloatToString(locVec.z));
    SetEventScript(trigger, EVENT_SCRIPT_TRIGGER_ON_OBJECT_ENTER,
                   "ms_treasure_trigger");
    SetLocalInt(trigger, MS_TREASURE_TRIGGER_SPOT_DIFF, treasureStruct.spotDiff);
}

int CreateTreasure(struct Treasure treasureStruct, location loc) {

    /* If we cant walk to the point need to find some where we can.*/
    int newLocTry = 0;
    if(GetIsLocationWalkable(loc) == FALSE) {
        vector locPos = GetPositionFromLocation(loc);
        int baseX = FloatToInt(locPos.x/10.0);
        int baseY = FloatToInt(locPos.y/10.0);
        float baseXf = baseX * 10.0;
        float baseYf = baseY * 10.0;
        while(newLocTry < 40 && (GetIsLocationWalkable(loc) == FALSE
              || isHeightWrong(loc) == TRUE)) {
            newLocTry++;
            float randXf = baseXf + IntToFloat(Random(100))/10;
            float randYf = baseYf + IntToFloat(Random(100))/10;
            loc = Location(GetAreaFromLocation(loc),
                           Vector(randXf, randYf, locPos.z), 0.0);
            loc = Location(GetAreaFromLocation(loc),
                           Vector(randXf, randYf, GetGroundHeight(loc) + 0.2),
                           0.0);
        }
    }

    if(newLocTry >= 40) {
        return FALSE;
    }
    vector pos = GetPositionFromLocation(loc);
    WriteTimestampedLogEntry("MS TREASURE: CreateTreasure " + treasureStruct.burriedResRef +
                             " - at x: " + FloatToString(pos.x) + " y: " +
                             FloatToString(pos.y)+ " z: " +
                             FloatToString(pos.z));
    object oTreasure = CreateObject(OBJECT_TYPE_PLACEABLE,
                                    treasureStruct.burriedResRef,
                                    loc,
                                    FALSE,
                                    MS_TREASURE_CONTAINER);
    CreateTreasureTrigger(treasureStruct, loc);
    NWNX_Object_SetPlaceableIsStatic(oTreasure, FALSE);
    SetUseableFlag(oTreasure, TRUE);
    SetName(oTreasure, treasureStruct.burriedName);

    SetLocalString(oTreasure, MS_TREASURE_CHEST_NAME, treasureStruct.burriedName);
    SetLocalString(oTreasure, MS_TREASURE_CHEST_NEW_TAG, treasureStruct.chestNewTag);
    SetLocalString(oTreasure, MS_TREASURE_CHEST_RESREF, treasureStruct.chestResRef);
    SetLocalString(oTreasure, MS_TREASURE_CHEST_ITEM_RESREF, treasureStruct.chestItemResRef);

    SetLocalInt(oTreasure, MS_TREASURE_CHEST_GOLD_MIN, treasureStruct.chestGoldMin);
    SetLocalInt(oTreasure, MS_TREASURE_CHEST_GOLD_MAX, treasureStruct.chestGoldMax);
    SetLocalInt(oTreasure, MS_TREASURE_CHEST_GEMS, treasureStruct.chestGems);
    SetLocalInt(oTreasure, MS_TREASURE_CHEST_WEAPONS, treasureStruct.chestWeapons);
    SetLocalInt(oTreasure, MS_TREASURE_CHEST_ARMOR, treasureStruct.chestArmor);
    SetLocalInt(oTreasure, MS_TREASURE_CHEST_POTIONS, treasureStruct.chestPotions);
    SetLocalInt(oTreasure, MS_TREASURE_CHEST_JEWLERY, treasureStruct.chestJewlery);
    SetLocalInt(oTreasure, MS_TREASURE_CHEST_GOLD, treasureStruct.chestGold);

    SetEventScript(oTreasure, EVENT_SCRIPT_PLACEABLE_ON_USED,
                   "ms_treas_on_used");
    SetEventScript(oTreasure, EVENT_SCRIPT_PLACEABLE_ON_MELEEATTACKED,
                   "ms_treas_on_atta");

    /* Set it as a container just in case its not */
    //NWNX_Object_SetHasInventory(oTreasure, TRUE);
    /* Set its visibility to DM Only */
    NWNX_Visibility_SetVisibilityOverride(OBJECT_INVALID, oTreasure,
                                          NWNX_VISIBILITY_DM_ONLY);
    /* Create herb item on container */
    //CreateItemOnObject(herbStruct.itemResRef, oHerb, 1,
    //                   "ms_herb_item" + herbStruct.itemResRef);

    return TRUE;
}

int CreateTreasureForTerrainType(location loc, string terrainType) {
    if (terrainType == TERRAIN_FRESH_WATER) {
        //WriteTimestampedLogEntry("CreateHerbForTerrainType: " +  TERRAIN_FRESH_WATER);
        return CreateTreasure(GetLesserRandomFreshWaterTreasure(), loc);
    } else if (terrainType == TERRAIN_SALT_WATER) {
        //WriteTimestampedLogEntry("CreateHerbForTerrainType: " +  TERRAIN_SALT_WATER);
        return CreateTreasure(GetLesserRandomSaltWaterTreasure(), loc);
    } else if (terrainType == TERRAIN_FIELD) {
        //WriteTimestampedLogEntry("CreateHerbForTerrainType: " +  TERRAIN_FIELD);
        return CreateTreasure(GetLesserRandomFieldTreasure(), loc);
    } else if (terrainType == TERRAIN_FOREST) {
        //WriteTimestampedLogEntry("CreateHerbForTerrainType: " +  TERRAIN_FOREST);
        return CreateTreasure(GetLesserRandomForestTreasure(), loc);
    } else if (terrainType == TERRAIN_MOUNTAIN) {
        //WriteTimestampedLogEntry("CreateHerbForTerrainType: " +  TERRAIN_MOUNTAIN);
        return CreateTreasure(GetLesserRandomMountainTreasure(), loc);
    } else if (terrainType == TERRAIN_ROCKY) {
        //WriteTimestampedLogEntry("CreateHerbForTerrainType: " +  TERRAIN_ROCKY);
        return CreateTreasure(GetLesserRandomRockyTreasure(), loc);
    } else if (terrainType == TERRAIN_HILL) {
        //WriteTimestampedLogEntry("CreateHerbForTerrainType: " +  TERRAIN_HILL);
        return CreateTreasure(GetLesserRandomFieldTreasure(), loc);
    }

    return FALSE;
}

int CreateTreasureByTerrianType(object oArea, string terrainType) {
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
    return CreateTreasureForTerrainType(randomLoc, terrainType);
}

void SeedRandomTreasure(object oArea, int maxTreasure) {
    int i = 0;
    int attempts = 0;

    // spend the rest randomly
    while(i < maxTreasure && attempts < 20) {
        attempts++;
        string randTerrianType = GetRandomTerrainType();
        //WriteTimestampedLogEntry("SeedRandomTreasure for: " + randTerrianType);
        if(CreateTreasureByTerrianType(oArea, randTerrianType) == TRUE) {
            i++;
        }
    }
}


