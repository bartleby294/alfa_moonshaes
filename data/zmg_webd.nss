#include "_btb_spider_sp1"

void main()
{
    spawnSpiders(d2() + 2, OBJECT_SELF);
    object secondWeb = GetNearestObjectByTag("destroyspiderweb");
    object solidObject = GetNearestObjectByTag("invisspiderblock");

    if(GetDistanceBetween(OBJECT_SELF, secondWeb) < 2.0) {
        DestroyObject(secondWeb);
    }

    if(GetDistanceBetween(OBJECT_SELF, solidObject) < 2.0) {
        DestroyObject(solidObject);
    }
}
