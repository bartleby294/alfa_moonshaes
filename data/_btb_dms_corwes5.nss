#include "_btb_corwellship"

void main()
{
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
