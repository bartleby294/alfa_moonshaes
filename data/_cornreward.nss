#include "nw_i0_plot"
void main()
{
    AddJournalQuestEntry("k010",1,GetPCSpeaker(),FALSE,FALSE,FALSE);
    //check inventory of oPC for oQuestItem and get iNumItems
    string sMark = "ITEM_TAG";
    int Corn = GetNumItems(GetPCSpeaker(), "corn");
    int ilevel = GetHitDice(GetPCSpeaker());
    int i;
    if (ilevel = 1)
    {
        for (i=0; i<(Corn); i++)
            {
    // Give the speaker some gold
            GiveGoldToCreature(GetPCSpeaker(), 5);

    // Give the speaker some XP
            GiveXPToCreature(GetPCSpeaker(), 20);

            }
    }

    else if (ilevel = 2)
    {
        for (i=0; i<(Corn); i++)
            {
    // Give the speaker some gold
            GiveGoldToCreature(GetPCSpeaker(), 5);

    // Give the speaker some XP
            GiveXPToCreature(GetPCSpeaker(), 10);

            }
    }

    else if (ilevel = 3)
    {
        for (i=0; i<(Corn); i++)
            {
    // Give the speaker some gold
            GiveGoldToCreature(GetPCSpeaker(), 5);

    // Give the speaker some XP
            GiveXPToCreature(GetPCSpeaker(), 5);

            }
    }

    else if (ilevel = 4)
    {
        for (i=0; i<(Corn); i++)
            {
    // Give the speaker some gold
            GiveGoldToCreature(GetPCSpeaker(), 5);

    // Give the speaker some XP
            GiveXPToCreature(GetPCSpeaker(), 2);

            }
    }
    // Remove items from the player's inventory
    object oItemToTake;
    oItemToTake = GetItemPossessedBy(GetPCSpeaker(), "corn");
    if(GetIsObjectValid(oItemToTake) != 0)
        DestroyObject(oItemToTake);

        object oPC = GetPCSpeaker();

}
