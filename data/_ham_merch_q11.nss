void main()
{
   object oItem = GetFirstItemInInventory(GetPCSpeaker());

    while (!(oItem == OBJECT_INVALID))
        {
            if(GetTag(oItem) == "HammerstaadPact")
            {
                break;
            }
        }

        SetLocalInt(oItem, "HamGoldamt", 33);
}
