//::///////////////////////////////////////////////
//:: FileName sailtomurlok
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Script Wizard
//:: Created On: 8/20/2002 12:58:32 PM
//:://////////////////////////////////////////////
void main()
{

    // Remove items from the player's inventory
    object oItemToTake;
    oItemToTake = GetItemPossessedBy(GetPCSpeaker(), "TickettoWesthaven");
    if(GetIsObjectValid(oItemToTake) != 0)
        DestroyObject(oItemToTake);
        AssignCommand(GetPCSpeaker(), JumpToLocation(GetLocation(GetObjectByTag ("westhaven_ship_arrive"))));
}
