#include "nwnx_visibility"
#include "ms_herb_declare"

void main()
{
    object oPC = GetPCSpeaker();
    object herb = GetNearestObjectByTag(MS_HERB_CONTAINER, oPC);

    // if we cant find an herb exit
    if(herb == OBJECT_INVALID) {
        return;
    }

    // if the marker is too far away exit.
    float herbDist = GetDistanceBetween(oPC, herb);
    if(herbDist == -1.0 || herbDist > 10.0) {
        return;
    }

    NWNX_Visibility_SetVisibilityOverride(OBJECT_INVALID, herb,
                                          NWNX_VISIBILITY_VISIBLE);
}
