#include "nwnx_visibility"
#include "nwnx_time"
#include "_btb_util"
#include "_btb_ship_const"
#include "X0_i0_anims"
#include "nwnx_object"

void SetVisibleToAllPCsInArea(object oObject) {
    object oArea = GetArea(oObject);
    object oPC = GetFirstPCInArea(oArea);

    while(oPC != OBJECT_INVALID) {
        NWNX_Visibility_SetVisibilityOverride(oPC, oObject,
            NWNX_VISIBILITY_ALWAYS_VISIBLE);
        oPC = GetNextPCInArea(oArea);
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
    object plank = GetObjectByTag(newTag);
    if(plank == OBJECT_INVALID) {
        plank = CreateObject(OBJECT_TYPE_PLACEABLE, plankRes,
                             plankLocation, FALSE, newTag);
        SetVisibleToAllPCsInArea(plank);
        DestroyObject(GetObjectByTag(blockerTag));
    }
}

void ShipInboundCreate(string shipStr, string waypntTag, vector position,
                       float facing, string shipRes, string createTime) {
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
        SetLocalInt(oArea, createTime, NWNX_Time_GetTimeStamp());
        SetVisibleToAllPCsInArea(oShip);
        PlayAnimation(ANIMATION_PLACEABLE_ACTIVATE);
        AssignCommand(oShip, PlayAnimation(ANIMATION_PLACEABLE_DEACTIVATE));
    }
}

void ShipOutboundCreate(string shipStr, string waypntTag, vector position,
                        float shipFacing, string shipRes, vector plankVector,
                        float plankFacing, string plankTag, string blockerTag,
                        string plankRes, string createTime) {
    int time = NWNX_Time_GetTimeStamp();
    object oShip = GetNearestObjectByTag(shipStr, OBJECT_SELF);

    if(oShip == OBJECT_INVALID) {
        object oBlockerWP = GetObjectByTag(waypntTag);
        object oArea = GetArea(oBlockerWP);
        oShip = CreateObject(OBJECT_TYPE_PLACEABLE,
                         shipRes,
                         Location(oArea,
                                  Vector(position.x, position.y, position.z),
                                  shipFacing),
                         FALSE,
                         shipStr);
        SetLocalInt(oArea, createTime, NWNX_Time_GetTimeStamp());
        SetVisibleToAllPCsInArea(oShip);
        PlayAnimation(ANIMATION_PLACEABLE_ACTIVATE);
        AssignCommand(oShip, PlayAnimation(ANIMATION_PLACEABLE_ACTIVATE));

        DockShip(oBlockerWP,
                 GangPlankLocation(oBlockerWP, plankVector, plankFacing),
                 plankTag, blockerTag, plankRes);
    }
}

int GetPlayerOnShip(string triggerTag) {
    object oShipTrigger = GetObjectByTag(triggerTag);
    object oArea = GetArea(oShipTrigger);
    object oPC = GetFirstPCInArea(oArea);

    // If its a dm and not dm possessing let the ship leave.
    if(GetIsDM(oPC) == TRUE && GetIsDMPossessed(oPC) == FALSE) {
        return FALSE;
    }

    while(oPC != OBJECT_INVALID) {
        if(NWNX_Object_GetPositionIsInTrigger(oShipTrigger, GetPosition(oPC))) {
            return TRUE;
        }
        oPC = GetNextPCInArea(oArea);
    }
    return FALSE;
}

void ShipOutActivate(string shipTag, string waypntTag, string plankTag,
                     string blockerTag, string blockerRes, string triggerTag,
                     string destroyTime) {
    object oShip = GetObjectByTag(shipTag);
    // if a player is on the ship or its already leaving abort.
    if(GetPlayerOnShip(triggerTag) || GetLocalInt(oShip, "leaving") != 0) {
        return;
    }

    float delay = 135.0;
    object oBlockerWP = GetObjectByTag(waypntTag);
    object oPlank = GetObjectByTag(plankTag);

    AssignCommand(oShip, PlayAnimation(ANIMATION_PLACEABLE_DEACTIVATE));
    SetLocalInt(oShip, "leaving", 1);
    DestroyObject(oPlank);

    object blocker = GetObjectByTag(blockerTag);
    if(blocker == OBJECT_INVALID) {
        CreateObject(OBJECT_TYPE_PLACEABLE, blockerRes, GetLocation(oBlockerWP),
                     FALSE, blockerTag);
    }

    DelayCommand(delay, DestroyObject(oShip));
    SetLocalInt(GetArea(oShip), destroyTime, NWNX_Time_GetTimeStamp());
}

void ShipActivate(string shipTag, string waypntTag, string plankTag,
                  string blockerTag, vector plankVector, float faceing,
                  string plankRes) {
    object oShip = GetObjectByTag(shipTag);

    if(GetLocalInt(oShip, "arriving") != 0) {
        return;
    }
    float delay = 125.0;
    object oBlockerWP = GetObjectByTag(waypntTag);
    AssignCommand(oShip, PlayAnimation(ANIMATION_PLACEABLE_ACTIVATE));
    SetLocalInt(oShip, "arriving", 1);
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
                 string blockerRes, string plankTag, string destroyTime) {
    object oShip = GetObjectByTag(shipStr);
    object oPlank = GetObjectByTag(plankTag);
    if(oShip != OBJECT_INVALID) {
        DestroyObject(oShip);
        DestroyObject(oPlank);
        SetLocalInt(GetArea(oShip), destroyTime, NWNX_Time_GetTimeStamp());
    }

    object blockerWP = GetObjectByTag(waypntStr);
    object blocker = GetObjectByTag(blockerTag);
    if(blocker == OBJECT_INVALID) {
        CreateObject(OBJECT_TYPE_PLACEABLE, blockerRes, GetLocation(blockerWP),
                     FALSE, blockerTag);
    }
}
