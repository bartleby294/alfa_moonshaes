#include "_btb_util"

void batScatter2(object oArea, location oItemLoc) {
    int batNum = 0;
    while(batNum < 20) {
        object bat = CreateObject(OBJECT_TYPE_CREATURE, "_btb_bat_swarm1",
                                  oItemLoc, TRUE);
        location nextWP = getNextWaypoint(oArea, oItemLoc, 70, OBJECT_SELF, 90.0);
        AssignCommand(bat, ActionMoveToLocation(nextWP, TRUE));
        SetLocalLocation(bat, "center", oItemLoc);
        batNum++;
    }
}

void batScatter(object oArea, location oItemLoc) {
    int batNum = 0;
    while(batNum < 20) {
        object bat = CreateObject(OBJECT_TYPE_CREATURE, "_btb_bat_swarm1",
                                  oItemLoc, TRUE);
        AssignCommand(bat, ActionMoveAwayFromLocation(oItemLoc, TRUE, 1000.0));
        SetLocalLocation(bat, "center", oItemLoc);
        batNum++;
    }
}

// OLD SWARM ITS STILL TOO SLOW
void batCircle(object oArea, location oItemLoc) {
    int batNum = 0;
    while(batNum < 20) {
        object bat = CreateObject(OBJECT_TYPE_CREATURE, "_btb_bat_swarm1",
                                  oItemLoc, TRUE);
        float delay = 0.0;
        while(delay < 6.0) {
            location nextWP = getNextWaypoint(oArea, oItemLoc, 7, OBJECT_SELF, 120.0);
            DelayCommand(0.1, AssignCommand(OBJECT_SELF, ActionMoveToLocation(nextWP, TRUE)));
            delay = delay + 0.1;
        }
        SetLocalLocation(bat, "center", oItemLoc);
        batNum++;
    }
}

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

    batScatter(oArea, oItemLoc);
    //batCircle(oArea, oItemLoc);

}
