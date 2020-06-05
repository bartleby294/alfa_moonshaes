void main()
{
    object oItem = GetFirstItemInInventory(GetPCSpeaker());

        while (!(oItem == OBJECT_INVALID))
        {
            if(GetTag(oItem) == "_SmugglersToken")
            {
                DestroyObject(oItem,0.0);
                break;
            }
         }
    AssignCommand(GetPCSpeaker(), ActionJumpToObject(GetObjectByTag("_smugglers_ship_AT01")));
}
