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
#include "nwnx_area"
#include "_btb_ban_util"
#include "ba_consts"
#include "_btb_util"

/**
 *  Select next walk waypoint.
 */
location getNextWaypoint2(object oArea, location campfireLoc, int radiusBase) {
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
        //writeToLog(" # I moved back now looking to do something new.");
        SetLocalInt(OBJECT_SELF, "action", Random(3) + 1);
    } else {
        writeToLog(" # moving back");
        ActionMoveToLocation(spawnloc, TRUE);
    }
}

void patrolAroundCamp(object oArea, location campfireLoc, int patrolCircle) {
    int wait = GetLocalInt(OBJECT_SELF, "turnsWaited");
    if(notTooClose() && wait == 0 && locatonIsValid(campfireLoc)) {
        //writeToLog(" # Not to close so next wp");
        location nextWP = getNextWaypoint2(oArea, campfireLoc, patrolCircle);
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
        location nextWP = getNextWaypoint2(oArea, patrolLoc, circle);
        AssignCommand(OBJECT_SELF, ActionMoveToLocation(nextWP, FALSE));
        } else if(wait >= 1) {
            SetLocalInt(OBJECT_SELF, "turnsWaited", 0);
        } else {
            SetLocalInt(OBJECT_SELF, "turnsWaited", 1);
    }
}

void sitOnTheGround(object oArea, location campfireLoc) {
    //writeToLog(" # Sit on the groud.");
    location sitWP = getSitWaypoint(oArea, campfireLoc);
    AssignCommand(OBJECT_SELF, ActionMoveToLocation(sitWP, FALSE));
    AssignCommand(OBJECT_SELF, ActionPlayAnimation(
        ANIMATION_LOOPING_SIT_CROSS, 1.0, 9999999.0));
}

void sleepByTheFire() {

}

void main()
{
    /* The best way to make ai not look dumb is to try to keep what it does to
     * minimum.  So I will try to do that here as much as i can.
     */

    object oArea = GetArea(OBJECT_SELF);
    int myAction = GetLocalInt(OBJECT_SELF, "action");

    // myAction 0 means no action. So just wait to despawn.
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
    } else {
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
            location attakerLoc = GetLocalLocation(OBJECT_SELF, "attackerLoc");
            patrolAroundHostileArea(oArea, attakerLoc, hbSinceCombat);
        }

        // Patrol an increased range.
        if(myAction == BANDIT_ATTACK_PATROL_ACTION) {
            writeToLog(" # BANDIT_ATTACK_PATROL_ACTION");
            patrolAroundCamp(oArea, campfireLoc, patrolCircle + 10);
        }

        writeToLog("Action Choice: " + IntToString(myAction));

        // Move back to inital location.
        if(myAction == BANDIT_RETURN_ACTION) {
            writeToLog(" # BANDIT_RETURN_ACTION");
            returnToStartLoc();
        }
        // Patrol around camp parimiter. It too close to another bandit wait.
        if(myAction == BANDIT_PATROL_ACTION) {
            writeToLog(" # BANDIT_PATROL_ACTION");
            patrolAroundCamp(oArea, campfireLoc, patrolCircle);
        }
        // Sit on the ground near the fire
        if(myAction == BANDIT_SIT_ACTION) {
            writeToLog(" # BANDIT_SIT_ACTION");
            sitOnTheGround(oArea, campfireLoc);
        }
        // Sleep near the fire.
        if(myAction == BANDIT_SLEEP_ACTION) {

        }
        // Interact with random objects near by.
        //if(myAction == BANDIT_INTERACT_ACTION) {

        //}

    }
}
