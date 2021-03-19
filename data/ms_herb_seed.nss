#include "ms_herb_declare"
#include "ms_location_util"
#include "nwnx_area"
#include "ms_terrain_id"
#include "ms_herb_structs"
#include "_btb_util"
#include "nwnx_object"
#include "nwnx_visibility"

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

int CreateHerbForTerrainType(location loc, int terrainType) {
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

void SeedRandomHerbs(object oArea, int maxHerbs) {
    int i = 0;
    int attempts = 0;
    while(i < maxHerbs && attempts < 60) {
        attempts++;
        location randomLoc = GetLocationInAreaWithBuffer(oArea, 20);
        vector randomLocVec = GetPositionFromLocation(randomLoc);
        string tileResRef = NWNX_Area_GetTileModelResRef(oArea,
                                                         randomLocVec.x,
                                                         randomLocVec.y);
        int terrainType = GetTerrainType(tileResRef, randomLoc);
        int herbCreated = CreateHerbForTerrainType(randomLoc, terrainType);
        if(herbCreated == TRUE) {
            i++;
        }
    }
}


