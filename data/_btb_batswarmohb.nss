#include "_btb_util"

void main()
{
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
