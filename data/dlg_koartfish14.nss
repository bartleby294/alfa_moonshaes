//::///////////////////////////////////////////////
//:: FileName dlg_koartfish14
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Script Wizard
//:: Created On: 0
//:://////////////////////////////////////////////
#include "ms_xp_util"

void main()
{
    // Give the speaker some gold
    GiveGoldToCreature(GetPCSpeaker(), 1);

    // Give the speaker some XP
    GiveAndLogXP(GetPCSpeaker(), 2, "FISH MONGER", "for handing in _fishing_item07.");


    // Remove items from the player's inventory
    object oItemToTake;
    oItemToTake = GetItemPossessedBy(GetPCSpeaker(), "_fishing_item07");
    if(GetIsObjectValid(oItemToTake) != 0)
        DestroyObject(oItemToTake);
}
