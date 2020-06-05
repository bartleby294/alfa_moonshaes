void main()
{
        object oPC = GetLastUsedBy();
        string sItem= "PickAxeSpecial01";
        object oItem = GetFirstItemInInventory(oPC);
        object PickNPC = GetObjectByTag("Mines04toMines03AreaTransNPC");

        while (!(oItem == OBJECT_INVALID))
        {
            if (GetTag(oItem) == sItem)
            {
              ActionTakeItem(oItem, oPC);
              AssignCommand(PickNPC, ActionSpeakString("*Takes pick back* Thank ye lad."));
            }

            oItem = GetNextItemInInventory(oPC);
        }
}
