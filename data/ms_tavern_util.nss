#include "nwnx_data"
#include "nwnx_object"
#include "ms_tavern_const"

int IsInNPCTrigger(object trigger, object obj) {

    if(NWNX_Object_GetPositionIsInTrigger(trigger, GetPosition(obj))) {
            return TRUE;
    }

    return FALSE;
}

int IsInAnNPCTrigger(object oTarget, object obj) {
    int i = 1;
    object trigger = GetNearestObjectByTag(MS_TAVERN_NPC_SEATING_TRIGGER_TAG,
                                           oTarget, i);
    while (trigger != OBJECT_INVALID) {
        if(IsInNPCTrigger(trigger, obj)) {
            return TRUE;
        }
        i++;
        trigger = GetNearestObjectByTag(MS_TAVERN_NPC_SEATING_TRIGGER_TAG,
                                        oTarget, i);
    }

    return FALSE;
}

void GatherObjectToArray(object oTarget, string tag, string arrayTag,
                         object oArea) {
    int i = 1;
    object obj = GetNearestObjectByTag(tag, oTarget, i);
    while (obj != OBJECT_INVALID) {
        NWNX_Data_Array_PushBack_Obj(oArea, arrayTag, obj);
        i++;
        obj = GetNearestObjectByTag(tag, oTarget, i);
    }
}

void GatherViableChairs(object oTarget, string tag, string arrayTag,
                        object oArea) {
    int i = 1;
    object obj = GetNearestObjectByTag(tag, oTarget, i);
    while (obj != OBJECT_INVALID) {
        if(IsInAnNPCTrigger(oTarget, obj)) {
            NWNX_Data_Array_PushBack_Obj(oArea, arrayTag, obj);
        }
        i++;
        obj = GetNearestObjectByTag(tag, oTarget, i);
    }
}

void InitalizeTavernArea(object oArea, object oTarget) {

    // Gather Doors.
    GatherObjectToArray(oTarget, MS_TAVERN_DOOR_TAG, MS_TAVERN_DOOR_ARRAY,
                        oArea);

    // Gather Walk Waypoints.
    GatherObjectToArray(oTarget, MS_TAVERN_WALK_WP_TAG, MS_TAVERN_WALK_WP_ARRAY,
                        oArea);

    // Gather viable chairs.
    GatherViableChairs(oTarget, MS_TAVERN_CHAIR_TAG, MS_TAVERN_CHAIR_ARRAY,
                       oArea);

    SetLocalInt(oArea, MS_TAVERN_INITALIZED, TRUE);
}

int GetChairCount(object oControler, object oArea) {

    // initalize chair count
    int chairCnt = GetLocalInt(oControler, MS_TAVERN_CHAIR_COUNT);
    if(chairCnt == 0) {
        chairCnt = NWNX_Data_Array_Size(NWNX_DATA_TYPE_OBJECT,
                                            oArea, MS_TAVERN_CHAIR_ARRAY);
        SetLocalInt(oControler, MS_TAVERN_CHAIR_COUNT, chairCnt);
    }

    return chairCnt;
}

int GetDoorCount(object oControler, object oArea) {

    // initalize door count
    int doorCnt = GetLocalInt(oControler, MS_TAVERN_DOOR_COUNT);
    if(doorCnt == 0) {
        doorCnt = NWNX_Data_Array_Size(NWNX_DATA_TYPE_OBJECT,
                                            oArea, MS_TAVERN_DOOR_ARRAY);
        SetLocalInt(oControler, MS_TAVERN_DOOR_COUNT, doorCnt);
    }

    return doorCnt;
}

int GetWaypointCount(object oControler, object oArea) {

    // initalize door count
    int wpCnt = GetLocalInt(oControler, MS_TAVERN_WALK_WP_COUNT);
    if(wpCnt == 0) {
        wpCnt = NWNX_Data_Array_Size(NWNX_DATA_TYPE_OBJECT,
                                            oArea, MS_TAVERN_WALK_WP_ARRAY);
        SetLocalInt(oControler, MS_TAVERN_WALK_WP_COUNT, wpCnt);
    }

    return wpCnt;
}

int GetPatronCount(object oControler, object oArea) {

    int i = 0;
    int patronCnt = GetLocalInt(oControler, MS_TAVERN_PATRON_COUNT);
    if(patronCnt == 0) {
        object obj = GetNearestObjectByTag(MS_TAVERN_PATRON_TAG, oControler, i);
        while (obj != OBJECT_INVALID) {
            patronCnt++;
            obj = GetNearestObjectByTag(MS_TAVERN_PATRON_TAG, oControler, i);
        }
    }

    return patronCnt;
}

object CreateRandomPatron(object oControler, object oArea, location spawnLoc,
                          int patronCnt) {

    string resRef = "innpatron" + IntToString(Random(10) + 1);
    object patron = CreateObject(OBJECT_TYPE_CREATURE, resRef, spawnLoc, FALSE,
                                 MS_TAVERN_PATRON_TAG);
    SetEventScript(patron, EVENT_SCRIPT_CREATURE_ON_HEARTBEAT,
                   "ms_tavern_on_hb");

    if(oControler != OBJECT_INVALID) {
        SetLocalInt(oControler, MS_TAVERN_PATRON_COUNT, patronCnt + 1);
    }

    return patron;
}

int isZeroPatrons(object oArea) {
    int rv = TRUE;
    object obj = GetNearestObjectByTag(MS_TAVERN_PATRON_TAG,
                                       GetFirstObjectInArea(oArea));
    if(obj != OBJECT_INVALID) {
        rv = FALSE;
    }

    return rv;
}
