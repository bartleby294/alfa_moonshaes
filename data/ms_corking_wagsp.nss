#include "nwnx_time"

void main()
{
    SetCampaignInt("CORKING_WAGON", "CORKING_WAGON_TIME",
                   2 * NWNX_Time_GetTimeStamp());
}

