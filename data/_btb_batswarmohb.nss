#include "_btb_util"
#include "x0_i0_position"

void mainOLD()
{
   //return;

    int hbCount = GetLocalInt(OBJECT_SELF, "hbCount");
    if(hbCount > 4) {
        DestroyObject(OBJECT_SELF);
    } else {
        object oArea = GetArea(OBJECT_SELF);
        location center = GetLocalLocation(OBJECT_SELF, "center");
        float delay = 0.0;
        while(delay < 6.0) {
            location nextWP = getNextWaypoint(oArea, center, 7, OBJECT_SELF, 120.0);
            DelayCommand(0.1, AssignCommand(OBJECT_SELF, ActionMoveToLocation(nextWP, TRUE)));
            delay = delay + 0.1;
        }
        SetLocalInt(OBJECT_SELF, "hbCount", hbCount + 1);
    }
}

void main32()
{
    int hbCount = GetLocalInt(OBJECT_SELF, "hbCount");
    if(hbCount > 3) {
        DestroyObject(OBJECT_SELF);
    } else {




        object oArea = GetArea(OBJECT_SELF);
        location center = GetLocalLocation(OBJECT_SELF, "center");
        location nextWP = getNextWaypoint(oArea, center, (hbCount + 1) * 70, OBJECT_SELF, 90.0);
        AssignCommand(OBJECT_SELF, ActionMoveToLocation(nextWP, TRUE));
        SetLocalInt(OBJECT_SELF, "hbCount", hbCount + 1);
    }
}


void main()
{
    int hbCount = GetLocalInt(OBJECT_SELF, "hbCount");
    if(hbCount > 3) {
        DestroyObject(OBJECT_SELF);
    } else {

        object oArea = GetArea(OBJECT_SELF);
        float facing = GetFacing(OBJECT_SELF);
        location center = GetLocalLocation(OBJECT_SELF, "center");
        location curLoc = GetLocation(OBJECT_SELF);
        vector curPos = GetPosition(OBJECT_SELF);

        if(GetDistanceBetweenLocations(center, curLoc) < 15.0) {
            facing = facing - 180;
        }

        SetLocalLocation(OBJECT_SELF, "center", curLoc);
        vector newVec = GetChangedPosition(curPos, 100.0, facing);
        location newLoc = Location(oArea, newVec, facing);
        AssignCommand(OBJECT_SELF, ActionMoveToLocation(newLoc, TRUE));
        SetLocalInt(OBJECT_SELF, "hbCount", hbCount + 1);
    }
}
