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
    int caravelDestroyedTime = GetLocalInt(oArea, CARAVEL_INBOUND_DESTROYED_TIME);
    int cityShipDestroyedTime = GetLocalInt(oArea,
                                            CITY_SHIP_INBOUND_DESTROYED_TIME);

    int caravelRandomChance = Random(DEFAULT_SHIP_WAIT_TIME)
                              +  curTime - caravelDestroyedTime;
    if(caravelRandomChance > WAIT_TIME_THRESHOLD) {
        // Inbound Caravel Arrival
        ShipInboundCreate(CARAVEL_INBOUND_TAG, CARAVEL_INBOUND_WAYPOINT_TAG,
                      Vector(85.4, 145.0, 0.0), 90.0, CARAVEL_INBOUND_RES,
                      CARAVEL_INBOUND_CREATED_TIME);

        DelayCommand(1.0, ShipActivate(CARAVEL_INBOUND_TAG,
                                       CARAVEL_INBOUND_WAYPOINT_TAG,
                                       CARAVEL_INBOUND_PLANK_TAG,
                                       CARAVEL_INBOUND_BLOCKER_TAG,
                                       Vector(0.0, 4.5, 0.0), 90.0,
                                       CARAVEL_INBOUND_PLANK_RES));
    }

    int cityShipRandomChance = Random(DEFAULT_SHIP_WAIT_TIME)
                              +  curTime - cityShipDestroyedTime;
    if(cityShipRandomChance > WAIT_TIME_THRESHOLD) {
        // Inbound City Ship Arrival
        ShipInboundCreate(CITY_SHIP_INBOUND_TAG, CITY_SHIP_INBOUND_WAYPOINT_TAG,
                          Vector(85.0, 175.0, 0.0), 90.0, CITY_SHIP_INBOUND_RES,
                          CITY_SHIP_INBOUND_CREATED_TIME);

        DelayCommand(1.0, ShipActivate(CITY_SHIP_INBOUND_TAG,
                                       CITY_SHIP_INBOUND_WAYPOINT_TAG,
                                       CITY_SHIP_INBOUND_PLANK_TAG,
                                       CITY_SHIP_INBOUND_BLOCKER_TAG,
                                       Vector(0.3, 3.13, 0.0), 180.0,
                                       CITY_SHIP_INBOUND_PLANK_RES));
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
        } else {
            SetLocalInt(oArea, "timeCheckCnt", timeCheckCnt + 1);
        }
    }
}

