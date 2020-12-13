#include "alfa_wealth_inc"
#include "nwnx_time"
#include "nw_o0_itemmaker"

void writeToLog(string str) {
    string oAreaName = GetName(GetArea(OBJECT_SELF));
    WriteTimestampedLogEntry(oAreaName + ": " +  str);
}

object GetFirstPCInArea(object oAreaTest)
{
    object oPCTestValid = GetFirstPC();
    while(GetArea(oPCTestValid)!=oAreaTest&&GetIsObjectValid(oPCTestValid))
        oPCTestValid = GetNextPC();
    return(oPCTestValid);
}

object GetNextPCInArea(object oAreaTest)
{
    object oPCTestValid = GetNextPC();
    while(GetArea(oPCTestValid)!=oAreaTest&&GetIsObjectValid(oPCTestValid))
        oPCTestValid = GetNextPC();
    return(oPCTestValid);
}

/**
 * This may need some adjustment right now im using the standard dnd suggested
 * wealth values to start but may need adjustment for alfa evntually.
*/
int getWealthTableValue(int charLvl) {
    switch (charLvl)
    {
        case 1:
             return 500;
        case 2:
             return 1000;
        case 3:
             return 3000;
        case 4:
             return 6000;
        case 5:
             return 10000;
        case 6:
             return 15000;
        case 7:
             return 21000;
        case 8:
             return 28000;
        case 9:
             return 36000;
        case 10:
             return 45000;
        case 11:
             return 55000;
        case 12:
             return 66000;
        case 13:
             return 78000;
        case 14:
             return 91000;
        case 15:
             return 105000;
        case 16:
             return 120000;
        case 17:
             return 136000;
        case 18:
             return 153000;
        case 19:
             return 171000;
        case 20:
             return 190000;
        default:
             return 1;
    }

    return 200000;
}

int getXPTableValue(int charLvl) {
    switch (charLvl)
    {
        case 1:
             return 300;
        case 2:
             return 900;
        case 3:
             return 2700;
        case 4:
             return 5400;
        case 5:
             return 9000;
        case 6:
             return 13000;
        case 7:
             return 19000;
        case 8:
             return 27000;
        case 9:
             return 36000;
        case 10:
             return 49000;
        case 11:
             return 66000;
        case 12:
             return 88000;
        case 13:
             return 110000;
        case 14:
             return 150000;
        case 15:
             return 200000;
        case 16:
             return 260000;
        case 17:
             return 340000;
        case 18:
             return 440000;
        case 19:
             return 580000;
        case 20:
             return 760000;
        default:
             return 1;
    }

    return 1;
}

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
int DecideIfAttack(int totalEstPCWealth, int totalPCLvls, int totalPCs,
                   int bandSenseMotive, int banditActivityLevel,
                   int bandXPAllocation) {

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
       int estTotalPartyXP = getXPTableValue(estAvgPCLvl) * totalPCs;

    int wealthDecisionPct = (estAvgPCWealth * 100) / normalWealth;
    int lvlDecisionPct =  (bandXPAllocation * 100) / estTotalPartyXP;
    int totalDecisionPct =  (banditActivityLevel +  lvlDecisionPct
                                + wealthDecisionPct) / 3;

    writeToLog("wealthDecisionPct: " + IntToString(wealthDecisionPct));
    writeToLog("lvlDecisionPct: " + IntToString(lvlDecisionPct));
    writeToLog("totalDecisionPct: " + IntToString(totalDecisionPct));

    int decisionNum = Random(100) + 1;
    writeToLog("decisionNum: " + IntToString(decisionNum));
    // If we are with in our decision percentage we are good to attack.
    if(decisionNum <= totalDecisionPct) {
        return 1;
    }

    return 0;
}

void setAttackState(object oArea, int value) {
    SetCampaignInt("BANDIT_ACTIVITY_LEVEL_2147440",
        "BANDIT_STATE_" + GetTag(oArea), value);
    // Set the time of the last state change.
    SetCampaignInt("BANDIT_ACTIVITY_LEVEL_2147440",
        "BANDIT_STATE_TIME_" + GetTag(oArea), NWNX_Time_GetTimeStamp());
}

string pickRace() {

    int roll = d100();

    // 15% Halfling
    if(roll > 0 && roll < 15) {
        return "ha";
    }
    // 10% Half Orc
    if(roll > 15 && roll < 25) {
        return "ho";
    }

    // 75% Human
    return "hu";
}

