/*
 *  This script is a part of a suite of scripts which should be placed on
 *  nested triggers.
 *
 *  Placed on trigger with tag: "bandit_amb_1":
 *      ms_bandit_amb1e - On Enter, Collects PCs to target/evaluate.
 *  Placed on trigger with tag: "bandit_amb_1":
 *      ms_bandit_amb1x - On Exit,  Removes  PCs to target/evaluate.
 *  Placed on trigger with tag: "bandit_amb_2":
 *      ms_bandit_amb2 - On Enter, Chance for PCs to notice ambush.
 *  Placed on trigger with tag: "bandit_amb_3":
 *      ms_bandit_amb3 - On Enter, Go/No Go and drop bandits if go.
 */
#include "ms_bandit_ambcon"
#include "ms_bandit_ambuti"
#include "ms_seed_bandits"
#include "nwnx_time"

void BanditAttack(object richestPC, int bandXPAllocation, object ambushTrigger,
                  int minLvl){

    vector pcVector = GetPosition(richestPC);
    float pcAngle = GetFacing(richestPC);
    int attackYelled = 0;

    while (bandXPAllocation > 0) {
        writeToLog("bandXPAllocation: " + IntToString(bandXPAllocation));
        int banditLvl = 0;
        // if we are at the end of our xp allocation just use a lvl 1 char
        if(bandXPAllocation > 300) {
            // loop till we get a valid lvl pick.\
            int curTry = 0;
            while(banditLvl == 0 && curTry < 10) {
                int randCharLvl = Random(5) + minLvl;
                int randCharLvlXP = getXPTableValueCore(randCharLvl);
                if(bandXPAllocation - randCharLvlXP > 0) {
                    banditLvl = randCharLvl;
                    bandXPAllocation -= randCharLvlXP;
                }
                curTry++;
            }
        }

        if(banditLvl == 0) {
            banditLvl = 1;
            bandXPAllocation -= 300;
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
        int arraySize = NWNX_Data_Array_Size(NWNX_DATA_TYPE_OBJECT,
                                             ambushTrigger,
                                             MS_BANDIT_AMBUSH_DETECT_PC_ARRAY);
        object randomPC = NWNX_Data_Array_At_Obj(ambushTrigger,
                                   MS_BANDIT_AMBUSH_DETECT_PC_ARRAY, arraySize);
        SetActionMode(bandit, ACTION_MODE_STEALTH, TRUE);
        AssignCommand(bandit, ActionAttack(randomPC, TRUE));
        if(attackYelled == 0) {
            attackYelled = 1;
            AssignCommand(bandit, ActionSpeakString("Attack!"));
        }
    }

    DelayCommand(0.1, TearBanditAmbushDown(GetArea(ambushTrigger)));
}

void BanditAmbush() {

    int banditActivityLevel = GetCampaignInt("FACTION_ACTIVITY",
                               "BANDIT_ACTIVITY_LEVEL_2147440");
    // cap banditActivityLevel at 200
    if(banditActivityLevel > 200) {
        banditActivityLevel = 200;
    }
    int banditBaseXP = GetLocalInt(OBJECT_SELF, MS_BANDIT_AMBUSH_BANDIT_XP);
    writeToLog("banditBaseXP: " + IntToString(banditBaseXP));
    float num = IntToFloat(banditBaseXP * banditActivityLevel);
    int bandXPAllocation = FloatToInt(num/100.0) + 100;
    writeToLog("banditBaseXP: " + IntToString(banditActivityLevel));
    writeToLog("banditBaseXP: " + IntToString(bandXPAllocation));
    int bandSenseMotive = GetLocalInt(OBJECT_SELF, MS_BANDIT_AMBUSH_BANDIT_SM);
    struct AmbushMetrics am = GatherAmbushMetrics(OBJECT_SELF);

    int attack = DecideIfAttack(am.totalEstPCWealth,
                                am.totalPCLvls,
                                am.totalPCs,
                                bandSenseMotive,
                                banditActivityLevel,
                                bandXPAllocation);

    if(attack == TRUE) {
        writeToLog("We are Attacking!");
        int minLvl = GetLocalInt(OBJECT_SELF, MS_BANDIT_AMBUSH_BANDIT_MIN_LVL);
        BanditAttack(am.richestPC, bandXPAllocation, OBJECT_SELF, minLvl);
    } else {
        writeToLog("Choose attacking not worth it.");
    }
}

void main()
{
    int curTime = NWNX_Time_GetTimeStamp();
    int lastAmbush = GetLocalInt(OBJECT_SELF, MS_BANDIT_AMBUSH_LAST_AMBUSH);
    if(curTime - lastAmbush > MS_BANDIT_AMBUSH_DELAY_SECONDS) {
        SetLocalInt(OBJECT_SELF, MS_BANDIT_AMBUSH_LAST_AMBUSH, curTime);
        BanditAmbush();
        NWNX_Data_Array_Clear(NWNX_DATA_TYPE_OBJECT, OBJECT_SELF,
                              MS_BANDIT_AMBUSH_DETECT_PC_ARRAY);
    }
}
