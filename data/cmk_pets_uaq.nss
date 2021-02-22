void main()
{
    object oItem = GetModuleItemLost();
    string sItem = GetTag(oItem);
    object oPC = GetModuleItemLostBy();

    if(GetStringLeft(sItem,6) == "004MON")
    {
        object oPet = GetAssociate(ASSOCIATE_TYPE_HENCHMAN,oPC);
        if(oPet != OBJECT_INVALID)
        {
            RemoveHenchman(oPC,oPet);
            DestroyObject(oPet);
            DestroyObject(oItem);
        }
    }
}