string pickClass() {

    int roll = d100();

    // 15% Preist
    if(roll > 0 && roll < 15) {
        return "p";
    }
    // 10% wizard
    if(roll > 15 && roll < 25) {
        return "w";
    }
    // 25% fighter
    if(roll > 25 && roll < 50) {
        return "f";
    }

    // 50% rogue
    return "r";
}

float randomFloat(int den, int num) {
    float denominator = IntToFloat(Random(den) + 1);
    float numerator = IntToFloat(Random(num) + 1);
    return numerator/denominator;
}

/**
    Return a location some units of distance away on a straight line.
 */
location pickSpawnLoc(object richestPC) {

    vector bandVector = GetPosition(OBJECT_SELF);
    vector pcVector = GetPosition(richestPC);

    float x = pcVector.x - bandVector.x;
    float y = pcVector.y - bandVector.y;

    float randX = randomFloat(4, 8);
    float randY = randomFloat(4, 8);

    switch(Random(3) + 1)
    {
        case 1:
            y = y * -1.0;
        case 2:
            x = x * -1.0;
    }

    vector norm = VectorNormalize(Vector(x, y, 0.0));
    float spawnX = pcVector.x + (25 * norm.x) + randX;
    float spawnY = pcVector.y + (25 * norm.y) + randY;

    return Location(GetArea(OBJECT_SELF), Vector(spawnX, spawnY, 0.0), 0.0);
}

/*
location(pickSpawnLocobject richestPC) {

    vector bandVector = GetPosition(OBJECT_SELF);
    vector pcVector = GetPosition(richestPC);

    float x = pcVector.x - bandVector.x;
    float y = pcVector.y - bandVector.y;

    float randX = randomFloat(4, 8);
    float randY = randomFloat(4, 8);

    vector norm = VectorNormalize(Vector(x, y, 0.0));
    float spawnX = bandVector.x + (15 * norm.x) + randX;
    float spawnY = bandVector.y + (15 * norm.y) + randY;

    return Location(GetArea(OBJECT_SELF), Vector(spawnX, spawnY, 0.0), 0.0);
}
*/

/**
 * This will get the current bandit attack state. It will also advance the
 * state if appropriate.
 */
int GetCurrentBanditAttackState(object oArea){
    int curBanditAttackState = GetCampaignInt("BANDIT_ACTIVITY_LEVEL_2147440",
                               "BANDIT_STATE_" + GetTag(oArea));

    if(curBanditAttackState == 1
        || curBanditAttackState == 3
        || curBanditAttackState == 4) {
        int lastStateDateTime = GetCampaignInt("BANDIT_ACTIVITY_LEVEL_2147440",
                                    "BANDIT_STATE_TIME_" + GetTag(oArea));
        int hardResetTime = 200;// was 600
        int softResetTime = 60; // was 300
        int curDateTime = NWNX_Time_GetTimeStamp();
        int elapsedTime = curDateTime - lastStateDateTime;

        //writeToLog("curDateTime: "+ IntToString(curDateTime));
        //writeToLog("lastStateDateTime: "+ IntToString(lastStateDateTime));
        //writeToLog("elapsedTime: "+ IntToString(elapsedTime));

        // Reset our state back to observe if too much time has elapsed.
        if(elapsedTime > hardResetTime) {
            curBanditAttackState = 0;
            setAttackState(oArea, curBanditAttackState);
        // Reset our state back to observe after deciding not to attack.ck.
        } else if (elapsedTime > 300 && curBanditAttackState == 3) {
            curBanditAttackState = 0;
            setAttackState(oArea, curBanditAttackState);
        // Advance to attack decision if observation state and time elapsed.
        } else if (elapsedTime > 10 && curBanditAttackState == 1) {
            curBanditAttackState = 2;
            setAttackState(oArea, curBanditAttackState);
        }
    }

    return curBanditAttackState;
}

