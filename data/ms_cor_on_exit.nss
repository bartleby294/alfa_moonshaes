#include "_btb_util"
#include "_btb_ship_const"
#include "_btb_corwellship"
#include "nwnx_visibility"
#include "nwnx_area"
#include "ms_corking_wagco"

void DestoryInboundShipsCheck() {
    object oArea = GetArea(OBJECT_SELF);
    int curTime = NWNX_Time_GetTimeStamp();
    int caravelCreateTime = GetLocalInt(oArea, CARAVEL_INBOUND_CREATED_TIME);
    int cityShipCreateTime = GetLocalInt(oArea, CITY_SHIP_INBOUND_CREATED_TIME);
    int caravelRandomChance = Random(DEFAULT_SHIP_WAIT_TIME)
                              +  curTime - caravelCreateTime;
    if(GetObjectByTag(CARAVEL_INBOUND_TAG) != OBJECT_INVALID
       && caravelRandomChance > WAIT_TIME_THRESHOLD) {
        // Destroy Inbound Caravel
        //WriteTimestampedLogEntry("Ship Activity: |V49| - Gwynneth: City of"
        //                          + " Corwell: Inbound Caravel Destroy - "
        //                          + IntToString(curTime));
        ShipDestroy(CARAVEL_INBOUND_TAG, CARAVEL_INBOUND_WAYPOINT_TAG,
                CARAVEL_INBOUND_BLOCKER_TAG, CARAVEL_INBOUND_BLOCKER_RES,
                CARAVEL_INBOUND_PLANK_TAG, CARAVEL_INBOUND_DESTROYED_TIME);
    }

    int cityShipRandomChance = Random(DEFAULT_SHIP_WAIT_TIME)
                              +  curTime - cityShipCreateTime;
    if(GetObjectByTag(CITY_SHIP_INBOUND_TAG) != OBJECT_INVALID &&
       cityShipRandomChance > WAIT_TIME_THRESHOLD) {
        // Destroy Inbound City Ship
        //WriteTimestampedLogEntry("Ship Activity: |V49| - Gwynneth: City of"
        //                          + " Corwell: Inbound City Ship Destroy - "
        //                          + IntToString(curTime));
        ShipDestroy(CITY_SHIP_INBOUND_TAG,
            CITY_SHIP_INBOUND_WAYPOINT_TAG,
            CITY_SHIP_INBOUND_BLOCKER_TAG,
            CITY_SHIP_INBOUND_BLOCKER_RES,
            CITY_SHIP_INBOUND_PLANK_TAG,
            CITY_SHIP_INBOUND_DESTROYED_TIME);
    }
}

void CreateOutboundShipsCheck() {
    object oArea = GetArea(OBJECT_SELF);
    int curTime = NWNX_Time_GetTimeStamp();
    int caravelDestroyTime = GetLocalInt(oArea,
                                         CITY_SHIP_OUTBOUND_DESTROYED_TIME);
    int cityShipDestroyTime = GetLocalInt(oArea,
                                          CARAVEL_OUTBOUND_DESTROYED_TIME);

    int caravelRandomChance = Random(DEFAULT_SHIP_WAIT_TIME)
                              +  curTime - caravelDestroyTime;
    if(GetObjectByTag(CARAVEL_OUTBOUND_TAG) == OBJECT_INVALID
       && caravelRandomChance > WAIT_TIME_THRESHOLD) {
        // Create Outbound Caravel
        //WriteTimestampedLogEntry("Ship Activity: |V49| - Gwynneth: City of"
        //                          + " Corwell: Outbound Caravel Create - "
        //                          + IntToString(curTime));
        ShipOutboundCreate(CARAVEL_OUTBOUND_TAG,
                           CARAVEL_OUTBOUND_WAYPOINT_TAG,
                           Vector(75.0, 125.0, 0.0), 270.0,
                           CARAVEL_OUTBOUND_RES,
                           Vector(0.0, -4.5, 0.0), 90.0,
                           CARAVEL_OUTBOUND_PLANK_TAG,
                           CARAVEL_OUTBOUND_BLOCKER_TAG,
                           CARAVEL_OUTBOUND_PLANK_RES,
                           CARAVEL_OUTBOUND_CREATED_TIME);

    }

    int cityShipRandomChance = Random(DEFAULT_SHIP_WAIT_TIME)
                              +  curTime - cityShipDestroyTime;
    if(GetObjectByTag(CITY_SHIP_OUTBOUND_TAG) == OBJECT_INVALID
       && cityShipRandomChance > WAIT_TIME_THRESHOLD) {
        // Create Outbound City Ship
        //WriteTimestampedLogEntry("Ship Activity: |V49| - Gwynneth: City of"
        //                          + " Corwell: Outbound City Ship Create - "
        //                          + IntToString(curTime));
        ShipOutboundCreate(CITY_SHIP_OUTBOUND_TAG,
                           CITY_SHIP_OUTBOUND_WAYPOINT_TAG,
                           Vector(95.0, 155.0, 0.0), 270.0,
                           CITY_SHIP_OUTBOUND_RES,
                           Vector(-0.3, -3.13, 0.0), 180.0,
                           CITY_SHIP_OUTBOUND_PLANK_TAG,
                           CITY_SHIP_OUTBOUND_BLOCKER_TAG,
                           CITY_SHIP_OUTBOUND_PLANK_RES,
                           CITY_SHIP_OUTBOUND_CREATED_TIME);
    }
}

void ShutOffHeartbeat() {
    // If the area is still empty shut down heartbeat.
    if(GetFirstPCInArea(GetArea(OBJECT_SELF)) == OBJECT_INVALID) {
        //cleanup stuff on ground
        ExecuteScript("areacleanup");
        //Set the heartbeat script to blank, turning it off
        SetEventScript(OBJECT_SELF, EVENT_SCRIPT_AREA_ON_HEARTBEAT, "");
    }
    return;
}

void main()
{
    object oPC = GetExitingObject();

    object slipperyEel = GetObjectByTag("v49_slippery_eel_building");
    NWNX_Visibility_SetVisibilityOverride(oPC, slipperyEel,
                                          NWNX_VISIBILITY_DEFAULT);

    // WE NEED vg_area_enter BEFORE WE TURN THIS BACK ON!
    //remove them from being underwater
    //if(GetLocalInt(oPC, "UNDERWATER") == TRUE){
    //    ExecuteScript("vg_area_ext");
    //    SendMessageToPC(oPC, "AreaExit Detected you are underwater and is removing you from the water.");
    //}

    // If no one is left in the area flag shutting down the hb scripts in 9 mins
    if(GetFirstPCInArea(GetArea(OBJECT_SELF)) == OBJECT_INVALID) {
        DelayCommand(540.00, ShutOffHeartbeat());

        if(GetLocalInt(GetArea(OBJECT_SELF), DM_SHIP_OVERRIDE) == FALSE) {
            // Check if any inbound ships should be destroyed.  The only time
            // inbound ships can be seemlessly removed is on area enter as they
            // must be jarringly destroyed.  They cant "leave port".
            DestoryInboundShipsCheck();

            // Check if any outbound ships should be created.  The only time
            // outbound ships can be seemlessly created is on area enter as they
            // must be created from thin air.
            CreateOutboundShipsCheck();
        }

        // If no one is left in the area de spawn the trade wagon.
        object wagon = GetObjectByTag("mstradewagon1");
        if(wagon != OBJECT_INVALID
           && GetLocalInt(wagon, WAGON_ESCORT_STATE) != WAGON_STATE_IN_PROGRESS) {
            DestroyObject(wagon);
        }
    }

    return;
}
