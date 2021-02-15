#include "_btb_ship_const"

void main()
{
    object oArea = GetArea(GetObjectByTag(CARAVEL_INBOUND_WAYPOINT_TAG));
    SetLocalInt(oArea, DM_SHIP_OVERRIDE, 0);
}