void pcSpotListenCheck(object curPC, int bandHide, int bandMoveSilently,
                        int banditAttackState) {
    int spotSuccess = 0;
    int listenSuccess = 0;
    int listenCheck = d20(1) + GetSkillRank(SKILL_LISTEN, curPC, FALSE);
    int spotCheck = d20(1) + GetSkillRank(SKILL_SPOT, curPC, FALSE);

    if(spotCheck > d20() + bandHide) {
        spotSuccess = 1;
    }

    if(listenCheck > d20() + bandMoveSilently) {
        listenSuccess = 1;
    }

    string pcMsg = "";

    /* Bandits just saw you you spot the ambush*/
    if(banditAttackState == 0) {
        if(spotSuccess && !listenSuccess) {
            writeToLog("Spot Success");
            switch (Random(3) + 1)
            {
                case 1:
                     pcMsg = "Did that bush just move?";
                case 2:
                     pcMsg = "Was that a shadow up ahead?";
                case 3:
                     pcMsg = "A rabbit runs hurriedly across your path.";
            }
        }

        if(!spotSuccess && listenSuccess) {
            writeToLog("Listen Success");
            switch (Random(3) + 1)
            {
                case 1:
                     pcMsg = "Was that a muffled voice?";
                case 2:
                     pcMsg = "You hear a twig snap.";
                case 3:
                     pcMsg = "It seems unnaturally quiet here?";
            }
        }

        if(spotSuccess && listenSuccess) {
            writeToLog("Spot and Listen Success");
            switch (Random(3) + 1)
            {
                case 1:
                     pcMsg = "You see a bush move and rustle unnaturally ahead.";
                case 2:
                     pcMsg = "You see a humanoid form snap a branch and move behind a tree ahead.";
                case 3:
                     pcMsg = "You see a crow caw and swoop at the undergrowth in the distance.";
            }
        }

        if(spotSuccess && !listenSuccess) {
            writeToLog("Listen and Spot Fail");
        }
    }

    /* Bandits are attacking and you see them as they move in*/
    if(banditAttackState == 2) {
        if(spotSuccess && !listenSuccess) {
            writeToLog("Spot Success");
            switch (Random(3) + 1)
            {
                case 1:
                     pcMsg = "You could swear you see a steel arrow head reflection in the distance.";
                case 2:
                     pcMsg = "test 1";
                case 3:
                     pcMsg = "test 1";
            }
        }

        if(!spotSuccess && listenSuccess) {
            writeToLog("Listen Success");
            switch (Random(3) + 1)
            {
                case 1:
                     pcMsg = "test 1";
                case 2:
                     pcMsg = "test 1";
                case 3:
                     pcMsg = "test 1";
            }
        }

        if(spotSuccess && listenSuccess) {
            writeToLog("Spot and Listen Success");
            switch (Random(3) + 1)
            {
                case 1:
                     pcMsg = "test 1";
                case 2:
                     pcMsg = "test 1";
                case 3:
                     pcMsg = "test 1";
            }
        }

        if(spotSuccess && !listenSuccess) {
            writeToLog("Listen and Spot Fail");
        }
    }

    if(GetStringLength(pcMsg) > 0) {
        SendMessageToPC(curPC, pcMsg);
    }
}

/**
 * Note that we have some exit points I'm not wild about but better to save
 * CPU cycles than make things 100% pretty.
 */

