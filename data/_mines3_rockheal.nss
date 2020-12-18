void main()
{

    object rock = OBJECT_SELF;
        object oPC = GetLastAttacker(rock);
            int check;
                int i;

    string sItem= "PickAxeSpecial01";
        object oItem = GetFirstItemInInventory(oPC);
        //checks for pick axe removes one if present and refunds 1 gp
        while (!(oItem == OBJECT_INVALID))
        {
            if (GetTag(oItem) == sItem)
            {
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
                check =1;
                break;
              }
        }

    if(check != 1)
    {
     ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectHeal(20),rock, 0.0);
     SendMessageToPC(oPC, "The rock seems to be too hard to be damaged by your impliment.  Maybe you should have used that pick.");
    }
}
