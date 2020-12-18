#include "nw_i0_tool"
int StartingConditional()
{
object oPC = GetPCSpeaker();
int nTotalCost = 8000;


 if(GetGold(oPC) >= nTotalCost)
 {
   return TRUE;
 }
 return FALSE;
 }
