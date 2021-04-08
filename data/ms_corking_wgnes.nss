#include "ms_aat_utility"
#include "nwnx_data"

const string AREA_WPS = "area_waypoints";

/**
 *  This will get the first waypoint cardinally not in the area and then add
 *  One to that.  We do this to jump to the first waypoint that the pedestrian
 *  should walk to while being able to still keep a single trail of waypoints.
 *
 *  This is what allows for bidirectional travel on the same line.
 */

int GetNextAreaWPTarget(int curWPInt) {

    string baseWpStr = "corwell_to_kingsbay_wp_";

    int firstOutOfAreaWP = curWPInt;
    int curWPIntInArea = FALSE;
    WriteTimestampedLogEntry("firstOutOfAreaWP: " + IntToString(firstOutOfAreaWP));
    string waypointStr = baseWpStr + IntToString(firstOutOfAreaWP);
    object areaWP = GetNearestObjectByTag(waypointStr, OBJECT_SELF);

    while (areaWP != OBJECT_INVALID) {
            firstOutOfAreaWP++;
            curWPIntInArea = TRUE;
            WriteTimestampedLogEntry("firstOutOfAreaWP: " + IntToString(firstOutOfAreaWP));
            waypointStr = baseWpStr + IntToString(firstOutOfAreaWP);
            areaWP = GetNearestObjectByTag(waypointStr, OBJECT_SELF);
    }

    WriteTimestampedLogEntry("returned firstOutOfAreaWP: " + IntToString(firstOutOfAreaWP + 1));

    /* Don't increment if the waypoint is already out of the area. */
    if(curWPIntInArea) {
        return firstOutOfAreaWP + 1;
    }

    return firstOutOfAreaWP;
}

void main()
{
    object enterObj = GetEnteringObject();
    if(GetTag(enterObj) != "mstradewagon1") {
        //WriteTimestampedLogEntry("not a tradewagon");
        return;
    }

    SetLocalInt(enterObj, "waggonStopped", TRUE);

    object oArea = GetArea(enterObj);
    int x = GetAreaTransitionX(enterObj);
    int y = GetAreaTransitionY(enterObj);

    object newArea = GetAreaAtCoordinates(oArea, x, y);

    vector curPosition = GetPosition(enterObj);
    float newX = curPosition.y;
    float newY = curPosition.y;

    if(x > 0) {
        newX = 6.0;
    } else if (x < 0) {
        newX = 314.0;
    }

    if(y > 0) {
        newY = 314.0;
    } else if (y < 0) {
        newY = 6.0;
    }

    location newLoc = Location(newArea, Vector(newX, newY, 0.0), 0.0);
    float newZ = GetGroundHeight(newLoc);
    newLoc = Location(newArea, Vector(newX, newY, newZ), 0.0);
    WriteTimestampedLogEntry("Sending To: " + GetTag(newArea));
    WriteTimestampedLogEntry("Sending To: (" + FloatToString(newX) + ", "
                             + FloatToString(newY) + ", "
                             + FloatToString(newZ));
    WriteTimestampedLogEntry("curWPInt pre update: "
                             + IntToString(GetLocalInt(enterObj, "curWP")));
    int curWPInt = GetLocalInt(enterObj, "curWP");
    int nextWP = GetNextAreaWPTarget(curWPInt);
    SetLocalInt(enterObj, "curWP", nextWP);
    WriteTimestampedLogEntry("curWPInt post update: "
                             + IntToString(GetLocalInt(enterObj, "curWP")));
    AssignCommand(enterObj, ClearAllActions(TRUE));
    AssignCommand(enterObj, ActionJumpToLocation(newLoc));
    DelayCommand(2.0, SetLocalInt(enterObj, "waggonStopped", FALSE));
}
