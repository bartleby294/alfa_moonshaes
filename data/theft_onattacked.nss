//::///////////////////////////////////////////////
//:: Anti-Theft OnAttack
//:: theft_onattacked
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
 For Items that to detect Bashing
*/
//:://////////////////////////////////////////////
//:: Created By: David "The Shadowlord" Corrales
//:: Created On: August 23,2002
//:://////////////////////////////////////////////

#include "theft_functions"

void main()
{
  if(GetIsPC(GetLastAttacker()))
  {
      Theft_SpotThief(GetLastAttacker(),TRUE);
//      if(GetCurrentHitPoints(OBJECT_SELF) < 1)
//      {
//        AdjustAlignment(GetLastAttacker(),ALIGNMENT_CHAOTIC,2);
//      }
   }
}
