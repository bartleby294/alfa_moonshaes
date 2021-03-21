#include "ms_herb_seed"

void main()
{
    object oPC = GetPCSpeaker();
    object oArea = GetArea(oPC);
    int herbCnt = GetCampaignInt(MAX_HERBS_PER_AREA, GetResRef(oArea));
    SetCampaignInt(MAX_HERBS_PER_AREA, GetResRef(oArea), herbCnt + 1);
}

