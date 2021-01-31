void main()
{
    object chest = GetNearestObjectByTag("randlootchesttes");
    object oItem = GetFirstItemInInventory(chest);

    while (oItem != OBJECT_INVALID) {
        DestroyObject(oItem);
        oItem = GetNextItemInInventory(chest);
    }

    SetLocalInt(chest, "loot_generated", 0);


    object chest2 = GetNearestObjectByTag("randlootchestte2");
    object oItem2 = GetFirstItemInInventory(chest2);

    while (oItem2 != OBJECT_INVALID) {
        DestroyObject(oItem2);
        oItem2 = GetNextItemInInventory(chest2);
    }

    SetLocalInt(chest2, "loot_generated", 0);


    SpeakString("Big Bucks No Whammys");

}
