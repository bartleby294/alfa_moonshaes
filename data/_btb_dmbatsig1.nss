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
    while(batFloat < 5.0) {
        DelayCommand(batFloat, createBat(oItemLoc));
        DelayCommand(batFloat, createBat(oItemLoc));
        DelayCommand(batFloat, createBat(oItemLoc));
        DelayCommand(batFloat, createBat(oItemLoc));
        batFloat = batFloat + 1.0;
    }
}

void batSound(object oArea, location oItemLoc) {
    int num = 0;
    while(num < 5) {
        string randomSound = IntToString(Random(9) + 1);
        object oSound = GetObjectByTag("batswarm" + randomSound);
        //object oSound = CreateObject(OBJECT_TYPE_PLACEABLE,
        //                            "batswarm" + randomSound, oItemLoc);
        SoundObjectSetPosition(oSound, GetPositionFromLocation(oItemLoc));
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
    //batSound(oArea, oItemLoc);

    //CreateObject(OBJECT_TYPE_PLACEABLE, "invisbatsound", oItemLoc);
    //AssignCommand(sound1, PlaySound("al_pl_x2bongolp1"));
}
