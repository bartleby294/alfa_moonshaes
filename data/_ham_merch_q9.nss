void main()
{
    object oItemToTake;
    oItemToTake = GetItemPossessedBy(GetPCSpeaker(), "HammerstaadPact");
    if(GetIsObjectValid(oItemToTake) != 0)
        DestroyObject(oItemToTake);

    CreateItemOnObject("tornuphammerstaa", GetPCSpeaker(), 1);
}
