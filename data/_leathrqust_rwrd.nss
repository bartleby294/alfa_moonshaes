//::///////////////////////////////////////////////
//:: FileName test
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Script Wizard
//:: Created On: 2
//:://////////////////////////////////////////////
void main()
{
    // Give the speaker some gold
    GiveGoldToCreature(GetPCSpeaker(), 45);

    // Give the speaker some XP
    GiveXPToCreature(GetPCSpeaker(), 45);


    // Remove items from the player's inventory
    object oItemToTake;
    oItemToTake = GetItemPossessedBy(GetPCSpeaker(), "LeatherGoodsPackage");
    if(GetIsObjectValid(oItemToTake) != 0)
        DestroyObject(oItemToTake);
}
