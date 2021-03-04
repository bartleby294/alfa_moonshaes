/************************ [On Heartbeat] ***************************************
    Filename: nw_c2_default1 or j_ai_onheartbeat
************************* [On Heartbeat] ***************************************
    Removed stupid stuff, special behaviour, sleep.

    Also, note please, I removed waypoints and day/night posting from this.
    It can be re-added if you like, but it does reduce heartbeats.

    Added in better checks to see if we should fire this script. Stops early if
    some conditions (like we can't move, low AI settings) are set.

    Hint: If nothing is used within this script, either remove it from creatures
          or create one witch is blank, with just a "void main(){}" at the top.

    Hint 2: You could add this very small file to your catche of scripts in the
            module properties, as it runs on every creature every 6 seconds (ow!)

    This also uses a system of Execute Script :-D This means the heartbeat, when
    compiled, should be very tiny.

    Note: NO Debug strings!
    Note 2: Remember, I use default SoU Animations/normal animations. As it is
            executed, we can check the prerequisists here, and then do it VIA
            execute script.

    -Working- Best possible, fast compile.
************************* [History] ********************************************
    1.3 - Added more "buffs" to fast buff.
        - Fixed animations (they both WORK and looping ones do loop right!)
        - Loot behaviour!
        - Randomly moving nearer a PC in 25M if set.
        - Removed silly day/night optional setting. Anything we can remove, is a good idea.
************************* [Workings] *******************************************
    This fires off every 6 seconds (with PCs in the area, or AI_LEVEL_HIGH without)
    and therefore is intensive.

    It fires of ExecutesScript things for the different parts - saves CPU stuff
    if the bits are not used.
************************* [Arguments] ******************************************
    Arguments: Basically, none. Nothing activates this script. Fires every 6 seconds.
************************* [On Heartbeat] **************************************/

// - This includes J_Inc_Constants
#include "J_INC_HEARTBEAT"
#include "nwnx_area"
#include "_btb_ban_util"
#include "ba_consts"
#include "_btb_util"

/**
 *  Select next walk waypoint.
 */
location getNextWaypoint1(object oArea, location campfireLoc, int radiusBase) {
    float theta = GetLocalFloat(OBJECT_SELF, "theta");
    float randFloat = GetLocalFloat(OBJECT_SELF, "randFloat");
    if(randFloat == 0.0) {
        theta = Random(360) / 1.0;
        randFloat = (Random(4) + 1)/4.0;
        SetLocalFloat(OBJECT_SELF, "randFloat", randFloat);
    }
    float radius = (5 * radiusBase) + randFloat;
    float direction = GetLocalFloat(OBJECT_SELF, "direction");
    string uuid = GetLocalString(OBJECT_SELF, "uuid");

    if(uuid== "") {
        SetLocalString(OBJECT_SELF, "uuid", GetRandomUUID());
    }

    if(direction == 0.0) {
        if(Random(1) == 0){
            SetLocalFloat(OBJECT_SELF, "direction", -1.0);
        } else {
            SetLocalFloat(OBJECT_SELF, "direction", 1.0);
        }
    }

    theta = theta + (direction * (90.0/radiusBase));
    if(theta > 360.0) {
        theta = theta - 360;
    }
    if(theta < -360.0) {
        theta = theta + 360;
    }

    SetLocalFloat(OBJECT_SELF, "theta", theta);

    //writeToLog(" theta: " + FloatToString(theta) +
    //                " direction " + FloatToString(direction));

    float x = radius * cos(theta);
    float y = radius * sin(theta);

    vector campfireVector = GetPositionFromLocation(campfireLoc);
    location patrolLoc = Location(oArea,
        Vector(campfireVector.x + x, campfireVector.y+ y, 0.0), 0.0);
    float z = GetGroundHeight(patrolLoc);

    patrolLoc = Location(oArea,
        Vector(campfireVector.x + x, campfireVector.y+ y, z),
            getFacing(campfireVector, GetPositionFromLocation(patrolLoc)));

    return patrolLoc;
}

int notTooClose() {
    object bandit = GetNearestObjectByTag("banditcamper", OBJECT_SELF, 1);
    float distance = GetDistanceBetweenLocations(GetLocation(OBJECT_SELF),
                                                GetLocation(bandit));
    if(distance < 1.0) {
        writeToLog(" # Too close");
        return 0;
    }
    return 1;
}

/**
 *  Select a random valid Location in camp.
 */
