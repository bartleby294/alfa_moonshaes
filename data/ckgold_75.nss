int StartingConditional()
{
object oPC = GetPCSpeaker();

if (!(GetGold(oPC) >= 75)) return FALSE;

return TRUE;
}
