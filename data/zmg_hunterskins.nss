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
    string oGiveItem = "050_hide";
    string oGiveItem2 = "050_food030";
    CreateItemOnObject(oGiveItem, GetPCSpeaker());
    CreateItemOnObject(oGiveItem2, GetPCSpeaker());
}
