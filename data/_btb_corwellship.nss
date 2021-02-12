#include "nwnx_visibility"
#include "nwnx_time"
#include "_btb_util"

location GangPlankLocationCaravel1(object blockerWP) {
    object oArea = GetArea(blockerWP);
    vector blockerPos = GetPosition(blockerWP);
    float facing = GetFacing(blockerWP) + 90;
    return Location(oArea,
                  Vector(blockerPos.x + 0.0, blockerPos.y + 4.5, 0.0), facing);
}

void DockShip(object oBlockerWP){
    object oGangPlank = CreateObject(OBJECT_TYPE_PLACEABLE,
                                     "caraveshipstairs",
                                     GangPlankLocationCaravel1(oBlockerWP));
}

void CaravelInbound() {

    float delay = 125.0;
    int time = NWNX_Time_GetTimeStamp();
    string shipStr = "corwell_anim_caravel_1";
    object oCaravel = GetObjectByTag(shipStr);
    int timeToggled = GetLocalInt(oCaravel, "timeToggled");

    if(oCaravel != OBJECT_INVALID && timeToggled == 0) {
        object oArea = GetArea(oCaravel);
        object oPC = GetFirstPCInArea(oArea);
        object oBlockerWP = GetObjectByTag("corwell_caravel_blocker_1");

        // Make the ship visable to all PCs in the area.
        while(oPC != OBJECT_INVALID) {
            NWNX_Visibility_SetVisibilityOverride(oPC, oCaravel,
                                                NWNX_VISIBILITY_ALWAYS_VISIBLE);
            GetNextPCInArea(oArea);
        }

        DelayCommand(delay, DockShip(oBlockerWP));
        AssignCommand(oCaravel, PlayAnimation(ANIMATION_PLACEABLE_ACTIVATE));
        SetLocalInt(oCaravel, "timeToggled", time);
    }
}
