#include "_btb_vil_const"
#include "_btb_villag_util"

int GetMarketAnimation() {

    switch(Random(8) + 1) {
        case 1:
            return ANIMATION_LOOPING_TALK_NORMAL;
        case 2:
            return ANIMATION_LOOPING_TALK_PLEADING;
        case 3:
            return ANIMATION_LOOPING_TALK_LAUGHING;
        case 4:
            return ANIMATION_LOOPING_TALK_FORCEFUL;
        case 5:
            return ANIMATION_LOOPING_PAUSE;
        case 6:
            return ANIMATION_LOOPING_GET_MID;
        case 7:
            return ANIMATION_LOOPING_PAUSE_TIRED;
        case 8:
            return ANIMATION_LOOPING_PAUSE2;
    }
    return ANIMATION_LOOPING_TALK_NORMAL;
}

void main()
{
    int isMale = GetLocalInt(OBJECT_SELF, IS_MALE);
    int initalized = GetLocalInt(OBJECT_SELF, INITALIZED);
    object actionWP = GetLocalObject(OBJECT_SELF, ACTION_WP);
    object spawnLoc = GetLocalObject(OBJECT_SELF, HOME);
    string actionTag = GetTag(actionWP);
    object villageController = GetNearestObjectByTag("village_life_controller");
    int villagerCnt = GetLocalInt(villageController, VILLAGER_TAG);
    int cropsCnt = GetLocalInt(villageController, CROPS);
    int marketCnt = GetLocalInt(villageController, MARKET);
    int tavernCnt = GetLocalInt(villageController, TAVERN);
    int waterCnt = GetLocalInt(villageController, WATER);

    int reachedWp = FALSE;
    if(GetDistanceToObject(actionWP) > 1.0) {
        ActionMoveToObject(actionWP, FALSE, 0.5);
    } else {
        reachedWp = TRUE;
    }

    if(actionTag == HOME) {
        if(reachedWp == TRUE) {
            SpeakString("*Opens Door*");
            DestroyObject(OBJECT_SELF, 2.0);
            SetLocalInt(villageController, VILLAGER_TAG, villagerCnt - 1);
        }
    } else if(actionTag == CROPS) {
        if(initalized == FALSE) {
            SetLocalInt(OBJECT_SELF, INITALIZED, TRUE);
        }

        if(reachedWp == TRUE) {
            AssignCommand(OBJECT_SELF,
                          ActionPlayAnimation(ANIMATION_LOOPING_GET_LOW, 1.0));
            if(Random(4) + 1 < 3) {
                object wp = GetNearestObjectByTag(CROPS, OBJECT_SELF,
                                              Random(cropsCnt) + 1);
                SetLocalObject(OBJECT_SELF, ACTION_WP, wp);
            } else {
                SetLocalObject(OBJECT_SELF, ACTION_WP, spawnLoc);
            }
        }
    } else if (actionTag == MARKET) {
        if(initalized == FALSE) {
            SetLocalInt(OBJECT_SELF, INITALIZED, TRUE);
        }

        if(reachedWp == TRUE) {
            AssignCommand(OBJECT_SELF,
                          ActionPlayAnimation(GetMarketAnimation(), 1.0));
            if(Random(4) + 1 < 3) {
                object wp = GetNearestObjectByTag(CROPS, OBJECT_SELF,
                                              Random(cropsCnt) + 1);
                SetLocalObject(OBJECT_SELF, ACTION_WP, wp);
            } else {
                SetLocalObject(OBJECT_SELF, ACTION_WP, spawnLoc);
            }
        }
    }  else if (actionTag == TAVERN) {
        if(initalized == FALSE) {
            SetLocalInt(OBJECT_SELF, INITALIZED, TRUE);
        }

        if(reachedWp == TRUE) {
            SpeakString("*Opens Door*");
            DestroyObject(OBJECT_SELF, 2.0);
            SetLocalInt(villageController, VILLAGER_TAG, villagerCnt - 1);
        }
    }  else if (actionTag == WATER) {
        if(initalized == FALSE) {
            SetLocalInt(OBJECT_SELF, INITALIZED, TRUE);
        }

        if(reachedWp == TRUE) {
            SpeakString("*Fills bucket with water.*");
            PlaySound("as_na_splash1");
            SetLocalObject(OBJECT_SELF, ACTION_WP, spawnLoc);
        }
    }
}
