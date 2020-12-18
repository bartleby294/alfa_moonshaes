#include "NW_I0_GENERIC"
//#include "nw_c3_waypoint1"

void main()
{
    object entered = GetEnteringObject();
    object WP = GetObjectByTag("WP__BatGroup_1_01");

    if(GetTag(entered) == "_BatGroup_1")
    {
       AssignCommand(entered, WalkWayPoints(FALSE, 0.0));
       AssignCommand(entered, ActionMoveToObject(WP, FALSE, 0.0));

    }


}
