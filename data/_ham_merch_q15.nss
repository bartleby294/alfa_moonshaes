void main()
{
    object oItem = GetFirstItemInInventory(GetPCSpeaker());

    while (!(oItem == OBJECT_INVALID))
        {
            if(GetTag(oItem) == "SignedHammerstaadPactNoSeal")
            {
                break;
            }
        }

    int oGoldamt = GetLocalInt(oItem, "HamGoldamt");

    TakeGoldFromCreature(oGoldamt, GetPCSpeaker(), TRUE);
}
