#include "nw_i0_plot"

void main()
{
    object oPC = GetPCSpeaker();
    object waypoint = GetObjectByTag("Mine03ATWaypoint01");
    object PickNPC = GetObjectByTag("Mines04toMines03AreaTransNPC");
    int gold = GetGold(oPC);


if(gold > 0)
{
    object pickaxe = CreateItemOnObject("PickAxeSpecial01", oPC,1, "PickAxeSpecial01");
    TakeGold(1, oPC, TRUE);
    AssignCommand(oPC, ActionEquipItem(pickaxe,INVENTORY_SLOT_RIGHTHAND));
    AssignCommand(PickNPC, ActionSpeakString("Here ya are. *Hands him a pick axe*"));
    DelayCommand(4.0, AssignCommand(oPC, ActionJumpToObject(waypoint, TRUE)));
    return;
}

    AssignCommand(PickNPC, ActionSpeakString("Rules are rules.  Have to give a gold peice lad."));

}
