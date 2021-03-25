#include "ms_bandit_ambcon"
#include "ms_terrain_id"
#include "ms_location_util"

void TearBanditAmbushDown(object oArea) {
    int cnt = 1;
    object baseObj = GetFirstObjectInArea(oArea);

    // Clean up any old bandit ambush triggers.
    object curTrigger = GetNearestObjectByTag(MS_BANDIT_AMBUSH_TRIGGER_1, baseObj, cnt);
    while(curTrigger != OBJECT_INVALID) {
         cnt++;
         WriteTimestampedLogEntry("MS BANDIT AMBUSH: Destroying trigger - cnt:" + IntToString(cnt));
         DestroyObject(curTrigger, 0.2);
         curTrigger = GetNearestObjectByTag(MS_BANDIT_AMBUSH_TRIGGER_1, baseObj, cnt);
    }

    // Clean up any old bandit ambush triggers.
    cnt = 1;
    curTrigger = GetNearestObjectByTag(MS_BANDIT_AMBUSH_TRIGGER_2, baseObj, cnt);
    while(curTrigger != OBJECT_INVALID) {
         cnt++;
         WriteTimestampedLogEntry("MS BANDIT AMBUSH: Destroying trigger - cnt:" + IntToString(cnt));
         DestroyObject(curTrigger, 0.2);
         curTrigger = GetNearestObjectByTag(MS_BANDIT_AMBUSH_TRIGGER_2, baseObj, cnt);
    }

    // Clean up any old bandit ambush triggers.
    cnt = 1;
    curTrigger = GetNearestObjectByTag(MS_BANDIT_AMBUSH_TRIGGER_3, baseObj, cnt);
    while(curTrigger != OBJECT_INVALID) {
         cnt++;
         WriteTimestampedLogEntry("MS BANDIT AMBUSH: Destroying trigger - cnt:" + IntToString(cnt));
         DestroyObject(curTrigger, 0.2);
         curTrigger = GetNearestObjectByTag(MS_BANDIT_AMBUSH_TRIGGER_3, baseObj, cnt);
    }
}

void setTriggerConstants(object trigger3, int ambushLevel) {
    if(ambushLevel == 1) {
        SetLocalInt(trigger3, MS_BANDIT_AMBUSH_BANDIT_XP, 1800);
        SetLocalInt(trigger3, MS_BANDIT_AMBUSH_BANDIT_MIN_LVL, 1);
        SetLocalInt(trigger3, MS_BANDIT_AMBUSH_BANDIT_MS, 3);
        SetLocalInt(trigger3, MS_BANDIT_AMBUSH_BANDIT_HIDE, 3);
        SetLocalInt(trigger3, MS_BANDIT_AMBUSH_BANDIT_SPOT, 3);
        SetLocalInt(trigger3, MS_BANDIT_AMBUSH_BANDIT_LISTEN, 4);
        SetLocalInt(trigger3, MS_BANDIT_AMBUSH_BANDIT_SM, 2);
        SetLocalInt(trigger3, MS_BANDIT_AMBUSH_BANDIT_APP, 1);
    } else if(ambushLevel == 2) {
        SetLocalInt(trigger3, MS_BANDIT_AMBUSH_BANDIT_XP, 2500);
        SetLocalInt(trigger3, MS_BANDIT_AMBUSH_BANDIT_MIN_LVL, 2);
        SetLocalInt(trigger3, MS_BANDIT_AMBUSH_BANDIT_MS, 4);
        SetLocalInt(trigger3, MS_BANDIT_AMBUSH_BANDIT_HIDE, 4);
        SetLocalInt(trigger3, MS_BANDIT_AMBUSH_BANDIT_SPOT, 4);
        SetLocalInt(trigger3, MS_BANDIT_AMBUSH_BANDIT_LISTEN, 5);
        SetLocalInt(trigger3, MS_BANDIT_AMBUSH_BANDIT_SM, 3);
        SetLocalInt(trigger3, MS_BANDIT_AMBUSH_BANDIT_APP, 2);
    } else if(ambushLevel > 2) {
        SetLocalInt(trigger3, MS_BANDIT_AMBUSH_BANDIT_XP, 4500);
        SetLocalInt(trigger3, MS_BANDIT_AMBUSH_BANDIT_MIN_LVL, 3);
        SetLocalInt(trigger3, MS_BANDIT_AMBUSH_BANDIT_MS, 6);
        SetLocalInt(trigger3, MS_BANDIT_AMBUSH_BANDIT_HIDE, 6);
        SetLocalInt(trigger3, MS_BANDIT_AMBUSH_BANDIT_SPOT, 6);
        SetLocalInt(trigger3, MS_BANDIT_AMBUSH_BANDIT_LISTEN, 7);
        SetLocalInt(trigger3, MS_BANDIT_AMBUSH_BANDIT_SM, 5);
        SetLocalInt(trigger3, MS_BANDIT_AMBUSH_BANDIT_APP, 4);
    }
}

