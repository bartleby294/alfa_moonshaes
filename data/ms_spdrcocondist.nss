#include "_btb_util"

void spawnSpiders(object oPC) {
    int i = 0;
    int maxSpawn = Random(2) + 1;
    while (i < maxSpawn){
        CreateObject(OBJECT_TYPE_CREATURE, "rn_spider_03",
                     pickLoc(oPC, Random(30)/10.0, 0.0), TRUE);
        i++;
    }
}

void main() {
    spawnSpiders(OBJECT_SELF);
}
