#include "_btb_corwellship"

void main()
{
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
