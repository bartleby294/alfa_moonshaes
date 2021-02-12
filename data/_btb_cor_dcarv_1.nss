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

//"gangplank_block"
//"city_ship_gangpl"
//"corwell_anim_caravel_docking_1"

void main() {

    float delay = 125.0;
    int time = NWNX_Time_GetTimeStamp();
    string shipStr = "corwell_anim_caravel_docking_1";
    object oCaravelShip = GetNearestObjectByTag(shipStr, OBJECT_SELF);
    //object oBlocker = GetNearestObjectByTag("lyplc_nowalk2", oLever, 1);

    if(oCaravelShip == OBJECT_INVALID) {
        object oBlockerWP = GetObjectByTag("corwell_caravel_blocker_1");
        object oArea = GetArea(oBlockerWP);
        oCaravelShip = CreateObject(OBJECT_TYPE_PLACEABLE,
                         "anim_caravel_1",
                         Location(oArea, Vector(85.4, 145.0, 0.0), 0.0),
                         FALSE,
                         shipStr);
        NWNX_Visibility_SetVisibilityOverride(GetLastUsedBy(), oCaravelShip,
            NWNX_VISIBILITY_ALWAYS_VISIBLE);
        DelayCommand(delay, DockShip(oBlockerWP));

        SpeakString("Activated");
        PlayAnimation(ANIMATION_PLACEABLE_ACTIVATE);
        AssignCommand(oCaravelShip,
            PlayAnimation(ANIMATION_PLACEABLE_ACTIVATE));
    }

}
