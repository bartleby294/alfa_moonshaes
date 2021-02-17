#include "_btb_util"

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


void main()
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
