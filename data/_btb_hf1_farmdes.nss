#include "nwnx_time"
#include "alfa_ms_config"

void main()
{
    object enterObj = GetEnteringObject();
    object oArea = GetArea(OBJECT_SELF);
    int lastRaid = GetCampaignInt("XVART_RAIDS", "XVART_RAID_" + GetTag(oArea));
    if(GetTag(enterObj) == "clav"
        || GetTag(enterObj) == "jart"
        || GetTag(enterObj) == "rolling"
        || GetTag(enterObj) == "mitchan") {
        // only despawn if the xvarts are coming.
        if(NWNX_Time_GetTimeStamp() - lastRaid < FARM_DELAY_SECONDS) {
            AssignCommand(enterObj, ActionSpeakString("*Runs into the barn.*"));
            DestroyObject(enterObj, 2.0);
        }
    }
}
