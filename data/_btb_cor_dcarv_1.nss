#include "nwnx_visibility"

void main()
{
    string shipStr = "corwell_anim_caravel_1";
    object oCityShip = GetNearestObjectByTag(shipStr, OBJECT_SELF, 1);
    int animationState = GetLocalInt(oCityShip, "animationState");
    PlayAnimation(ANIMATION_PLACEABLE_ACTIVATE);
    NWNX_Visibility_SetVisibilityOverride(GetLastUsedBy(), oCityShip,
        NWNX_VISIBILITY_ALWAYS_VISIBLE);

    if(animationState == TRUE) {
        AssignCommand(oCityShip, PlayAnimation(ANIMATION_PLACEABLE_ACTIVATE));
        SetLocalInt(oCityShip, "animationState", FALSE);
    } else {
        AssignCommand(oCityShip, PlayAnimation(ANIMATION_PLACEABLE_DEACTIVATE));
        SetLocalInt(oCityShip, "animationState", TRUE);
    }
}