location getSitWaypoint(object oArea, location campfireLoc) {
    vector campfireVec = GetPositionFromLocation(campfireLoc);
    vector banditVec = GetPosition(OBJECT_SELF);

    float x = (banditVec.x + campfireVec.x) / 2;
    float y = (banditVec.y + campfireVec.y) / 2;

    location sitLocation = Location(oArea, Vector(x, y, 0.0), 0.0);
    float z = GetGroundHeight(sitLocation);

    return Location(oArea, Vector(x, y, z), 0.0);
}

void returnToStartLoc() {
    //writeToLog(" # Was in combat now looking to move back");
    location myloc = GetLocation(OBJECT_SELF);
    location spawnloc = GetLocalLocation(OBJECT_SELF, "spawnLoc");
    if(GetDistanceBetweenLocations(myloc, spawnloc) < 1.0) {
        writeToLog(" # I moved back now looking to do something new.");
        SetLocalInt(OBJECT_SELF, "action", Random(BANDIT_MAX_ACTION) + 1);
    } else {
        writeToLog(" # moving back");
        ActionMoveToLocation(spawnloc, TRUE);
    }
}

void patrolAroundCamp(object oArea, location campfireLoc, int patrolCircle) {
    int wait = GetLocalInt(OBJECT_SELF, "turnsWaited");
    if(notTooClose() && wait == 0 && locatonIsValid(campfireLoc)) {
        //writeToLog(" # Not to close so next wp");
        location nextWP = getNextWaypoint1(oArea, campfireLoc, patrolCircle);
        AssignCommand(OBJECT_SELF, ActionMoveToLocation(nextWP, FALSE));
        } else if(wait >= 1) {
            SetLocalInt(OBJECT_SELF, "turnsWaited", 0);
        } else {
            SetLocalInt(OBJECT_SELF, "turnsWaited", 1);
    }
}

void patrolAroundHostileArea(object oArea, location patrolLoc, int circle) {
    int wait = GetLocalInt(OBJECT_SELF, "turnsWaited");
    if(notTooClose() && wait == 0 && locatonIsValid(patrolLoc)) {
        location nextWP = getNextWaypoint1(oArea, patrolLoc, circle);
        AssignCommand(OBJECT_SELF, ActionMoveToLocation(nextWP, FALSE));
        } else if(wait >= 1) {
            SetLocalInt(OBJECT_SELF, "turnsWaited", 0);
        } else {
            SetLocalInt(OBJECT_SELF, "turnsWaited", 1);
    }
}

void sitOnTheGround(object oArea, location campfireLoc) {
    //writeToLog(" # Sit on the groud.");
    putWeaponAway();
    int offset = (Random(GetLocalInt(OBJECT_SELF, "circle_max"))) * 5;
    location sitWP = selectLocationAroundFire(oArea, campfireLoc, offset + 1);
    AssignCommand(OBJECT_SELF, ActionMoveToLocation(sitWP, FALSE));
    AssignCommand(OBJECT_SELF, ActionPlayAnimation(
        ANIMATION_LOOPING_SIT_CROSS, 1.0, 9999999.0));
}

void sleepByTheFire(object oArea, location campfireLoc) {
    //writeToLog(" # Sleep on the groud.");
    int offset = (Random(GetLocalInt(OBJECT_SELF, "circle_max"))) * 5;
    location sleepWP = selectLocationAroundFire(oArea, campfireLoc, offset + 2);
    AssignCommand(OBJECT_SELF, ActionMoveToLocation(sleepWP, FALSE));
    putWeaponAway();
    if(Random(2) < 1) {
        AssignCommand(OBJECT_SELF, ActionPlayAnimation(
           ANIMATION_LOOPING_DEAD_BACK, 1.0, 9999999.0));
    } else {
        AssignCommand(OBJECT_SELF, ActionPlayAnimation(
           ANIMATION_LOOPING_DEAD_FRONT, 1.0, 9999999.0));
    }

}

