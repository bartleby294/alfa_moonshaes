#include "_btb_util"

void createBat(location oItemLoc) {
    object bat = CreateObject(OBJECT_TYPE_CREATURE, "_btb_bat_swarm1",
                                  oItemLoc, TRUE);
        AssignCommand(bat, ActionMoveAwayFromLocation(oItemLoc, TRUE, 1000.0));
        SetLocalLocation(bat, "center", oItemLoc);
}

void batScatter(object oArea, location oItemLoc) {
    int batNum = 0;
    while(batNum < 20) {
        createBat(oItemLoc);
        batNum++;
    }
    float batFloat = 0.0;
    while(batFloat < 7.0) {
        DelayCommand(batFloat, createBat(oItemLoc));
        DelayCommand(batFloat, createBat(oItemLoc));
        DelayCommand(batFloat, createBat(oItemLoc));
        DelayCommand(batFloat, createBat(oItemLoc));
        DelayCommand(batFloat, createBat(oItemLoc));
        DelayCommand(batFloat, createBat(oItemLoc));
        batFloat = batFloat + 1.0;
    }
}

void main()
{
    object oPC = GetItemActivator();
    object oArea = GetArea(oPC);
    object oItem = GetItemActivated();
    location oItemLoc = GetItemActivatedTargetLocation();
    batScatter(oArea, oItemLoc);
}
