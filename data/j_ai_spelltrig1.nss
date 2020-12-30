/************************ [Spell Trigger Create/Start] *************************
    Filename: J_AI_SpellTrig1
************************* [Spell Trigger Create/Start] *************************
    This is the spawn file for spell trigger object

    It follows the caster around, is totally unselectable, is plot, is able
    to move through creatures, and checks (on heartbeat) for spells.
************************* [History] ********************************************
    1.3 - Added
************************* [Workings] *******************************************
    The spell triggers are set up OnSpawn of the caster.

    They can be fired under various circumstances - for instance:

    * NOT_GOT_FIRST_SPELL - When we !GetHasSpellEffect(iFirstSpell);
    * DAMAGED_AT_PERCENT  - When we are below X percent of HP, it fires
    * IMMOBILE            - When we are uncommandable/paralyzed/sleeping, etc.
    * START_OF_COMBAT     - Fired first, whatever condition

    When fired, they are deleted from the caster until resting (where they
    are re-set! :-) using the on rest event).

************************* [Arguments] ******************************************
    Arguments: N/A
************************* [Spell Trigger Create/Start] ************************/

#include "J_INC_CONSTANTS"

void main()
{
    // Set to eathreal and whatever
    effect eInvis = EffectEthereal(); // So we cannot be targeted.
    effect eCutseen = EffectVisualEffect(VFX_DUR_CUTSCENE_INVISIBILITY); // Not seen!
    effect eGhost = EffectCutsceneGhost(); // To move into the casters location
    effect eSee = EffectTrueSeeing(); // To see the spell target

    // Link
    effect eLink = EffectLinkEffects(eInvis, eCutseen);
    eLink = EffectLinkEffects(eLink, eGhost);
    eLink = EffectLinkEffects(eLink, eSee);
    // Supernatural
    eLink = SupernaturalEffect(eLink);

    // Apply visuals
    ApplyEffectToObject(DURATION_TYPE_PERMANENT, eLink, OBJECT_SELF, 99999.0);

    // Set ignore for AI
    SetIgnore(OBJECT_SELF);

    // Set local for heartbeat ignore (for 8 seconds)
    DelayCommand(8.0, SetLocalInt(OBJECT_SELF, "HEARTBEAT_DO", TRUE));
}
