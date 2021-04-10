#include "nwnx_visibility"

void main()
{
    object oPC = GetPCSpeaker();
    object treasureMarker = GetNearestObjectByTag("ms_treasure_eart", oPC);
    if(treasureMarker == OBJECT_INVALID) {
        treasureMarker = GetNearestObjectByTag("ms_treasure_sand", oPC);
    }

    // if we cant find a maker exit
    if(treasureMarker == OBJECT_INVALID) {
        return;
    }

    // if the marker is too far away exit.
    float treasureDist = GetDistanceBetween(oPC, treasureMarker);
    if(treasureDist == -1.0 || treasureDist > 10.0) {
        return;
    }

    NWNX_Visibility_SetVisibilityOverride(OBJECT_INVALID, treasureMarker,
                                          NWNX_VISIBILITY_VISIBLE);
}
