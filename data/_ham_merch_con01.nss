int StartingConditional()
{
    object oItem = GetFirstItemInInventory(GetPCSpeaker());

    while(oItem != OBJECT_INVALID)
    {
        if(GetTag(oItem) == "_fishing_item02" || GetTag(oItem) == "_fishing_item03" || GetTag(oItem) == "_fishing_item04" ||
            GetTag(oItem) == "_fishing_item05" || GetTag(oItem) == "_fishing_item06" || GetTag(oItem) == "_fishing_item07" ||
            GetTag(oItem) == "_fishing_item14")
            {
                return TRUE;
            }

        oItem = GetNextItemInInventory(GetPCSpeaker());
    }

            return FALSE;
}