void main()
{
    object oArea = GetArea(OBJECT_SELF);
    int banditAttackState = GetCurrentBanditAttackState(oArea);

    writeToLog("banditAttackState: " + IntToString(banditAttackState));

    // If bandit attacks are disabled for this area exist imediately.
    // State 0: Enabled  - Never been run before.
    // State 1: Disabled - Perceived but gathering inforamtion
    // State 2: Enabled  - Make attack no attack decision
    // State 3: Disabled - Choose not to attack
    // State 4: Disabled - Attacking
    // State 9: Disabled - Brute force over ride
    if(banditAttackState != 0 && banditAttackState != 2) {
        return;
    }

    int totalEstPCWealth = 0;
    int totalPCLvls = 0;
    int totalPCs = 0;
    object richestPC = OBJECT_INVALID;
    int richestPCValue = 0;
    object curPC = GetFirstPCInArea(oArea);

    int bandSpot = 4;
    int bandListen = 5;
    int bandAppraise = 2;
    int bandHide = 4;
    int bandMoveSilently = 4;
    int bandSenseMotive = 3;
    int bandXPAllocation=2500;

    // Get what type of bandit party this is and set specifics for that party.
    // Default above is for bandit_look_sm
    if(GetTag(OBJECT_SELF) == "bandit_look_md") {
        bandSpot = 4;
        bandListen = 5;
        bandAppraise = 2;
        bandHide = 4;
        bandMoveSilently = 4;
        bandSenseMotive = 3;
        bandXPAllocation=2500;
    } else if(GetTag(OBJECT_SELF) == "bandit_look_lg") {

    }

    /* Gather Party Information The Bandit Lookout Can See. */
    while(curPC != OBJECT_INVALID) {
        writeToLog("PC in area: " + GetPCPlayerName(curPC));
        // Only considers PCs near the rally point.
        float distToPC = GetDistanceToObject(curPC);
        if(distToPC < 100.0) {
            writeToLog("PC in range: " + GetPCPlayerName(curPC));
            pcSpotListenCheck(curPC, bandHide, bandMoveSilently, banditAttackState);
            // If the character isnt trying to hide or doesn't account for them.
            int hideCheck = d20(1) + GetSkillRank(SKILL_HIDE, curPC, FALSE);
            int moveSilentlyCheck = d20(1) + GetSkillRank(SKILL_MOVE_SILENTLY,
                                                curPC, FALSE);
            if(GetStealthMode(curPC) == STEALTH_MODE_DISABLED
               || hideCheck < d20() + bandSpot
               || moveSilentlyCheck < d20() + bandListen) {
                writeToLog("PC detected: " + GetPCPlayerName(curPC));
                /* Only do the extra work if were going to need it. */
                if(banditAttackState == 2) {
                    // Store off all our PCs.
                    SetLocalArrayString(OBJECT_SELF, "pcTarget", totalPCs,
                                        ObjectToString(curPC));
                    // If bandits make a DC 16 Apraise check they appraise PC.
                    int estimatedPCWorth = GetTotalWealth(curPC);
                    // If they fail they over or under estimate.
                    if(d20() + bandAppraise <= 16) {
                        int roll = d6(2) + 3;
                        estimatedPCWorth =
                            FloatToInt(estimatedPCWorth * roll * 0.1);
                    }

                    // Check if this PC should be the new main mark.
                    if(estimatedPCWorth > richestPCValue) {
                        richestPC = curPC;
                        richestPCValue = estimatedPCWorth;
                    }

                    // Acumulate Party Levels
                    int totalPCLvl = GetLevelByPosition(1, curPC) +
                                     GetLevelByPosition(2, curPC) +
                                     GetLevelByPosition(3, curPC);

                    // Tally Everything up.
                    totalEstPCWealth += estimatedPCWorth;
                    totalPCLvls += totalPCLvl;
                }
                totalPCs++;
            }
        }
        curPC = GetNextPCInArea(oArea);
    }

    /* If there are no PCs with in range get out of here. */
    if(totalPCs == 0) {
        writeToLog("No PC Observed Exiting");
        return;
    /* If bandits just noticed some one set some observational time. */
    } else if(banditAttackState == 0) {
        writeToLog("Entering Observe Phase.");
        setAttackState(oArea, 1);
        return;
    }

    int banditActivityLevel = GetCampaignInt("FACTION_ACTIVITY",
                               "BANDIT_ACTIVITY_LEVEL_2147440");

    bandXPAllocation = bandXPAllocation * (banditActivityLevel/100);
    int attackChoice = DecideIfAttack(totalEstPCWealth, totalPCLvls, totalPCs,
                        bandSenseMotive, banditActivityLevel, bandXPAllocation);

    // if we are not attacking break out (we will update this later give pcs
    // a chance to spot the hidden bandits.)
    if(attackChoice == 0) {
        // We decided not to attack so lets wait at least 5 mins before we
        // think about attakcing again.
        writeToLog("Choose attacking not worth it.");
        setAttackState(oArea, 3);
        return;
    // Start the attack!
    } else {
        // Choose our bandits and have them attack.
        writeToLog("We are Attacking!");
        setAttackState(oArea, 4);
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
                    int randCharLvl = Random(5) + 1;
                    int randCharLvlXP = getXPTableValue(randCharLvl);
                    if(bandXPAllocation - randCharLvlXP > 0) {
                        banditLvl = randCharLvl;
                        bandXPAllocation -= randCharLvlXP;
                    }
                }
            }
            // pick gender (will put in after the rest is tested)
            string resref = pickRace() + pickClass() + "m_bandit_1";
            writeToLog("bandit type: " + resref + " lvl: " + IntToString(banditLvl));
            location spawnLoc = pickSpawnLoc(richestPC);
            // Spawn the bandit.
            object bandit = CreateObject(OBJECT_TYPE_CREATURE, resref,
                                spawnLoc, FALSE, resref);
            // Level the bandit up.
            while(banditLvl > 1) {
                LevelUpHenchman(bandit, CLASS_TYPE_INVALID, 1, PACKAGE_INVALID);
                banditLvl--;
            }
            string randomPCStr = GetLocalArrayString(OBJECT_SELF, "pcTarget",
                                                   Random(totalPCs));
            object randomPC = StringToObject(randomPCStr);
            SetActionMode(bandit, ACTION_MODE_STEALTH, TRUE);
            AssignCommand(bandit, ActionAttack(randomPC, TRUE));
            writeToLog("Attacking: " + GetName(randomPC));
        }
    }
}


