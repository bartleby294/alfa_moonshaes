/************************ [Hostile Action Commoner] ****************************
    Filename: J_AI_Civil_Speak
************************* [Hostile Action Commoner] ****************************
    This handles normal default talking.

    Because they have no speak strings to listen to, or shouldn't have, the
************************* [History] ********************************************
    1.3 - Added
************************* [Workings] *******************************************
    This one should go in:
    - On Conversation

    + For OnPhisicalAttacked, OnDamaged, OnSpellCastAt and OnDisturbed, use the
      file "J_AI_Civil_Host"
    + For the OnBlocked event, using the default should be fine.
    + The OnPerception, OnRested and OnCombatRoundEnd events scripts can be
      "J_AI_Civil_Empty". This is to stop any odd behaviour.
    + Spawn file script "J_AI_Civil_Spawn"
    + Heartbeat script is "J_AI_Civil_HB"
************************* [Arguments] ******************************************
    Arguments: RUN_RANGE can be set.
************************* [Hostile Action Commoner] ***************************/

void main()
{
    // Conversation if not a shout.
    if(GetListenPatternNumber() == -1)
    {
        // Make sure we are not fighting.
        if(!GetIsInCombat())
        {
            ClearAllActions();
            BeginConversation();
        }
    }
}
