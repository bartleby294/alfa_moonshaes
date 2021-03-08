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
         DestroyObject(curWeb, 1.0);
         curWeb = GetNearestObjectByTag("destroyspiderweb", baseObj, cnt);
    }

    // Clean up any old blockers.
    cnt = 1;
    curWeb = GetNearestObjectByTag("invisspiderblock", baseObj, cnt);
    while(curWeb != OBJECT_INVALID) {
         cnt++;
         DestroyObject(curWeb, 1.0);
         curWeb = GetNearestObjectByTag("invisspiderblock", baseObj, cnt);
    }
}

void BuildNewWebs() {
    int cnt = 1;
    object baseObj = GetObjectByTag("defiledCavernSpiderUniqueTag");

    // Clean up any old webs.
    object curWeb = GetNearestObjectByTag("destroyspiderwebwp", baseObj, cnt);
    while(curWeb != OBJECT_INVALID) {
         cnt++;
         CreateObject(OBJECT_TYPE_PLACEABLE, "destroyspiderweb",
                      GetLocation(curWeb));
         curWeb = GetNearestObjectByTag("destroyspiderwebwp", baseObj, cnt);
    }

    // Clean up any old blockers.
    cnt = 1;
    curWeb = GetNearestObjectByTag("invisspiderblockwp", baseObj, cnt);
    while(curWeb != OBJECT_INVALID) {
         cnt++;
         CreateObject(OBJECT_TYPE_PLACEABLE, "destroyspiderweb",
                      GetLocation(curWeb));
         curWeb = GetNearestObjectByTag("invisspiderblockwp", baseObj, cnt);
    }
}

void main()
{
    object oArea = GetArea(OBJECT_SELF);
    ExecuteScript("ms_on_area_enter", oArea);

    // if players are in the area dont change spider state
    if(NWNX_Area_GetNumberOfPlayersInArea(oArea) > 0) {
        return;
    }

    // check to see the last time spider webs were destoryed.  If time has
    // elapsed tear any existing webs down and put up new ones.
    int lastDestoryed = GetLocalInt(oArea, "lastSpiderWebDestroy");
    if(NWNX_Time_GetTimeStamp() - lastDestoryed > SPIDER_WEB_DELAY_SECONDS) {
        TearWebsDown();
        BuildNewWebs();
    }


}
