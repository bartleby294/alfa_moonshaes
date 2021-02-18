#include "_btb_util"

void batScatter(object oArea, location oItemLoc) {
    int batNum = 0;
    while(batNum < 40) {
        object bat = CreateObject(OBJECT_TYPE_CREATURE, "_btb_bat_swarm1",
                                  oItemLoc, TRUE);
        AssignCommand(bat, ActionMoveAwayFromLocation(oItemLoc, TRUE, 1000.0));
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


    //as_an_bat1
    //as_an_bat2
    //as_an_bat3
    //as_an_batflap1
    //as_an_batflap2
    //as_an_bats1
    //as_an_bat2
    //as_an_batsflap1
    //as_an_batsflap2
    object sound1 = CreateObject(OBJECT_TYPE_PLACEABLE, "invisbatsound", oItemLoc);
    AssignCommand(sound1, PlaySound("as_an_bat1"));
    AssignCommand(sound1, PlaySound("as_an_batflap1"));
    AssignCommand(sound1, PlaySound("as_an_batsflap2"));

    batScatter(oArea, oItemLoc);
}
