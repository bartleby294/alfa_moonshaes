void main()
{
    object oPC = GetPCSpeaker();
    object InnKeep = GetObjectByTag("_mines_02_innkeeper");

   object InnDoor1 = GetObjectByTag("_mines02_inndoor_01");
   object InnDoor2 = GetObjectByTag("_mines02_inndoor_02");
   object InnDoor3 = GetObjectByTag("_mines02_inndoor_03");
   object InnDoor4 = GetObjectByTag("_mines02_inndoor_04");

    object oItem = GetFirstItemInInventory(oPC);
        //checks your inv for key
        while (!(oItem == OBJECT_INVALID))
        {
            if (GetTag(oItem) == "_mine02_innkey01")
            {
                SetLocalInt(InnKeep, "one", 0);
                DestroyObject(oItem, 0.0);
                SetLocked(InnDoor1, TRUE);
            }
            if (GetTag(oItem) == "_mine02_innkey02")
            {
                SetLocalInt(InnKeep, "two", 0);
                DestroyObject(oItem, 0.0);
                SetLocked(InnDoor2, TRUE);
            }
            if (GetTag(oItem) == "_mine02_innkey03")
            {
                 SetLocalInt(InnKeep, "three", 0);
                 DestroyObject(oItem, 0.0);
                 SetLocked(InnDoor3, TRUE);
            }
            if (GetTag(oItem) == "_mine02_innkey04")
            {
                 SetLocalInt(InnKeep, "four", 0);
                 DestroyObject(oItem, 0.0);
                 SetLocked(InnDoor4, TRUE);
            }

            oItem = GetNextItemInInventory(oPC);
         }
}
