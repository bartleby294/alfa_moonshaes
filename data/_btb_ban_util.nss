#include "ba_consts"

void writeToLog(string str) {
    string oAreaName = GetName(GetArea(OBJECT_SELF));
    string uuid = GetLocalString(OBJECT_SELF, "uuid");
    WriteTimestampedLogEntry(uuid + " Bandit Camp: " + oAreaName + ": " +  str);
}

int locatonIsValid(location loc) {
    if(GetAreaFromLocation(loc) != OBJECT_INVALID){
        return TRUE;
    }
    return FALSE;
}

float getFacing(vector campfireVector, vector possibleStructureVector) {

    vector direction = Vector(possibleStructureVector.x - campfireVector.x,
                              possibleStructureVector.y - campfireVector.y,
                              0.0);
    return VectorToAngle(direction);
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

/** Right now we are just going to make everything the bandit has droppable and
  * add some gold.  Later we will add more fun loot.
  */
void AddLootToBandit(object bandit, string race, string class) {
    GiveGoldToCreature(bandit, Random(20));

    //object loot = CreateItemOnObject("some_tag", bandit, 1);
    //SetDroppableFlag(loot, TRUE);
}

string getBanditPrefix(int banditLvl){
    switch (banditLvl)
    {
        case 1:
             return "";
        case 2:
             return "Seasoned ";
        case 3:
             return "Veteran ";
        case 4:
             return "Elite";
        case 5:
             return "Chief";
    }
    return "Boss ";
}

object spawnBandit(string resref, string race, string class,
                    location spawnLoc, int banditLvl, string tag){
    // Spawn the bandit.
    object bandit = CreateObject(OBJECT_TYPE_CREATURE, resref,
                        spawnLoc, FALSE, tag);
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
    return bandit;
}

void onAttackActions() {
   int myAction = GetLocalInt(OBJECT_SELF, "action");
    // Need to call other bandits to help and attack who attacked you.
    AssignCommand(bandit, ClearAllActions());
    if(myAction > 0) {
        writeToLog(" new combat PA");
        int i = 1;
        object lastAttacker = GetLastAttacker(OBJECT_SELF);
        location lastAttackerLoc = GetLocation(lastAttacker);
        object bandit = GetNearestObjectByTag("banditcamper", OBJECT_SELF, 1);
        while(bandit != OBJECT_INVALID) {
            SetLocalLocation(bandit, "attackerLoc", lastAttackerLoc);
            if(!GetIsInCombat(bandit)) {
                if(GetDistanceBetween(OBJECT_SELF, bandit) < 50.0) {
                    writeToLog("Called " + GetLocalString(bandit, "uuid")
                                    + " for help");
                    AssignCommand(bandit, ActionAttack(lastAttacker));
                    SetLocalInt(bandit, "action", BANDIT_ATTACK_ACTION);
                } else {
                    int actionChoice = Random(2) + 1;
                    if(actionChoice == 1) {
                        SetLocalInt(bandit, "action",
                                        BANDIT_ATTACK_PATROL_ACTION);
                    }
                    if(actionChoice == 2) {
                        SetLocalInt(bandit, "action",
                                        BANDIT_ATTACK_SEARCH_ACTION);
                    }
                }
            }
            i++;
            bandit = GetNearestObjectByTag("banditcamper", OBJECT_SELF, i);
        }
        SpeakString("Were under attack!");
        SetLocalInt(OBJECT_SELF, "action", BANDIT_ATTACK_ACTION);
    }
}

