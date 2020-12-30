/************************ [Lich (High Cheater) Custom AI] **********************
    Filename: J_CAI_LichCheat
************************* [Lich (High Cheater) Custom AI] **********************
    Cheating-AI file for Lich's (Default: Not Demi-lich, but a modified one
    could be a Demi-lich one!).

    It does some high-level things:
    - Cast a few big protections once at the start of combat.
    - Be able to heal self with Inflict Critical Wounds always.
    - Cheat with defensive and offensive spells:
       - High Level defensive spells (Premonition, Spell Mantal, ETC)
       - Level 6-9 Offensive spells (Up to 6 from each level)

    Once it has used up all 6 from each level (random offensive spells) it will
    default to some random level 1-5 spells (unlimited).

    Not a good boss for intelligence-using spells, but for sheer mass of them.

    Adding in parts from "J_CAI_Necro" for summoning big undead allies would
    help this AI if it has no allies.
************************* [History] ********************************************
    1.3 - Added as sample
************************* [Workings] *******************************************
    Uses Combat_GetAITargetObject, to see if we saw something new or something.

    Then we do:

    - Protections at start of combat if not already
    - Heal self with inflict critcal wounds
    - Cast defensive spells on self
    - Cast offensive spells 6-9 (In order, up to 6 from each)
    - Cast random 1-5 offensive spells.
************************* [Arguments] ******************************************
    Arguments: N/A
************************* [Lich (High Cheater) Custom AI] *********************/

// Useful custom AI functions here
#include "J_INC_BASIC"

