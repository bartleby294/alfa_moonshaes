 int StartingConditional()
{
object oPC = GetPCSpeaker();

if (!(GetGold(oPC) >= 150)) return FALSE;

return TRUE;
}
