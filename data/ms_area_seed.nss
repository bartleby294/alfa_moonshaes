#include "ms_herb_seed"
#include "nwnx_time"
#include "nwnx_area"

void HerbTearDown(object oArea) {
    int cnt = 1;
    object baseObj = GetFirstObjectInArea(oArea);

    // Clean up any old herbs.
    object curHerb = GetNearestObjectByTag(MS_HERB_CONTAINER, baseObj, cnt);
    while(curHerb != OBJECT_INVALID) {
         cnt++;
         WriteTimestampedLogEntry("MS HERBS: Destroying an herb - cnt:" + IntToString(cnt));
         DestroyObject(curHerb);
         curHerb = GetNearestObjectByTag(MS_HERB_CONTAINER, baseObj, cnt);
    }
}

void RandomAreaSeed(object oArea) {
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
