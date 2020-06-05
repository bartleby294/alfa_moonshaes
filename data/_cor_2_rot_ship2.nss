void main()
{
    object oItemToTake = GetItemPossessedBy(GetPCSpeaker(), "TickettoRottesheim");
    if(GetIsObjectValid(oItemToTake) != 0)
        DestroyObject(oItemToTake);
       AssignCommand(GetPCSpeaker(), ActionJumpToObject(GetObjectByTag("Gwyneth_to_Norland_ship")));
}
