/*
  Here is how this in theory should work.

  *PC Rings bell to "signal spotting incomming Xvarts" this will start the raid.
  *Xvarts will spawn from one of the randomly selected waypoints.
  *PCs will get a listen/spot check to see if they hear from where.
  *This script set intial actions on a number of xvarts to steal corn if they
   are inturupted right now they will not resume stealing.  I may try to tweak
   this in the future if time allows.
  *If they steal corn they will try to run away again if inturupted they will
   just default to hosiles right now may try to update later.
  *If killed they will drop some corn.

  Corn drop script is on Xvart
  Run away action is on the corn
*/

#include "nwnx_time"
#include "alfa_ms_config"
#include "_btb_util"

void writeToLog(string str) {
    string oAreaName = GetName(GetArea(OBJECT_SELF));
    WriteTimestampedLogEntry("Xvart Corn Raid: " + oAreaName + ": " +  str);
}

void writeToDB(int cornCnt) {
    string indexStr = IntToString(NWNX_Time_GetTimeStamp()) + "|";
    object oPC = GetFirstPCInArea(GetArea(OBJECT_SELF));
    while(oPC != OBJECT_INVALID) {
        indexStr += GetPCPublicCDKey(oPC) + GetPCPlayerName(oPC) + "|";
        oPC = GetNextPCInArea(GetArea(OBJECT_SELF));
    }
    SetCampaignInt("xvart_corn_raid", indexStr, cornCnt);
}

int isObjectInArea(string objTag) {
    int objectFound = 0;
    object obj = GetFirstObjectInArea();
    while(GetIsObjectValid(obj) && objectFound == 0){
        if(GetTag(obj) == objTag){
            objectFound = 1;
        }
        obj = GetNextObjectInArea();
    }
    return objectFound;
}

void MovementReset(object farmer) {
    WriteTimestampedLogEntry("BELL Resetting Movement");
    effect eSpeedUp = EffectMovementSpeedIncrease(98);
    ApplyEffectToObject(DURATION_TYPE_PERMANENT, eSpeedUp, farmer);
}

void YellRunAway(object farmer) {
    if(GetTag(farmer) == "clav") {
        AssignCommand(farmer, SpeakString("Here they come, fleeee!"));
    } else if(GetTag(farmer) == "jart") {
        AssignCommand(farmer, SpeakString("Bloody things are back!"));
    } else if(GetTag(farmer) == "rolling") {
        AssignCommand(farmer, SpeakString("Hide, dammit, Hide!"));
    } else if(GetTag(farmer) == "mitchan") {
        AssignCommand(farmer, SpeakString("Run for the barn!"));
    }
}

void makeFarmerRunAway(object farmer) {
    if(GetLocalInt(farmer, "walking") == 1){
        SetLocalInt(farmer, "walking", 0);
        MovementReset(farmer);
    }
    SetLocalInt(farmer, "perilalert", 1);
    AssignCommand(farmer, ClearAllActions());
    YellRunAway(farmer);
    AssignCommand(farmer,
        ActionMoveToObject(GetObjectByTag("corn_farmer_despawn"), TRUE));
}

