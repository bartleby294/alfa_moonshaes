#include "_btb_vil_const"
#include "_btb_villag_util"
#include "nwnx_area"
#include "_btb_util"

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

void DestoryCheck() {
    int oAreaPlayerNumber
        = NWNX_Area_GetNumberOfPlayersInArea(GetArea(OBJECT_SELF));
    if(oAreaPlayerNumber == 0) {
        int noPCSeenIn = GetLocalInt(OBJECT_SELF, NO_PC_SEEN_IN);
        SetLocalInt(OBJECT_SELF, NO_PC_SEEN_IN, noPCSeenIn + 1);
        if(noPCSeenIn > 5) {
            DestroyObject(OBJECT_SELF, 2.0);
        }
    } else {
        SetLocalInt(OBJECT_SELF, "NoPCSeenIn", 0);
    }
}

void HomeActions(object villageController, int villagerCnt, object spawnLoc) {
    //SpeakString("*Opens Door*");
    PlaySound("as_dr_woodmedop1")
    DestroyObject(OBJECT_SELF, 2.0);
    SetLocalInt(villageController, VILLAGER_TAG, villagerCnt - 1);
}

void CropActions(object villageController, int villagerCnt, int cropsCnt,
                 object spawnLoc) {
    AssignCommand(OBJECT_SELF,
                  ActionPlayAnimation(ANIMATION_LOOPING_GET_LOW, 1.0));

    int tendFeildChance = 19;
    if(GetIsNight()) {
        tendFeildChance = 4;
    }

    if(Random(20) + 1 < tendFeildChance) {
        object wp = GetNearestObjectByTag(CROPS, OBJECT_SELF, Random(2) + 1);
        location randLoc = pickLoc(OBJECT_SELF, 3.0, 90.0);
        AssignCommand(OBJECT_SELF, ActionMoveToLocation(randLoc));
        SetLocalObject(OBJECT_SELF, ACTION_WP, wp);
    } else {
        SetLocalObject(OBJECT_SELF, ACTION_WP, spawnLoc);
    }
}

void MarketActions(object villageController, int villagerCnt, int marketCnt,
                   object spawnLoc) {
    AssignCommand(OBJECT_SELF,
                  ActionPlayAnimation(GetMarketAnimation(), 1.0));
    if(Random(6) + 1 < 5) {
        object wp = GetNearestObjectByTag(MARKET, OBJECT_SELF,
                                      Random(marketCnt) + 1);
        SetLocalObject(OBJECT_SELF, ACTION_WP, wp);
    } else {
        SetLocalObject(OBJECT_SELF, ACTION_WP, spawnLoc);
    }
}

void WaterActions(object villageController, int villagerCnt, object spawnLoc) {
    SpeakString("*Fills bucket with water.*");
    PlaySound("as_na_splash1");
    SetLocalObject(OBJECT_SELF, ACTION_WP, spawnLoc);
}

void TavernActions(object villageController, int villagerCnt, object spawnLoc) {
    //SpeakString("*Opens Door*");
    DestroyObject(OBJECT_SELF, 2.0);
    SetLocalInt(villageController, VILLAGER_TAG, villagerCnt - 1);
}

void main()
{
    // if in combat get inside a house!
    if(GetIsInCombat()) {
        object wp = GetNearestObjectByTag(HOME);
        ActionMoveToObject(wp, TRUE, 0.5);
        SetLocalObject(OBJECT_SELF, ACTION_WP, wp);
    }

    DestoryCheck();

    int isMale = GetGender(OBJECT_SELF);
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
        SetFacing(GetFacing(actionWP));
    }

    if(actionTag == HOME && reachedWp == TRUE) {
        HomeActions(villageController, villagerCnt, spawnLoc);
    } else if(actionTag == CROPS && reachedWp == TRUE) {
        CropActions(villageController, villagerCnt, cropsCnt, spawnLoc);
    } else if (actionTag == MARKET && reachedWp == TRUE) {
        MarketActions(villageController, villagerCnt, marketCnt, spawnLoc);
    }  else if (actionTag == TAVERN && reachedWp == TRUE) {
        TavernActions(villageController, villagerCnt, spawnLoc);
    }  else if (actionTag == WATER && reachedWp == TRUE) {
        WaterActions(villageController, villagerCnt, spawnLoc);
    }
}
