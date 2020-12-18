void main()
{
    object oItem = GetFirstItemInInventory(GetPCSpeaker());

        while (!(oItem == OBJECT_INVALID))
        {
            if(GetTag(oItem) == "TickettoCorwell")
            {
                DestroyObject(oItem,0.0);
                break;
            }
         }
   AssignCommand(GetPCSpeaker(), ActionJumpToObject(GetObjectByTag("Norland_to_Gwyneth_ship")));
}
