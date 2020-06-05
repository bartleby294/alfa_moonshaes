#include "nw_i0_plot"
//Gold or Bar
int StartingConditional()
{
object oPC = GetPCSpeaker();
if (
(GetGold(oPC) >= 500) ||
(HasItem(oPC, "alfa_tradebar"))
)
return TRUE;
return FALSE;
}
