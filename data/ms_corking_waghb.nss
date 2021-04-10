#include "nw_i0_plot"
#include "nwnx_data"
#include "ms_bandit_ambcon"
#include "ms_bandit_ambuti"
#include "ms_seed_bandits"
#include "nwnx_time"
#include "ms_corking_wagco"

const string AREA_WPS = "area_waypoints";

void BanditAttack(object wagon, int bandXPAllocation, int minLvl){

    vector pcVector = GetPosition(wagon);
    float pcAngle = GetFacing(wagon);
    int attackYelled = 0;

    while (bandXPAllocation > 0) {
        writeToLog("bandXPAllocation: " + IntToString(bandXPAllocation));
        int banditLvl = 0;
        // if we are at the end of our xp allocation just use a lvl 1 char
        if(bandXPAllocation <= 300) {
            banditLvl = 1;
            bandXPAllocation -= 300;
        } else {
            // loop till we get a valid lvl pick.
            while(banditLvl == 0) {
                int randCharLvl = Random(5) + minLvl;
                int randCharLvlXP = getXPTableValueCore(randCharLvl);
                if(bandXPAllocation - randCharLvlXP > 0) {
                    banditLvl = randCharLvl;
                    bandXPAllocation -= randCharLvlXP;
                }
            }
        }
        // pick gender (will put in after the rest is tested)
        string race = pickRace();
        string class = pickClass();
        string resref = race + class + "m_bandit_1";
        writeToLog("bandit type: " + resref + " lvl: " + IntToString(banditLvl));
        location spawnLoc = pickSpawnLocBan(pcVector, pcAngle);
        // Spawn the bandit.
        object bandit = CreateObject(OBJECT_TYPE_CREATURE, resref,
                            spawnLoc, FALSE, resref);
        SetEventScript(bandit, EVENT_SCRIPT_CREATURE_ON_HEARTBEAT,
                   "_btb_ai_ban_hb3");
        object bandRing = CreateItemOnObject("CopperBanditRing", bandit, 1);
        SetDroppableFlag(bandRing, TRUE);
        // Level the bandit up.
        int curBanditLvl = 1;
        while(curBanditLvl < banditLvl) {
            LevelUpHenchman(bandit, CLASS_TYPE_INVALID, 1, PACKAGE_INVALID);
            AddLootToBandit(bandit, race, class);
            curBanditLvl++;
        }
        // Add prefix to name based on lvl.
        SetName(bandit, getBanditPrefix(banditLvl) + GetName(bandit));
        SetActionMode(bandit, ACTION_MODE_STEALTH, TRUE);
        AssignCommand(bandit, ActionAttack(wagon, TRUE));
        if(attackYelled == 0) {
            attackYelled = 1;
            AssignCommand(bandit, ActionSpeakString("Attack!"));
        }
    }
}

void BanditAmbush() {

    int banditActivityLevel = GetCampaignInt("FACTION_ACTIVITY",
                               "BANDIT_ACTIVITY_LEVEL_2147440");

    // cap banditActivityLevel at 200
    if(banditActivityLevel > 200) {
        banditActivityLevel = 200;
    }

    int banditBaseXP = GetLocalInt(OBJECT_SELF, MS_BANDIT_AMBUSH_BANDIT_XP);
    banditBaseXP = 2400; // over riding for now.
    int minLvl = GetLocalInt(OBJECT_SELF, MS_BANDIT_AMBUSH_BANDIT_MIN_LVL);
    minLvl = 1; // over riding for now will be escort lvl 1-3.
    float num = IntToFloat(banditBaseXP * banditActivityLevel);
    int bandXPAllocation = FloatToInt(num/100.0) + 100;
    BanditAttack(OBJECT_SELF, bandXPAllocation, minLvl);
}

void AmbushChance(int curTurn) {

    int ambushCount = GetLocalInt(OBJECT_SELF, "ambushCount");
    int ambushCountMax = GetLocalInt(OBJECT_SELF, "ambushCountMax");

    /* Set a max if we dont have one. */
    if(ambushCountMax == 0) {
        ambushCountMax = d2() + 1;
        SetLocalInt(OBJECT_SELF, "ambushCountMax", 1);
    }

    /* If weve met our max ambush quota exit. */
    if(ambushCount >= ambushCountMax) {
        return;
    }

    /* Check to see if we are in an area where ambushes can occur */
    string areaTag = GetTag(GetArea(OBJECT_SELF));
    if(areaTag == "v_49_e" || areaTag == "w_49_e" || areaTag == "z_49_e"
       || areaTag == "cc_48_e") {
        return;
    }

    /* If were all good to go roll up if we have an ambush. */
    int chance = Random(2000);
    if(chance > 1995 - curTurn) {
        BanditAmbush();
        SetLocalInt(OBJECT_SELF, "ambushCount", ambushCount + 1);
    }
}

