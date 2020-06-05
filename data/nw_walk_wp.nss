/*******************************************************************************
Script:     Default End of Conversation script for Hour-based Waypoints
Filename:   nw_walk_wp
Modifier:   Thomas J. Hamman (Rhone)

This change was made from the original nw_walk_wp:

*   Signal event 2000 to resume waypoints instead of WalkWayPoints.
*******************************************************************************/

void main()
{
    SignalEvent(OBJECT_SELF, EventUserDefined(2000));
}
