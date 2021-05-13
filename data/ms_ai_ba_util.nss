#include "ba_consts"
#include "nwnx_data"
#include "_btb_ban_util"
#include "_btb_util"

/**
 *  Select a random valid Location in camp.
 */
location selectLocationInCamp(object oArea, location campfireLoc,
                              int circle_min, int circle_max) {
    int radius = 5 * (Random(circle_max - circle_min) + circle_min);
    int radSqr = radius * radius;
    int xsqr = Random(radSqr);
    int ysqr = radSqr - xsqr;

    float x = sqrt(IntToFloat(xsqr));
    float y = sqrt(IntToFloat(ysqr));

    if(Random(2) == 1) {
        x = x * -1;
    }

    if(Random(2) == 1) {
        y = y * -1;
    }

    vector campfireVector = GetPositionFromLocation(campfireLoc);
    location possibleStructureLoc = Location(oArea,
        Vector(campfireVector.x + x, campfireVector.y+ y, 0.0), 0.0);
    float z = GetGroundHeight(possibleStructureLoc);

    possibleStructureLoc = Location(oArea,
        Vector(campfireVector.x + x, campfireVector.y+ y, z),
            getBanditFacing(campfireVector,
                GetPositionFromLocation(possibleStructureLoc)));

    return possibleStructureLoc;
}

void moveToLocationInCamp(object sourceBandit, object campFire) {
    object oArea = GetArea(sourceBandit);
    int max_circle = GetLocalInt(campFire, "circle_max");
    location campfireLoc = GetLocation(campFire);
    location runToLoc = selectLocationInCamp(oArea, campfireLoc, max_circle,
                                             max_circle);

    // Check if we got a valid location back
    if(GetAreaFromLocation(runToLoc) == OBJECT_INVALID) {
        return;
    }

    AssignCommand(sourceBandit, ActionMoveToLocation(runToLoc, TRUE));
}

void getIntoPosition(object curBandit, location runLoc, object campFire) {

    int decision = d3();

    // Take up a defensive position in camp
    if(decision == 3) {
        moveToLocationInCamp(curBandit, campFire);
    // 2/3 run to the attacked bandit
    } else {
        float distance = ((Random(8) + 1) / (Random(4) + 1)) * 3.0;
        location runToLoc = pickLocFromLoc(runLoc, distance,
                                           Random(360) * 1.0);
        AssignCommand(curBandit, ActionMoveToLocation(runToLoc, TRUE));
    }
}

void setAttackAI(object curBandit, object sourceBandit, location runLoc,
                 object campFire) {

    if(curBandit != sourceBandit) {
        getIntoPosition(curBandit, runLoc, campFire);
    }

    // cant set ms_ai_bah_onspaw
    SetEventScript(curBandit, EVENT_SCRIPT_CREATURE_ON_BLOCKED_BY_DOOR,
                   "ms_ai_bah_onbloc");
    SetEventScript(curBandit, EVENT_SCRIPT_CREATURE_ON_END_COMBATROUND,
                   "ms_ai_bah_ocomba");
    SetEventScript(curBandit, EVENT_SCRIPT_CREATURE_ON_DIALOGUE,
                   "ms_ai_bah_onconv");
    SetEventScript(curBandit, EVENT_SCRIPT_CREATURE_ON_DAMAGED,
                   "ms_ai_bah_ondama");
    SetEventScript(curBandit, EVENT_SCRIPT_CREATURE_ON_DEATH,
                   "ms_ai_bah_ondeat");
    SetEventScript(curBandit, EVENT_SCRIPT_CREATURE_ON_DISTURBED,
                   "ms_ai_bah_ondist");
    SetEventScript(curBandit, EVENT_SCRIPT_CREATURE_ON_HEARTBEAT,
                   "ms_ai_bah_onhear");
    SetEventScript(curBandit, EVENT_SCRIPT_CREATURE_ON_NOTICE,
                   "ms_ai_bah_onperc");
    SetEventScript(curBandit, EVENT_SCRIPT_CREATURE_ON_MELEE_ATTACKED,
                   "ms_ai_bah_onphia");
    SetEventScript(curBandit, EVENT_SCRIPT_CREATURE_ON_RESTED,
                   "ms_ai_bah_onrest");
    SetEventScript(curBandit, EVENT_SCRIPT_CREATURE_ON_SPELLCASTAT,
                   "ms_ai_bah_onspel");
    SetEventScript(curBandit, EVENT_SCRIPT_CREATURE_ON_USER_DEFINED_EVENT,
                   "ms_ai_bah_onuser");
}

