/************************ [Low Healer Custom AI] *******************************
    Filename: J_CAI_LowHealer
************************* [Low Healer Custom AI] *******************************
    This is a custom AI file for Low Cleric's.

    This is a cleric - It heals the nearest ally, after itself (if under
    50% HP) that has under 50% HP.

    It doesn't cast spells other then healing ones, however.
************************* [History] ********************************************
    1.3 - Added as sample
************************* [Workings] *******************************************
    Uses Combat_GetAITargetObject, to see if we saw something new or something.
    It will only attack seen things.

    Then we do:

    - Healing (at 50%) using best
    - Heal allies
    - Potions (using random % below)
    - Use turning
    - Attack in melee or range.
************************* [Arguments] ******************************************
    Arguments: N/A
************************* [Low Healer Custom AI] ******************************/

// Useful custom AI functions here
#include "J_INC_BASIC"

// % Chance to use a potion.
const int PERCENT_POTION = 40;
// Range, in meters, that if the enemy is in we attack in HTH.
const float RANGE_FOR_MELEE = 5.0;

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
            // Heal allies after combat
            if(Combat_HealAllies()) return;
            // Walk waypoints if we do not heal
            Combat_WalkWaypoints();
            return;
        }
    }

    // Do combat.

    // Heal ourselves first, if under 50% HP.
    Combat_HealTarget(OBJECT_SELF);

    // Heal the nearest ally under 50% HP.
    // - This function uses seen allies, and heals the nearest under 50% HP.
    if(Combat_HealAllies()) return;

    // There is a % chance of using a potion (Set above)
    if(d100() <= PERCENT_POTION)
    {
        // Function to use best potion we possess
        if(Combat_UseAnyPotions()) { return; }
    }

    // Check turning
    if(Combat_TurnUndead()) return;

    // Equip the right weapons, and attack.
    float fRange = GetDistanceToObject(oTarget);

    // If under RANGE_FOR_MELEE, attack in melee, else range.
    if(fRange <= RANGE_FOR_MELEE)
    {
        // Attack in melee - with feats, and equip most damaging.
        Combat_AttackMelee(oTarget);
    }
    else
    {
        // Ranged combat
        Combat_AttackRanged(oTarget);
    }
}