int getShouldStop() {

    float distanceToPC = GetDistanceToObject(GetNearestPC());

    int isPCTooFar = TRUE;
    int noPCNearWagon = FALSE;
    int isInCombat = GetIsInCombat();
    int isWagonStopped = GetLocalInt(OBJECT_SELF, "waggonStopped");

    if(distanceToPC < 0.0) {
        noPCNearWagon = TRUE;
    }

    if(distanceToPC < 15.0 && noPCNearWagon == FALSE) {
        isPCTooFar = FALSE;
    }

    if((isPCTooFar == TRUE || isWagonStopped == TRUE) && isInCombat == FALSE) {
        if(d6() == 1) {
            int speakChoice = d6();
            if(speakChoice == 1) {
                SpeakString("Whats the hold up?");
            } else if(speakChoice == 2) {
                SpeakString("We moven soon?");
            } else if(speakChoice == 3) {
                SpeakString("Somethin in the road?");
            } else if(speakChoice == 4) {
                SpeakString("I aint got all day!");
            } else if(speakChoice == 5) {
                SpeakString("Wha are yer legs tired?");
            } else if(speakChoice == 6) {
                SpeakString("We ready?");
            }
        }
    }

    if(isInCombat || isPCTooFar || isWagonStopped) {
        return TRUE;
    }

    return FALSE;
}

void CheckIfWeShouldDestroyOurSelf() {
    int state = GetLocalInt(OBJECT_SELF, WAGON_ESCORT_STATE);

    if(state == WAGON_STATE_FINISHED) {
        object oArea = GetArea(OBJECT_SELF);
        int numberOfPlayers = NWNX_Area_GetNumberOfPlayersInArea(oArea);
        if(numberOfPlayers == 0) {
            DestroyObject(OBJECT_SELF);
        }
    }
}

void main()
{
    if(GetIsDMPossessed(OBJECT_SELF)) {
        return;
    }

    if(GetLocalInt(OBJECT_SELF, WAGON_ESCORT_STATE) != WAGON_STATE_IN_PROGRESS){
        return;
    }

    int curTurn = GetLocalInt(OBJECT_SELF, "curTurn");
    SetLocalInt(OBJECT_SELF, "curTurn", curTurn + 1);

    AmbushChance(curTurn);

    if(getShouldStop() == TRUE) {
        ClearAllActions(TRUE);
        WriteTimestampedLogEntry(" * ShouldStop");
        return;
    }

    string baseWpStr = "corwell_to_kingsbay_wp_";
    int curWPInt = GetLocalInt(OBJECT_SELF, "curWP");

    if(curWPInt == 0) {
        int i = 1;
        string waypointStr = baseWpStr + IntToString(i);
        object areaWP = GetObjectByTag(waypointStr);
        while (areaWP != OBJECT_INVALID) {
            NWNX_Data_Array_PushBack_Obj(OBJECT_SELF, AREA_WPS, areaWP);
            i++;
            waypointStr = baseWpStr + IntToString(i);
            areaWP = GetObjectByTag(waypointStr);
        }
        SetLocalInt(OBJECT_SELF, "curWP", 1);
    }

    object curWP = NWNX_Data_Array_At_Obj(OBJECT_SELF, AREA_WPS, curWPInt);
    if(GetDistanceToObject(curWP) < 3.0) {
        SetLocalInt(OBJECT_SELF, "curWP", curWPInt + 1);
        curWP = NWNX_Data_Array_At_Obj(OBJECT_SELF, AREA_WPS, curWPInt + 1);
        // if were out of waypoints we are there.
        if(curWP == OBJECT_INVALID) {
            SetLocalInt(OBJECT_SELF, WAGON_ESCORT_STATE, WAGON_STATE_FINISHED);
        }
    }

    CheckIfWeShouldDestroyOurSelf();

    AssignCommand(OBJECT_SELF, ActionMoveToObject(curWP));
}
