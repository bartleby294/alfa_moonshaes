#include "ba_consts"
#include "nwnx_data"

void getIntoPosition(object curBandit) {

}

void setAttackAI(object curBandit, object sourceBandit) {

    if(curBandit != sourceBandit) {
        getIntoPosition(curBandit);
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

void alertCamp(object sourceBandit) {

    object campFire = GetLocalObject(sourceBandit, "bandit_campfire");

    if(campFire == OBJECT_INVALID) {
        WriteTimestampedLogEntry("campFire == OBJECT_INVALID");
    }

    // if an attack isnt already in progress.
    if(GetLocalInt(campFire, ATTACK_ON_CAMP_STATE) == BANDIT_ATTACK_NONE) {
        WriteTimestampedLogEntry("BANDIT onAttackActions: ONLY CALL ONCE!!!!");
        SetLocalInt(campFire, ATTACK_ON_CAMP_STATE, BANDIT_ATTACK_IN_PROGRESS);

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
                setAttackAI(curBandit, sourceBandit);
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
