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

string ChooseVillagerAction(int isMale, int cropsCnt,int marketCnt,
                            int tavernCnt, int waterCnt, object villager) {

    int choice = Random(100) + 1;
    if(isMale == TRUE) {
        if(choice < 40) {
            object wp = GetNearestObjectByTag(CROPS, OBJECT_SELF,
                                              Random(cropsCnt) + 1);
            SetLocalObject(villager, ACTION_WP, wp);
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
            return WATER;
        }
    } else {
        if(choice < 20) {
            object wp = GetNearestObjectByTag(CROPS, OBJECT_SELF,
                                              Random(cropsCnt) + 1);
            SetLocalObject(villager, ACTION_WP, wp);
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
            return WATER;
        }
    }

    return WATER;
}
