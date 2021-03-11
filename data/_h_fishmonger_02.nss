#include "ms_xp_util"

void main()
{
    object oPC =  GetPCSpeaker();
    object Fishmonger = GetObjectByTag("_h_fishmonger01");
    object oItem = GetFirstItemInInventory(oPC);
    int countnum = 0;
    int gate1 = 0;
    object oItemStore;

     while (!(oItem == OBJECT_INVALID))
        {
            if(GetTag(oItem) == "_fishing_item02" || GetTag(oItem) == "_fishing_item03" || GetTag(oItem) == "_fishing_item04" ||
            GetTag(oItem) == "_fishing_item05" || GetTag(oItem) == "_fishing_item06" || GetTag(oItem) == "_fishing_item07" ||
            GetTag(oItem) == "_fishing_item14")
            {
                //gate to make sure that only buys even numbers of goods
                if( gate1 == 0)
                {
                   gate1 = 1;
                   oItemStore = oItem;
                }

                if(gate1 = 1)
                {
                    gate1 = 0;
                    countnum = countnum + 2;
                    DestroyObject(oItem , 0.0);
                    DestroyObject(oItemStore , 0.0);
                }
            }

            oItem = GetNextItemInInventory(oPC);
        }

        int numgive = (countnum/2);

        GiveGoldToCreature(oPC, numgive);
        GiveAndLogXP(oPC, numgive, "LEGACY FISH MONGER", "for handing in fish.");

        ExecuteScript("_h_fishmong_sit1", OBJECT_SELF);
}
