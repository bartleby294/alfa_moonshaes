#include "alfa_wealth_inc"
#include "nwnx_time"
#include "nw_o0_itemmaker"
#include "alfa_ms_config"
#include "_btb_util"
#include "nwnx_area"
#include "nwnx_regex"
#include "nwnx_data"
#include "ba_consts"
#include "ms_bndcmp_fireut"

void main()
{
    //writeToLog("===================================");
    //writeToLog("|BANDIT CAMPFIRE HEARTBEAT");
    object oArea = GetArea(OBJECT_SELF);
    int lastRaid = GetCampaignInt("BANDIT_CAMP_PC_LAST_OBSERVED",
        "BANDIT_CAMP_PC_LAST_OBSERVED" + GetTag(oArea));
    // If no one is in the area check if we should destory camp.
    if(NWNX_Area_GetNumberOfPlayersInArea(oArea) == 0) {
        //writeToLog("|No players in the area.");
        // If we there are no players in the area and haven't been in
        // the alloted time destory the camp.
        if(NWNX_Time_GetTimeStamp() - lastRaid
            > BANDIT_CAMP_DESTORY_DELAY_SECONDS) {
            writeToLog("|No players in the area for time limit.");
            DestroyCamp(oArea);
        }
    // If someone is in the area update the last seen time.
    } else {
        //writeToLog("|Player found updating timestamp.");
        SetCampaignInt("BANDIT_CAMP_PC_LAST_OBSERVED",
            "BANDIT_CAMP_PC_LAST_OBSERVED" + GetTag(oArea),
            NWNX_Time_GetTimeStamp());
    }

}