void createRaidingParty(object xvartRaidSpawnWP) {

    float firstCornDist = -1.0;
    float secondCornDist = -1.0;
    float thirdCornDist = -1.0;
    float fourthCornDist = -1.0;
    float fifthCornDist = -1.0;

    object firstCorn = OBJECT_INVALID;
    object secondCorn = OBJECT_INVALID;
    object thirdCorn = OBJECT_INVALID;
    object fouthCorn = OBJECT_INVALID;
    object fifthCorn = OBJECT_INVALID;

    // loop thorugh all obejct in area get the 5 closest corns.
    object obj = GetFirstObjectInArea();
    //object test = GetNearestObjectByTag("hlf_f1_corn_obj_*n", obj, 1);
    //WriteTimestampedLogEntry("-----------");
    //WriteTimestampedLogEntry(GetTag(test));
    while(GetIsObjectValid(obj)){
        // if its a corn check if its closer than what we have saved
        if (TestStringAgainstPattern("hlf_f1_corn_obj_*n", GetTag(obj))) {
            float curDist = GetDistanceBetween(obj, xvartRaidSpawnWP);
            if(firstCornDist == -1.0 || curDist < firstCornDist){
                fifthCornDist = fourthCornDist;
                fourthCornDist = thirdCornDist;
                thirdCornDist = secondCornDist;
                secondCornDist = firstCornDist;
                firstCornDist = curDist;

                fifthCorn = fouthCorn;
                fouthCorn = thirdCorn;
                thirdCorn = secondCorn;
                secondCorn = firstCorn;
                firstCorn = obj;
            }
            else {
                if(secondCornDist == -1.0 || curDist < secondCornDist){
                    fifthCornDist = fourthCornDist;
                    fourthCornDist = thirdCornDist;
                    thirdCornDist = secondCornDist;
                    secondCornDist = curDist;

                    fifthCorn = fouthCorn;
                    fouthCorn = thirdCorn;
                    thirdCorn = secondCorn;
                    secondCorn = obj;
                }
                else {
                    if(thirdCornDist == -1.0 || curDist < thirdCornDist){
                        fifthCornDist = fourthCornDist;
                        fourthCornDist = thirdCornDist;
                        thirdCornDist = curDist;

                        fifthCorn = fouthCorn;
                        fouthCorn = thirdCorn;
                        thirdCorn = obj;
                    }
                    else {
                        if(fourthCornDist == -1.0 || curDist < fourthCornDist){
                            fifthCornDist = fourthCornDist;
                            fourthCornDist = curDist;

                            fifthCorn = fouthCorn;
                            fouthCorn = obj;
                        }
                        else {
                            if(fifthCornDist == -1.0 || curDist < fifthCornDist){
                                fifthCornDist = curDist;

                                fifthCorn = obj;
                           }
                        }
                    }
                }
            }
            //WriteTimestampedLogEntry("-----------");
            //WriteTimestampedLogEntry("Current Obj: " + GetTag(obj));
            //WriteTimestampedLogEntry(GetTag(firstCorn));
            //WriteTimestampedLogEntry(GetTag(secondCorn));
            //WriteTimestampedLogEntry(GetTag(thirdCorn));
            //WriteTimestampedLogEntry(GetTag(fouthCorn));
            //WriteTimestampedLogEntry(GetTag(fifthCorn));
        }
        obj = GetNextObjectInArea();
    }

    // Now create 1d4 +3 xvart raiders at the wp and set each to attack corn
    int rand_1d5_xvarts = Random(3) + 4;
    int curXvartCnt = 1;

    for(curXvartCnt = 1; curXvartCnt <= rand_1d5_xvarts; ++curXvartCnt) {

        object curXvart = OBJECT_INVALID;

        // Make 2 full AI xvarts and the rest smash and grab.
        if(curXvartCnt < 3) {
            // spawn random ranged or warrior.
            if(Random(2) == 1) {
                // Warior have them run into the fields and run out
                curXvart = CreateObject(OBJECT_TYPE_CREATURE, "sw_goblin_003",
                    GetLocation(xvartRaidSpawnWP), FALSE, "xvart_raider");
                if(firstCorn != OBJECT_INVALID) {
                    AssignCommand(curXvart,
                        ActionMoveToObject(firstCorn, TRUE, 1.0));
                    //DelayCommand(15.0, runAway(curXvart));
                }
            } else {
                // Slinger have them hang back and cover
                curXvart = CreateObject(OBJECT_TYPE_CREATURE, "sw_goblin_004",
                    GetLocation(xvartRaidSpawnWP), FALSE, "xvart_raider");
                //DelayCommand(15.0, runAway(curXvart));
            }
        } else {
            curXvart = CreateObject(OBJECT_TYPE_CREATURE, "sw_goblin_01",
                GetLocation(xvartRaidSpawnWP), FALSE, "xvart_raider");
        }

        // Note that if there are less than 5 corn left in the area xvart will
        // not attack any more corn but at this point leave the pcs a chance.
        if(curXvartCnt == 3 && firstCorn != OBJECT_INVALID) {
            AssignCommand(curXvart, ActionAttack(firstCorn, FALSE));
        }
        else if(curXvartCnt == 4 && secondCorn != OBJECT_INVALID) {
            AssignCommand(curXvart, ActionAttack(secondCorn, FALSE));
        }
        else if(curXvartCnt == 5 && thirdCorn != OBJECT_INVALID) {
            AssignCommand(curXvart, ActionAttack(thirdCorn, FALSE));
        }
        else if(curXvartCnt == 6 && fouthCorn != OBJECT_INVALID) {
            AssignCommand(curXvart, ActionAttack(fouthCorn, FALSE));
        }
        else if(curXvartCnt == 7 && fifthCorn != OBJECT_INVALID) {
            AssignCommand(curXvart, ActionAttack(fifthCorn, FALSE));
        }
    }
}

