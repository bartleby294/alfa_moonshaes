//::///////////////////////////////////////////////
//:: Custom: End of Combat Round
//:: an_animal_combe
//:://////////////////////////////////////////////
/*
    Calls the end of combat script every round.
    Takes into account the animal's desire to flee
    and not turn around to continue fighting.
*/
//:://////////////////////////////////////////////
//:: Created By: Preston Watamaniuk
//:: Created On: Oct 16, 2001
//::
//:: Modified: Rahvin Talemon 5.4
//:: - Modified for use by ALFA, using alfa_combat
//:://////////////////////////////////////////////

#include "NW_I0_GENERIC"

//*************************************** CORE Mod
#include "alfa_combat"
#include "an_animal_ai_inc"
//*************************************** End CORE Mod

void main()
{

//**************************************************CORE MOD
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
//*************************************************End CORE MOD

    if(GetBehaviorState(NW_FLAG_BEHAVIOR_SPECIAL))
    {
        DetermineSpecialBehavior();
    }
    else if(!GetSpawnInCondition(NW_FLAG_SET_WARNINGS))
    {
       // RT.5.4 Break out if this creature should be fleeing.
       if (GetLocalInt(OBJECT_SELF, I_AM_FLEEING))
            return;

       DetermineCombatRound();
    }
    if(GetSpawnInCondition(NW_FLAG_END_COMBAT_ROUND_EVENT))
    {
        SignalEvent(OBJECT_SELF, EventUserDefined(1003));
    }

//*** CORE Mod - checks and if appropriate clears combat for weapon breakage
    ALFA_CheckClearCombat();
//*** end CORE mod

}
