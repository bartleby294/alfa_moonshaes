#include "nwnx_dialog"
#include "ms_rest_consts"

void main()
{
    SetCampaignInt(REST_DATABASE, GetResRef(GetArea(GetPCSpeaker())),
                   NWNX_Dialog_GetCurrentNodeIndex());

    WriteTimestampedLogEntry("SET RESTING: rest state for "
                              + GetResRef(GetArea(GetPCSpeaker())) + " = "
                              + IntToString(NWNX_Dialog_GetCurrentNodeIndex()));
}
