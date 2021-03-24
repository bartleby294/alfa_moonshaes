#include "alfa_wealth_inc"
#include "nwnx_time"
#include "nw_o0_itemmaker"
#include "alfa_ms_config"
#include "_btb_util"
#include "_btb_ban_util"

/*void writeToLog(string str) {
    string oAreaName = GetName(GetArea(OBJECT_SELF));
    WriteTimestampedLogEntry("Bandit Ambush: " + oAreaName + ": " +  str);
} */

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
       int estTotalPartyXP = getXPTableValueCore(estAvgPCLvl) * totalPCs;

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
            return 1;
        }
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
        int hardResetTime = BANDIT_HARD_DELAY_SECONDS;
        int softResetTime = BANDIT_SOFT_DELAY_SECONDS;
        int curDateTime = NWNX_Time_GetTimeStamp();
        int elapsedTime = curDateTime - lastStateDateTime;

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
                     pcMsg = "You see a group charge toward you.";
                case 2:
                     pcMsg = "You see an arrow catch the light in the distance.";
                case 3:
                     pcMsg = "You see a sword hilt catch the light.";
            }
        }

        if(!spotSuccess && listenSuccess) {
            writeToLog("Listen Success");
            switch (Random(3) + 1)
            {
                case 1:
                     pcMsg = "You hear some one yell 'Go!'.";
                case 2:
                     pcMsg = "You hear a sword exiting its sheath.";
                case 3:
                     pcMsg = "You hear an arrow loose.";
            }
        }

        if(spotSuccess && listenSuccess) {
            writeToLog("Spot and Listen Success");
            switch (Random(3) + 1)
            {
                case 1:
                     pcMsg = "You see and hear an arrow loose in your direction.";
                case 2:
                     pcMsg = "You hear some one yell 'Get em!' as you are ambushed.";
                case 3:
                     pcMsg = "You see a sword hilt glint in the distance and hear a arrow loose.";
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

    int bandSpot = 3;
    int bandListen = 4;
    int bandAppraise = 1;
    int bandHide = 3;
    int bandMoveSilently = 3;
    int bandSenseMotive = 2;
    int bandXPAllocation=1800;
    int minLvl = 1;

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
        minLvl = 2;
    } else if(GetTag(OBJECT_SELF) == "bandit_look_lg") {
        bandSpot = 6;
        bandListen = 7;
        bandAppraise = 4;
        bandHide = 6;
        bandMoveSilently = 6;
        bandSenseMotive = 5;
        bandXPAllocation=4500;
        minLvl = 3;
    }

    /* Gather Party Information The Bandit Lookout Can See. */
    while(curPC != OBJECT_INVALID) {
        writeToLog("PC in area: " + GetPCPlayerName(curPC));
        // Only considers PCs near the rally point.
        float distToPC = GetDistanceToObject(curPC);
        if(distToPC < 100.0 && !GetIsDM(curPC)) {
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
        int noPCTurns = GetLocalInt(OBJECT_SELF, "noPCTurns");
        SetLocalInt(OBJECT_SELF, "noPCTurns", noPCTurns + 1);
        if(noPCTurns > 60) {
            writeToLog("No PC Observed in over 60 Rounds Destorying Ambush");
            DestroyObject(OBJECT_SELF);
        } else {
            writeToLog("No PC Observed in " + IntToString(noPCTurns)
                   + " Turns Exiting");
        }
        return;
    /* If bandits just noticed some one set some observational time. */
    } else if(banditAttackState == 0) {
        writeToLog("Entering Observe Phase.");
        setAttackState(oArea, 1);
        return;
    }

    int banditActivityLevel = GetCampaignInt("FACTION_ACTIVITY",
                               "BANDIT_ACTIVITY_LEVEL_2147440");

    bandXPAllocation = bandXPAllocation * (banditActivityLevel/100) + 100;
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
        vector pcVector = GetPosition(richestPC);
        float pcAngle = GetFacing(richestPC);
        //writeToLog("PC Angle: " + FloatToString(pcAngle));
        setAttackState(oArea, 4);
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
            string randomPCStr = GetLocalArrayString(OBJECT_SELF, "pcTarget",
                                                   Random(totalPCs));
            object randomPC = StringToObject(randomPCStr);
            SetActionMode(bandit, ACTION_MODE_STEALTH, TRUE);
            AssignCommand(bandit, ActionAttack(randomPC, TRUE));
            if(attackYelled == 0) {
                attackYelled = 1;
                AssignCommand(bandit, ActionSpeakString("Attack!"));
            }
        }
    }
}


