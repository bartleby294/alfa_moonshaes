#include "ms_herb_seed"

void main()
{
    object oPC = GetPCSpeaker();
    object oArea = GetArea(oPC);
    int herbCnt = GetCampaignInt(MAX_HERBS_PER_AREA, GetResRef(oArea));
    string herbCntStr = IntToString(herbCnt);
    SetCustomToken(21473647, herbCntStr);
}
