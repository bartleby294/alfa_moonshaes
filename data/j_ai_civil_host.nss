/************************ [Hostile Action Commoner] ****************************
    Filename: J_AI_Civil_host
************************* [Hostile Action Commoner] ****************************
    This is used for commoners, or civilians, in several events - they never fight,
    and therefore this is a lot quicker at running!

    Also can be used in animal events, using the script "J_AI_Animal_HB" on the
    heartbeat to run away from enemies and neutrals.
************************* [History] ********************************************
    1.3 - Added
************************* [Workings] *******************************************
    This file handles several events, getting the last thing to attack them and
    running from it.

    This one should go in:
    - On Phisical Attacked
    - On Damaged
    - On Spell Cast At
    - On Disturbed

    + For the OnBlocked event, using the default should be fine.
    + The OnPerception, OnRested and OnCombatRoundEnd events scripts can be
      "J_AI_Civil_Empty". This is to stop any odd behaviour.
    + Spawn file script "J_AI_Civil_Spawn"
    + Conversation script is "J_AI_Civil_Speak"
    + Heartbeat script is "J_AI_Civil_HB"
************************* [Arguments] ******************************************
    Arguments: RUN_RANGE can be set.
************************* [Hostile Action Commoner] ***************************/

const float RUN_RANGE = 50.0;

void main()
{
    // Generic: We get last hostile actor:
        // Get the last object that was sent as a GetLastAttacker(), GetLastDamager(),
        // GetLastSpellCaster() (for a hostile spell), or GetLastDisturbed() (when a
        // creature is pickpocketed).
        // Note: Return values may only ever be:
        // 1) A Creature
        // 2) Plot Characters will never have this value set
        // 3) Area of Effect Objects will return the AOE creator if they are registered
        //    as this value, otherwise they will return INVALID_OBJECT_ID
        // 4) Traps will not return the creature that set the trap.
        // 5) This value will never be overwritten by another non-creature object.
        // 6) This value will never be a dead/destroyed creature
    object oHostileActor = GetLastHostileActor();

    if(GetIsObjectValid(oHostileActor))
    {
        // Perfect!
        // Then...we flee from them!
        if(d4() == TRUE) PlayVoiceChat(VOICE_CHAT_FLEE);
        ClearAllActions();
        // Run RUN_RANGE distance (default 50.0)
        ActionMoveAwayFromObject(oHostileActor, TRUE, RUN_RANGE);
    }
    else
    {
        ClearAllActions();// Just as backup, stop doing things as the event
                          // should be something hostile.
    }
}
