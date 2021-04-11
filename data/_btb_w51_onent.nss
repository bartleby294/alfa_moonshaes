#include "nwnx_visibility"

void main()
{
    object oPC = GetEnteringObject();
    object tree1 = GetObjectByTag("TreePine001divinity");
    NWNX_Visibility_SetVisibilityOverride(oPC, tree1,
                                          NWNX_VISIBILITY_ALWAYS_VISIBLE);
       ExecuteScript("ms_on_area_enter");
}
