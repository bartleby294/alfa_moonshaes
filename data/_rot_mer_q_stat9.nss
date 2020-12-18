//::///////////////////////////////////////////////
//::
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Script Wizard
//:://////////////////////////////////////////////
void main()
{
    // Give the speaker the items
    CreateItemOnObject("rottpact015", GetPCSpeaker(), 1);


    // Remove some gold from the player
    //TakeGoldFromCreature(50, GetPCSpeaker(), TRUE);

    // Remove items from the player's inventory
    object oItemToTake;
    oItemToTake = GetItemPossessedBy(GetPCSpeaker(), "Rottpact01");
    if(GetIsObjectValid(oItemToTake) != 0)
        DestroyObject(oItemToTake);
}
