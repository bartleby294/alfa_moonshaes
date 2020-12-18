#include "nw_i0_2q4luskan"

void main()
{
    object oPC = GetEnteringObject();
    object Doorspawn = GetObjectByTag("Mines01ATDOOR");
    location DoorspawnLoc = GetLocation(Doorspawn);
    object door = GetObjectByTag("Mines_Ent_State_Tracker");

    if(GetLocalInt(door, "doorstate") == 0)
    {
        SetLocalInt(door, "doorstate", 1);
        AssignCommand(oPC, ActionSpeakString("*The door begins to come into focus as you examine the face more closely.*", TALKVOLUME_SILENT_SHOUT));
        CreateObjectVoid(OBJECT_TYPE_PLACEABLE, "dwarven_mine_secretdoor01", DoorspawnLoc, FALSE);
        object doorsecret = GetNearestObjectByTag("dwarven_mine_secretdoor01");
        DestroyObject(doorsecret, 40.0);
        DelayCommand(41.0, SetLocalInt(door, "doorstate", 0));
    }

}
