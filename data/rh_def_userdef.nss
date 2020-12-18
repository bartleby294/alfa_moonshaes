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

    switch(nEvent)
    {
        case 2000:  //Send the NPC to its waypoints.
            HourWayPoints(FALSE, 0.0, FALSE);
            break;
    }
}
