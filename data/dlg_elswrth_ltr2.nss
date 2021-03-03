//::///////////////////////////////////////////////
//:: FileName dlg_elswrth_ltr2
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Script Wizard
//:: Created On: 2
//:://////////////////////////////////////////////
void main()
{
    // Give the speaker some gold
    GiveGoldToCreature(GetPCSpeaker(), 20);

    // Give the speaker some XP
    GiveXPToCreature(GetPCSpeaker(), 20);

    // Remove items from the player's inventory
    object oItemToTake;
    oItemToTake = GetItemPossessedBy(GetPCSpeaker(), "ElsworthsLoveLetter");
    if(GetIsObjectValid(oItemToTake) != 0)
        DestroyObject(oItemToTake);

    // Set the variables
    SetLocalInt(GetPCSpeaker(), "iElsworthquest", 6);

   //create alignment shifts +1 EVIL +1 CHAOTIC
   {
   object oReader = GetPCSpeaker();
   AdjustAlignment(oReader, ALIGNMENT_EVIL, 1, FALSE);
   }
{
   object oReader = GetPCSpeaker();
   AdjustAlignment(oReader, ALIGNMENT_CHAOTIC, 1, FALSE);
   }

   }


