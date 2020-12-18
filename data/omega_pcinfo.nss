#include "dmw_inc"
#include "alfa_wealth_inc"

int StartingConditional()
{
    object oDM = GetLastSpeaker();
    object oMyTarget = GetLocalObject(oDM, "OMWandTarget");
    struct WealthStruct wealthInfo = GetWealthInfo(oMyTarget);

    SetCustomToken(6901, GetDeity(oMyTarget));
    SetCustomToken(6902, ReadableIntToString(GetXP(oMyTarget)));
    SetCustomToken(6903, FloatToString(wealthInfo.percentXPToNextLevel * 100, 2, 0));
    SetCustomToken(6904, ReadableIntToString(wealthInfo.wealth));
    SetCustomToken(6905, GetWealthPositionAsString(wealthInfo.position));
    SetCustomToken(6906, ReadableIntToString(wealthInfo.lowLevel));
    SetCustomToken(6907, ReadableIntToString(wealthInfo.averageLevel));
    SetCustomToken(6908, ReadableIntToString(wealthInfo.highLevel));
    SetCustomToken(6909, ReadableIntToString(wealthInfo.limitLevel));

    return 1;
}
