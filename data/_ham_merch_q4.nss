//::///////////////////////////////////////////////
//:: FileName _ham_merch_q4
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Script Wizard
//:: Created On: 7/20/2006 12:36:38 AM
//:://////////////////////////////////////////////
void main()
{
    // Give the speaker the items
    CreateItemOnObject("signedhammerstaa", GetPCSpeaker(), 1);


    // Remove some gold from the player
    TakeGoldFromCreature(13, GetPCSpeaker(), TRUE);

    // Remove items from the player's inventory
    object oItemToTake;
    oItemToTake = GetItemPossessedBy(GetPCSpeaker(), "HammerstaadPact");
    if(GetIsObjectValid(oItemToTake) != 0)
        DestroyObject(oItemToTake);
}
