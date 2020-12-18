int StartingConditional()
{
    object oPC = GetPCSpeaker();
    object InnKeep = GetObjectByTag("_mines_02_innkeeper");

    object oItem = GetFirstItemInInventory(oPC);
        //checks your inv for key
        while (!(oItem == OBJECT_INVALID))
        {
            if (GetTag(oItem) == "_mine02_innkey01")
            {
                return TRUE;
            }
            if (GetTag(oItem) == "_mine02_innkey02")
            {
                return TRUE;
            }
            if (GetTag(oItem) == "_mine02_innkey03")
            {
                return TRUE;
            }
            if (GetTag(oItem) == "_mine02_innkey04")
            {
                return TRUE;
            }

            oItem = GetNextItemInInventory(oPC);
         }

         return FALSE;
}
