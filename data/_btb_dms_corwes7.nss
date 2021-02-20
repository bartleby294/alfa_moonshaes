#include "_btb_corwellship"

void main()
{
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
