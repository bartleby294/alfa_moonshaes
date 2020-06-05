/*******************************************************************************
Script:     Default OnUserDefined for NPCs using Hour-based Waypoints
Filename:   rh_def_userdef
Author:     Thomas J. Hamman (Rhone)

This is a default OnUserDefined script for NPCs which gives them event 2000 for
running HourWayPoints.  To give an NPC other OnUserDefined events, add case
statements for the events in this script, save it under a new name, and change
the NPC's OnUserDefined to the new script.
*******************************************************************************/

#include "RH_INC_HRWPOINTS"

void main()
{
    int nEvent = GetUserDefinedEventNumber();
    object oChair;

    switch(nEvent)
    {
        case 2000:  //Send the NPC to its waypoints.
            HourWayPoints(FALSE, 0.0, FALSE);
            break;

        case 91300:
            oChair = GetNearestObjectByTag("Chair");
            ActionSit(oChair);
            break;

        case 91400:
            ActionPlayAnimation(ANIMATION_LOOPING_DEAD_FRONT,1.0,10.0);
            ActionPlayAnimation(ANIMATION_LOOPING_DEAD_FRONT,1.0,10.0);
            ActionPlayAnimation(ANIMATION_LOOPING_CONJURE1,1.0,10.0);
            break;
    }
}
