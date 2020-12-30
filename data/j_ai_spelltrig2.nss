/************************ [Spell Trigger Heartbeat] ****************************
    Filename: J_AI_SpellTrig2
************************* [Spell Trigger Heartbeat] ****************************
    This is fired on heartbeat.

    Checks spell trigger things, and fires them if any valid.
************************* [History] ********************************************
    1.3 - Added
************************* [Workings] *******************************************
    It will check:

    - If caster dead, stop
    - If caster invalid, destroy
    - Jump to caster.
    - Check seperate spell triggers and fire any spells for them.
************************* [Arguments] ******************************************
    Arguments: N/A
************************* [Spell Trigger Heartbeat] ***************************/

#include "J_INC_SETEFFECTS"

// Destroys ourselves.
void DestroyTrigger();
// Attempts to fire a spell trigger set to sID.
// iOverride is the spell trigger number (EG trigger 3) to force fire.
void FireSpellTrigger(string sID, object oCaster, int iOverrideID = FALSE);
// Gets the nearest seen or heard enemy.
object Combat_GetNearestSeenOrHeardEnemy(int bSeenOnly = FALSE);

void main()
{
    // Get caster.
    object oCaster = GetMaster();

    // If not valid, destroy self
    if(!GetIsObjectValid(oCaster))
    {
        // Destroy ourselves
        DestroyTrigger();
    }

    // If dead, stop
    if(GetIsDead(oCaster) || !GetLocalInt(OBJECT_SELF, "HEARTBEAT_DO")) return;

    // If casting soemthing, stop - will be interrupting an exssiting spell trigger.
    if(GetCurrentAction() == ACTION_CASTSPELL) return;

    // If in time stop, stop, as spells cannot be cast correctly in time stop
    if(GetHasSpellEffect(SPELL_TIME_STOP, oCaster) ||
       GetHasSpellEffect(SPELL_TIME_STOP, OBJECT_SELF)) return;

    // Move to the caster
    // Clear actions
    ClearAllActions();
    // Jump to location
    JumpToLocation(GetLocation(oCaster));

    // Apply Etherealness if not got it
    int nTrue = FALSE;
    effect eCheck = GetFirstEffect(OBJECT_SELF);
    while(GetIsEffectValid(eCheck))
    {
        if(GetEffectType(eCheck) == EFFECT_TYPE_SANCTUARY)
        {
            nTrue = TRUE;
        }
        eCheck = GetNextEffect(OBJECT_SELF);
    }
    // Not got it? Apply a new one
    if(nTrue == FALSE)
    {
        ApplyEffectToObject(DURATION_TYPE_PERMANENT, SupernaturalEffect(EffectEthereal()), OBJECT_SELF);
    }

    // If not in combat (caster) stop or if there is no enemy seen.
    if(!GetIsInCombat(oCaster)) return;

    // Start checking spell triggers

    // - Uncommandable check.
    if(AI_GetAIHaveEffect(GlobalEffectUncommandable, oCaster) ||
       AI_GetAIHaveEffect(GlobalEffectParalyze, oCaster) ||
       AI_GetAIHaveEffect(GlobalEffectDazed))
    {
        // Check spell triggers.
        FireSpellTrigger(SPELLTRIGGER_IMMOBILE, oCaster);
    }

    // Check spell triggers for start of combat. Basic check.
    FireSpellTrigger(SPELLTRIGGER_START_OF_COMBAT, oCaster);

    // Check damage
    int iPercent = FloatToInt((IntToFloat(GetCurrentHitPoints(oCaster))/IntToFloat(GetMaxHitPoints(oCaster))) * i100);
    if(iPercent < GetLocalInt(OBJECT_SELF, VALUE + SPELLTRIGGER_DAMAGED_AT_PERCENT))
    {
        FireSpellTrigger(SPELLTRIGGER_DAMAGED_AT_PERCENT, oCaster);
    }

    // Check Spell effects for SPELLTRIGGER_NOT_GOT_FIRST_SPELL
    // - Must have at least the first valid
    if(GetLocalInt(OBJECT_SELF, MAXINT_ + SPELLTRIGGER_NOT_GOT_FIRST_SPELL + s1))
    {
        // Check the spells seperatly
        int iMax = GetLocalInt(OBJECT_SELF, MAXIMUM + SPELLTRIGGER_NOT_GOT_FIRST_SPELL);
        int iCnt;
        for(iCnt = i1; iCnt <= iMax; iCnt++)
        {
            // Check if this is valid
            if(!GetLocalInt(OBJECT_SELF, SPELLTRIGGER_NOT_GOT_FIRST_SPELL + IntToString(iCnt) + USED))
            {
                // Check spell effects
                if(!GetHasSpellEffect(GetLocalInt(OBJECT_SELF, SPELLTRIGGER_NOT_GOT_FIRST_SPELL + IntToString(iCnt) + s1), oCaster))
                {
                    FireSpellTrigger(SPELLTRIGGER_NOT_GOT_FIRST_SPELL, oCaster, iCnt);
                    break;
                }
            }
        }
    }
}

