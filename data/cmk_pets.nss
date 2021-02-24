void main()
{
    object oItem = GetItemActivated();
    string sItem = GetTag(oItem);
    location lLoc = GetItemActivatedTargetLocation();

    if(GetStringLeft(sItem,6) == "004MON")
    {
        object oPet = GetAssociate(ASSOCIATE_TYPE_HENCHMAN,OBJECT_SELF);
        if(oPet == OBJECT_INVALID)
        {
            oPet = CreateObject(OBJECT_TYPE_CREATURE,GetStringRight(sItem,GetStringLength(sItem)-6),lLoc,FALSE);
            AddHenchman(OBJECT_SELF,oPet);
            SetCommandable(TRUE,oPet);
        }
    }
}
