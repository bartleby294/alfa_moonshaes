#include "spawn_main"
#include "_btb_ship_const"
#include "_btb_corwellship"
#include "nwnx_visibility"
#include "nwnx_area"

void TriggerOutboundShipsCheck() {
    object oArea = GetArea(OBJECT_SELF);
    int curTime = NWNX_Time_GetTimeStamp();
    int caravelCreateTime = GetLocalInt(oArea, CARAVEL_OUTBOUND_CREATED_TIME);
    int cityShipCreateTime = GetLocalInt(oArea,
                                         CITY_SHIP_OUTBOUND_CREATED_TIME);

    int caravelRandomChance = Random(DEFAULT_SHIP_WAIT_TIME)
                              +  curTime - caravelCreateTime;
    if(caravelRandomChance > WAIT_TIME_THRESHOLD) {
        // Outbound Caravel Departure
        //WriteTimestampedLogEntry("Ship Activity: |V49| - Gwynneth: City of"
        //                          + " Corwell: Outbound Caravel Departure - "
        //                          + IntToString(curTime));
        ShipOutActivate(CARAVEL_OUTBOUND_TAG,
                        CARAVEL_OUTBOUND_WAYPOINT_TAG,
                        CARAVEL_OUTBOUND_PLANK_TAG,
                        CARAVEL_OUTBOUND_BLOCKER_TAG,
                        CARAVEL_OUTBOUND_BLOCKER_RES,
                        CARAVEL_OUTBOUND_TRIGGER_TAG,
                        CARAVEL_OUTBOUND_DESTROYED_TIME);

    }

    int cityShipRandomChance = Random(DEFAULT_SHIP_WAIT_TIME)
                              +  curTime - cityShipCreateTime;
    if(cityShipRandomChance > WAIT_TIME_THRESHOLD) {
        // Outbound City Ship Departure
        //WriteTimestampedLogEntry("Ship Activity: |V49| - Gwynneth: City of"
        //                          + " Corwell: Outbound City Ship Departure - "
        //                         + IntToString(curTime));
        ShipOutActivate(CITY_SHIP_OUTBOUND_TAG,
                        CITY_SHIP_OUTBOUND_WAYPOINT_TAG,
                        CITY_SHIP_OUTBOUND_PLANK_TAG,
                        CITY_SHIP_OUTBOUND_BLOCKER_TAG,
                        CITY_SHIP_OUTBOUND_BLOCKER_RES,
                        CITY_SHIP_OUTBOUND_TRIGGER_TAG,
                        CITY_SHIP_OUTBOUND_DESTROYED_TIME);
    }
}

void TriggerInboundShipsCheck() {
    object oArea = GetArea(OBJECT_SELF);
    int curTime = NWNX_Time_GetTimeStamp();
    int caravelDestroyedTime = GetLocalInt(oArea,
                                           CARAVEL_INBOUND_DESTROYED_TIME);
    int cityShipDestroyedTime = GetLocalInt(oArea,
                                            CITY_SHIP_INBOUND_DESTROYED_TIME);

    int caravelRandomChance = Random(DEFAULT_SHIP_WAIT_TIME)
                              +  curTime - caravelDestroyedTime;
    if(caravelRandomChance > WAIT_TIME_THRESHOLD) {
        if(caravelDestroyedTime == 0) {
            SetLocalInt(oArea, CARAVEL_INBOUND_DESTROYED_TIME, curTime);
        }
        // If Caravel exists abort.
        if(GetObjectByTag(CARAVEL_INBOUND_TAG) != OBJECT_INVALID) {
            return;
        }
        // Inbound Caravel Arrival
        //WriteTimestampedLogEntry("Ship Activity: |V49| - Gwynneth: City of"
        //                          + " Corwell: Inbound Caravel Arrival - "
        //                          + IntToString(curTime));
        ShipInboundCreate(CARAVEL_INBOUND_TAG, CARAVEL_INBOUND_WAYPOINT_TAG,
                      Vector(85.4, 145.0, 0.0), 90.0, CARAVEL_INBOUND_RES,
                      CARAVEL_INBOUND_CREATED_TIME);
        float randFloat = Random(100) * 1.0;
        DelayCommand(randFloat, ShipActivate(CARAVEL_INBOUND_TAG,
                                             CARAVEL_INBOUND_WAYPOINT_TAG,
                                             CARAVEL_INBOUND_PLANK_TAG,
                                             CARAVEL_INBOUND_BLOCKER_TAG,
                                             Vector(0.0, 4.5, 0.0), 90.0,
                                             CARAVEL_INBOUND_PLANK_RES));
    }

    int cityShipRandomChance = Random(DEFAULT_SHIP_WAIT_TIME)
                              +  curTime - cityShipDestroyedTime;
    if(cityShipRandomChance > WAIT_TIME_THRESHOLD) {
        if(cityShipDestroyedTime == 0) {
            SetLocalInt(oArea, CITY_SHIP_INBOUND_DESTROYED_TIME, curTime);
        }
        // If City Ship exists abort.
        if(GetObjectByTag(CITY_SHIP_INBOUND_TAG) != OBJECT_INVALID) {
            return;
        }
        // Inbound City Ship Arrival
        //WriteTimestampedLogEntry("Ship Activity: |V49| - Gwynneth: City of"
        //                          + " Corwell: Inbound City Ship Arrival - "
        //                          + IntToString(curTime));
        ShipInboundCreate(CITY_SHIP_INBOUND_TAG, CITY_SHIP_INBOUND_WAYPOINT_TAG,
                          Vector(85.0, 175.0, 0.0), 90.0, CITY_SHIP_INBOUND_RES,
                          CITY_SHIP_INBOUND_CREATED_TIME);
        float randFloat = Random(100) * 1.0;
        DelayCommand(randFloat, ShipActivate(CITY_SHIP_INBOUND_TAG,
                                             CITY_SHIP_INBOUND_WAYPOINT_TAG,
                                             CITY_SHIP_INBOUND_PLANK_TAG,
                                             CITY_SHIP_INBOUND_BLOCKER_TAG,
                                             Vector(0.3, 3.13, 0.0), 180.0,
                                             CITY_SHIP_INBOUND_PLANK_RES));
    }
}

