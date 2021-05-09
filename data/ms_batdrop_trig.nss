#include "_btb_util"

void main()
{
    object oPC = GetEnteringObject();
    location loc = GetLocation(oPC);
    batScatter(loc, 50.0, 1);

    int cnt = 0;
    int fBatNum = d3();
    int cBatNum = d3();
    int rBatNum = d6();

    // DM Fledgling Bat Spawn
    while(cnt < fBatNum) {
        CreateObject(OBJECT_TYPE_CREATURE, "fledglingbat", loc, TRUE);
        cnt++;
    }
    // DM Corrupted Bat Spawn
    if(cBatNum == 1) {
        CreateObject(OBJECT_TYPE_CREATURE, "cavebat", loc, TRUE);
    }
    // DM Rabid Bat Spawn
    if(rBatNum == 1) {
        CreateObject(OBJECT_TYPE_CREATURE, "rabidbat", loc, TRUE);
    }

    DestroyObject(OBJECT_SELF);
}
