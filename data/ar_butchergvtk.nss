//::///////////////////////////////////////////////
//:: FileName zmg_meathandin
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Script Wizard
//:: Created On: 2
//:://////////////////////////////////////////////
void main()
{
    // Give the speaker some gold
    GiveGoldToCreature(GetPCSpeaker(), 30);

    // Give the speaker some XP
    GiveXPToCreature(GetPCSpeaker(), 25);


    // Remove items from the player's inventory
    object oItemToTake;
    oItemToTake = GetItemPossessedBy(GetPCSpeaker(), "DeerMeat");
    if(GetIsObjectValid(oItemToTake) != 0)
        DestroyObject(oItemToTake);
}