// Destroys ourselves.
void DestroyTrigger()
{
    // We have the plot flag on ourselves.
    SetPlotFlag(OBJECT_SELF, FALSE);

    // We destroy selves after no plot flag
    DestroyObject(OBJECT_SELF);
}

// Attempts to fire a spell trigger set to sID.
// iOverride is the spell trigger number (EG trigger 3) to force fire.
void FireSpellTrigger(string sID, object oCaster, int iOverrideID = FALSE)
{
    // Get how many triggers under sID.
    int iMax = GetLocalInt(OBJECT_SELF, MAXIMUM + sID);
    if(iMax <= FALSE) return;

    // Get the spell triggers to fire
    string sTotalID;
    int iCnt;

    if(iOverrideID > FALSE)
    {
        sTotalID = sID + IntToString(iOverrideID);
    }
    else
    {
        // Check USED status - of the seperate triggers
        for(iCnt = i1; iCnt <= iMax; iCnt++)
        {
            if(!GetLocalInt(OBJECT_SELF, sID + IntToString(iCnt) + USED))
            {
                sTotalID = sID + IntToString(iCnt);
                break;
            }
        }
    }
    // Check if we have any
    if(sTotalID != "")
    {
        // Set to used!
        SetLocalInt(OBJECT_SELF, sTotalID + USED, TRUE);
        // Speakstring to show trigger released
        SpeakString("*Spelltrigger Released*");
        // Loop spells and cast
        int iTotalSpells = GetLocalInt(OBJECT_SELF, MAXINT_ + sTotalID);
        int iSpell;
        for(iCnt = i1; iCnt <= iTotalSpells; iCnt++)
        {
            // Cast spell from local
            iSpell = GetLocalInt(OBJECT_SELF, sTotalID + IntToString(iCnt));
            ActionCastSpellAtObject(iSpell, oCaster, METAMAGIC_ANY, TRUE, i20, PROJECTILE_PATH_TYPE_DEFAULT, TRUE);
        }
    }
}

// Gets the nearest seen or heard enemy.
object Combat_GetNearestSeenOrHeardEnemy(int bSeenOnly = FALSE)
{
    object oTarget = GetNearestCreature(CREATURE_TYPE_REPUTATION, REPUTATION_TYPE_ENEMY, OBJECT_SELF, 1, CREATURE_TYPE_PERCEPTION, PERCEPTION_SEEN, CREATURE_TYPE_IS_ALIVE, TRUE);
    if(!GetIsObjectValid(oTarget) && bSeenOnly == FALSE)
    {
        oTarget = GetNearestCreature(CREATURE_TYPE_REPUTATION, REPUTATION_TYPE_ENEMY, OBJECT_SELF, 1, CREATURE_TYPE_PERCEPTION, PERCEPTION_HEARD, CREATURE_TYPE_IS_ALIVE, TRUE);
        if(!GetIsObjectValid(oTarget))
        {
            return OBJECT_INVALID;
        }
    }
    return oTarget;
}
