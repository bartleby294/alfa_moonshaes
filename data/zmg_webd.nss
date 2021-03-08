#include "_btb_spider_sp1"

void main()
{
    spawnSpiders(d2() + 2, OBJECT_SELF);
    object solidWeb = GetNearestObjectByTag("solidWeb");
    DestroyObject(solidWeb);
}
