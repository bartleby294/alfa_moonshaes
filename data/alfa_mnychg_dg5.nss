#include "nw_i0_plot"

void main()
{
object oPC = GetPCSpeaker();
TakeGold(500, oPC, TRUE);
CreateItemOnObject("alfa_tradebar",oPC,1);
}
