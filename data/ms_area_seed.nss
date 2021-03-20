#include "ms_herb_seed"
#include "nwnx_time"
#include "nwnx_area"
#include "nwnx_data"

const string AREA_TERRAIN_MAPPED_STATE = "area_terrain_mapped_state";

void PersistTerrainType(object oArea, string terrainType, int x, int y) {
    string xyStr = IntToString(x) + "|" + IntToString(y);
    NWNX_Data_Array_PushBack_Str(oArea, terrainType, xyStr);
}

void MapAreaTerrain(object oArea) {

    int x = 0;
    int y = 0;
    int areaHeight = GetAreaSize(AREA_HEIGHT, oArea);
    int areaWidth = GetAreaSize(AREA_WIDTH, oArea);

    WriteTimestampedLogEntry("MapAreaTerrain Start");

    while(x < areaWidth) {
        while (y < areaHeight) {
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
    WriteTimestampedLogEntry("MapAreaTerrain End");
}

void RandomAreaSeed(object oArea) {
    if(GetLocalInt(oArea, AREA_TERRAIN_MAPPED_STATE) == FALSE) {
        MapAreaTerrain(oArea);
    }

    int maxHerbs = GetCampaignInt(MAX_HERBS_PER_AREA, GetResRef(oArea));
    if(maxHerbs > 0) {
        if(NWNX_Area_GetNumberOfPlayersInArea(oArea) > 1) {
            WriteTimestampedLogEntry("HERBS ON ENTER: EXIT 1");
        } else {
            int lastHerbCreate = GetLocalInt(oArea, LAST_HERB_CREATE);
            int curTime = NWNX_Time_GetTimeStamp();
            if(curTime - lastHerbCreate > HERB_CREATE_DELAY_SECONDS) {
                HerbTearDown(oArea);
                DelayCommand(0.5, SeedRandomHerbs(oArea, maxHerbs));
            }
        }
    }

    // if( WE SHOULD SEED OTHER STUFF ) {

    //}
}
