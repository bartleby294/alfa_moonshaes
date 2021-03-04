//::///////////////////////////////////////////////
//:: FileName dlg_elswrth_set3
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Script Wizard
//:: Created On: 2
//:://////////////////////////////////////////////
void main()
{
    // Set the variables
    SetLocalInt(GetPCSpeaker(), "iElsworthquest", 3);

   //create alignment shift +1 LAWFUL, +1 EVIL
   {
   object oPlayer = GetPCSpeaker();
   AdjustAlignment(oPlayer, ALIGNMENT_LAWFUL, 1, FALSE);
   AdjustAlignment(oPlayer, ALIGNMENT_EVIL, 1, FALSE);
                           }
   {
	// Give the speaker some XP
	GiveXPToCreature(GetPCSpeaker(), 40);   }


 // Remove items from the player's inventory
    object oItemToTake;
    oItemToTake = GetItemPossessedBy(GetPCSpeaker(), "ElsworthsLoveLetter");
    if(GetIsObjectValid(oItemToTake) != 0)
        DestroyObject(oItemToTake);
                                       }
