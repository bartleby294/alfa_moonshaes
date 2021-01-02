/************************ [Low Mage Custom AI] *********************************
    Filename: J_CAI_LowMage
************************* [Low Mage Custom AI] *********************************
    This is a custom AI file for Low Mage's.

    This is a partly cheating AI. It uses Combat_CheatRandomSpellAtObject to
    cast a random level 1 or 0 spell, after it runs out of ones it had.

    It will cast level 1 and 0 spells, then cheat cast between Mage Armor,
    Magic Missile, Colour Spray, and Ice Ray.

    Only attacks seen things!
************************* [History] ********************************************
    1.3 - Added as sample
************************* [Workings] *******************************************
    Uses Combat_GetAITargetObject, to see if we saw something new or something.
    It will only attack seen things.

    Then we do:

    - Healing (at 50%) using best
    - Potions (using random % below)
    - Attack with known spells
    - Attack with cheat spells (as above)
************************* [Arguments] ******************************************
    Arguments: N/A
************************* [Low Mage Custom AI] ********************************/

// Useful custom AI functions here
#include "J_INC_BASIC"

// % Chance to use a potion.
const int PERCENT_POTION = 40;

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


    // Shield
    if(Combat_CastAtObject(SPELL_SHIELD, OBJECT_SELF)) return;

    // Mage armor
    if(Combat_CastAtObject(SPELL_MAGE_ARMOR, OBJECT_SELF)) return;

    // Endure Elements
    if(Combat_CastAtObject(SPELL_ENDURE_ELEMENTS, OBJECT_SELF)) return;

    //Summon Creature I
    if(Combat_CastAtObject(SPELL_SUMMON_CREATURE_I, OBJECT_SELF)) return;

    // Magic Missile
    if(Combat_CastAtObject(SPELL_MAGIC_MISSILE, oTarget)) return;

    // Negative Energy Ray
    if(Combat_CastAtObject(SPELL_NEGATIVE_ENERGY_RAY, oTarget)) return;

    // Sleep
    if(Combat_CastAtObject(SPELL_SLEEP, oTarget)) return;

    // Grease
    if(Combat_CastAtObject(SPELL_GREASE, oTarget)) return;

    // Burning hands
    if(Combat_CastAtObject(SPELL_BURNING_HANDS, oTarget)) return;

    // Color Spray
    if(Combat_CastAtObject(SPELL_COLOR_SPRAY, oTarget)) return;

    // Doom
    if(Combat_CastAtObject(SPELL_DOOM, oTarget)) return;

    // Scare
    if(Combat_CastAtObject(SPELL_SCARE, oTarget)) return;

    // Charm Person
    if(Combat_CastAtObject(SPELL_CHARM_PERSON, oTarget)) return;

    // Random cheat casting spells now.
    if(Combat_CheatRandomSpellAtObject(SPELL_MAGE_ARMOR, OBJECT_SELF, 70)) return;
    if(Combat_CheatRandomSpellAtObject(SPELL_MAGIC_MISSILE, OBJECT_SELF, 35)) return;
    if(Combat_CheatRandomSpellAtObject(SPELL_COLOR_SPRAY, OBJECT_SELF, 35)) return;
    if(Combat_CheatRandomSpellAtObject(SPELL_RAY_OF_FROST, OBJECT_SELF, 100)) return;
}
