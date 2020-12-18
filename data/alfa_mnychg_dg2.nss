#include "nw_i0_plot"
//Has Gold
int StartingConditional()
{
if (GetGold(GetPCSpeaker()) >= 500)
return TRUE;
return FALSE;
}
