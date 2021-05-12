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
        SetLocalInt(OBJECT_SELF, BANDIT_ACTION_STATE, Random(BANDIT_MAX_ACTION) + 1);
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
    /*if(GetIsInCombat(OBJECT_SELF)){
        writeToLog(" # Is in combat");
        //SetLocalInt(OBJECT_SELF, "hbSinceCombat", 0);
        //onAttackActions("");
        return;
    // if we are no longer in combat, have been recently, and cool down lapsed.
    } else if(myAction < 0 && hbSinceCombat > Random(3) + 15) {
        writeToLog(" # Was in combat not anymore");
        //SetLocalInt(OBJECT_SELF, "hbSinceCombat", 0);
        //SetLocalInt(OBJECT_SELF, BANDIT_ACTION_STATE, BANDIT_RETURN_ACTION);
    // if we are no longer in combat, have been recently, and not cooled down.
    } else if(myAction < 0) {
        writeToLog(" # Was in combat recently still on gaurd");
        //SetLocalInt(OBJECT_SELF, "hbSinceCombat", hbSinceCombat + 1);
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
            && d4() == 1) {
            ExecuteScript(FILE_HEARTBEAT_WALK_TO_PC, OBJECT_SELF);
        }
    }

    // Patrol an increased range.
    if(myAction == BANDIT_ATTACK_PATROL_ACTION) {
        writeToLog(" # BANDIT_ATTACK_PATROL_ACTION");
        patrolAroundCamp(oArea, campfireLoc, patrolCircle + 10);
    }*/

    //writeToLog("Action Choice: " + IntToString(myAction));

    // Move back to inital location. Or just stand gaurd.
    //if(myAction == BANDIT_RETURN_ACTION) {
    //    writeToLog(" # BANDIT_RETURN_ACTION");
    //    returnToStartLoc();
    //}
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

void main(){

    object oArea = GetArea(OBJECT_SELF);
    int myAction = GetLocalInt(OBJECT_SELF, BANDIT_ACTION_STATE);
    int destroySelf = GetLocalInt(OBJECT_SELF, BANDIT_DESTROY_SELF);

    //SpeakString("My Action: " + IntToString(myAction));

    if(destroySelf == TRUE) {
        //writeToLog("DESTROY SELF ON HEARTBEAT TRUE.");
        SetIsDestroyable(TRUE,FALSE,FALSE);
        DestroyObject(OBJECT_SELF, 2.0);
        return;
    } else {
        //writeToLog("DESTROY SELF ON HEARTBEAT FALSE.");
        customActions(oArea, myAction);
    }
}
