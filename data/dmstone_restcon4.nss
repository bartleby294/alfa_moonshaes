#include "nwnx_dialog"
#include "ms_rest_consts"

void main()
{
    SetCampaignInt(REST_DATABASE, GetResRef(GetArea(GetPCSpeaker())), 4);

    WriteTimestampedLogEntry("SET RESTING: rest state for "
                              + GetResRef(GetArea(GetPCSpeaker())) + " = "
                              + IntToString(4));
}
