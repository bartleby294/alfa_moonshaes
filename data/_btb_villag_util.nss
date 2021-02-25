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

string ChooseVillagerAction(int isFemale, int cropsCnt,int marketCnt,
                            int tavernCnt, int waterCnt, object villager) {

    int choice = Random(100) + 1;
    AssignCommand(villager,
        ActionUnequipItem(GetItemInSlot(INVENTORY_SLOT_LEFTHAND , villager)));
    AssignCommand(villager,
        ActionUnequipItem(GetItemInSlot(INVENTORY_SLOT_RIGHTHAND , villager)));

    if(isFemale == FALSE) {
        if(choice < 40 && GetIsNight() == FALSE) {
            object wp = GetNearestObjectByTag(CROPS, OBJECT_SELF,
                                              Random(cropsCnt) + 1);
            SetLocalObject(villager, ACTION_WP, wp);
            string randTool = randomFarmToolResef();
            object oTool = CreateItemOnObject(randomFarmToolResef(), villager);
            AssignCommand(villager,
                          ActionEquipItem(oTool, INVENTORY_SLOT_RIGHTHAND));
            return CROPS;
        } else if(choice < 70) {
            object wp = GetNearestObjectByTag(TAVERN, OBJECT_SELF,
                                              Random(tavernCnt) + 1);
            SetLocalObject(villager, ACTION_WP, wp);
            return TAVERN;
        } else if(choice < 85) {
            object wp = GetNearestObjectByTag(MARKET, OBJECT_SELF,
                                              Random(marketCnt) + 1);
            SetLocalObject(villager, ACTION_WP, wp);
            return MARKET;
        } else {
            object wp = GetNearestObjectByTag(WATER, OBJECT_SELF,
                                              Random(waterCnt) + 1);
            SetLocalObject(villager, ACTION_WP, wp);
            object oTool = CreateItemOnObject("_bucket", villager);
            AssignCommand(villager,
                          ActionEquipItem(oTool, INVENTORY_SLOT_LEFTHAND));
            return WATER;
        }
    } else {
        if(choice < 20 && GetIsNight() == FALSE) {
            object wp = GetNearestObjectByTag(CROPS, OBJECT_SELF,
                                              Random(cropsCnt) + 1);
            SetLocalObject(villager, ACTION_WP, wp);
            string randTool = randomFarmToolResef();
            object oTool = CreateItemOnObject(randomFarmToolResef(), villager);
            AssignCommand(villager,
                          ActionEquipItem(oTool, INVENTORY_SLOT_RIGHTHAND));
            return CROPS;
        } else if(choice < 30) {
            object wp = GetNearestObjectByTag(TAVERN, OBJECT_SELF,
                                              Random(tavernCnt) + 1);
            SetLocalObject(villager, ACTION_WP, wp);
            return TAVERN;
        } else if(choice < 70) {
            object wp = GetNearestObjectByTag(MARKET, OBJECT_SELF,
                                              Random(marketCnt) + 1);
            SetLocalObject(villager, ACTION_WP, wp);
            return MARKET;
        } else {
            object wp = GetNearestObjectByTag(WATER, OBJECT_SELF,
                                              Random(waterCnt) + 1);
            SetLocalObject(villager, ACTION_WP, wp);
            object oTool = CreateItemOnObject("_bucket", villager);
            AssignCommand(villager,
                          ActionEquipItem(oTool, INVENTORY_SLOT_LEFTHAND));
            return WATER;
        }
    }

    return WATER;
}
