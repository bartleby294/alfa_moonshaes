#include "_btb_vil_const"
#include "_btb_villag_util"

string SelectVillager() {

    switch(Random(14) +1) {
        case 1:
            return "farmergwynnth001";
        case 2:
            return "farmergwynnth005";
        case 3:
            return "farmergwynnth007";
        case 4:
            return "farmergwynnth009";
        case 5:
            return "farmergwynnth013";
        case 6:
            return "farmergwynnth015";
        case 7:
            return "farmergwynnth003";
        case 8:
            return "farmergwynnth017";
        case 9:
            return "corwellcommon013";
        case 10:
            return "farmergwynnth011";
        case 11:
            return "farmergwynnth019";
        case 12:
            return "farmergwynnth021";
        case 13:
            return "farmergwynnth023";
        case 14:
            return "farmergwynnth025";
    }

    return "farmergwynnth001";
}

void InitalizeCounts() {
    int homeCnt = 0;
    int tagCnt = 0;
    int cropsCnt = 0;
    int marketCnt = 0;
    int tavernCnt = 0;
    int waterCnt = 0;
    int villagerCnt = 0;
    object obj = GetFirstObjectInArea();
    while(GetIsObjectValid(obj)){
        if(GetTag(obj) == HOME){
            homeCnt++;
        } else if(GetTag(obj) == TAG){
            tagCnt++;
        } else if(GetTag(obj) == CROPS){
            cropsCnt++;
        } else if(GetTag(obj) == MARKET){
            marketCnt++;
        } else if(GetTag(obj) == TAVERN){
            tavernCnt++;
        } else if(GetTag(obj) == WATER){
            waterCnt++;
        } else if(GetTag(obj) == VILLAGER_TAG){
            villagerCnt++;
        }
        obj = GetNextObjectInArea();
    }
    SetLocalInt(OBJECT_SELF, HOME, homeCnt);
    SetLocalInt(OBJECT_SELF, TAG, tagCnt);
    SetLocalInt(OBJECT_SELF, CROPS, cropsCnt);
    SetLocalInt(OBJECT_SELF, MARKET, marketCnt);
    SetLocalInt(OBJECT_SELF, TAVERN, tavernCnt);
    SetLocalInt(OBJECT_SELF, WATER, waterCnt);
    SetLocalInt(OBJECT_SELF, VILLAGER_TAG, villagerCnt);

    return;
}

void main() {
    // if Vilage scrips have been DM halted return.
    if(GetLocalInt(GetArea(OBJECT_SELF), DM_FORCE_STOP) == TRUE) {
        return ;
    }

    int isInitalized = GetLocalInt(OBJECT_SELF, INITALIZED);

    if(isInitalized == FALSE) {
        InitalizeCounts();
        SetLocalInt(OBJECT_SELF, INITALIZED, TRUE);
    }

    int homesCnt = GetLocalInt(OBJECT_SELF, HOME);
    int tagCnt = GetLocalInt(OBJECT_SELF, TAG);
    int cropsCnt = GetLocalInt(OBJECT_SELF, CROPS);
    int marketCnt = GetLocalInt(OBJECT_SELF, MARKET);
    int tavernCnt = GetLocalInt(OBJECT_SELF, TAVERN);
    int waterCnt = GetLocalInt(OBJECT_SELF, WATER);
    int villagerCnt = GetLocalInt(OBJECT_SELF, VILLAGER_TAG);
    int workerCnt = cropsCnt + marketCnt + waterCnt;
    float villagerRatio = (villagerCnt * 1.0)/(homesCnt * 1.0);

    // no one lives here or everyone is outside so return.
    if(homesCnt == 0 || homesCnt >= villagerCnt || workerCnt >= villagerCnt) {
        return;
    }

    // The more people outside the less chance to spawn a new person
    float celing = 100.0;
    if(villagerRatio < 0.5) {
        villagerRatio = 1.0/villagerRatio;
    } else {
        celing = (celing * villagerRatio) / 2;
    }

    float randomSpawnChance = (villagerRatio * 100);
    if(Random(FloatToInt(randomSpawnChance)) > FloatToInt(celing)) {
        string villagerResRef = SelectVillager();
        int isMale = IsMale(villagerResRef);
        int randomHome = Random(homesCnt) + 1;
        object spawnLoc = GetNearestObjectByTag(HOME, OBJECT_SELF, randomHome);
        object villager = CreateObject(OBJECT_TYPE_CREATURE,
                                       villagerResRef,
                                       GetLocation(spawnLoc),
                                       FALSE,
                                       VILLAGER_TAG);
        SetLocalObject(villager, HOME, spawnLoc);
        SetLocalInt(villager, IS_MALE, isMale);
        ChooseVillagerAction(isMale, cropsCnt, marketCnt, tavernCnt,
                             waterCnt, villager);
        SetLocalInt(OBJECT_SELF, VILLAGER_TAG, villagerCnt + 1);
        SetEventScript(villager,
                       EVENT_SCRIPT_CREATURE_ON_HEARTBEAT,
                       "_btb_villag_onhb");
    }
}
