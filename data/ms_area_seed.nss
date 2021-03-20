#include "ms_herb_seed"
#include "nwnx_time"

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
