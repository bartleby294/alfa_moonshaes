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