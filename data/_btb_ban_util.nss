#include "ba_consts"

void writeToLog(string str) {
    string oAreaName = GetName(GetArea(OBJECT_SELF));
    string uuid = GetLocalString(OBJECT_SELF, "uuid");
    WriteTimestampedLogEntry(uuid + " Bandit Camp: " + oAreaName + ": " +  str);
}

int GetBaseGroup(int nItem) {
    // 0 - Non-equippable items
    // 1 - Shields
    // 2 - One handed weapons
    // 3 - Two handed weapons
    int nValue = 0;
    switch (nItem ) {
    //Shield group - usable in off hand only.
    case BASE_ITEM_SMALLSHIELD:
    case BASE_ITEM_TOWERSHIELD:
    case BASE_ITEM_LARGESHIELD:
        nValue = 1;
        break;
    //One handed weapons
    case BASE_ITEM_BASTARDSWORD:
    case BASE_ITEM_BATTLEAXE:
    case BASE_ITEM_CLUB:
    case BASE_ITEM_DAGGER:
    case BASE_ITEM_DART:
    case BASE_ITEM_HANDAXE:
    case BASE_ITEM_KAMA:
    case BASE_ITEM_KATANA:
    case BASE_ITEM_KUKRI:
    case BASE_ITEM_LIGHTFLAIL:
    case BASE_ITEM_LIGHTHAMMER:
    case BASE_ITEM_LIGHTMACE:
    case BASE_ITEM_LONGSWORD:
    case BASE_ITEM_RAPIER:
    case BASE_ITEM_SCIMITAR:
    case BASE_ITEM_SHORTSWORD:
    case BASE_ITEM_MORNINGSTAR:
    case BASE_ITEM_SHURIKEN:
    case BASE_ITEM_SICKLE:
    case BASE_ITEM_SLING:
    case BASE_ITEM_THROWINGAXE:
    case BASE_ITEM_WARHAMMER:
        nValue = 2;
        break;
    //Two Handed Weapons
    case BASE_ITEM_GREATSWORD:
    case BASE_ITEM_LIGHTCROSSBOW:
    case BASE_ITEM_SHORTBOW:
    case BASE_ITEM_DIREMACE:
    case BASE_ITEM_DOUBLEAXE:
    case BASE_ITEM_GREATAXE:
    case BASE_ITEM_HALBERD:
    case BASE_ITEM_HEAVYCROSSBOW:
    case BASE_ITEM_HEAVYFLAIL:
    case BASE_ITEM_LONGBOW:
    case BASE_ITEM_QUARTERSTAFF:
    case BASE_ITEM_SCYTHE:
    case BASE_ITEM_SHORTSPEAR:
    case BASE_ITEM_TWOBLADEDSWORD:
        nValue = 3;
        break;
    }
    return nValue;
}

int randomBanditTrap(int circle_max) {

    if(circle_max == 1) {
        switch(Random(10) + 1)
        {
            case 1:
                return TRAP_BASE_TYPE_MINOR_ACID;
            case 2:
                return TRAP_BASE_TYPE_MINOR_ACID_SPLASH;
            case 3:
                return TRAP_BASE_TYPE_MINOR_ELECTRICAL;
            case 4:
                return TRAP_BASE_TYPE_MINOR_FIRE;
            case 5:
                return TRAP_BASE_TYPE_MINOR_FROST;
            case 6:
                return TRAP_BASE_TYPE_MINOR_GAS;
            case 7:
                return TRAP_BASE_TYPE_MINOR_NEGATIVE;
            case 8:
                return TRAP_BASE_TYPE_MINOR_SONIC;
            case 9:
                return TRAP_BASE_TYPE_MINOR_SPIKE;
            case 10:
                return TRAP_BASE_TYPE_MINOR_TANGLE;
        }
    }

    if(circle_max == 2) {
        switch(Random(10) + 1)
        {
            case 1:
                return TRAP_BASE_TYPE_AVERAGE_ACID;
            case 2:
                return TRAP_BASE_TYPE_AVERAGE_ACID_SPLASH;
            case 3:
                return TRAP_BASE_TYPE_AVERAGE_ELECTRICAL;
            case 4:
                return TRAP_BASE_TYPE_AVERAGE_FIRE;
            case 5:
                return TRAP_BASE_TYPE_AVERAGE_FROST;
            case 6:
                return TRAP_BASE_TYPE_AVERAGE_GAS;
            case 7:
                return TRAP_BASE_TYPE_AVERAGE_NEGATIVE;
            case 8:
                return TRAP_BASE_TYPE_AVERAGE_SONIC;
            case 9:
                return TRAP_BASE_TYPE_AVERAGE_SPIKE;
            case 10:
                return TRAP_BASE_TYPE_AVERAGE_TANGLE;
        }
    }

    if(circle_max == 3) {
        switch(Random(10) + 1)
        {
            case 1:
                return TRAP_BASE_TYPE_STRONG_ACID;
            case 2:
                return TRAP_BASE_TYPE_STRONG_ACID_SPLASH;
            case 3:
                return TRAP_BASE_TYPE_STRONG_ELECTRICAL;
            case 4:
                return TRAP_BASE_TYPE_STRONG_FIRE;
            case 5:
                return TRAP_BASE_TYPE_STRONG_FROST;
            case 6:
                return TRAP_BASE_TYPE_STRONG_GAS;
            case 7:
                return TRAP_BASE_TYPE_STRONG_NEGATIVE;
            case 8:
                return TRAP_BASE_TYPE_STRONG_SONIC;
            case 9:
                return TRAP_BASE_TYPE_STRONG_SPIKE;
            case 10:
                return TRAP_BASE_TYPE_STRONG_TANGLE;
        }
    }

    return TRAP_BASE_TYPE_MINOR_ACID;
}

