int IsMale(string resRef) {
    if(resRef == "farmergwynnth011"
       || resRef == "farmergwynnth019"
       || resRef == "farmergwynnth021"
       || resRef == "farmergwynnth023"
       || resRef == "farmergwynnth025") {
        return FALSE;
    }
    return TRUE;
}

string randomFarmToolResef() {
    switch(Random(4) + 1) {
        case 1:
            return "hayfork";
        case 2:
            return "workingshovel";
        case 3:
            return "farmershoe";
        case 4:
            return "farmerssythe";
    }
    return "farmerssythe";
}

void AssignVillagerAction(object villager, string actionChoice, object wp) {

    AssignCommand(villager,
        ActionUnequipItem(GetItemInSlot(INVENTORY_SLOT_LEFTHAND , villager)));
    AssignCommand(villager,
        ActionUnequipItem(GetItemInSlot(INVENTORY_SLOT_RIGHTHAND , villager)));

    if(actionChoice == CROPS) {
        WriteTimestampedLogEntry("VILLAGER: Createing CROPS Villager.");
        SetLocalObject(villager, ACTION_WP, wp);
        string randTool = randomFarmToolResef();
        object oTool = CreateItemOnObject(randomFarmToolResef(), villager);
        AssignCommand(villager,
                      ActionEquipItem(oTool, INVENTORY_SLOT_RIGHTHAND));
    } else if(actionChoice == TAVERN) {
        WriteTimestampedLogEntry("VILLAGER: Createing TAVERN Villager.");
        SetLocalObject(villager, ACTION_WP, wp);
        SetName(villager, "Villager");
    } else if(actionChoice == MARKET) {
        WriteTimestampedLogEntry("VILLAGER: Createing MARKET Villager.");
        SetLocalObject(villager, ACTION_WP, wp);
        SetName(villager, "Villager");
    } else if(actionChoice == WATER) {
        WriteTimestampedLogEntry("VILLAGER: Createing WATER Villager.");
        SetLocalObject(villager, ACTION_WP, wp);
        object oTool = CreateItemOnObject("_bucket", villager);
        AssignCommand(villager,
                      ActionEquipItem(oTool, INVENTORY_SLOT_LEFTHAND));
        SetName(villager, "Villager");
    }
}

string ChooseVillagerWP(int isFemale) {

    int choice = Random(100) + 1;

    if(isFemale == FALSE) {
        if(choice < 40 && GetIsNight() == FALSE) {
            return CROPS;
        } else if(choice < 70) {
            return TAVERN;
        } else if(choice < 85) {
            return MARKET;
        } else {
            return WATER;
        }
    } else {
        if(choice < 20 && GetIsNight() == FALSE) {
            return CROPS;
        } else if(choice < 30) {
            return TAVERN;
        } else if(choice < 70) {
            return MARKET;
        } else {
            return WATER;
        }
    }

    return WATER;
}

int GetWPCount(string wpString, int cropsCnt, int marketCnt, int tavernCnt,
               int waterCnt) {
    if(wpString ==  CROPS) {

    } else if(wpString ==  CROPS) {
        return cropsCnt;
    } else if(wpString ==  TAVERN) {
        return tavernCnt;
    } else if(wpString ==  MARKET) {
        return marketCnt;
    } else if(wpString ==  WATER) {
        return waterCnt;
    }

    return 0;
}

string ChooseVillagerAction(int isFemale, int cropsCnt,int marketCnt,
                            int tavernCnt, int waterCnt, object villager) {
    string wpString = ChooseVillagerWP(isFemale);
    int wpCnt = GetWPCount(wpString, cropsCnt, marketCnt, tavernCnt, waterCnt);
    object wp = GetNearestObjectByTag(wpString, OBJECT_SELF, Random(wpCnt) + 1);

    // Loop until we get a valid desitnation.
    int breakout = 1;
    while(wp == OBJECT_INVALID && breakout < 40) {
        wpString = ChooseVillagerWP(isFemale);
        wpCnt = GetWPCount(wpString, cropsCnt, marketCnt, tavernCnt, waterCnt);
        wp = GetNearestObjectByTag(wpString, OBJECT_SELF, Random(wpCnt) + 1);
    }

    AssignVillagerAction(villager, wpString, wp);

    return wpString;
}
