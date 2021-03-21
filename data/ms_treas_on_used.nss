#include "ms_treas_declare"
#include "_btb_random_loot"

void main()
{
    object oTreasure = OBJECT_SELF;
    location loc = GetLocation(OBJECT_SELF);
    string burriedName = GetLocalString(oTreasure, MS_TREASURE_CHEST_NAME);
    string chestNewTag = GetLocalString(oTreasure, MS_TREASURE_CHEST_NEW_TAG);
    string chestResRef = GetLocalString(oTreasure, MS_TREASURE_CHEST_RESREF);
    int chestGoldMin = GetLocalInt(oTreasure, MS_TREASURE_CHEST_GOLD_MIN);
    int chestGoldMax = GetLocalInt(oTreasure, MS_TREASURE_CHEST_GOLD_MAX);
    int chestGems = GetLocalInt(oTreasure, MS_TREASURE_CHEST_GEMS);
    int chestWeapons = GetLocalInt(oTreasure, MS_TREASURE_CHEST_WEAPONS);
    int chestArmor = GetLocalInt(oTreasure, MS_TREASURE_CHEST_ARMOR);
    int chestPotions = GetLocalInt(oTreasure, MS_TREASURE_CHEST_POTIONS);
    int chestJewlery = GetLocalInt(oTreasure, MS_TREASURE_CHEST_JEWLERY);
    int chestGold = GetLocalInt(oTreasure, MS_TREASURE_CHEST_GOLD);

    object chest = CreateObject(OBJECT_TYPE_PLACEABLE, chestResRef, loc, FALSE,
                                MS_TREASURE_CONTAINER);

    generateLootByChance(chestGoldMin + Random(chestGoldMax - chestGoldMin),
                         chest, 1, chestGold, chestPotions, chestArmor,
                         chestGems, chestJewlery, chestWeapons);

    DestroyObject(OBJECT_SELF, 0.2);
}
