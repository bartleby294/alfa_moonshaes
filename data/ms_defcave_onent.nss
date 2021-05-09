#include "nwnx_time"
#include "nwnx_area"
#include "_btb_util"

int SPIDER_WEB_DELAY_SECONDS = 120; // 120 seconds

void TearBatDropsDown(){
    int cnt = 1;
    object baseObj = GetObjectByTag("defiledCavernSpiderUniqueTag");

    // Clean up any old webs.
    object curDrop = GetNearestObjectByTag("bat_swarm_drop", baseObj, cnt);
    while(curDrop != OBJECT_INVALID) {
         cnt++;
         //WriteTimestampedLogEntry("DEFILED CAVERNS BAT DROP: Destroying a bat drop - cnt:" + IntToString(cnt));
         DestroyObject(curDrop);
         curDrop = GetNearestObjectByTag("bat_swarm_drop", baseObj, cnt);
    }
}

void CreateBatDrops(object baseObj, int batWP1Cnt, int batWP2Cnt) {

    object WP = OBJECT_INVALID;

    // Pick a Waypoint and get a random location from it.
    if(d2() == 1) {
        // Create using wp 1
        WP =  GetNearestObjectByTag("corrupted_bats", baseObj, Random(batWP1Cnt));
    } else {
        // Create using wp 2
        WP =  GetNearestObjectByTag("corrupted_bats2", baseObj, Random(batWP2Cnt));
    }

    location loc = pickLoc(WP, Random(5) * 1.0, Random(360) * 1.0);
    float trigger1Size = 10.0;
    vector locVec = GetPositionFromLocation(loc);
    WriteTimestampedLogEntry("Creating Bat Drop at (" + FloatToString(locVec.x)
                                                      + FloatToString(locVec.y)
                                                      + FloatToString(locVec.z)
                                                      + ")");
    object batTrigger = NWNX_Area_CreateGenericTrigger(OBJECT_SELF,
                                                       locVec.x,
                                                       locVec.y,
                                                       locVec.z,
                                                       "bat_swarm_drop",
                                                       trigger1Size);
}

void BuildNewBatDrops() {

    int batWP1Cnt = 0;
    int batWP2Cnt = 0;
    object baseObj = GetObjectByTag("defiledCavernSpiderUniqueTag");

    // Count Waypoints 1.
    object curDrop1 = GetNearestObjectByTag("corrupted_bats", baseObj, batWP1Cnt);
    while(curDrop1 != OBJECT_INVALID) {
         batWP1Cnt++;
         curDrop1 = GetNearestObjectByTag("corrupted_bats", baseObj, batWP1Cnt);
    }

    // Count Waypoints 2.
    object curDrop2 = GetNearestObjectByTag("corrupted_bats2", baseObj, batWP2Cnt);
    while(curDrop2 != OBJECT_INVALID) {
         batWP2Cnt++;
         curDrop2 = GetNearestObjectByTag("corrupted_bats2", baseObj, batWP2Cnt);
    }

    int cnt = 0;
    int dropsToSeed = d6() + 4;

    while(cnt < dropsToSeed) {
        CreateBatDrops(baseObj, batWP1Cnt, batWP2Cnt);
        cnt++;
    }
}

void TearWebsDown() {
    int cnt = 1;
    object baseObj = GetObjectByTag("defiledCavernSpiderUniqueTag");

    // Clean up any old webs.
    object curWeb = GetNearestObjectByTag("destroyspiderweb", baseObj, cnt);
    while(curWeb != OBJECT_INVALID) {
         cnt++;
         //WriteTimestampedLogEntry("DEFILED CAVERNS SPIDER WEBS: Destroying a web - cnt:" + IntToString(cnt));
         DestroyObject(curWeb);
         curWeb = GetNearestObjectByTag("destroyspiderweb", baseObj, cnt);
    }

    // Clean up any old blockers.
    cnt = 1;
    curWeb = GetNearestObjectByTag("invisspiderblock", baseObj, cnt);
    while(curWeb != OBJECT_INVALID) {
         cnt++;
         //WriteTimestampedLogEntry("DEFILED CAVERNS SPIDER WEBS: Destroying a blocker - cnt:" + IntToString(cnt));
         DestroyObject(curWeb);
         curWeb = GetNearestObjectByTag("invisspiderblock", baseObj, cnt);
    }
}

