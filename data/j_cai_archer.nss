/************************ [Archer Custom AI] ***********************************
    Filename: J_CAI_Archer
************************* [Archer Custom AI] ***********************************
    This is a custom AI file for archers.

    This will either attack the imputted target, or attack the nearest seen
    or heard enemy. It will also attempt to use a random potion, or heal itself
    at 50% HP.

    As it likes ranged weapons, it flees from melee attackers :-P
************************* [History] ********************************************
    1.3 - Added as sample
************************* [Workings] *******************************************
    Uses Combat_GetAITargetObject, to see if we saw something new or something.

    Then we do:

    - Healing (at 50%) using best
    - Potions (using random % below)
    - Attack at range, or flee if they are within RANGE_FOR_FLEE
************************* [Arguments] ******************************************
    Arguments: N/A
************************* [Archer Custom AI] **********************************/

// Useful custom AI functions here
#include "J_INC_BASIC"

// % Chance to use a potion.
const int PERCENT_POTION = 40;
// Range, in meters, that if the enemy is in we run away from.
const float RANGE_FOR_FLEE = 5.0;

void main()
{
    // Get the target to attack
    object oTarget = Combat_GetAITargetObject();

    // Check if valid
    // - Can be seen or heard
    if(!Combat_GetTargetValid(oTarget))
    {
        // Nearest seen or heard enemy. If not valid, stop the script.
        oTarget = Combat_GetNearestSeenOrHeardEnemy();
        if(!GetIsObjectValid(oTarget))
        {
            // Heal ourselves after combat.
            if(Combat_HealTarget(OBJECT_SELF)) return;
            // Walk waypoints if we do not heal
            Combat_WalkWaypoints();
            return;
        }
    }

    // Do combat.

    // Heal ourselves first, if under 50% HP.
    Combat_HealTarget(OBJECT_SELF);

    // There is a % chance of using a potion (Set above)
    if(d100() <= PERCENT_POTION)
    {
        // Function to use best potion we possess
        if(Combat_UseAnyPotions()) { return; }
    }

    // Equip the right weapons, and attack.
    float fRange = GetDistanceToObject(oTarget);

    // If under RANGE_FOR_FLEE, run away.
    if(fRange <= RANGE_FOR_FLEE)
    {
        // Run away from the target, because we want to shoot at range.
        ClearAllActions();
        ActionMoveAwayFromObject(oTarget, TRUE, RANGE_FOR_FLEE + 5.0);
    }
    else
    {
        // Ranged combat
        Combat_AttackRanged(oTarget);
    }
}
