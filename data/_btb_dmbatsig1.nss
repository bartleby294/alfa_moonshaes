#include "_btb_util"

void main()
{
    object oPC = GetItemActivator();
    object oArea = GetArea(oPC);
    object oItem = GetItemActivated();
    location oItemLoc = GetItemActivatedTargetLocation();
    //location oPCLoc = GetLocation(oPC);
    //float oPCfacing = GetFacingFromLocation(oPCLoc);
    //vector oItemVec = GetPositionFromLocation(oItemLoc);
    //location oItemLocFinal = Location(oArea, oItemVec, oPCfacing);

    int batNum = 0;
    while(batNum < 20) {
        object bat = CreateObject(OBJECT_TYPE_CREATURE, "_btb_bat_swarm1",
                                  oItemLoc, TRUE);
        float delay = 0.0;
        while(delay < 6.0) {
            location nextWP = getNextWaypoint(oArea, oItemLoc, 7, OBJECT_SELF);
            DelayCommand(0.1, AssignCommand(OBJECT_SELF, ActionMoveToLocation(nextWP, TRUE)));
            delay = delay + 0.1;
        }
        SetLocalLocation(bat, "center", oItemLoc);
        batNum++;
    }
}
