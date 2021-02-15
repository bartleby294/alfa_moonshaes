#include "_btb_corwellship"

void main()
{
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
