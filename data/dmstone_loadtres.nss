#include "ms_treas_declare"

void main()
{
    object oPC = GetPCSpeaker();
    object oArea = GetArea(oPC);
    int treasureCnt = GetCampaignInt(MS_TREASURE_PER_AREA, GetResRef(oArea));
    string treasureCntStr = IntToString(treasureCnt);
    SetCustomToken(21473646, treasureCntStr);
}
