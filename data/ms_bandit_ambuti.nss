/**
*   Decide if the attack is on or off.
*    Bandit makes sense motive checks:
*     DC<10 party average +-5 levels,
*     DC 10 party average +-3 levels,
*     DC 15 party average level +-1 level,
*     DC 20 party average level
*
*   Return 1 if attack 0 if dont attack.
*/
#include "nwnx_data"
#include "_btb_util"
#include "_btb_ban_util"
#include "alfa_wealth_inc"

struct AmbushMetrics {
    object richestPC;
    int totalEstPCWealth;
    int totalPCLvls;
    int totalPCs;
};

int BanditsDetectPC(object oPC, int bandSpot, int bandListen) {

    int hideCheck = d20(1) + GetSkillRank(SKILL_HIDE, oPC);
    int moveSilentlyCheck = d20(1) + GetSkillRank(SKILL_MOVE_SILENTLY, oPC);

    if(GetStealthMode(oPC) == STEALTH_MODE_DISABLED
       || hideCheck < d20() + bandSpot
       || moveSilentlyCheck < d20() + bandListen) {
        return TRUE;
    }

    return FALSE;
}

struct AmbushMetrics GatherAmbushMetrics(object ambushTrigger) {

    struct AmbushMetrics ambushMetrics;
    int arraySize = NWNX_Data_Array_Size(NWNX_DATA_TYPE_OBJECT, ambushTrigger,
                                         MS_BANDIT_AMBUSH_PC_ARRAY);
    int i = 0;
    int richestPCValue = 0;
    int bandSpot = GetLocalInt(ambushTrigger, MS_BANDIT_AMBUSH_BANDIT_SPOT);
    int bandListen = GetLocalInt(ambushTrigger, MS_BANDIT_AMBUSH_BANDIT_LISTEN);
    int bandAppraise = GetLocalInt(ambushTrigger, MS_BANDIT_AMBUSH_BANDIT_APP);

    writeToLog("bandSpot: " + IntToString(bandSpot));
    writeToLog("bandListen: " + IntToString(bandListen));
    writeToLog("bandAppraise: " + IntToString(bandAppraise));
    writeToLog("arraySize: " + IntToString(arraySize));

    while(i < arraySize) {
        object oPC = NWNX_Data_Array_At_Obj(ambushTrigger,
                                            MS_BANDIT_AMBUSH_PC_ARRAY,
                                            i);
        if(BanditsDetectPC(oPC, bandSpot, bandListen) == TRUE) {
            writeToLog("PC detected: " + GetPCPlayerName(oPC));
            int estimatedPCWorth = GetTotalWealth(oPC);
            // If they fail they over or under estimate.
            if(d20() + bandAppraise <= 16) {
                int roll = d6(2) + 3;
                estimatedPCWorth =
                    FloatToInt(estimatedPCWorth * roll * 0.1);
            }

            // Check if this PC should be the new main mark.
            if(estimatedPCWorth > richestPCValue) {
                ambushMetrics.richestPC = oPC;
                richestPCValue = estimatedPCWorth;
            }

            NWNX_Data_Array_PushBack_Obj(ambushTrigger,
                                         MS_BANDIT_AMBUSH_DETECT_PC_ARRAY, oPC);

            // Acumulate Party Levels
            int totalPCLvl = GetLevelByPosition(1, oPC) +
                             GetLevelByPosition(2, oPC) +
                             GetLevelByPosition(3, oPC);

            // Tally Everything up.
            ambushMetrics.totalEstPCWealth += estimatedPCWorth;
            ambushMetrics.totalPCLvls += totalPCLvl;
            ambushMetrics.totalPCs = ambushMetrics.totalPCs + 1;
        }

        i++;
    }

    return ambushMetrics;
}

int DecideIfAttack(int totalEstPCWealth, int totalPCLvls, int totalPCs,
                   int bandSenseMotive, int banditActivityLevel,
                   int bandXPAllocation) {

    if(totalPCs == 0) {
        return FALSE;
    }

    int estAvgPCWealth = totalEstPCWealth/totalPCs;
    int avgPCLvl = totalPCLvls/totalPCs;
    int senseMotivePercept = 5;
    int estAvgPCLvl = 0;

    // Sense motive roll to get the party lvl correct.
    int senseMotiveRoll = d20() + bandSenseMotive;
    if(senseMotiveRoll >= 20) {
        senseMotivePercept = 0;
    } else if(senseMotiveRoll >= 15) {
        senseMotivePercept = 1;
    } else if(senseMotiveRoll >= 10) {
        senseMotivePercept = 3;
    }

    // Random add or subtract.
    if(Random(2) == 0) {
        estAvgPCLvl = avgPCLvl + Random(senseMotivePercept);
    } else {
        estAvgPCLvl = avgPCLvl - Random(senseMotivePercept);
    }

    // Decide if the fight will be worth the trouble.
    int normalWealth = getWealthTableValue(estAvgPCLvl);
       int estTotalPartyXP = getXPTableValueCore(estAvgPCLvl) * totalPCs;

    writeToLog("estAvgPCWealth: " + IntToString(estAvgPCWealth));
    writeToLog("normalWealth: " + IntToString(normalWealth));
    writeToLog("bandXPAllocation: " + IntToString(bandXPAllocation));
    writeToLog("estTotalPartyXP: " + IntToString(estTotalPartyXP));
    writeToLog("banditActivityLevel: " + IntToString(banditActivityLevel));

    int wealthDecisionPct = (estAvgPCWealth * 100) / normalWealth;
    int lvlDecisionPct =  (bandXPAllocation * 100) / estTotalPartyXP;
    int totalDecisionPct =  (banditActivityLevel +  lvlDecisionPct
                                + wealthDecisionPct) / 3;

    writeToLog("wealthDecisionPct: " + IntToString(wealthDecisionPct));
    writeToLog("lvlDecisionPct: " + IntToString(lvlDecisionPct));
    writeToLog("totalDecisionPct: " + IntToString(totalDecisionPct));

    // Do I think i can win? If my total strength is 50% what theirs is maybe.
    if(lvlDecisionPct > 50) {
        int decisionNum = Random(100) + 1;
        writeToLog("I think we can win.");
        writeToLog("decisionNum: " + IntToString(decisionNum));
        // If we are with in our decision percentage we are good to attack.
        if(decisionNum <= totalDecisionPct) {
            return TRUE;
        }
    }

    return FALSE;
}

/**
    Return a location some units of distance away on a straight line.
 */
location pickSpawnLocBan(vector pcVector, float pcAngle) {

    vector bandVector = GetPosition(OBJECT_SELF);
    vector normPcVector = AngleToVector(pcAngle);

    float x = normPcVector.x;
    float y = normPcVector.y;

    float randX = randomFloat(4, 8);
    float randY = randomFloat(4, 8);

    int distance = 25;

    // 90 or 270 degree rotation of position.
    switch(Random(3) + 1)
    {
        case 1:
            x = cos(90.0) * x - sin(90.0) * y;
            y = sin(90.0) * x + cos(90.0) * y;
            distance = 15;
        case 2:
            x = cos(270.0) * x - sin(270.0) * y;
            y = sin(270.0) * x + cos(270.0) * y;
            distance = 15;
    }

    vector norm = VectorNormalize(Vector(x, y, 0.0));
    float spawnX = pcVector.x + (distance * norm.x) + randX;
    float spawnY = pcVector.y + (distance * norm.y) + randY;

    return Location(GetArea(OBJECT_SELF), Vector(spawnX, spawnY, 0.0), 0.0);
}
