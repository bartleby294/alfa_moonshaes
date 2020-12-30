/************************ [Necromancer (Low) Custom AI] ************************
    Filename: J_CAI_Necro
************************* [Necromancer (Low) Custom AI] ************************
    This is a custom AI file for necromancers.

    It will summon 3 skeletons (by creating them, and adding them as faction
    members) until it has 3, 1 each round. Healing is done normally, so it
    should be a non-undead necromancer (Necromancers are meant to be not undead!)

    It will cheat-cast negative spells, "Negative Energy Ray" and "Negative energy
    Burst". Spells it'll cast on self ar "Negative energy protection" and
    "Mage armor". Pretty odd selection, but this is only a sample AI.

    Also note the skeletons hang around at the end. It could be scripted to
    destroy all skeletons OnDeath too.

    Note:
    - Add negative spells to heal undead allies.
    - All other spells are cheat-cast (when cast at enemies)
    - CR of necromancer should be 4-8.

    Ideas:
    - Modify to summon "Deer" for a ranger, or "Dogs" for a dog trainer, the functions
      ActionCreateAlly() and CountCreaturesOfTagInFaction() can be changed to
      check for amounts of these exsisting, and "summon" new ones.
************************* [History] ********************************************
    1.3 - Added as sample
************************* [Workings] *******************************************
    Uses Combat_GetAITargetObject, to see if we saw something new or something.

    Then we do:

    - Summon an extra skeleton (From default pallet) if we have under 5
    - Healing self with normal arrangements
    - Heal undead around us
    - Defend self with spells
    - Use negative attacks
************************* [Arguments] ******************************************
    Arguments: N/A
************************* [Necromancer (Low) Custom AI] ***********************/

// Useful custom AI functions here
#include "J_INC_BASIC"

// Amount of skeletons to summon. 1-4 are OK, 5-7 are a hell of a lot! 8+ are too many.
const int SKELETONS_MAX = 3;

// Counts amount of creatures of tag sTag, that are in the area and in the same
// faction as the caster.
int CountCreaturesOfTagInFaction(string sTag);
// Summon a undead ally of sResRef, with casting animations and effects, using
// nVisEffect for the visual effect applied to the created creature.
void ActionCreateAlly(string sResRef, int nVisEffect = VFX_FNF_SUMMON_UNDEAD);

void main()
{
    // If we have summoned an undead in the last 3 seconds, stop. Set in ActionCreateAlly.
    if(GetLocalInt(OBJECT_SELF, "SUMMONING")) return;

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

    // Get amount of skeletons by tag "NW_SKELWARR01"
    int nFollowers = CountCreaturesOfTagInFaction("NW_SKELWARR01");

    // May also check for the second skeleton that we create, "NW_SKELWARR02",
    // and check how many of them there are.
    if(nFollowers < SKELETONS_MAX)
    {
        // Add it onto the exsisting nFollowers.
        nFollowers += CountCreaturesOfTagInFaction("NW_SKELWARR02");
    }

    // We will summon more if nFollowers is < SKELETONS_MAX (Default: 3).
    if(nFollowers < SKELETONS_MAX)
    {
        // Stop, and summon
        // There are 2 suitable undead - warriors that is.
        // - Skeleton Warrior 6 nw_skelwarr01 NW_SKELWARR01
        // - Skeleton Warrior 6 nw_skelwarr02 NW_SKELWARR02
        string sUse = "nw_skelwarr0" + IntToString(d2());
        // Use function created for it (so we could modify to make it, say,
        // summon deer).
        ActionCreateAlly(sUse);
        return;
    }

    // Heal undead allies (or other allies) using spells we know
    object oMostDamaged = GetFactionMostDamagedMember();

    // Check if undead
    if(GetIsObjectValid(oMostDamaged))
    {
        if(GetRacialType(oMostDamaged) == RACIAL_TYPE_UNDEAD)
        {
            // Heal this undead with negative spells
            if(Combat_CastAtObject(SPELL_NEGATIVE_ENERGY_BURST, oMostDamaged)) return;
            if(Combat_CastAtObject(SPELL_NEGATIVE_ENERGY_RAY, oMostDamaged)) return;
        }
        else
        {
            // Normal heal
            Combat_HealTarget(oMostDamaged);
        }
    }

    // Cheat cast hostile, and defensive, spells.

    // Negative energy protection - 90
    if(Combat_CheatRandomSpellAtObject(SPELL_NEGATIVE_ENERGY_PROTECTION, OBJECT_SELF, 90)) return;

    // Mage armor - 60
    if(Combat_CheatRandomSpellAtObject(SPELL_MAGE_ARMOR, OBJECT_SELF, 60)) return;

    // Negative energy burst - 50
    if(Combat_CheatRandomSpellAtObject(SPELL_NEGATIVE_ENERGY_BURST, oTarget, 50)) return;

    // Negative energy ray - 100
    if(Combat_CheatRandomSpellAtObject(SPELL_NEGATIVE_ENERGY_RAY, oTarget, 100)) return;
}

// Counts amount of creatures of tag sTag, that are in the area and in the same
// faction as the caster.
int CountCreaturesOfTagInFaction(string sTag)
{
    // Get amount of followers to return
    int nFollowers = 0;
    int nCnt = 1;
    object oUndead = GetNearestObjectByTag(sTag, OBJECT_SELF, nCnt);
    while(GetIsObjectValid(oUndead))
    {
        if(GetFactionEqual(oUndead))
        {
            // Add 1 to the followers
            nFollowers++;
        }
        nCnt++;
        oUndead = GetNearestObjectByTag(sTag, OBJECT_SELF, nCnt);
    }
    return nFollowers;
}
// Summon a undead ally of sResRef, with casting animations and effects, using
// nVisEffect for the visual effect applied to the created creature.
void ActionCreateAlly(string sResRef, int nVisEffect = VFX_FNF_SUMMON_UNDEAD)
{
    // Stop, and summon
    ClearAllActions();
    // Fake cast spell
    ActionCastFakeSpellAtObject(SPELL_CREATE_GREATER_UNDEAD, OBJECT_SELF);
    object oNewUndead = CreateObject(OBJECT_TYPE_CREATURE, sResRef, GetLocation(OBJECT_SELF));
    // Add to our faction
    ChangeFaction(oNewUndead, OBJECT_SELF);
    // Apply visual effect to new creature after a few seconds
    effect eVis = EffectVisualEffect(nVisEffect);
    DelayCommand(0.5, ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oNewUndead));
    SetLocalInt(OBJECT_SELF, "SUMMONING", TRUE);
    DelayCommand(3.0, DeleteLocalInt(OBJECT_SELF, "SUMMONING"));
    return;
}
