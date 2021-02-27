#include "nwnx_visibility"

void main()
{
    object oPC = GetEnteringObject();
    object house1 = GetObjectByTag("korat_house_1");
    NWNX_Visibility_SetVisibilityOverride(oPC, house1,
                                          NWNX_VISIBILITY_ALWAYS_VISIBLE);
    object house2 = GetObjectByTag("korat_house_2");
    NWNX_Visibility_SetVisibilityOverride(oPC, house2,
                                          NWNX_VISIBILITY_ALWAYS_VISIBLE);
    object house3 = GetObjectByTag("korat_house_3");
    NWNX_Visibility_SetVisibilityOverride(oPC, house3,
                                          NWNX_VISIBILITY_ALWAYS_VISIBLE);
    object house4 = GetObjectByTag("korat_house_4");
    NWNX_Visibility_SetVisibilityOverride(oPC, house4,
                                          NWNX_VISIBILITY_ALWAYS_VISIBLE);
    object house5 = GetObjectByTag("korat_house_5");
    NWNX_Visibility_SetVisibilityOverride(oPC, house5,
                                          NWNX_VISIBILITY_ALWAYS_VISIBLE);
    ExecuteScript("ms_on_area_enter");
}
