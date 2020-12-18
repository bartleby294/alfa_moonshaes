int StartingConditional()
{
object oPC = GetPCSpeaker();
    // Inspect local variables
if((!GetIsObjectValid(GetItemPossessedBy(oPC,"043_BRWNBRDL_01")) && !GetIsObjectValid(GetItemPossessedBy(oPC,"043_GREYBRDL_01"))) && !GetIsObjectValid(GetItemPossessedBy(oPC,"043_BLAKBRDL_01")))
        {
        return TRUE;
        }
    return FALSE;
}
