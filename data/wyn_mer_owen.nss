#include "nw_i0_plot"
void main()
{

object oPC = GetPCSpeaker();

object oTarget;
oTarget = GetObjectByTag("mer_wyn_glory");

gplotAppraiseOpenStore(oTarget, oPC, 0, 0);

}

