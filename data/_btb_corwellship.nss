#include "nwnx_visibility"
#include "nwnx_time"
#include "_btb_util"
#include "_btb_ship_const"
#include "X0_i0_anims"
#include "nwnx_object"

void SetVisible(object oObject) {
    object oArea = GetArea(oObject);
    object oPC = GetFirstPCInArea(oArea);

    while(oPC != OBJECT_INVALID) {
        NWNX_Visibility_SetVisibilityOverride(oPC, oObject,
            NWNX_VISIBILITY_ALWAYS_VISIBLE);
        GetNextPCInArea(oArea);
    }
}

location GangPlankLocation(object blockerWP, vector plankVector,float rotation){
    object oArea = GetArea(blockerWP);
    vector blockerPos = GetPosition(blockerWP);
    float facing = GetFacing(blockerWP) + rotation;
    return Location(oArea,
                    Vector(blockerPos.x + plankVector.x,
                           blockerPos.y + plankVector.y,
                           plankVector.z),
                    facing);
}

void DockShip(object oBlockerWP, location plankLocation, string newTag,
              string blockerTag, string plankRes){
    object plank = CreateObject(OBJECT_TYPE_PLACEABLE, plankRes,
                                plankLocation, FALSE, newTag);
    SetVisible(plank);
    DestroyObject(GetObjectByTag(blockerTag));
}

void ShipInboundCreate(string shipStr, string waypntTag, vector position,
                       float facing, string shipRes) {
    int time = NWNX_Time_GetTimeStamp();
    object oShip = GetNearestObjectByTag(shipStr, OBJECT_SELF);

    if(oShip == OBJECT_INVALID) {
        object oBlockerWP = GetObjectByTag(waypntTag);
        object oArea = GetArea(oBlockerWP);
        oShip = CreateObject(OBJECT_TYPE_PLACEABLE,
                         shipRes,
                         Location(oArea,
                                  Vector(position.x, position.y, position.z),
                                  facing),
                         FALSE,
                         shipStr);
        SetVisible(oShip);
        SpeakString("Create Caravel: (" + FloatToString(position.x) + ", "
                                                + FloatToString(position.y));
        PlayAnimation(ANIMATION_PLACEABLE_ACTIVATE);
        AssignCommand(oShip, PlayAnimation(ANIMATION_PLACEABLE_DEACTIVATE));
    }
}

void ShipActivate(string shipTag, string waypntTag, string plankTag,
                  string blockerTag, vector plankVector, float faceing,
                  string plankRes) {
    float delay = 125.0;
    object oBlockerWP = GetObjectByTag(waypntTag);
    object oShip = GetNearestObjectByTag(shipTag, OBJECT_SELF);
    AssignCommand(oShip, PlayAnimation(ANIMATION_PLACEABLE_ACTIVATE));
    DelayCommand(delay,
        DockShip(oBlockerWP,
             GangPlankLocation(oBlockerWP, plankVector, faceing),
             plankTag,
             blockerTag,
             plankRes));
}

void ShipDeactivate(string shipStr) {
    object oCaravelShip = GetNearestObjectByTag(shipStr, OBJECT_SELF);
     AssignCommand(oCaravelShip,
            PlayAnimation(ANIMATION_PLACEABLE_DEACTIVATE));
}

void ShipDestroy(string shipStr, string waypntStr, string blockerTag,
                 string blockerRes, string plankTag) {
    object oShip = GetObjectByTag(shipStr);
    object oPlank = GetObjectByTag(plankTag);
    DestroyObject(oShip);
    DestroyObject(oPlank);

    object blockerWP = GetObjectByTag(waypntStr);
    object blocker = GetObjectByTag(blockerTag);
    if(blocker == OBJECT_INVALID) {
        CreateObject(OBJECT_TYPE_PLACEABLE, blockerRes, GetLocation(blockerWP),
                     FALSE, blockerTag);
    }
}
