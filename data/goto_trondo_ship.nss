//::///////////////////////////////////////////////
//:: FileName goto_trondor_ship
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Script Wizard
//:: Created On: 7/7/2002 1:19:03 PM
//:://////////////////////////////////////////////
void main()
{

    // Remove items from the player's inventory
    object oItemToTake;
    oItemToTake = GetItemPossessedBy(GetPCSpeaker(), "TickettoIron_Keep");
    if(GetIsObjectValid(oItemToTake) != 0)
        DestroyObject(oItemToTake);
    AssignCommand(GetPCSpeaker(), JumpToLocation(GetLocation(GetObjectByTag ("iron_keep_ship_arrive"))));


}
