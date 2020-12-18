#include "omega_include"
#include "alfa_wealth_inc"

int StartingConditional()
{
    object oSpeaker = GetPCSpeaker();
    object oTarget = GetLocalObject(oSpeaker, "OMWandTarget");
    location loc = GetLocalLocation(oSpeaker, "OMWandLoc");
    int filter = GetLocalInt(oSpeaker, "OMFilter");

    if(!GetIsObjectValid(oTarget)) {
        oTarget = GetNearestObjectToLocation(filter, loc);
        SetLocalObject( oSpeaker, "OMWandTarget", oTarget );
    }

    string isPlot, isImmortal;

    if(GetPlotFlag(oTarget))
        isPlot = "YES";
        else isPlot = "no";

    if(GetImmortal(oTarget))
        isImmortal = "YES";
        else isImmortal = "no";

    SetCustomToken(6900, GetName(oTarget));
    SetCustomToken(6901, GetObjectTypeAsString(GetObjectType(oTarget)));
    SetCustomToken(6902, GetTag(oTarget));
    SetCustomToken(6903, GetResRef(oTarget));
    SetCustomToken(6904, isPlot);
    SetCustomToken(6905, isImmortal);
    SetCustomToken(6906, IntToString(GetTotalWealth(oTarget)));

    return 1;
}
