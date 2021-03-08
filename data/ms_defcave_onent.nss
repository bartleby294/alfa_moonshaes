#include "nwnx_time"
#include "nwnx_area"

int SPIDER_WEB_DELAY_SECONDS = 120000; // 120 second

void TearWebsDown() {
    int cnt = 1;
    object baseObj = GetObjectByTag("defiledCavernSpiderUniqueTag");

    // Clean up any old webs.
    object curWeb = GetNearestObjectByTag("destroyspiderweb", baseObj, cnt);
    while(curWeb != OBJECT_INVALID) {
         cnt++;
         WriteTimestampedLogEntry("DEFILED CAVERNS SPIDER WEBS: Destroying a web");
         DestroyObject(curWeb);
         curWeb = GetNearestObjectByTag("destroyspiderweb", baseObj, cnt);
    }

    // Clean up any old blockers.
    cnt = 1;
    curWeb = GetNearestObjectByTag("invisspiderblock", baseObj, cnt);
    while(curWeb != OBJECT_INVALID) {
         cnt++;
         WriteTimestampedLogEntry("DEFILED CAVERNS SPIDER WEBS: Destroying a blocker");
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
         WriteTimestampedLogEntry("DEFILED CAVERNS SPIDER WEBS: Building a web");
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
         WriteTimestampedLogEntry("DEFILED CAVERNS SPIDER WEBS: Building a blocker");
         CreateObject(OBJECT_TYPE_PLACEABLE, "invisspiderblock",
                      GetLocation(curWeb));
         curWeb = GetNearestObjectByTag("invisspiderblockwp", baseObj, cnt);
    }
}

void main()
{
    object oArea = GetArea(OBJECT_SELF);
    ExecuteScript("ms_on_area_enter", oArea);

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
    if(NWNX_Time_GetTimeStamp() - lastDestoryed > SPIDER_WEB_DELAY_SECONDS) {
        WriteTimestampedLogEntry("DEFILED CAVERNS SPIDER WEBS: Tearing down webs");
        TearWebsDown();
        WriteTimestampedLogEntry("DEFILED CAVERNS SPIDER WEBS: Building webs");
        BuildNewWebs();
    }


}
