#include "_btb_spider_sp1"
#include "nwnx_time"

void main()
{
    // Spawn spiders to react to their web being disturbed.
    spawnSpiders(d2() + 2, OBJECT_SELF);

    // Destroy all webs with in range destroying this one represnts destroying the group
    int cnt = 1;
    object secondWeb = GetNearestObjectByTag("destroyspiderweb", OBJECT_SELF, cnt);
    while(secondWeb != OBJECT_INVALID) {
        cnt++;
        if(GetDistanceBetween(OBJECT_SELF, secondWeb) < 3.0) {
            WriteTimestampedLogEntry("DESTROY WEBS: Destroying a web - cnt:" + IntToString(cnt));
            DestroyObject(secondWeb, 1.0);
        }
        secondWeb = GetNearestObjectByTag("destroyspiderweb", OBJECT_SELF, cnt);
    }

    // Remove the blocker as the webs are gone.
    cnt = 1;
    object solidObject = GetNearestObjectByTag("invisspiderblock", OBJECT_SELF, cnt);
    while(solidObject != OBJECT_INVALID) {
        cnt++;
        if(GetDistanceBetween(OBJECT_SELF, solidObject) < 3.0) {
            WriteTimestampedLogEntry("DESTROY WEBS: Destroying invis - cnt:" + IntToString(cnt));
            DestroyObject(solidObject, 1.0);
        }
        solidObject = GetNearestObjectByTag("invisspiderblock", OBJECT_SELF, cnt);
    }

    // Track the last time a web was destoryed in the area.
    SetLocalInt(GetArea(OBJECT_SELF),
        "lastSpiderWebDestroy", NWNX_Time_GetTimeStamp());
}