void customActions(object oArea, int myAction) {
    location campfireLoc = GetLocalLocation(OBJECT_SELF, "campfireLoc");
    int patrolCircle = GetLocalInt(OBJECT_SELF, "circle_max") + 2;
    int beenInCombat = GetLocalInt(OBJECT_SELF, "beenInCombat");
    int hbSinceCombat = GetLocalInt(OBJECT_SELF, "hbSinceCombat");

    // If we're in combat
    if(GetIsInCombat(OBJECT_SELF)){
        writeToLog(" # Is in combat");
        SetLocalInt(OBJECT_SELF, "hbSinceCombat", 0);
        onAttackActions("");
        return;
    // if we are no longer in combat, have been recently, and cool down lapsed.
    } else if(myAction < 0 && hbSinceCombat > Random(3) + 15) {
        writeToLog(" # Was in combat not anymore");
        SetLocalInt(OBJECT_SELF, "hbSinceCombat", 0);
        SetLocalInt(OBJECT_SELF, "action", BANDIT_RETURN_ACTION);
    // if we are no longer in combat, have been recently, and not cooled down.
    } else if(myAction < 0) {
        writeToLog(" # Was in combat recently still on gaurd");
        SetLocalInt(OBJECT_SELF, "hbSinceCombat", hbSinceCombat + 1);
    }

    if(myAction == BANDIT_ATTACK_ACTION) {
        writeToLog(" # Is in combat!");
        if(!GetIsInCombat(OBJECT_SELF)){
            location lastAttackerLoc =
                               GetLocalLocation(OBJECT_SELF, "attackerLoc");
            AssignCommand(OBJECT_SELF,
                            ActionMoveToLocation(lastAttackerLoc , TRUE));
        }
    }

    // Search near where the attack occured
    if(myAction == BANDIT_ATTACK_SEARCH_ACTION) {
        writeToLog(" # BANDIT_ATTACK_SEARCH_ACTION");
        if(GetSpawnInCondition(AI_FLAG_OTHER_SEARCH_IF_ENEMIES_NEAR,
            AI_OTHER_MASTER) && !GetLocalTimer(AI_TIMER_SEARCHING)
            && d4() == i1) {
            ExecuteScript(FILE_HEARTBEAT_WALK_TO_PC, OBJECT_SELF);
        }
    }

    // Patrol an increased range.
    if(myAction == BANDIT_ATTACK_PATROL_ACTION) {
        writeToLog(" # BANDIT_ATTACK_PATROL_ACTION");
        patrolAroundCamp(oArea, campfireLoc, patrolCircle + 10);
    }

    //writeToLog("Action Choice: " + IntToString(myAction));

    // Move back to inital location. Or just stand gaurd.
    if(myAction == BANDIT_RETURN_ACTION) {
        writeToLog(" # BANDIT_RETURN_ACTION");
        returnToStartLoc();
    }
    // Patrol around camp parimiter. It too close to another bandit wait.
    if(myAction == BANDIT_PATROL_ACTION) {
        //writeToLog(" # BANDIT_PATROL_ACTION");
        patrolAroundCamp(oArea, campfireLoc, patrolCircle);
    }
    // Sit on the ground near the fire
    if(myAction == BANDIT_SIT_ACTION) {
        //writeToLog(" # BANDIT_SIT_ACTION");
        sitOnTheGround(oArea, campfireLoc);
    }
    // Sleep near the fire.
    if(myAction == BANDIT_SLEEP_ACTION) {
        //writeToLog(" # BANDIT_SLEEP_ACTION");
        sleepByTheFire(oArea, campfireLoc);
    }
    // Interact with random objects near by.
    //if(myAction == BANDIT_INTERACT_ACTION) {
    //
    //}
}

