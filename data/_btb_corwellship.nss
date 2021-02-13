#include "nwnx_visibility"
#include "nwnx_time"
#include "_btb_util"
#include "_btb_ship_const"
#include "X0_i0_anims"
#include "nwnx_object"

location GangPlankLocation(object blockerWP, float xOff, float yOff, float zOff,
                           float rotation){
    object oArea = GetArea(blockerWP);
    vector blockerPos = GetPosition(blockerWP);
    float facing = GetFacing(blockerWP) + rotation;
    return Location(oArea,
                    Vector(blockerPos.x + xOff, blockerPos.y + yOff, zOff),
                    facing);
}

void DockShip(object oBlockerWP, location plankLocation, string newTag,
              string blockerTag){
    CreateObject(OBJECT_TYPE_PLACEABLE, "caraveshipstairs",
                    plankLocation, FALSE, newTag);
    DestroyObject(GetObjectByTag(blockerTag));
}

void CaravelInboundCreate() {
    int time = NWNX_Time_GetTimeStamp();
    string shipStr = CARAVEL_INBOUND_TAG;
    object oCaravelShip = GetNearestObjectByTag(shipStr, OBJECT_SELF);

    if(oCaravelShip == OBJECT_INVALID) {
        object oBlockerWP = GetObjectByTag(CARAVEL_INBOUND_WAYPOINT_TAG);
        object oArea = GetArea(oBlockerWP);
        float x = 85.4;
        float y = 145.0;
        oCaravelShip = CreateObject(OBJECT_TYPE_PLACEABLE,
                         "corwell_car_deac",
                         Location(oArea, Vector(x, y, 0.0), 90.0),
                         FALSE,
                         shipStr);
        NWNX_Visibility_SetVisibilityOverride(GetLastUsedBy(), oCaravelShip,
            NWNX_VISIBILITY_ALWAYS_VISIBLE);

        SpeakString("Create Caravel: (" + FloatToString(x) + ", "
                                                + FloatToString(y));
        PlayAnimation(ANIMATION_PLACEABLE_ACTIVATE);
        AssignCommand(oCaravelShip,
            PlayAnimation(ANIMATION_PLACEABLE_DEACTIVATE));
    }

}

void CaravelDeactivate() {
    string shipStr = CARAVEL_INBOUND_TAG;
    object oCaravelShip = GetNearestObjectByTag(shipStr, OBJECT_SELF);
     AssignCommand(oCaravelShip,
            PlayAnimation(ANIMATION_PLACEABLE_DEACTIVATE));
}

void CaravelActivate() {
    float delay = 125.0;
    object oBlockerWP = GetObjectByTag(CARAVEL_INBOUND_WAYPOINT_TAG);
    string shipStr = CARAVEL_INBOUND_TAG;
    object oCaravelShip = GetNearestObjectByTag(shipStr, OBJECT_SELF);
     AssignCommand(oCaravelShip,
            PlayAnimation(ANIMATION_PLACEABLE_ACTIVATE));
     DelayCommand(delay,
        DockShip(oBlockerWP,
             GangPlankLocation(oBlockerWP, 0.0, 4.5, 0.0, 90.0),
             CARAVEL_INBOUND_PLANK_TAG,
             CARAVEL_INBOUND_BLOCKER_TAG));
}

void CaravelDestroy() {
    string shipStr = CARAVEL_INBOUND_TAG;
    object oCaravelShip = GetNearestObjectByTag(shipStr, OBJECT_SELF);
    DestroyObject(oCaravelShip);

    object blockerWP = GetObjectByTag(CARAVEL_INBOUND_WAYPOINT_TAG);
    object blocker = GetObjectByTag(CARAVEL_INBOUND_BLOCKER_TAG);
    if(blocker == OBJECT_INVALID) {
        CreateObject(OBJECT_TYPE_PLACEABLE, CARAVEL_INBOUND_BLOCKER_RES,
                 GetLocation(blockerWP), FALSE, CARAVEL_INBOUND_BLOCKER_TAG);
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
                     CITY_SHIP_INBOUND_PLANK_TAG,
                     CITY_SHIP_INBOUND_BLOCKER_TAG));
        AssignCommand(oCityShip, PlayAnimation(ANIMATION_PLACEABLE_ACTIVATE));
        SetLocalInt(oCityShip, "timeToggled", time);
    }
}
