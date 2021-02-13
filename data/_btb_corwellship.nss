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
    string shipStr = "corwell_created_caravel_1";
    object oCaravelShip = GetNearestObjectByTag(shipStr, OBJECT_SELF);
    //object oBlocker = GetNearestObjectByTag("lyplc_nowalk2", oLever, 1);

    if(oCaravelShip == OBJECT_INVALID) {
        object oBlockerWP = GetObjectByTag(CARAVEL_INBOUND_WAYPOINT_TAG);
        object oArea = GetArea(oBlockerWP);
        float curXOff = GetLocalFloat(OBJECT_SELF, "xOff");
        float x = 85.4 - curXOff;
        float y = 145.0;
        oCaravelShip = CreateObject(OBJECT_TYPE_PLACEABLE,
                         "corwell_car_deac",
                         Location(oArea, Vector(x, y, 0.0), 90.0),
                         FALSE,
                         shipStr);
        NWNX_Visibility_SetVisibilityOverride(GetLastUsedBy(), oCaravelShip,
            NWNX_VISIBILITY_ALWAYS_VISIBLE);
        //DelayCommand(delay, DockShip(oBlockerWP));

        SpeakString("curXOff: " + FloatToString(curXOff));
        SpeakString("Create Caravel: (" + FloatToString(x) + ", "
                                                + FloatToString(y));
        PlayAnimation(ANIMATION_PLACEABLE_ACTIVATE);
        AssignCommand(oCaravelShip,
            PlayAnimation(ANIMATION_PLACEABLE_DEACTIVATE));
    }

}

void CaravelDeactivate() {
    string shipStr = "corwell_created_caravel_1";
    object oCaravelShip = GetNearestObjectByTag(shipStr, OBJECT_SELF);
     AssignCommand(oCaravelShip,
            PlayAnimation(ANIMATION_PLACEABLE_DEACTIVATE));
}

void CaravelActivate() {
    string shipStr = "corwell_created_caravel_1";
    object oCaravelShip = GetNearestObjectByTag(shipStr, OBJECT_SELF);
     AssignCommand(oCaravelShip,
            PlayAnimation(ANIMATION_PLACEABLE_ACTIVATE));
}

void CaravelClose() {
    string shipStr = "corwell_created_caravel_1";
    object oCaravelShip = GetNearestObjectByTag(shipStr, OBJECT_SELF);
     AssignCommand(oCaravelShip,
            PlayAnimation(ANIMATION_PLACEABLE_CLOSE));
}

void CaravelOpen() {
    string shipStr = "corwell_created_caravel_1";
    object oCaravelShip = GetNearestObjectByTag(shipStr, OBJECT_SELF);
     AssignCommand(oCaravelShip,
            PlayAnimation(ANIMATION_PLACEABLE_OPEN));
}

void CaravelDestroy() {
    string shipStr = "corwell_created_caravel_1";
    object oCaravelShip = GetNearestObjectByTag(shipStr, OBJECT_SELF);
    DestroyObject(oCaravelShip);
}

void CaravelMinus() {
    object oLever = GetObjectByTag("caravel_create");
    float curXOff = GetLocalFloat(oLever, "xOff");
    SetLocalFloat(oLever, "xOff", curXOff + 10.0);
    SpeakString("curXOff: " + FloatToString(GetLocalFloat(oLever, "xOff")));
}

void CaravelSerial(){
    object oLever = GetObjectByTag("caravel_serial");
    object oCaravel = GetObjectByTag(CARAVEL_INBOUND_TAG);
    if(oCaravel != OBJECT_INVALID) {
        SetLocalString(oLever, "serializeCaravel",
                                NWNX_Object_Serialize(oCaravel));
    }
}

void CaravelSerialDestroy() {
    string shipStr = CARAVEL_INBOUND_TAG;
    object oCaravelShip = GetNearestObjectByTag(shipStr, OBJECT_SELF);
    DestroyObject(oCaravelShip);
}

void CaravelSerialMinus() {
    object oLever = GetObjectByTag("caravel_serial");
    float curXOff = GetLocalFloat(oLever, "xOff");
    SetLocalFloat(oLever, "xOff", curXOff + 10.0);
    SpeakString("curXOff: " + FloatToString(GetLocalFloat(oLever, "xOff")));
}

void CaravelSerialPlus() {
    object oLever = GetObjectByTag("caravel_serial");
    float curXOff = GetLocalFloat(oLever, "xOff");
    SetLocalFloat(oLever, "xOff", curXOff - 10.0);
    SpeakString("curXOff: " + FloatToString(GetLocalFloat(oLever, "xOff")));
}

void CaravelSerialCreate() {

    float delay = 125.0;
    int time = NWNX_Time_GetTimeStamp();
    string shipStr = CARAVEL_INBOUND_TAG;
    object oCaravelShip = GetNearestObjectByTag(shipStr, OBJECT_SELF);
    //object oBlocker = GetNearestObjectByTag("lyplc_nowalk2", oLever, 1);

    if(oCaravelShip == OBJECT_INVALID) {
        object oLever = GetObjectByTag("caravel_serial");
        float curXOff = GetLocalFloat(oLever, "xOff");
        object oBlockerWP = GetObjectByTag(CARAVEL_INBOUND_WAYPOINT_TAG);
        object oArea = GetArea(oBlockerWP);
        string caravelStr = GetLocalString(oLever, "serializeCaravel");
        object oCaravelShip = NWNX_Object_Deserialize(caravelStr);
        float x = 85.4 - curXOff;
        float y = 145.0;
        NWNX_Object_AddToArea(oCaravelShip, oArea, Vector(x, y, 0.0));
        NWNX_Visibility_SetVisibilityOverride(GetLastUsedBy(), oCaravelShip,
            NWNX_VISIBILITY_ALWAYS_VISIBLE);
        //DelayCommand(delay, DockShip(oBlockerWP));

        SpeakString("Create Caravel: (" + FloatToString(x) + ", "
                                                + FloatToString(y));
        PlayAnimation(ANIMATION_PLACEABLE_ACTIVATE);
        AssignCommand(oCaravelShip,
            PlayAnimation(ANIMATION_PLACEABLE_ACTIVATE));
    } else {
        SpeakString("Create Caravel Already Exists");
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
