// Remember to keep the tag short! Variablenames can be a maximum of 32 characters!

void main()
{
    if (GetLocalInt(OBJECT_SELF, "iFirstOpen") == 0)
    {
        string sAreaResRef = GetResRef(GetArea(OBJECT_SELF));
        string sDatabase = sAreaResRef; //"tb_el_persistantchests";
        string sTag = GetTag(OBJECT_SELF);
        string sVarName;
        object oItem = OBJECT_SELF;
        int i = 0;
        int iMax = GetCampaignInt(sDatabase, sTag + "_n");

        while ((oItem != OBJECT_INVALID) && (i < iMax))
        {
            sVarName = sTag + "_" + IntToString(i);
            oItem = RetrieveCampaignObject(sDatabase, sVarName, GetLocation(OBJECT_SELF), OBJECT_SELF);
            SetLocalObject(OBJECT_SELF, sVarName, oItem);
            i++;
        }
        SetLocalInt(OBJECT_SELF, "iFirstOpen", 1);
    }
}

