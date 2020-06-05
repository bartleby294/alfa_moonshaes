int StartingConditional()
{
object oPC = GetPCSpeaker();

if (!(GetGold(oPC) >= 45)) return FALSE;

return TRUE;
}
