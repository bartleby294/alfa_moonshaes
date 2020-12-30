/************************ [Heartbeat Action Commoner] **************************
    Filename: J_AI_Civil_HB
************************* [Heartbeat Action Commoner] **************************
    This is used for a heartbeat for commoners.

    Contains animations, and animations, taken from the default heartbeat.
************************* [History] ********************************************
    1.3 - Added
************************* [Workings] *******************************************
    This uses the default AI file (nw_c2_defualt1) heartbeat, but with bits
    removed that will not be used.

    These include the checks for the fleeing checks, AI off checks, UDE's,
    AI level resetting, and looting and walking to PC.
************************* [Arguments] ******************************************
    Arguments: Settings On Spawn.
************************* [Heartbeat Action Commoner] *************************/

const float RUN_RANGE = 50.0;

// - This includes J_Inc_Constants
#include "J_INC_HEARTBEAT"

void main()
{
    // Define the enemy and player to use.
    object oEnemy = GetNearestCreature(CREATURE_TYPE_REPUTATION, REPUTATION_TYPE_ENEMY, OBJECT_SELF, 1, CREATURE_TYPE_PERCEPTION, PERCEPTION_SEEN);

    // Check seen enemy
    // - Flee!
    if(GetIsObjectValid(oEnemy))
    {
        ClearAllActions();
        // Run RUN_RANGE distance (default 50.0)
        ActionMoveAwayFromObject(oEnemy, TRUE, RUN_RANGE);
        return;
    }
    // Get player to use.
    object oPlayer = GetNearestCreature(CREATURE_TYPE_PLAYER_CHAR, PLAYER_CHAR_IS_PC);

    // We can skip to the end if we are in combat, or something...
    if(!JumpOutOfHeartBeat() && // We don't stop due to effects.
       !GetIsInCombat())        // We are not in combat.
    {
        // Execute waypoints file if we have waypoints set up.
        if(GetWalkCondition(NW_WALK_FLAG_CONSTANT))
        {
            ExecuteScript(FILE_WALK_WAYPOINTS, OBJECT_SELF);
        }
        // We can't have any waypoints for the other things
        else
        {
            // We must have animations set, and not be "paused", so doing a
            // longer looping one
            // - Need a valid player
            if(!GetIsObjectValid(oPlayer))
            {
                // Do we have any animations to speak of?
                // If we have a nearby PC, not in conversation, we do animations.
                if(!IsInConversation(OBJECT_SELF) &&
                   (GetSpawnInCondition(NW_FLAG_AMBIENT_ANIMATIONS, NW_GENERIC_MASTER) ||
                    GetSpawnInCondition(NW_FLAG_AMBIENT_ANIMATIONS_AVIAN, NW_GENERIC_MASTER) ||
                    GetSpawnInCondition(NW_FLAG_IMMOBILE_AMBIENT_ANIMATIONS, NW_GENERIC_MASTER)))
                {
                    ExecuteScript(FILE_HEARTBEAT_ANIMATIONS, OBJECT_SELF);
                }
            }
        }
    }
}
