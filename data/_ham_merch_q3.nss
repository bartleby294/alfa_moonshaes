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
            if(GetTag(oItem) == "HammerstaadPact")
            {
                break;
            }
        }

    if(!GetIsSkillSuccessful(GetPCSpeaker(), SKILL_BLUFF, 15))
    {
        SetLocalInt(oItem, "HamGoldamt", 25);
        return TRUE;
    }
    else
    {
        SetLocalInt(oItem, "HamGoldamt", 50);
        return FALSE;
    }
}
