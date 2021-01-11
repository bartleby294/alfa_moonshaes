#include "_btb_random_loot"

void main()
{
    object chest = OBJECT_SELF;
    int lootGP = GetLocalInt(chest, "loot_gp");
    int lootLvl =  GetLocalInt(chest, "loot_lvl");

    if(lootGP == 0) {
        lootGP = 3000;
    }

    if(lootLvl == 0) {
        lootGP = 1;
    }

    if(GetLocalInt(chest, "loot_generated") == 0) {
        SetLocalInt(chest, "loot_generated", 1);
        SpeakString("Gold Value: " + IntToString(lootGP));
        SpeakString("Level Value: " + IntToString(lootLvl));
        generateLoot(lootGP, chest, lootLvl);
    }
}