int CreateBanditAmbushTriggers(location loc, int ambushLevel) {

    float trigger1Size = 20.0f;
    float trigger2Size = 10.0f;
    float trigger3Size =  9.0f;
    vector locVec = GetPositionFromLocation(loc);
    object trigger1 = NWNX_Area_CreateGenericTrigger(GetAreaFromLocation(loc),
                                                    locVec.x,
                                                    locVec.y,
                                                    locVec.z,
                                                    MS_BANDIT_AMBUSH_TRIGGER_1,
                                                    trigger1Size);
    SetEventScript(trigger1, EVENT_SCRIPT_TRIGGER_ON_OBJECT_ENTER,
                   "ms_bandit_amb_1e");
    SetEventScript(trigger1, EVENT_SCRIPT_TRIGGER_ON_OBJECT_EXIT,
                   "ms_bandit_amb_1x");

    object trigger2 = NWNX_Area_CreateGenericTrigger(GetAreaFromLocation(loc),
                                                    locVec.x,
                                                    locVec.y,
                                                    locVec.z,
                                                    MS_BANDIT_AMBUSH_TRIGGER_2,
                                                    trigger2Size);
    SetEventScript(trigger2, EVENT_SCRIPT_TRIGGER_ON_OBJECT_ENTER,
                   "ms_bandit_amb_2");

    object trigger3 = NWNX_Area_CreateGenericTrigger(GetAreaFromLocation(loc),
                                                    locVec.x,
                                                    locVec.y,
                                                    locVec.z,
                                                    MS_BANDIT_AMBUSH_TRIGGER_3,
                                                    trigger3Size);
    SetEventScript(trigger3, EVENT_SCRIPT_TRIGGER_ON_OBJECT_ENTER,
                   "ms_bandit_amb_3");
    setTriggerConstants(trigger3, ambushLevel);

    return TRUE;
}

int BadLocation(object oArea, location randLoc, float buffer) {

    vector pos = GetPositionFromLocation(randLoc);
    float areaHeight = GetAreaSize(AREA_HEIGHT, oArea) * 10.0;
    float areaWidth  = GetAreaSize(AREA_WIDTH, oArea) * 10.0;

    if(pos.x < buffer || pos.x > areaWidth - buffer) {
        return FALSE;
    }

    if(pos.y < buffer || pos.y > areaHeight - buffer) {
        return FALSE;
    }

    return TRUE;
}

location GetRandomLocation(object oArea, string terrainType, int arraySize) {
    string xyStr = NWNX_Data_Array_At_Str(oArea, terrainType,Random(arraySize));
    float randX = GetRandomXFrom(xyStr);
    float randY = GetRandomYFrom(xyStr);
    return Location(oArea, Vector(randX, randY, 0.0), 0.0);
}

int CreateBanditAmbush(object oArea, string terrainType, int ambushLevel) {
    int arraySize = NWNX_Data_Array_Size(NWNX_DATA_TYPE_STRING, oArea,
                                         terrainType);
    if(arraySize == 0) {
        return FALSE;
    }

    int i = 0;
    int cutOff = 15;
    location randLoc = GetRandomLocation(oArea, terrainType, arraySize);
    while(i < cutOff && BadLocation(oArea, randLoc, 20.0) == FALSE) {
        i++;
        randLoc = GetRandomLocation(oArea, terrainType, arraySize);
    }
    vector pos = GetPositionFromLocation(randLoc);
    location randomLoc = Location(oArea,
                                  Vector(pos.x, pos.y, GetGroundHeight(randLoc)),
                                  0.0);
    return CreateBanditAmbushTriggers(randomLoc, ambushLevel);
}

void SeedRandomBanditAmbush(object oArea, int ambushLevel) {
    // spend the rest randomly
    if(ambushLevel > 0) {
        //WriteTimestampedLogEntry("SeedRandomTreasure for: " + randTerrianType);
        CreateBanditAmbush(oArea, TERRAIN_ROAD, ambushLevel);
    }
}
