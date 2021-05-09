#include "_btb_util"

void createBat2(location oItemLoc) {
    object bat = CreateObject(OBJECT_TYPE_CREATURE, "_btb_bat_swarm1",
                                  oItemLoc, TRUE);
        AssignCommand(bat, ActionMoveAwayFromLocation(oItemLoc, TRUE, 1000.0));
        SetLocalLocation(bat, "center", oItemLoc);
}

void batScatter2(object oArea, location oItemLoc) {
    createBat2(oItemLoc);
}

void main()
{
    object oPC = GetItemActivator();
    object oArea = GetArea(oPC);
    object oItem = GetItemActivated();
    location oItemLoc = GetItemActivatedTargetLocation();
    batScatter2(oArea, oItemLoc);
}
