//::///////////////////////////////////////////////
//:: Default: End of Combat Round
//:: NW_C2_DEFAULT3
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Calls the end of combat script every round
*/
//:://////////////////////////////////////////////
//:: Created By: Preston Watamaniuk
//:: Created On: Oct 16, 2001
//:://////////////////////////////////////////////

#include "NW_I0_GENERIC"

//*************************************** ALFA Mod
#include "alfa_combat"
//*************************************** End ALFA Mod

void main()
{

//**************************************************ALFA MOD
    object oCurrentTarget = GetAttackTarget();

    if  (ALFA_CheckForUnconsciousTarget(OBJECT_SELF, oCurrentTarget))
    {
      ClearAllActions();

      // choose new target...
      object oNewTarget = ALFA_ChooseDifferentTarget(OBJECT_SELF, oCurrentTarget);

      if (GetIsObjectValid(oNewTarget))
      {
        DetermineCombatRound(oNewTarget);
      }
    }
    else
//*************************************************End ALFA MOD

    if(GetBehaviorState(NW_FLAG_BEHAVIOR_SPECIAL))
    {
        DetermineSpecialBehavior();
    }
    else if(!GetSpawnInCondition(NW_FLAG_SET_WARNINGS))
    {
       DetermineCombatRound();
    }
    if(GetSpawnInCondition(NW_FLAG_END_COMBAT_ROUND_EVENT))
    {
        SignalEvent(OBJECT_SELF, EventUserDefined(1003));
    }

//*** ALFA Mod - checks and if appropriate clears combat for weapon breakage
    ALFA_CheckClearCombat();
//*** end ALFA mod

}
