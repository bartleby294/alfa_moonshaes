void main()
{
    object oItemToTake;
    oItemToTake = GetItemPossessedBy(GetPCSpeaker(), "SignedHammerstaadPactNoSeal");
    if(GetIsObjectValid(oItemToTake) != 0)
    {
        DestroyObject(oItemToTake);
    }

    CreateItemOnObject("signedhammerstaa", GetPCSpeaker(), 1);

}
