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

void batSound(object oArea, location oItemLoc) {
    int num = 0;
    while(num < 5) {
        string randomSound = IntToString(Random(9) + 1);
        object oSound = CreateObject(OBJECT_TYPE_PLACEABLE,
                                    "batswarm" + randomSound, oItemLoc);
        SoundObjectPlay(oSound);
        DestroyObject(oSound, 7.0 - num);
        num++;
    }
}

void main()
{
    object oPC = GetItemActivator();
    object oArea = GetArea(oPC);
    object oItem = GetItemActivated();
    location oItemLoc = GetItemActivatedTargetLocation();
    batScatter(oArea, oItemLoc);
    batSound(oArea, oItemLoc);
}