void TriggerPlankCheck(string shipStr, string waypntTag, vector plankVector,
                       float plankFacing, string plankTag, string blockerTag,
                       string plankRes, string createTime) {
    if(GetObjectByTag(plankTag) != OBJECT_INVALID) {
        // if ship exists and current time is > 100 seconds plank should exist.
        // if plank does not exist create it.
        if(GetObjectByTag(shipStr) != OBJECT_INVALID
           && GetLocalInt(OBJECT_SELF, createTime) + 100
              < NWNX_Time_GetTimeStamp()) {
            object oBlockerWP = GetObjectByTag(waypntTag);
            DockShip(oBlockerWP,
                     GangPlankLocation(oBlockerWP, plankVector, plankFacing),
                     plankTag, blockerTag, plankRes);
        }
    }
}

void main()
{
    object oArea = GetArea(OBJECT_SELF);
    //SendMessageToAllDMs("SpawnHB in area: " + GetName(OBJECT_SELF));
    Spawn();

    if(GetLocalInt(oArea, DM_SHIP_OVERRIDE) == FALSE) {
        int timeCheckCnt = GetLocalInt(oArea, "timeCheckCnt");
        if(timeCheckCnt > 10) {
            TriggerOutboundShipsCheck();
            TriggerInboundShipsCheck();

            TriggerPlankCheck(CITY_SHIP_INBOUND_TAG,
                              CITY_SHIP_INBOUND_WAYPOINT_TAG,
                              Vector(0.3, 3.13, 0.0), 180.0,
                              CITY_SHIP_INBOUND_PLANK_TAG,
                              CITY_SHIP_INBOUND_BLOCKER_TAG,
                              CITY_SHIP_INBOUND_PLANK_RES,
                              CITY_SHIP_INBOUND_CREATED_TIME);

            TriggerPlankCheck(CARAVEL_INBOUND_TAG,
                              CARAVEL_INBOUND_WAYPOINT_TAG,
                              Vector(0.0, 4.5, 0.0), 90.0,
                              CARAVEL_INBOUND_PLANK_TAG,
                              CARAVEL_INBOUND_BLOCKER_TAG,
                              CARAVEL_INBOUND_PLANK_RES,
                              CARAVEL_INBOUND_CREATED_TIME);

            TriggerPlankCheck(CITY_SHIP_OUTBOUND_TAG,
                              CITY_SHIP_OUTBOUND_WAYPOINT_TAG,
                              Vector(-0.3, -3.13, 0.0), 180.0,
                              CITY_SHIP_OUTBOUND_PLANK_TAG,
                              CITY_SHIP_OUTBOUND_BLOCKER_TAG,
                              CITY_SHIP_OUTBOUND_PLANK_RES,
                              CITY_SHIP_OUTBOUND_CREATED_TIME);

            TriggerPlankCheck(CARAVEL_OUTBOUND_TAG,
                              CARAVEL_OUTBOUND_WAYPOINT_TAG,
                              Vector(0.0, -4.5, 0.0), 90.0,
                              CARAVEL_OUTBOUND_PLANK_TAG,
                              CARAVEL_OUTBOUND_BLOCKER_TAG,
                              CARAVEL_OUTBOUND_PLANK_RES,
                              CARAVEL_OUTBOUND_CREATED_TIME);

            SetLocalInt(oArea, "timeCheckCnt", 0);
        } else {
            SetLocalInt(oArea, "timeCheckCnt", timeCheckCnt + 1);
        }
    }
}

