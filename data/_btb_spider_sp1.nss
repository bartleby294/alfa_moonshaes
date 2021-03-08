#include "_btb_util"

void spawnSpiders(int spiderCap, object web)
{
    int curSpider;

    while (curSpider < spiderCap) {
        location spiderSpawn = pickLoc(web, Random(30)/10.0 + 2.0,
                                        IntToFloat(Random(360)));
        switch (Random(10)) {
        case 0:
            CreateObject(OBJECT_TYPE_CREATURE, "rn_spider_01", spiderSpawn);
            break;
        case 1:
            CreateObject(OBJECT_TYPE_CREATURE, "rn_spider_01", spiderSpawn);
            break;
        case 2:
            CreateObject(OBJECT_TYPE_CREATURE, "rn_spider_01", spiderSpawn);
            break;
        case 3:
            CreateObject(OBJECT_TYPE_CREATURE, "tinyspider", spiderSpawn);
            break;
        case 4:
            CreateObject(OBJECT_TYPE_CREATURE, "tinyspider001", spiderSpawn);
            break;
        case 5:
            CreateObject(OBJECT_TYPE_CREATURE, "tinyspider002", spiderSpawn);
            break;
        case 6:
            CreateObject(OBJECT_TYPE_CREATURE, "rn_spider_01", spiderSpawn);
            break;
        case 7:
            CreateObject(OBJECT_TYPE_CREATURE, "rn_spider_02", spiderSpawn);
            break;
        case 8:
            CreateObject(OBJECT_TYPE_CREATURE, "rn_spider_02", spiderSpawn);
            break;
        case 9:
            CreateObject(OBJECT_TYPE_CREATURE, "rn_spider_02", spiderSpawn);
            break;
        }
        curSpider++;
    }
}
