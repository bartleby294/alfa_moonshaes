/************************ [Flying Fighter Custom AI] ***************************
    Filename: J_CAI_Flying
************************* [Flying Fighter Custom AI] ***************************
    This is a custom AI file for flying fighters.

    Basically, flying is the aim. We can apply EffectDisappearAppear() and
    jump or "fly" to a new target.

    This is in the normal AI, but of course, having it seperate is both more
    efficient, and if you wanted to add it to custom AI.
************************* [History] ********************************************
    1.3 - Added as sample
************************* [Workings] *******************************************
    Uses Combat_GetAITargetObject, to see if we saw something new or something.
    Similar to fighter custom AI - J_CAI_Fighter

    Then we do:

    - Healing (at 50%) using best
    - Potions (using random % below)
    - Attack in melee, flying if over RANGE_FOR_MELEE
************************* [Arguments] ******************************************
    Arguments: N/A
************************* [Flying Fighter Custom AI] **************************/

// Useful custom AI functions here
#include "J_INC_BASIC"

// % Chance to use a potion.
const int PERCENT_POTION = 40;
// Range, in meters, that we will fly to the target from.
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

    // If under RANGE_FOR_MELEE, attack in melee, else range.
    if(fRange <= RANGE_FOR_MELEE)
    {
        // Attack in melee - with feats, and equip most damaging.
        Combat_AttackMelee(oTarget);
    }
    else
    {
        // Fly to the target!
        effect eAppearDis = EffectDisappearAppear(GetLocation(oTarget));

        ClearAllActions();
        // Fly for an amount of seconds half of the range (so 10M = 5 seconds)
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eAppearDis, OBJECT_SELF, fRange/2);
    }
}
