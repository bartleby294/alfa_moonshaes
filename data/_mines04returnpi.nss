#include "nw_i0_plot"
#include "ms_xp_util"

void main()
{
    object oPC = GetPCSpeaker();
    object waypoint = GetObjectByTag("Mine03ATWaypoint01");
    object PickNPC = GetObjectByTag("Mines04toMines03AreaTransNPC");
    int gold = GetGold(oPC);
    int check =0;
    int i;

        string sItem= "PickAxeSpecial01";
        object oItem = GetFirstItemInInventory(oPC);
        //checks for pick axe removes one if present and refunds 1 gp
        while (!(oItem == OBJECT_INVALID))
        {
            if (GetTag(oItem) == sItem)
            {
              ActionTakeItem(oItem, oPC);
              AssignCommand(PickNPC, ActionSpeakString("*Takes pick back* Thank ye lad. *Gives gold peice back*"));
              GiveGoldToCreature(oPC, 1);
              check =1;
                break;
            }

            oItem = GetNextItemInInventory(oPC);
        }

        for (i = 0; i < NUM_INVENTORY_SLOTS; ++i)
        {
            if (!(GetItemInSlot(i, oPC) == OBJECT_INVALID)
              && (GetTag(GetItemInSlot(i, oPC)) == sItem))
              {
                ActionUnequipItem(GetItemInSlot(i, oPC));
                ActionTakeItem(GetItemInSlot(i, oPC), oPC);
                AssignCommand(PickNPC, ActionSpeakString("*Takes pick back* Thank ye lad. *Gives gold peice back*"));
                GiveGoldToCreature(oPC, 1);
                check =1;
                break;
              }
        }

        if(check !=1)
        {
           AssignCommand(PickNPC, ActionSpeakString("**Scratches head. Ye daft lad?  I dont see no pick.*"));
           return;
        }

        //checks the # of rocks a pc has mined and give out 1 xp per 20 up to 30 xp, fell free to modify this as deemed apropriate

        float rockbashnum = IntToFloat(GetLocalInt(oPC, "rocksbashed"));
        float rawrocknum = (rockbashnum/20);
        int rocknum = FloatToInt(rawrocknum);

        if(rawrocknum <= 30.0)
        {
            SetLocalInt(oPC, "rocksbashed", 0);
            GiveAndLogXP(oPC, rocknum, "LEGACY MINING", "for bashing rocks.");
        }
        if(rawrocknum > 30.0)
        {
            SetLocalInt(oPC, "rocksbashed", 0);
            GiveAndLogXP(oPC, 30, "LEGACY MINING", "for bashing rocks.");
        }


}

