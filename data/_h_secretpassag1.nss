#include "nw_i0_spells"

void main()
{
    object oPC = GetLastUsedBy();
    int oPCSize = GetCreatureSize(oPC);
    object JumpWP = GetObjectByTag("_norheim_passage1");

    if(oPCSize == CREATURE_SIZE_SMALL || oPCSize == CREATURE_SIZE_TINY )
       {
         SendMessageToPC(oPC, "You manage to crawl through with little trouble.");
         AssignCommand(oPC, ActionJumpToObject(JumpWP, FALSE));
       }

     if(oPCSize == CREATURE_SIZE_MEDIUM)
     {
        if(GetLocalInt(oPC, "norheimcavepassage1") != 3)
        {
            int newnum = GetLocalInt(oPC, "norheimcavepassage1") + 1;
            SetLocalInt(oPC, "norheimcavepassage1", newnum);

            if(MySavingThrow(SAVING_THROW_REFLEX, oPC, 16, SAVING_THROW_TYPE_NONE, OBJECT_SELF, 0.0))
            {
                SendMessageToPC(oPC, "After some effort you manage to get through.");
                AssignCommand(oPC, ActionJumpToObject(JumpWP, FALSE));
                SetLocalInt(oPC, "norheimcavepassage1", 0);
                return;
            }
            SendMessageToPC(oPC, "After a time of struggling to make it though you give up.  Perhaps the hole is just to small");
            return;
        }
        SendMessageToPC(oPC, "The hole is too small.  Perhaps with time it could enlarge though.");
     }


}
