//::///////////////////////////////////////////////
//:: FileName dlg_koartfish10
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Script Wizard
//:: Created On: 0
//:://////////////////////////////////////////////
#include "ms_xp_util"

void main()
{
    // Give the speaker some gold
    GiveGoldToCreature(GetPCSpeaker(), 2);

    // Give the speaker some XP
    GiveAndLogXP(GetPCSpeaker(), 4, "FISH MONGER", "for handing in _fishing_item02.");


    // Remove items from the player's inventory
    object oItemToTake;
    oItemToTake = GetItemPossessedBy(GetPCSpeaker(), "_fishing_item02");
    if(GetIsObjectValid(oItemToTake) != 0)
        DestroyObject(oItemToTake);
}
