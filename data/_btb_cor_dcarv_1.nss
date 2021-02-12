/*#include "nwnx_visibility"

void main()
{
    string shipStr = "corwell_anim_caravel_1";
    object oCityShip = GetNearestObjectByTag(shipStr, OBJECT_SELF);
    int activated = GetLocalInt(oCityShip, "activated");
    NWNX_Visibility_SetVisibilityOverride(GetLastUsedBy(), oCityShip,
        NWNX_VISIBILITY_ALWAYS_VISIBLE);

    if(activated == FALSE) {
        SpeakString("Activated");
        PlayAnimation(ANIMATION_PLACEABLE_ACTIVATE);
        AssignCommand(oCityShip, PlayAnimation(ANIMATION_PLACEABLE_ACTIVATE));
        SetLocalInt(oCityShip, "animationState", TRUE);
    } else {
        SpeakString("Deactivated");
        PlayAnimation(ANIMATION_PLACEABLE_DEACTIVATE);
        AssignCommand(oCityShip, PlayAnimation(ANIMATION_PLACEABLE_DEACTIVATE));
        SetLocalInt(oCityShip, "animationState", FALSE);
    }
}  */

#include "nwnx_visibility"
#include "nwnx_time"

location GangPlankLocation(object blockerWP) {
    object oArea = GetArea(blockerWP);
    vector blockerPos = GetPosition(blockerWP);
    float facing = GetFacing(blockerWP) + 90;
    return Location(oArea,
                  Vector(blockerPos.x + 0.0, blockerPos.y + 4.5, 0.0), facing);
}

void DockShip(object oBlockerWP){
    object oGangPlank = CreateObject(OBJECT_TYPE_PLACEABLE,
                             "caraveshipstairs", GangPlankLocation(oBlockerWP));
}

void main() {

    float delay = 125.0;
    int time = NWNX_Time_GetTimeStamp();
    string shipStr = "corwell_anim_caravel_1";
    object oCityShip = GetNearestObjectByTag(shipStr, OBJECT_SELF);
    int activated = GetLocalInt(oCityShip, "activated");
    int timeToggled = GetLocalInt(oCityShip, "timeToggled");
    NWNX_Visibility_SetVisibilityOverride(GetLastUsedBy(), oCityShip,
        NWNX_VISIBILITY_ALWAYS_VISIBLE);

    //object oBlocker = GetNearestObjectByTag("lyplc_nowalk2", oLever, 1);

    SpeakString("time: " + IntToString(time));
    SpeakString("timeToggled: " + IntToString(timeToggled));

    if(time > timeToggled) {
        if(activated == FALSE) {
            //"gangplank_block"
            //"city_ship_gangpl"
            //"corwell_city_ship_blocker_1"
            object oBlockerWP = GetObjectByTag("corwell_caravel_blocker_1");
            DelayCommand(delay, DockShip(oBlockerWP));

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
