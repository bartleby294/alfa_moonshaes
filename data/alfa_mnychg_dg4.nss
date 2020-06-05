#include "nw_i0_plot"
//No Gold, No Bar
int StartingConditional()
{
object oPC = GetPCSpeaker();
if (
(GetGold(oPC) >= 500) ||
(HasItem(oPC, "alfa_tradebar"))
)
return FALSE;
return TRUE;
}
