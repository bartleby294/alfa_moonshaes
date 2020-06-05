#include "omega_include"
#include "alfa_wealth_inc"

int StartingConditional()
{
    object oSpeaker = GetPCSpeaker();
    object oTarget = GetLocalObject(oSpeaker, "OMWandTarget");
    location loc = GetLocalLocation(oSpeaker, "OMWandLoc");

    /*if(!GetIsObjectValid(oTarget)) {
        oTarget = GetNearestObjectToLocation(OBJECT_TYPE_DOOR | OBJECT_TYPE_PLACEABLE, loc);
        SetLocalObject( oSpeaker, "OMWandTarget", oTarget );
    }*/

    string isPlot, isImmortal, value;

    if(GetPlotFlag(oTarget))
        isPlot = "YES";
        else isPlot = "no";

    if(GetImmortal(oTarget))
        isImmortal = "YES";
        else isImmortal = "no";

    if(GetObjectType(oTarget) == OBJECT_TYPE_ITEM)
        value = IntToString(GetItemValue(oTarget));
        else value = "NA";

    SetCustomToken(6900, GetName(oTarget));
    SetCustomToken(6901, GetObjectTypeAsString(GetObjectType(oTarget)));
    SetCustomToken(6902, GetTag(oTarget));
    SetCustomToken(6903, GetResRef(oTarget));
    SetCustomToken(6904, isPlot);
    SetCustomToken(6905, isImmortal);
    SetCustomToken(6906, value);

    return 1;
}
