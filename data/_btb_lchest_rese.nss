void main()
{
    object chest = GetObjectByTag("randlootchesttes");
    object oItem = GetFirstItemInInventory(chest);

    while (oItem != OBJECT_INVALID) {
        DestroyObject(oItem);
        oItem = GetNextItemInInventory(chest);
    }

    SetLocalInt(chest, "loot_generated", 0);

}
