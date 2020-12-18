//::///////////////////////////////////////////////
//:: FileName _ham_merch_q1
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Script Wizard
//:: Created On: 7/20/2006 12:21:29 AM
//:://////////////////////////////////////////////
int StartingConditional()
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

    if(GetGold(GetPCSpeaker()) >= oGoldamt)
    {
        return TRUE;
    }
    else
    {
        return FALSE;
    }
}
