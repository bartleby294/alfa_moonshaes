#include "nwnx_visibility"

void main()
{
    object oPC = GetExitingObject();
    object tree1 = GetObjectByTag("TreePine001divinity");
    NWNX_Visibility_SetVisibilityOverride(oPC, tree1,
                                          NWNX_VISIBILITY_DEFAULT);

    ExecuteScript("ms_on_area_exit");
}
