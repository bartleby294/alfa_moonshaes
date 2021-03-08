#include "nwnx_time"
#include "nwnx_area"

int SPIDER_WEB_DELAY_SECONDS = 120; // 120 seconds

void TearWebsDown() {
    int cnt = 1;
    object baseObj = GetObjectByTag("defiledCavernSpiderUniqueTag");

    // Clean up any old webs.
    object curWeb = GetNearestObjectByTag("destroyspiderweb", baseObj, cnt);
    while(curWeb != OBJECT_INVALID) {
         cnt++;
         WriteTimestampedLogEntry("DEFILED CAVERNS SPIDER WEBS: Destroying a web - cnt:" + IntToString(cnt));
         DestroyObject(curWeb);
         curWeb = GetNearestObjectByTag("destroyspiderweb", baseObj, cnt);
    }

    // Clean up any old blockers.
    cnt = 1;
    curWeb = GetNearestObjectByTag("invisspiderblock", baseObj, cnt);
    while(curWeb != OBJECT_INVALID) {
         cnt++;
         WriteTimestampedLogEntry("DEFILED CAVERNS SPIDER WEBS: Destroying a blocker - cnt:" + IntToString(cnt));
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
         WriteTimestampedLogEntry("DEFILED CAVERNS SPIDER WEBS: Building a web - cnt:" + IntToString(cnt));
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
         WriteTimestampedLogEntry("DEFILED CAVERNS SPIDER WEBS: Building a blocker - cnt:" + IntToString(cnt));
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

    WriteTimestampedLogEntry("DEFILED CAVERNS SPIDER WEBS: Numer of Players: "
                             + IntToString(NWNX_Area_GetNumberOfPlayersInArea(oArea)));
    // if players are in the area dont change spider state
    if(NWNX_Area_GetNumberOfPlayersInArea(oArea) > 1) {
        WriteTimestampedLogEntry("DEFILED CAVERNS SPIDER WEBS: EXIT 1");
        return;
    }

    // check to see the last time spider webs were destoryed.  If time has
    // elapsed tear any existing webs down and put up new ones.
    int lastDestoryed = GetLocalInt(oArea, "lastSpiderWebDestroy");
    int curTime = NWNX_Time_GetTimeStamp();
    WriteTimestampedLogEntry("curTime : " + IntToString(curTime)
                             + " - lastDestoryed: " + IntToString(lastDestoryed)
                             +" > SPIDER_WEB_DELAY_SECONDS: "
                             + IntToString(SPIDER_WEB_DELAY_SECONDS));
    WriteTimestampedLogEntry("curTime  - lastDestoryed: "
                             + IntToString(curTime - lastDestoryed)
                             +" > SPIDER_WEB_DELAY_SECONDS: "
                             + IntToString(SPIDER_WEB_DELAY_SECONDS));
    if(curTime - lastDestoryed > SPIDER_WEB_DELAY_SECONDS) {
        SetLocalInt(oArea, "processingWebs", TRUE);
        WriteTimestampedLogEntry("DEFILED CAVERNS SPIDER WEBS: Tearing down webs");
        TearWebsDown();
        WriteTimestampedLogEntry("DEFILED CAVERNS SPIDER WEBS: Building webs");
        DelayCommand(0.5, BuildNewWebs());
    }

    ExecuteScript("ms_on_area_enter", oArea);
}
