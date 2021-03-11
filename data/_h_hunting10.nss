#include "ms_xp_util"

void main()
{
     object oNpC =  GetObjectByTag("_h_Ham_butch");
     object oPC = GetPCSpeaker();
     int deercount = GetLocalInt(oNpC, "deercount");
     int Storevar2;

     object oItem = GetFirstItemInInventory(oPC);

    int oXP = 5;
    int oGP = 3;

        while (!(oItem == OBJECT_INVALID))
        {
            if(GetTag(oItem) == "_DeadDeer")
            {
                if(deercount < 15)
                {
                    DestroyObject(oItem, 0.0);
                    GiveAndLogXP(oPC, oXP, "LEGACY BUTCHER", "for handing in deer.");
                    GiveGoldToCreature(oPC, oGP);
                    deercount = deercount +1;
                }
            }

            oItem = GetNextItemInInventory(oPC);
        }


    SetLocalInt(oNpC, "deercount", deercount);
}
