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

int RandomTavern(int tavernCnt) {

    int tavernToHome = Random(10);
    if(GetIsNight() == TRUE) {
        tavernToHome = Random(20);
    }

    if(tavernToHome > 9) {
        return Random(tavernCnt) + 1;
    }
    return 0;
}

void SpawnVillager(int homesCnt, int cropsCnt,int marketCnt,
                   int tavernCnt, int waterCnt, int villagerCnt) {

    WriteTimestampedLogEntry("Village: Spawning");
    string villagerResRef = SelectVillager();
    int randomHome = Random(homesCnt) + 1;
    int randomTavern = RandomTavern(tavernCnt);

    if(randomTavern == 0) {
        object spawnLoc = GetNearestObjectByTag(HOME, OBJECT_SELF, randomHome);
        object villager = CreateObject(OBJECT_TYPE_CREATURE,
                                       villagerResRef,
                                       GetLocation(spawnLoc),
                                       FALSE,
                                       VILLAGER_TAG);
        SetLocalObject(villager, HOME, spawnLoc);
        int isMale = GetGender(villager);
        ChooseVillagerAction(isMale, cropsCnt, marketCnt, tavernCnt,
                             waterCnt, villager);
        villagerCnt = GetLocalInt(OBJECT_SELF, VILLAGER_TAG);
        SetLocalInt(OBJECT_SELF, VILLAGER_TAG, villagerCnt + 1);
        SetEventScript(villager,
                       EVENT_SCRIPT_CREATURE_ON_HEARTBEAT,
                       "_btb_villag_onhb");
    } else {
        object spawnLoc =GetNearestObjectByTag(TAVERN,OBJECT_SELF,randomTavern);
        object homeLoc = GetNearestObjectByTag(HOME, OBJECT_SELF, randomHome);
        object villager = CreateObject(OBJECT_TYPE_CREATURE,
                                       villagerResRef,
                                       GetLocation(spawnLoc),
                                       FALSE,
                                       VILLAGER_TAG);
        SetLocalObject(villager, HOME, homeLoc);
        SetLocalObject(villager, ACTION_WP, homeLoc);
        villagerCnt = GetLocalInt(OBJECT_SELF, VILLAGER_TAG);
        SetLocalInt(OBJECT_SELF, VILLAGER_TAG, villagerCnt + 1);
        SetEventScript(villager, EVENT_SCRIPT_CREATURE_ON_HEARTBEAT,
                       "_btb_villag_onhb");
    }
}

void main() {
    WriteTimestampedLogEntry("Village: On Heartbeat");
    // if Vilage scrips have been DM halted return.
    if(GetLocalInt(GetArea(OBJECT_SELF), DM_FORCE_STOP) == TRUE) {
        return ;
    }

    int isInitalized = GetLocalInt(OBJECT_SELF, INITALIZED);

    if(isInitalized == FALSE) {
        WriteTimestampedLogEntry("Village: Initalizing");
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

    WriteTimestampedLogEntry("Village: homesCnt: " + IntToString(homesCnt));
    WriteTimestampedLogEntry("Village: villagerCnt: " + IntToString(villagerCnt));
    WriteTimestampedLogEntry("Village: workerCnt: " + IntToString(workerCnt));

    // no one lives here or everyone is outside so return.
    if(homesCnt == 0 || (homesCnt * 2) <= villagerCnt) {
        WriteTimestampedLogEntry("Village: No one lives here");
        return;
    }
    int i = 0;
    if(isInitalized == FALSE) {
        while( i < homesCnt/2) {
            SpawnVillager(homesCnt, cropsCnt, marketCnt, tavernCnt, waterCnt,
                          villagerCnt);
            i++;
        }
        return;
    }

    // The more people outside the less chance to spawn a new person
    float celing = 100.0;
    if(villagerRatio == 0.0) {
        villagerRatio = 300.0;
    } else if(villagerRatio < 0.5) {
        villagerRatio = 1.0/villagerRatio;
    } else {
        celing = (celing * villagerRatio) / 2;
    }

    float randomSpawnChance = (villagerRatio * 100);
    int chance = Random(FloatToInt(randomSpawnChance));
    WriteTimestampedLogEntry("Village: chance (" + IntToString(chance)
                             + ") > celing (" + IntToString(FloatToInt(celing))
                             + ")");
    if(chance > FloatToInt(celing)) {
        SpawnVillager(homesCnt, cropsCnt, marketCnt, tavernCnt, waterCnt,
                      villagerCnt);
    }
}