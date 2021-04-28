#include "nwnx_visibility"

void main()
{
    object oPC = GetEnteringObject();
    int nNth = 0;
    string sTag = "TreePine001divinity";
    object oObject = GetObjectByTag(sTag, nNth);
    while(GetIsObjectValid(oObject))
    {
        // Do something
    NWNX_Visibility_SetVisibilityOverride(oPC, oObject,
                                          NWNX_VISIBILITY_ALWAYS_VISIBLE);
        oObject = GetObjectByTag(sTag, ++nNth);
    }
    ExecuteScript("ms_on_area_exit");
}
