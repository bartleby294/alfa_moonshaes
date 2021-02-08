#include "nwnx_visibility"
#include "nwnx_time"

void main() {

    int time = NWNX_Time_GetTimeStamp();
    string shipStr = "corwell_anim_sm_ship_1";
    object oCityShip = GetNearestObjectByTag(shipStr, OBJECT_SELF);
    int activated = GetLocalInt(oCityShip, "activated");
    int timeToggled = GetLocalInt(oCityShip, "timeToggled");
    NWNX_Visibility_SetVisibilityOverride(GetLastUsedBy(), oCityShip,
        NWNX_VISIBILITY_ALWAYS_VISIBLE);

    object oBlocker = GetNearestObjectByTag("lyplc_nowalk2", oLever, 1);

    if(time > timeToggled) {
        if(activated == FALSE) {
            SpeakString("Activated");
            PlayAnimation(ANIMATION_PLACEABLE_ACTIVATE);
            AssignCommand(oCityShip,
                PlayAnimation(ANIMATION_PLACEABLE_ACTIVATE));
            SetLocalInt(oCityShip, "animationState", TRUE);
            SetLocalInt(oCityShip, "timeToggled", time + 150);
        } else {
            SpeakString("Deactivated");
            PlayAnimation(ANIMATION_PLACEABLE_DEACTIVATE);
            AssignCommand(oCityShip,
                PlayAnimation(ANIMATION_PLACEABLE_DEACTIVATE));
            SetLocalInt(oCityShip, "animationState", FALSE);
        }
    } else {
        SpeakString("Waiting for animation to finish.");
    }
}