int locatonIsValid(location loc) {
    if(GetAreaFromLocation(loc) != OBJECT_INVALID){
        return TRUE;
    }
    return FALSE;
}

float getBanditFacing(vector campfireVector, vector possibleStructureVector) {

    vector direction = Vector(possibleStructureVector.x - campfireVector.x,
                              possibleStructureVector.y - campfireVector.y,
                              0.0);
    return VectorToAngle(direction);
}

int banditInArea(object oArea) {

    object oObject = GetFirstObjectInArea(oArea);
    while(GetIsObjectValid(oObject)) {
         // Destroy any objects tagged "DESTROY"
         if(GetStringRight(GetResRef(oObject), 10) == "m_bandit_1") {
             return TRUE;
         }
         oObject = GetNextObjectInArea(oArea);
    }

    return FALSE;
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

void onAttackActions(string yellString) {
   int myAction = GetLocalInt(OBJECT_SELF, "action");
    // Need to call other bandits to help and attack who attacked you.
    //AssignCommand(OBJECT_SELF, ClearAllActions()); - removed
    if(myAction > 0) {
        AssignCommand(OBJECT_SELF, ClearAllActions());
        writeToLog(" new combat PA");
        int i = 1;
        object lastAttacker = GetLastAttacker(OBJECT_SELF);
        location lastAttackerLoc = GetLocation(lastAttacker);
        object bandit = GetNearestObjectByTag("banditcamper", OBJECT_SELF, 1);
        while(bandit != OBJECT_INVALID) {
            SetLocalLocation(bandit, "attackerLoc", lastAttackerLoc);
            if(!GetIsInCombat(bandit)) {
                //if(GetDistanceBetween(OBJECT_SELF, bandit) < 50.0) {
                if(TRUE){
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
        if(yellString != "") {
            SpeakString(yellString);
        }
        SetLocalInt(OBJECT_SELF, "action", BANDIT_ATTACK_ACTION);
    }
}

void putWeaponAway() {
    object objInHand = GetItemInSlot(INVENTORY_SLOT_RIGHTHAND);
    if(GetBaseGroup(GetBaseItemType(objInHand)) == 2
        || GetBaseGroup(GetBaseItemType(objInHand)) == 3)
    {
        ActionUnequipItem(objInHand);
    }
    objInHand = GetItemInSlot(INVENTORY_SLOT_LEFTHAND);
    if(GetBaseGroup(GetBaseItemType(objInHand)) == 2
        || GetBaseGroup(GetBaseItemType(objInHand)) == 1)
    {
        DelayCommand(0.1, ActionUnequipItem(objInHand));
    }
    return;
}

/**
 *  Select a random valid Location in camp around the fire.
 */
location selectLocationAroundFire(object oArea, location campfireLoc,
                              int radius) {
    int radSqr = radius * radius;
    int xsqr = Random(radSqr);
    int ysqr = radSqr - xsqr;

    float x = sqrt(IntToFloat(xsqr));
    float y = sqrt(IntToFloat(ysqr));

    if(Random(2) == 1) {
        x = x * -1;
    }

    if(Random(2) == 1) {
        y = y * -1;
    }

    vector campfireVector = GetPositionFromLocation(campfireLoc);
    location possibleStructureLoc = Location(oArea,
        Vector(campfireVector.x + x, campfireVector.y+ y, 0.0), 0.0);
    float z = GetGroundHeight(possibleStructureLoc);

    possibleStructureLoc = Location(oArea,
        Vector(campfireVector.x + x, campfireVector.y+ y, z),
            getBanditFacing(campfireVector,
                GetPositionFromLocation(possibleStructureLoc)));

    return possibleStructureLoc;
}

