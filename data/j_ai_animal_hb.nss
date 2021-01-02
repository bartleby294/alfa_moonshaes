/************************ [Animal Heartbeat] ***********************************
    Filename: J_AI_animal_hb
************************* [Animal Heartbeat] ***********************************
    This makes the animal run away from any creature (neutral, or hostile) who
    comes within 20M of them.

    No enemies means random walking - as animals cannot talk.

    Simple, effective, and better on CPU!
************************* [History] ********************************************
    1.3 - Added
************************* [Workings] *******************************************
    This uses no spawn options, no settings, and is fast.

    You can either have the other slots containing the files "AI_Civil_XXX"
    which makes them run away from hostile people (who attack them) or leave
    them blank.

    This runs away from any NEUTRAL people in 20M, and ANY HOSTILEs - but note
    that it will not run away from NEUTRAL Druids and Rangers, nor FRIENDLY
    things (like other animals!)
************************* [Arguments] ******************************************
    Arguments: Some constants (like run range)
************************* [Animal Heartbeat] **********************************/

// How near a neutral has to be.
const float NEUTRAL_DISTANCE = 20.0;
// How far they run away
const float RUN_RANGE        = 50.0;

void main()
{
    // Get the nearest enemy.
    object oEnemy = GetNearestCreature(CREATURE_TYPE_REPUTATION, REPUTATION_TYPE_ENEMY);

    // If valid, run away.
    if(GetIsObjectValid(oEnemy))
    {
        // Stop and action move away.
        ClearAllActions();
        // RUN_RANGE run distance.
        ActionMoveAwayFromObject(oEnemy, TRUE, RUN_RANGE);
        return;
    }

    // Check neutrals
    // - Loop through until we get to the max distance or a non-druid, non-ranger.
    int iCnt = 1;
    int iBreak = FALSE;
    object oNeutral = GetNearestCreature(CREATURE_TYPE_REPUTATION, REPUTATION_TYPE_NEUTRAL, OBJECT_SELF, iCnt);

    // Loop
    while(GetIsObjectValid(oNeutral) && iBreak != TRUE &&
          GetDistanceToObject(oNeutral) <= NEUTRAL_DISTANCE)
    {
        // Check if they are a ranger or druid
        if(!GetLevelByClass(CLASS_TYPE_DRUID, oNeutral) &&
           !GetLevelByClass(CLASS_TYPE_RANGER, oNeutral))
        {
            // If not, run from them!
            oEnemy = oNeutral;
            iBreak = TRUE;
        }
        iCnt++;
        oNeutral = GetNearestCreature(CREATURE_TYPE_REPUTATION, REPUTATION_TYPE_NEUTRAL, OBJECT_SELF, iCnt);
    }

    // Check if we caught anyone
    if(GetIsObjectValid(oEnemy))
    {
        // Stop and action move away.
        ClearAllActions();
        // RUN_RANGE run distance.
        ActionMoveAwayFromObject(oEnemy, TRUE, RUN_RANGE);
        return;
    }

    // Randomwalk otherwise
    ClearAllActions();
    ActionRandomWalk();
}
