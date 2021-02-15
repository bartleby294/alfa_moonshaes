#include "nwnx_visibility"

void main()
{
    string shipStr = "corwell_anim_caravel_2";
    object oCityShip = GetNearestObjectByTag(shipStr, OBJECT_SELF);
    int activated = GetLocalInt(oCityShip, "activated");
    NWNX_Visibility_SetVisibilityOverride(GetLastUsedBy(), oCityShip,
        NWNX_VISIBILITY_ALWAYS_VISIBLE);

    if(activated == FALSE) {
        SpeakString("Activated");
        PlayAnimation(ANIMATION_PLACEABLE_ACTIVATE);
        AssignCommand(oCityShip, PlayAnimation(ANIMATION_PLACEABLE_DEACTIVATE));
        SetLocalInt(oCityShip, "animationState", TRUE);
    } else {
        SpeakString("Deactivated");
        PlayAnimation(ANIMATION_PLACEABLE_DEACTIVATE);
        AssignCommand(oCityShip, PlayAnimation(ANIMATION_PLACEABLE_ACTIVATE));
        SetLocalInt(oCityShip, "animationState", FALSE);
    }
}
