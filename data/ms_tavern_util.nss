#include "nwnx_data"
#include "nwnx_object"
#include "ms_tavern_const"
#include "nwnx_time"
#include "nwnx_area"

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

    // Gather Walk Waypoints.
    GatherObjectToArray(oTarget, MS_TAVERN_BAR_TAG, MS_TAVERN_BAR_ARRAY,
                        oArea);

    // Gather Walk Waypoints.
    GatherObjectToArray(oTarget, MS_TAVERN_STAND_TAG, MS_TAVERN_STAND_ARRAY,
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

int GetBarCount(object oControler, object oArea) {

    // initalize chair count
    int barCnt = GetLocalInt(oControler, MS_TAVERN_BAR_COUNT);
    if(barCnt == 0) {
        barCnt = NWNX_Data_Array_Size(NWNX_DATA_TYPE_OBJECT,
                                            oArea, MS_TAVERN_BAR_ARRAY);
        SetLocalInt(oControler, MS_TAVERN_BAR_COUNT, barCnt);
    }

    return barCnt;
}

int GetStandCount(object oControler, object oArea) {

    // initalize chair count
    int standCnt = GetLocalInt(oControler, MS_TAVERN_STAND_COUNT);
    if(standCnt == 0) {
        standCnt = NWNX_Data_Array_Size(NWNX_DATA_TYPE_OBJECT,
                                            oArea, MS_TAVERN_STAND_ARRAY);
        SetLocalInt(oControler, MS_TAVERN_STAND_COUNT, standCnt);
    }

    return standCnt;
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

    int patronCnt = GetLocalInt(oControler, MS_TAVERN_PATRON_COUNT);
    if(patronCnt == 0) {
        object obj = GetNearestObjectByTag(MS_TAVERN_PATRON_TAG, oControler, patronCnt);
        while (obj != OBJECT_INVALID) {
            patronCnt++;
            obj = GetNearestObjectByTag(MS_TAVERN_PATRON_TAG, oControler, patronCnt);
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

void DestroyPatron(object oPatron, object oControler, int patronCnt) {
    DestroyObject(oPatron);
    if(oControler != OBJECT_INVALID) {
        SetLocalInt(oControler, MS_TAVERN_PATRON_COUNT, patronCnt - 1);
    }
}


void SelfDestructCheck(object oPatron, object oArea) {
    int lastPCSeen = GetLocalInt(oPatron, MS_TAVERN_PATRONS_LAST_PC_SEEN);
    // If no one is in the area check if we should destory camp.
    if(NWNX_Area_GetNumberOfPlayersInArea(oArea) == 0) {
        if(NWNX_Time_GetTimeStamp() - lastPCSeen
            > MS_TAVERN_DESTORY_DELAY_SECONDS) {
            WriteTimestampedLogEntry("MS TAVERN UTIL: Times Up Destroying Inn Patron");
            DestroyObject(oPatron);
            return;
        }
    // If someone is in the area update the last seen time.
    } else {
        SetLocalInt(oPatron, MS_TAVERN_PATRONS_LAST_PC_SEEN,
                    NWNX_Time_GetTimeStamp());
    }
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

object GetValidChair(object oArea, int chairCnt) {

    int cutOff = 0;
    while(cutOff < 20) {
        object oChair = NWNX_Data_Array_At_Obj(oArea, MS_TAVERN_CHAIR_ARRAY,
                                               Random(chairCnt));
        if(!GetIsObjectValid(GetSittingCreature(oChair))
           && GetLocalInt(oChair, MS_TAVERN_CHAIR_IN_USE) == FALSE) {
            return oChair;
        }
        cutOff++;
    }

    return OBJECT_INVALID;
}