void setCalmAI(object curBandit) {

    // cant set ms_ai_bap_onspaw
    SetEventScript(curBandit, EVENT_SCRIPT_CREATURE_ON_BLOCKED_BY_DOOR,
                   "ms_ai_bap_onbloc");
    SetEventScript(curBandit, EVENT_SCRIPT_CREATURE_ON_END_COMBATROUND,
                   "ms_ai_bap_ocomba");
    SetEventScript(curBandit, EVENT_SCRIPT_CREATURE_ON_DIALOGUE,
                   "ms_ai_bap_onconv");
    SetEventScript(curBandit, EVENT_SCRIPT_CREATURE_ON_DAMAGED,
                   "ms_ai_bap_ondama");
    SetEventScript(curBandit, EVENT_SCRIPT_CREATURE_ON_DEATH,
                   "ms_ai_bap_ondeat");
    SetEventScript(curBandit, EVENT_SCRIPT_CREATURE_ON_DISTURBED,
                   "ms_ai_bap_ondist");
    SetEventScript(curBandit, EVENT_SCRIPT_CREATURE_ON_HEARTBEAT,
                   "ms_ai_bap_onhear");
    SetEventScript(curBandit, EVENT_SCRIPT_CREATURE_ON_NOTICE,
                   "ms_ai_bap_onperc");
    SetEventScript(curBandit, EVENT_SCRIPT_CREATURE_ON_MELEE_ATTACKED,
                   "ms_ai_bap_onphia");
    SetEventScript(curBandit, EVENT_SCRIPT_CREATURE_ON_RESTED,
                   "ms_ai_bap_onrest");
    SetEventScript(curBandit, EVENT_SCRIPT_CREATURE_ON_SPELLCASTAT,
                   "ms_ai_bap_onspel");
    SetEventScript(curBandit, EVENT_SCRIPT_CREATURE_ON_USER_DEFINED_EVENT,
                   "ms_ai_bap_onuser");
}

void alertCamp(object sourceBandit, object target) {

    object campFire = GetLocalObject(sourceBandit, "bandit_campfire");

    if(campFire == OBJECT_INVALID) {
        WriteTimestampedLogEntry("campFire == OBJECT_INVALID");
    }

    // if an attack isnt already in progress.
    if(GetLocalInt(campFire, ATTACK_ON_CAMP_STATE) == BANDIT_ATTACK_NONE) {
        WriteTimestampedLogEntry("BANDIT onAttackActions: ONLY CALL ONCE!!!!");
        SetLocalInt(campFire, ATTACK_ON_CAMP_STATE, BANDIT_ATTACK_IN_PROGRESS);

        location runLoc = GetMidPoint(GetLocation(sourceBandit),
                                      GetLocation(target));

        // Loop over all the members of the campfire.
        int arraySize = NWNX_Data_Array_Size(NWNX_DATA_TYPE_OBJECT, campFire,
                                             BANDIT_OBJ_ARRAY);
        WriteTimestampedLogEntry("BANDIT onAttackActions: arraySize - " + IntToString(arraySize));
        int i = 0;
        while(i < arraySize) {

            if(i > 100) {
                WriteTimestampedLogEntry("WARNING: NEW LIMITER REACHED!!!");
                return;
            }

            object curBandit = NWNX_Data_Array_At_Obj(campFire,
                                                      BANDIT_OBJ_ARRAY,
                                                      i);

            // if our object is a creature set its attack state.
            if(GetObjectType(curBandit) == OBJECT_TYPE_CREATURE) {
                WriteTimestampedLogEntry("BANDIT onAttackActions: Tag - " + GetTag(curBandit) + " ATTACK");
                setAttackAI(curBandit, sourceBandit, runLoc, campFire);
            }else {
                WriteTimestampedLogEntry("BANDIT onAttackActions: Tag - " + GetTag(curBandit));
            }
            i++;
        }
    }
}

void calmCamp(object campFire) {

    if(campFire == OBJECT_INVALID) {
        WriteTimestampedLogEntry("campFire == OBJECT_INVALID");
    }

    // if an attack isnt already in progress.
    if(GetLocalInt(campFire, ATTACK_ON_CAMP_STATE) == BANDIT_ATTACK_IN_PROGRESS) {
        WriteTimestampedLogEntry("BANDIT calmActions: ONLY CALL ONCE!!!!");
        SetLocalInt(campFire, ATTACK_ON_CAMP_STATE, BANDIT_ATTACK_NONE);

        // Loop over all the members of the campfire.
        int arraySize = NWNX_Data_Array_Size(NWNX_DATA_TYPE_OBJECT, campFire,
                                             BANDIT_OBJ_ARRAY);
        WriteTimestampedLogEntry("BANDIT calmActions: arraySize - " + IntToString(arraySize));
        int i = 0;
        while(i < arraySize) {

            if(i > 100) {
                WriteTimestampedLogEntry("WARNING: NEW LIMITER REACHED!!!");
                return;
            }

            object curBandit = NWNX_Data_Array_At_Obj(campFire,
                                                      BANDIT_OBJ_ARRAY,
                                                      i);

            // if our object is a creature set its attack state.
            if(GetObjectType(curBandit) == OBJECT_TYPE_CREATURE) {
                WriteTimestampedLogEntry("BANDIT calmActions: Tag - " + GetTag(curBandit) + " Calm");
                setCalmAI(curBandit);
            }else {
                WriteTimestampedLogEntry("BANDIT calmActions: Tag - " + GetTag(curBandit));
            }
            i++;
        }
    }
}
