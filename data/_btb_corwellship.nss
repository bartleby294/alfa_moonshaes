#include "nwnx_visibility"
#include "nwnx_time"
#include "_btb_util"
#include "_btb_ship_const"
#include "X0_i0_anims"

location GangPlankLocation(object blockerWP, float xOff, float yOff, float zOff,
                           float rotation){
    object oArea = GetArea(blockerWP);
    vector blockerPos = GetPosition(blockerWP);
    float facing = GetFacing(blockerWP) + rotation;
    return Location(oArea,
                    Vector(blockerPos.x + xOff, blockerPos.y + yOff, zOff),
                    facing);
}

void DockShip(object oBlockerWP, location plankLocation, string newTag){
    CreateObject(OBJECT_TYPE_PLACEABLE, "caraveshipstairs",
                    plankLocation, FALSE, newTag);
}

void CaravelInbound() {

    float delay = 125.0;
    int time = NWNX_Time_GetTimeStamp();
    string shipStr = CARAVEL_INBOUND_TAG;
    object oCaravel = GetObjectByTag(shipStr);
    int timeToggled = GetLocalInt(oCaravel, "timeToggled");

    if(oCaravel != OBJECT_INVALID && timeToggled == 0) {
        object oArea = GetArea(oCaravel);
        object oPC = GetFirstPCInArea(oArea);
        object oBlockerWP = GetObjectByTag(CARAVEL_INBOUND_WAYPOINT_TAG);

        // Make the ship visable to all PCs in the area.
        while(oPC != OBJECT_INVALID) {
            NWNX_Visibility_SetVisibilityOverride(oPC, oCaravel,
                                                NWNX_VISIBILITY_ALWAYS_VISIBLE);
            oPC = GetNextPCInArea(oArea);
        }

        DelayCommand(delay,
            DockShip(oBlockerWP,
                     GangPlankLocation(oBlockerWP, 0.0, 4.5, 0.0, 90.0),
                     CARAVEL_INBOUND_PLANK_TAG));
        AssignCommand(oCaravel, PlayAnimation(ANIMATION_PLACEABLE_ACTIVATE));
        SetLocalInt(oCaravel, "timeToggled", time);
    }
}

void CaravelInboundCreate() {

    float delay = 125.0;
    int time = NWNX_Time_GetTimeStamp();
    string shipStr = "corwell_anim_caravel_docking_1";
    object oCaravelShip = GetNearestObjectByTag(shipStr, OBJECT_SELF);
    //object oBlocker = GetNearestObjectByTag("lyplc_nowalk2", oLever, 1);

    if(oCaravelShip == OBJECT_INVALID) {
        object oBlockerWP = GetObjectByTag(CARAVEL_INBOUND_WAYPOINT_TAG);
        object oArea = GetArea(oBlockerWP);
        oCaravelShip = CreateObject(OBJECT_TYPE_PLACEABLE,
                         "corwell_car_deac",
                         Location(oArea, Vector(85.4, 145.0, 0.0), 0.0),
                         FALSE,
                         shipStr);
        NWNX_Visibility_SetVisibilityOverride(GetLastUsedBy(), oCaravelShip,
            NWNX_VISIBILITY_ALWAYS_VISIBLE);
        //DelayCommand(delay, DockShip(oBlockerWP));

        SpeakString("Create Activated");
        PlayAnimation(ANIMATION_PLACEABLE_ACTIVATE);
        AssignCommand(oCaravelShip,
            PlayAnimation(ANIMATION_PLACEABLE_ACTIVATE));
    }

}

void CityShipInbound() {

    float delay = 125.0;
    int time = NWNX_Time_GetTimeStamp();
    string shipStr = CITY_SHIP_INBOUND_TAG;
    object oCityShip = GetObjectByTag(shipStr);
    int timeToggled = GetLocalInt(oCityShip, "timeToggled");

    if(oCityShip != OBJECT_INVALID && timeToggled == 0) {
        object oArea = GetArea(oCityShip);
        object oPC = GetFirstPCInArea(oArea);
        object oBlockerWP = GetObjectByTag(CITY_SHIP_INBOUND_WAYPOINT_TAG);

        // Make the ship visable to all PCs in the area.
        while(oPC != OBJECT_INVALID) {
            NWNX_Visibility_SetVisibilityOverride(oPC, oCityShip,
                                                NWNX_VISIBILITY_ALWAYS_VISIBLE);
            oPC = GetNextPCInArea(oArea);
        }

        DelayCommand(delay,
            DockShip(oBlockerWP,
                     GangPlankLocation(oBlockerWP, 0.3, 3.13, 0.0, 180.0),
                     CITY_SHIP_INBOUND_PLANK_TAG));
        AssignCommand(oCityShip, PlayAnimation(ANIMATION_PLACEABLE_ACTIVATE));
        SetLocalInt(oCityShip, "timeToggled", time);
    }
}