void main()
{
    object oArea = GetArea(OBJECT_SELF);
    int myAction = GetLocalInt(OBJECT_SELF, "action");
    if(myAction == BANDIT_NO_ACTION) {
        int oAreaPlayerNumber = NWNX_Area_GetNumberOfPlayersInArea(oArea);
        if(oAreaPlayerNumber == 0) {
            //WriteTimestampedLogEntry("No PCs Found");
            int noPCSeenIn = GetLocalInt(OBJECT_SELF, "NoPCSeenIn");
            SetLocalInt(OBJECT_SELF, "NoPCSeenIn", noPCSeenIn + 1);
            // Each time a bandit wins or is run away from they are emboldened.
            if(noPCSeenIn > 5) {
                //WriteTimestampedLogEntry("Destroying myself");
                int banditActivityLevel = GetCampaignInt("FACTION_ACTIVITY",
                                               "BANDIT_ACTIVITY_LEVEL_2147440");
                //SetCampaignInt("FACTION_ACTIVITY",
                //               "BANDIT_ACTIVITY_LEVEL_2147440",
                //               banditActivityLevel + 1);
                DestroyObject(OBJECT_SELF, 2.0);
            }
        } else {
            SetLocalInt(OBJECT_SELF, "NoPCSeenIn", 0);
            //WriteTimestampedLogEntry("PCs Found");
        }
    }

    // Special - Runner from the leader shouts, each heartbeat, to others to get thier
    // attention that they are being attacked.
    // - Includes fleeing making sure (so it resets the ActionMoveTo each 6 seconds -
    //   this is not too bad)
    // - Includes door bashing stop heartbeat
    if(PerformSpecialAction()) return;

    // Pre-heartbeat-event
    if(FireUserEvent(AI_FLAG_UDE_HEARTBEAT_PRE_EVENT, EVENT_HEARTBEAT_PRE_EVENT))
        // We may exit if it fires
        if(ExitFromUDE(EVENT_HEARTBEAT_PRE_EVENT)) return;

    // AI status check. Is the AI on?
    if(GetAIOff() || GetSpawnInCondition(AI_FLAG_OTHER_LAG_IGNORE_HEARTBEAT, AI_OTHER_MASTER)) return;

    // Define the enemy and player to use.
    object oEnemy = GetNearestCreature(CREATURE_TYPE_REPUTATION, REPUTATION_TYPE_ENEMY);
    object oPlayer = GetNearestCreature(CREATURE_TYPE_PLAYER_CHAR, PLAYER_CHAR_IS_PC);
    int iTempInt;

    // AI level (re)setting
    if(!GetIsInCombat() && !GetIsObjectValid(GetAttackTarget()) &&
       (GetIsObjectValid(oEnemy) && GetDistanceToObject(oEnemy) <= f50 ||
        GetIsObjectValid(oPlayer) && GetDistanceToObject(oPlayer) <= f50))
    {
        // AI setting, normally higher then normal.
        iTempInt = GetAIConstant(LAG_AI_LEVEL_YES_PC_OR_ENEMY_50M);
        if(iTempInt > iM1 && GetAILevel() != iTempInt)
        {
            SetAILevel(OBJECT_SELF, iTempInt);
        }
    }
    else
    {
        // AI setting, normally higher then normal.
        iTempInt = GetAIConstant(LAG_AI_LEVEL_NO_PC_OR_ENEMY_50M);
        if(iTempInt > iM1 && GetAILevel() != iTempInt)
        {
            SetAILevel(OBJECT_SELF, iTempInt);
        }
    }

    // We can skip to the end if we are in combat, or something...
    if(!JumpOutOfHeartBeat() && // We don't stop due to effects.
       !GetIsInCombat() &&      // We are not in combat.
       !GetIsObjectValid(GetAttackTarget()) && // Second combat check.
       !GetObjectSeen(oEnemy))  // Nearest enemy is not seen.
    {
        // Fast buffing...if we have the spawn in condition...
        if(GetSpawnInCondition(AI_FLAG_COMBAT_FLAG_FAST_BUFF_ENEMY, AI_COMBAT_MASTER) &&
           GetIsObjectValid(oEnemy) && GetDistanceToObject(oEnemy) <= f40)
        {
            // ...we may do an advanced buff. If we cannot see/hear oEnemy, but oEnemy
            // is within 40M, we cast many defensive spells instantly...
            ExecuteScript(FILE_HEARTBEAT_TALENT_BUFF, OBJECT_SELF);
            //...if TRUE (IE it does something) we turn of future calls.
            DeleteSpawnInCondition(AI_FLAG_COMBAT_FLAG_FAST_BUFF_ENEMY, AI_COMBAT_MASTER);
            // This MUST STOP the heartbeat event - else, the actions may be interrupted.
            return;
        }
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
            // - Need a valid player.
            if(GetIsObjectValid(oPlayer))
            {
                // Do we have any animations to speak of?
                // If we have a nearby PC, not in conversation, we do animations.
                //if(!IsInConversation(OBJECT_SELF) &&
                //    GetAIInteger(AI_VALID_ANIMATIONS))
                //{
                //    ExecuteScript(FILE_HEARTBEAT_ANIMATIONS, OBJECT_SELF);
                //}
                // We may search for PC enemies :-) move closer to PC's
                //else if(GetSpawnInCondition(AI_FLAG_OTHER_SEARCH_IF_ENEMIES_NEAR, AI_OTHER_MASTER) &&
                //       !GetLocalTimer(AI_TIMER_SEARCHING) && d4() == i1)
                //{
                //    ExecuteScript(FILE_HEARTBEAT_WALK_TO_PC, OBJECT_SELF);
                //}
                customActions(oArea, myAction);

            }
        }
    }
    // Fire End-heartbeat-UDE
    FireUserEvent(AI_FLAG_UDE_HEARTBEAT_EVENT, EVENT_HEARTBEAT_EVENT);
}