void spotListenChecks(object curXvartRaidWP, float total_delay) {
    object oPC = GetFirstPC();
    while (oPC != OBJECT_INVALID) {

        int listenCheck = d20(1) + GetSkillRank(SKILL_LISTEN, oPC, FALSE);
        int spotCheck = d20(1) + GetSkillRank(SKILL_SPOT, oPC, FALSE);
        if (listenCheck >= 15 || spotCheck >= 15) {
            string listen_spot_str = "";
            if(listenCheck >= 15 && spotCheck >= 15) {
                listen_spot_str = "You spot and hear something to the";
            } else {
                if(listenCheck >= 15) {
                    listen_spot_str = "You hear something to the";
                } else {
                    listen_spot_str = "You spot something to the";
                }
            }
            if(GetTag(curXvartRaidWP) == "hlf1_xvart_1") {
                DelayCommand(total_delay - 4.0, SendMessageToPC(oPC,
                    listen_spot_str + " north west."));
            }
            if(GetTag(curXvartRaidWP) == "hlf1_xvart_2") {
                DelayCommand(total_delay - 4.0, SendMessageToPC(oPC,
                    listen_spot_str + " west."));
            }
            if(GetTag(curXvartRaidWP) == "hlf1_xvart_3") {
                DelayCommand(total_delay - 4.0, SendMessageToPC(oPC,
                    listen_spot_str + " south west."));
            }
            if(GetTag(curXvartRaidWP) == "hlf1_xvart_4") {
                DelayCommand(total_delay - 4.0, SendMessageToPC(oPC,
                    listen_spot_str + " south east."));
            }
            if(GetTag(curXvartRaidWP) == "hlf1_xvart_5") {
                DelayCommand(total_delay - 4.0, SendMessageToPC(oPC,
                    listen_spot_str + " north east."));
            }
        } else {
            DelayCommand(total_delay - 4.0, SendMessageToPC(oPC,
             "You hear something but cant tell which direction it came from."));
        }
        oPC = GetNextPC();
    }
}

void msgToAllPCsInArea(float delay, string message) {
    object oPC = GetFirstPCInArea(GetArea(OBJECT_SELF));
    while (oPC != OBJECT_INVALID) {
        DelayCommand(delay, SendMessageToPC(oPC, message));
        oPC = GetNextPCInArea(GetArea(OBJECT_SELF));
    }
}

/* Count up the corn thats left and put 2x the corn in the barrel. */
void rewardCorn() {
    int cornCnt = 0;
    object obj = GetFirstObjectInArea();
    while(GetIsObjectValid(obj)){
        // if its corn add to the corn count.
        if (TestStringAgainstPattern("hlf_f1_corn_obj_*n", GetTag(obj))) {
            cornCnt++;
        }
        obj = GetNextObjectInArea();
    }
    CreateItemOnObject("corn", GetObjectByTag("rewardCorn", 0),
        cornCnt * 2, "corn");
    writeToLog(IntToString(cornCnt) + " corn was saved!");
    writeToDB(cornCnt);
}

void logPlayers() {
    object oPC = GetFirstPCInArea(GetArea(OBJECT_SELF));
    while (oPC != OBJECT_INVALID) {
        writeToLog(GetPCPlayerName(oPC) + " is defending the farm.");
        oPC = GetNextPCInArea(GetArea(OBJECT_SELF));
    }
}

void startRaid() {
    AssignCommand(OBJECT_SELF, ActionSpeakString("The bell rings."));

    string BASE_WP_TAG = "hlf_f1_corn_";
    string BASE_OBJ_TAG = "hlf_f1_corn_obj_";
    string CORN_RESREF = "alfa_produce014";

    // do 1d5 + 10 total raids
    int numberOfRaids = Random(7) + 14;
    int curRaidCnt = 1;
    //int rand_raids = Random(4) + 4;
    float total_delay = 5.0 + IntToFloat(Random(10));
    for(curRaidCnt = 1; curRaidCnt <= numberOfRaids; ++curRaidCnt) {
        // Add Spot/Listen checks here
        object curXvartRaidWP = GetWaypointByTag("hlf1_xvart_" +
            IntToString(Random(5) + 1));
        spotListenChecks(curXvartRaidWP, total_delay);
        DelayCommand(total_delay, createRaidingParty(curXvartRaidWP));
        total_delay += 25.0 + Random(20);
    }

    msgToAllPCsInArea(total_delay,
        "The xvarts scramble away carrying what spoils they can.");

    DelayCommand(total_delay + 2.0, rewardCorn());
}

void main()
{
    // If enough time has elapsed start a raid.
    object oArea = GetArea(OBJECT_SELF);
    int lastRaid = GetCampaignInt("XVART_RAIDS", "XVART_RAID_" + GetTag(oArea));
    if(NWNX_Time_GetTimeStamp() - lastRaid > FARM_DELAY_SECONDS) {
        SetCampaignInt("XVART_RAIDS", "XVART_RAID_" + GetTag(oArea),
            NWNX_Time_GetTimeStamp());
        makeFarmerRunAway(GetObjectByTag("clav"));
        makeFarmerRunAway(GetObjectByTag("jart"));
        makeFarmerRunAway(GetObjectByTag("rolling"));
        makeFarmerRunAway(GetObjectByTag("mitchan"));
        startRaid();
    }
}
