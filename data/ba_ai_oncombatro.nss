/************************ [On Combat Round End] ********************************
    Filename: nw_c2_default3 or j_ai_oncombatrou
************************* [On Combat Round End] ********************************
    This is run every 3 or 6 seconds, if the creature is in combat. It is
    executed only in combat automatically.

    It runs what the AI should do, bascially.
************************* [History] ********************************************
    1.3 - Executes same script as the other parts of the AI to cuase a new action
************************* [Workings] *******************************************
    Calls the combat AI file using the J_INC_OTHER_AI include function,
    DetermineCombatRound.
************************* [Arguments] ******************************************
    Arguments: GetAttackTarget, GetLastHostileActor, GetAttemptedAttackTarget,
               GetAttemptedSpellTarget (Or these are useful at least!)
************************* [On Combat Round End] *******************************/

#include "j_inc_other_ai"
//*************************************** ALFA Mod
#include "alfa_combat"
//*************************************** End ALFA Mod
#include "_btb_ban_util"
#include "ba_consts"

void main()
{
    // Pre-combat-round-event
    if(FireUserEvent(AI_FLAG_UDE_END_COMBAT_ROUND_PRE_EVENT, EVENT_END_COMBAT_ROUND_PRE_EVENT))
        // We may exit if it fires
        if(ExitFromUDE(EVENT_END_COMBAT_ROUND_PRE_EVENT)) return;

    // AI status check. Is the AI on?
    if(GetAIOff()) return;

    // It is our normal call (every 3 or 6 seconds, when we can change actions)
    // so no need to delete, and we fire the UDE's.

// THIS NO LONGER NEEDED? JAI TAG ONSPAWN NO TARGET FALLEN
/**************************************************ALFA MOD
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
//*************************************************End ALFA MOD  */

    // Determine combat round against an invalid target (as default)
    DetermineCombatRound();
    onAttackActions("");
    object lastAttacker = GetLastAttacker(OBJECT_SELF);
    location lastAttackerLoc = GetLocation(lastAttacker);
    SetLocalLocation(OBJECT_SELF, "attackerLoc", lastAttackerLoc);
    // Fire End of end combat round event
    FireUserEvent(AI_FLAG_UDE_END_COMBAT_ROUND_EVENT, EVENT_END_COMBAT_ROUND_EVENT);
}
