#include "_btb_random_loot"

void main()
{
    object chest = OBJECT_SELF;
    int lootGP = GetLocalInt(chest, "loot_gp");
    int lootLvl =  GetLocalInt(chest, "loot_lvl");
    int goldChance =  GetLocalInt(chest, "goldChance");
    int potionChance =  GetLocalInt(chest, "potionChance");
    int armorChance =  GetLocalInt(chest, "armorChance");
    int gemChance =  GetLocalInt(chest, "gemChance");
    int jeweleryChance =  GetLocalInt(chest, "jeweleryChance");
    int weaponChance =  GetLocalInt(chest, "weaponChance");

    if(lootGP == 0) {
        lootGP = 3000;
    }

    if(lootLvl == 0) {
        lootGP = 1;
    }

    if(GetLocalInt(chest, "loot_generated") == 0) {
        SetLocalInt(chest, "loot_generated", 1);
        SpeakString("Gold Value: " + IntToString(lootGP));
        SpeakString("Gold Chance: " + IntToString(goldChance));
        SpeakString("Potion Chance: " + IntToString(potionChance));
        SpeakString("Armor Chance: " + IntToString(armorChance));
        SpeakString("Gem Chance: " + IntToString(gemChance));
        SpeakString("Jewelery Chance" + IntToString(jeweleryChance));
        SpeakString("Weapon Chance: " + IntToString(weaponChance));

        generateLootByChance(lootGP, chest, lootLvl, goldChance,
                             potionChance, armorChance, gemChance,
                             jeweleryChance, weaponChance);
    }
}
