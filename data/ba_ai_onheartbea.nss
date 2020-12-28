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

void writeToLog(string str) {
    string oAreaName = GetName(GetArea(OBJECT_SELF));
    WriteTimestampedLogEntry("Bandit Camp: " + oAreaName + ": " +  str);
}

/**
 *  Select a random valid Location in camp.
 */
location getNextWaypoint(object oArea, location campfireLoc,
                              int radiusBase) {
    float theta = 0.0;
    float randFloat = GetLocalFloat(OBJECT_SELF, "randFloat");
    if(randFloat == 0.0) {
        theta = Random(360) / 1.0;
        randFloat = (Random(4) + 1)/4.0;
        SetLocalFloat(OBJECT_SELF, "randFloat", randFloat);
    }
    float radius = 5 * (radiusBase + randFloat);
    float direction = GetLocalFloat(OBJECT_SELF, "direction");
    string uuid = GetLocalString(OBJECT_SELF, "uuid");
    theta = GetLocalFloat(OBJECT_SELF, "theta");

    if(uuid == "") {
        SetLocalString(OBJECT_SELF, "uuid", GetRandomUUID());
    }

    if(direction == 0.0) {
        if(Random(1) == 0){
            SetLocalFloat(OBJECT_SELF, "direction", -1.0);
        } else {
            SetLocalFloat(OBJECT_SELF, "direction", 1.0);
        }
    }

    theta = theta + (direction * (50.0/radiusBase));
    if(theta > 360.0) {
        theta = theta - 360;
    }
    if(theta < -360.0) {
        theta = theta + 360;
    }

    SetLocalFloat(OBJECT_SELF, "theta", theta);

    writeToLog(uuid + " theta: " + FloatToString(theta) +
                    " direction " + FloatToString(direction));

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

void main()
{
    // If were in combat exit.
    if(GetIsInCombat()){
        return;
    }

    object oArea = GetArea(OBJECT_SELF);
    int myAction = GetLocalInt(OBJECT_SELF, "action");

    // myAction 0 means no action. So just wait to despawn.
    if(myAction == 0) {
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
                SetCampaignInt("FACTION_ACTIVITY",
                               "BANDIT_ACTIVITY_LEVEL_2147440",
                               banditActivityLevel + 1);
                DestroyObject(OBJECT_SELF, 2.0);
            }
        } else {
            SetLocalInt(OBJECT_SELF, "NoPCSeenIn", 0);
            //WriteTimestampedLogEntry("PCs Found");
        }
    // Otherwise lets do what we decided.
    // 1) Patrol around the fire using circle max
    // 2) Sit on the ground near the fire.
    // 3) Interact with random objects near by.
    // 4) Stand there?
    } else {
        location campfireLoc = GetLocalLocation(OBJECT_SELF, "campfireLoc");
        int patrolCircle = GetLocalInt(OBJECT_SELF, "circle_max") + 2;

        writeToLog("Action Choice: " + IntToString(myAction));

        // Patrol around camp parimiter.
        if(myAction == 1) {
            location nextWP = getNextWaypoint(oArea, campfireLoc, patrolCircle);
            AssignCommand(OBJECT_SELF, ActionMoveToLocation(nextWP, FALSE));
        }
        // Sit on the ground near the fire
        if(myAction == 2) {

        }
        // Interact with random objects near by.
        if(myAction == 3) {

        }
    }
}
