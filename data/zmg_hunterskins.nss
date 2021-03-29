//::///////////////////////////////////////////////
//:: FileName zmg_hunterskins
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Script Wizard
//:: Created On: 0
//:://////////////////////////////////////////////
void main()
{

    // Remove items from the player's inventory
    object oItemToTake;
    oItemToTake = GetItemPossessedBy(GetPCSpeaker(), "_DeadDeer");
    if(GetIsObjectValid(oItemToTake) != 0)
        DestroyObject(oItemToTake);
    string oGiveItem2 = "050_food030";
    CreateItemOnObject(oGiveItem2, GetPCSpeaker());
    GiveXPToCreature(GetPCSpeaker(), 20);
    GiveGoldToCreature(GetPCSpeaker(), 25);
}
