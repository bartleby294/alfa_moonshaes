int StartingConditional()
{
object oPC = GetPCSpeaker();

if (!(GetHitDice(oPC) <=  3)) return FALSE;

return TRUE;
}