void BuildNewWebs() {
    int cnt = 1;
    object baseObj = GetObjectByTag("defiledCavernSpiderUniqueTag");

    // Build new webs.
    object curWeb = GetNearestObjectByTag("destroyspiderwebwp", baseObj, cnt);
    while(curWeb != OBJECT_INVALID) {
         cnt++;
         //WriteTimestampedLogEntry("DEFILED CAVERNS SPIDER WEBS: Building a web - cnt:" + IntToString(cnt));
         float scale = StringToFloat(GetName(curWeb));
         object web = CreateObject(OBJECT_TYPE_PLACEABLE, "destroyspiderweb",
                                    GetLocation(curWeb));
         SetObjectVisualTransform(web , OBJECT_VISUAL_TRANSFORM_SCALE, scale);
         curWeb = GetNearestObjectByTag("destroyspiderwebwp", baseObj, cnt);
    }

    // Build new blockers.
    cnt = 1;
    curWeb = GetNearestObjectByTag("invisspiderblockwp", baseObj, cnt);
    while(curWeb != OBJECT_INVALID) {
         cnt++;
         //WriteTimestampedLogEntry("DEFILED CAVERNS SPIDER WEBS: Building a blocker - cnt:" + IntToString(cnt));
         CreateObject(OBJECT_TYPE_PLACEABLE, "invisspiderblock",
                      GetLocation(curWeb));
         curWeb = GetNearestObjectByTag("invisspiderblockwp", baseObj, cnt);
    }
}

void main()
{
    object oArea = GetArea(OBJECT_SELF);
    object oPC = GetEnteringObject();

    if(GetIsPC(oPC) == FALSE) {
        return;
    }

    //WriteTimestampedLogEntry("DEFILED CAVERNS SPIDER WEBS: Numer of Players: "
    //                         + IntToString(NWNX_Area_GetNumberOfPlayersInArea(oArea)));
    // if players are in the area dont change spider state
    if(NWNX_Area_GetNumberOfPlayersInArea(oArea) > 1) {
        //WriteTimestampedLogEntry("DEFILED CAVERNS SPIDER WEBS: EXIT 1");
    } else {
        // check to see the last time spider webs were destoryed.  If time has
        // elapsed tear any existing webs down and put up new ones.
        int lastDestoryed = GetLocalInt(oArea, "lastSpiderWebDestroy");
        int curTime = NWNX_Time_GetTimeStamp();
        //WriteTimestampedLogEntry("curTime : " + IntToString(curTime)
        //                        + " - lastDestoryed: " + IntToString(lastDestoryed)
        //                         +" > SPIDER_WEB_DELAY_SECONDS: "
       //                         + IntToString(SPIDER_WEB_DELAY_SECONDS));
       //WriteTimestampedLogEntry("curTime  - lastDestoryed: "
       //                         + IntToString(curTime - lastDestoryed)
       //                         +" > SPIDER_WEB_DELAY_SECONDS: "
       //                         + IntToString(SPIDER_WEB_DELAY_SECONDS));
        if(curTime - lastDestoryed > SPIDER_WEB_DELAY_SECONDS) {
            SetLocalInt(oArea, "processingWebs", TRUE);
            //WriteTimestampedLogEntry("DEFILED CAVERNS SPIDER WEBS: Tearing down webs");
            TearWebsDown();
            TearBatDropsDown();
            //WriteTimestampedLogEntry("DEFILED CAVERNS SPIDER WEBS: Building webs");
            DelayCommand(0.5, BuildNewWebs());
            DelayCommand(1.0, BuildNewBatDrops());
        }
    }

    ExecuteScript("ms_on_area_enter", oArea);
}