// Cheat-cast and fast-cast nSpell on self.
void CastPreparedSpell(int nSpell);

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

    // Prepare ourselves with:
    // - Premonition
    // - Energy buffer
    // - Spell resistance
    // - Greater spell mantal
    if(!GetLocalInt(OBJECT_SELF, "DONE_PREPARE_SPELLS"))
    {
        // Set to not do it again
        SetLocalInt(OBJECT_SELF, "DONE_PREPARE_SPELLS", TRUE);
        // Cheat-and-fast cast spells.
        CastPreparedSpell(SPELL_PREMONITION);
        CastPreparedSpell(SPELL_ENERGY_BUFFER);
        CastPreparedSpell(SPELL_SPELL_RESISTANCE);
        CastPreparedSpell(SPELL_GREATER_SPELL_MANTLE);
        return;
    }

    // If we are under 50% HP, heal self with Inflict Critical Wounds!
    if(GetCurrentHitPoints() * 2 < GetMaxHitPoints())
    {
        Combat_CheatRandomSpellAtObject(FEAT_INFLICT_CRITICAL_WOUNDS, OBJECT_SELF, 100);
        return;
    }

    // Cheat cast hostile, and defensive, spells.

    // If we have not got these spells effects, cast them.
    // High level defensive spells.
    if(!GetHasSpellEffect(SPELL_PREMONITION))
    {
        Combat_CheatRandomSpellAtObject(SPELL_PREMONITION, OBJECT_SELF, 100);
        return;
    }
    if(!GetHasSpellEffect(SPELL_GREATER_SPELL_MANTLE))
    {
        Combat_CheatRandomSpellAtObject(SPELL_GREATER_SPELL_MANTLE, OBJECT_SELF, 100);
        return;
    }
    if(!GetHasSpellEffect(SPELL_ENERGY_BUFFER))
    {
        Combat_CheatRandomSpellAtObject(SPELL_ENERGY_BUFFER, OBJECT_SELF, 100);
        return;
    }

    // Level 9 offensive spells
    int nUsed = GetLocalInt(OBJECT_SELF, "LEVEL_9_SPELLS_USED");
    if(nUsed < 6)
    {
        // Add one to uses
        nUsed++;
        SetLocalInt(OBJECT_SELF, "LEVEL_9_SPELLS_USED", nUsed);

        // Wail of the banshee - 60
        if(Combat_CheatRandomSpellAtObject(SPELL_WAIL_OF_THE_BANSHEE, oTarget, 60)) return;
        // Meteorswarm - 60
        if(GetDistanceToObject(oTarget) < 5.0)
        {
            if(Combat_CheatRandomSpellAtObject(SPELL_METEOR_SWARM, OBJECT_SELF, 60)) return;
        }
        // Crushing Hand - 60
        if(Combat_CheatRandomSpellAtObject(SPELL_BIGBYS_CRUSHING_HAND, oTarget, 60)) return;
        // Wierd - 100
        if(Combat_CheatRandomSpellAtObject(SPELL_WEIRD, oTarget, 100)) return;
    }
    // Level 8 offensive spells
    nUsed = GetLocalInt(OBJECT_SELF, "LEVEL_8_SPELLS_USED");
    if(nUsed < 6)
    {
        // Add one to uses
        nUsed++;
        SetLocalInt(OBJECT_SELF, "LEVEL_8_SPELLS_USED", nUsed);

        // Horrid Wilting - 75
        if(Combat_CheatRandomSpellAtObject(SPELL_HORRID_WILTING, oTarget, 75)) return;
        // Clenched Fist - 60
        if(Combat_CheatRandomSpellAtObject(SPELL_BIGBYS_CLENCHED_FIST, oTarget, 60)) return;
        // Power Word Stun - 50
        if(GetCurrentHitPoints(oTarget) <= 150)
        {
            if(Combat_CheatRandomSpellAtObject(SPELL_POWER_WORD_STUN, oTarget, 50)) return;
        }
        // Horrid Wilting - 100
        if(Combat_CheatRandomSpellAtObject(SPELL_HORRID_WILTING, oTarget, 100)) return;
    }
    // Level 7 offensive spells
    nUsed = GetLocalInt(OBJECT_SELF, "LEVEL_7_SPELLS_USED");
    if(nUsed < 6)
    {
        // Add one to uses
        nUsed++;
        SetLocalInt(OBJECT_SELF, "LEVEL_7_SPELLS_USED", nUsed);

        // Finger of death - 75
        if(Combat_CheatRandomSpellAtObject(SPELL_FINGER_OF_DEATH, oTarget, 75)) return;
        // Prismatic Spray - 60
        if(Combat_CheatRandomSpellAtObject(SPELL_PRISMATIC_SPRAY, oTarget, 60)) return;
        // Grasping hand - 60
        if(Combat_CheatRandomSpellAtObject(SPELL_BIGBYS_GRASPING_HAND, oTarget, 60)) return;
        // Delayed fireball blast - 100
        if(Combat_CheatRandomSpellAtObject(SPELL_DELAYED_BLAST_FIREBALL, oTarget, 100)) return;
    }
    // Level 6 offensive spells
    nUsed = GetLocalInt(OBJECT_SELF, "LEVEL_6_SPELLS_USED");
    if(nUsed < 6)
    {
        // Add one to uses
        nUsed++;
        SetLocalInt(OBJECT_SELF, "LEVEL_6_SPELLS_USED", nUsed);

        // Chain Lightning - 75
        if(Combat_CheatRandomSpellAtObject(SPELL_CHAIN_LIGHTNING, oTarget, 75)) return;
        // Acid fog - 60
        if(Combat_CheatRandomSpellAtObject(SPELL_ACID_FOG, oTarget, 60)) return;
        // Forceful hand - 50
        if(Combat_CheatRandomSpellAtObject(SPELL_BIGBYS_FORCEFUL_HAND, oTarget, 50)) return;
        // Greater missile storm 100
        if(Combat_CheatRandomSpellAtObject(SPELL_ISAACS_GREATER_MISSILE_STORM, oTarget, 100)) return;
    }
    // Random level 1-5 level offensive spells. Mainly totally random, but
    // more chance of a higher level one.

    // Interposing hand - 30
    if(Combat_CheatRandomSpellAtObject(SPELL_BIGBYS_INTERPOSING_HAND, oTarget, 30)) return;
    // Cone of cold - 30
    if(Combat_CheatRandomSpellAtObject(SPELL_CONE_OF_COLD, oTarget, 30)) return;
    // Hold monster - 30
    if(Combat_CheatRandomSpellAtObject(SPELL_HOLD_MONSTER, oTarget, 30)) return;

    // Phantasmal killer - 20
    if(Combat_CheatRandomSpellAtObject(SPELL_PHANTASMAL_KILLER, oTarget, 20)) return;
    // Ice Storm - 20
    if(Combat_CheatRandomSpellAtObject(SPELL_ICE_STORM, oTarget, 20)) return;

    // Fireball - 10
    if(Combat_CheatRandomSpellAtObject(SPELL_FIREBALL, oTarget, 10)) return;
    // Flame arrow - 10
    if(Combat_CheatRandomSpellAtObject(SPELL_FLAME_ARROW, oTarget, 10)) return;

    // Acid arrow - 5
    if(Combat_CheatRandomSpellAtObject(SPELL_MELFS_ACID_ARROW, oTarget, 5)) return;

    // Magic missile - 100
    if(Combat_CheatRandomSpellAtObject(SPELL_MAGIC_MISSILE, oTarget, 100)) return;
}

// Cheat-cast and fast-cast nSpell on self.
void CastPreparedSpell(int nSpell)
{
    ActionCastSpellAtObject(nSpell, OBJECT_SELF, METAMAGIC_EXTEND, TRUE, FALSE, PROJECTILE_PATH_TYPE_DEFAULT, TRUE);
}
