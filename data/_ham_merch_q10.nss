void main()
{
    // Remove items from the player's inventory
    object oItemToTake;
    int oItemData;
    oItemToTake = GetItemPossessedBy(GetPCSpeaker(), "HammerstaadPact");
    if(GetIsObjectValid(oItemToTake) != 0)
    {
        oItemData = GetLocalInt(oItemToTake, "HamGoldamt");
        DestroyObject(oItemToTake);
    }

    object oNewItem = CreateItemOnObject("signedhammers001", GetPCSpeaker(), 1);
    SetLocalInt(oNewItem, "HamGoldamt", oItemData);
}
