int StartingConditional()
{
object oPC = GetPCSpeaker();
    // Inspect local variables
    if((GetPhenoType(oPC) == 5) || (GetPhenoType(oPC) == 6) || (GetPhenoType(oPC) == 7))
        {
        return FALSE;
        }
    return TRUE;
}
