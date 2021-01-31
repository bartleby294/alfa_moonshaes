#include "_btb_rand_potion"
#include "_btb_rand_armor"
#include "_btb_rand_gem"
#include "_btb_rand_weapon"
#include "_btb_rand_jewelr"
#include "_btb_util"
#include "nwnx_object"

int createPotionInChest(object chest, int goldAmount, int difficulty_lvl) {
    string randPotionResref = getRandomPotion();
    int iCost = getItemCostFromTag(GetStringUpperCase(randPotionResref));
    if(iCost != 0 && iCost <= goldAmount) {
        goldAmount = goldAmount - iCost;
        CreateItemOnObject(randPotionResref, chest);
    }
    return goldAmount;
}

int createGemInChest(object chest, int goldAmount, int difficulty_lvl) {
    string randGemTag = getRandomGem();
    int iCost = getItemCostFromTag(randGemTag);
    if(iCost != 0 && iCost <= goldAmount) {
        goldAmount = goldAmount - iCost;
        CreateItemOnObject(randGemTag, chest);
    }
    return goldAmount;
}

int createArmorInChest(object chest, int goldAmount, int difficulty_lvl) {

    location chestLoc = GetLocation(chest);
    vector chestVec = GetPosition(chest);
    object oArea = GetAreaFromLocation(chestLoc);
    vector invChestVec = Vector(chestVec.x, chestVec.y + 4.0, chestVec.z);
    location invChestLoc = Location(oArea, invChestVec, 0.0);
    object tempInvObj = CreateObject(OBJECT_TYPE_PLACEABLE, "tempinventoryobj",
                                                                   invChestLoc);
    string randArmorResref = getRandomBaseArmor();
    object oArmor = CreateItemOnObject(randArmorResref, tempInvObj);
    //WriteTimestampedLogEntry("randomizeStyle");
    object randArmor = randomizeStyle(oArmor);
    //WriteTimestampedLogEntry("serializedArmor");
    string serializedArmor = NWNX_Object_Serialize(randArmor);
    //WriteTimestampedLogEntry("GetGoldPieceValue");
    int iCost = GetGoldPieceValue(oArmor);
    //WriteTimestampedLogEntry("DestroyObject");
    DestroyObject(oArmor, 1.0);
    //WriteTimestampedLogEntry("DestroyObject");
    DestroyObject(tempInvObj, 2.0);

    if(iCost != 0 && iCost <= goldAmount) {
        //WriteTimestampedLogEntry("NWNX_Object_Deserialize");
        object randArmor = NWNX_Object_Deserialize(serializedArmor);

        // Drives how many properties. ADJUST THIS EVENTUALLY!!!!
        int i;
        int maxMagic = difficulty_lvl - 1;
        int properties = Random(maxMagic);
        //WriteTimestampedLogEntry("properties: " + IntToString(properties));
        for(i = 0; i < properties; ++i) {
            //WriteTimestampedLogEntry("i: " + IntToString(i));
            int magicChance = d100();
            int magicThreshold = 100 - (difficulty_lvl * 10);
            // 10% * difficulty_lvl chance its magic(NOT FINAL)
            if(magicChance > magicThreshold) {
                //WriteTimestampedLogEntry("add property");
                randArmor = AddRandomMagicArmorProperty(randArmor,
                    difficulty_lvl);
                //WriteTimestampedLogEntry("add property end");
            }
        }

        // If we can aford magic add magic else add mundane.
        int iCostRand = GetGoldPieceValue(randArmor);
        if(iCostRand != 0 && iCostRand <= goldAmount) {
            NWNX_Object_AcquireItem(chest, randArmor);
            goldAmount = goldAmount - iCostRand;
        } else {
            object oArmorMundane = NWNX_Object_Deserialize(serializedArmor);
            NWNX_Object_AcquireItem(chest, oArmorMundane);
            goldAmount = goldAmount - iCost;
        }
    }

    return goldAmount;
}

int createWeaponInChest(object chest, int goldAmount, int difficulty_lvl) {
    object tempInvObj = CreateObject(OBJECT_TYPE_PLACEABLE, "tempinventoryobj",
                                     GetLocation(chest));
    string randWeaponResref = getRandomBaseWeapon();
    object oWeapon = CreateItemOnObject(randWeaponResref, tempInvObj);
    string serializeWeapon = NWNX_Object_Serialize(RandomizeWeapon(oWeapon));
    int iCost = getItemCostFromTag(GetStringUpperCase(randWeaponResref));
    DestroyObject(oWeapon, 1.0);
    DestroyObject(tempInvObj, 2.0);

    if(iCost != 0 && iCost <= goldAmount) {
        //WriteTimestampedLogEntry("Weapon NWNX_Object_Deserialize");
        object randWeapon = NWNX_Object_Deserialize(serializeWeapon);

        // Drives how many properties. ADJUST THIS EVENTUALLY!!!!
        int i;
        int maxMagic = difficulty_lvl - 1;
        int properties = Random(maxMagic);
        //WriteTimestampedLogEntry("properties: " + IntToString(properties));
        for(i = 0; i < properties; ++i) {
            //WriteTimestampedLogEntry("i: " + IntToString(i));
            int magicChance = d100();
            int magicThreshold = 100 - (difficulty_lvl * 10);
            // 10% * difficulty_lvl chance its magic(NOT FINAL)
            if(magicChance > magicThreshold) {
                //WriteTimestampedLogEntry("add property");
                randWeapon = AddRandomMagicWeaponProperty(randWeapon,
                    difficulty_lvl);
                //WriteTimestampedLogEntry("add property end");
            }
        }
                // If we can aford magic add magic else add mundane.
        int iCostRand = GetGoldPieceValue(randWeapon);
        if(iCostRand != 0 && iCostRand <= goldAmount) {
            NWNX_Object_AcquireItem(chest, randWeapon);
            goldAmount = goldAmount - iCostRand;
        } else {
            object oWeaponMundane = NWNX_Object_Deserialize(serializeWeapon);
            NWNX_Object_AcquireItem(chest, oWeaponMundane);
            goldAmount = goldAmount - iCost;
        }
    }

    return goldAmount;
}

int createJewelryInChest(object chest, int goldAmount, int difficulty_lvl) {
    object tempInvObj = CreateObject(OBJECT_TYPE_PLACEABLE, "tempinventoryobj",
                                     GetLocation(chest));
    string randJewelryResref = getRandomJewelry();
    object jewelry = CreateItemOnObject(randJewelryResref, tempInvObj);
    string serializeJewelry = NWNX_Object_Serialize(jewelry);
    int iCost = getItemCostFromTag(GetStringUpperCase(randJewelryResref));
    DestroyObject(jewelry);
    DestroyObject(tempInvObj);

    if(iCost != 0 && iCost <= goldAmount) {
        //WriteTimestampedLogEntry("Weapon NWNX_Object_Deserialize");
        object randJewelry = NWNX_Object_Deserialize(serializeJewelry);

        // Drives how many properties. ADJUST THIS EVENTUALLY!!!!
        int i;
        int maxMagic = difficulty_lvl - 1;
        int properties = Random(maxMagic);
        //WriteTimestampedLogEntry("properties: " + IntToString(properties));
        for(i = 0; i < properties; ++i) {
            //WriteTimestampedLogEntry("i: " + IntToString(i));
            int magicChance = d100();
            int magicThreshold = 100 - (difficulty_lvl * 10);
            // 10% * difficulty_lvl chance its magic(NOT FINAL)
            if(magicChance > magicThreshold) {
                //WriteTimestampedLogEntry("add property");
                randJewelry = AddRandomMagicJewelryProperty(randJewelry,
                    difficulty_lvl);
                //WriteTimestampedLogEntry("add property end");
            }
        }
                // If we can aford magic add magic else add mundane.
        int iCostRand = GetGoldPieceValue(randJewelry);
        if(iCostRand != 0 && iCostRand <= goldAmount) {
            NWNX_Object_AcquireItem(chest, randJewelry);
            goldAmount = goldAmount - iCostRand;
        } else {
            object oJewelryMundane = NWNX_Object_Deserialize(serializeJewelry);
            NWNX_Object_AcquireItem(chest, oJewelryMundane);
            goldAmount = goldAmount - iCost;
        }
    }

    return goldAmount;
}

//void fillChest(object chest, int goldAmount, int difficulty_lvl)
void generateLoot(int goldAmount, object chest, int difficulty_lvl)
{
    int goldToAddToChest = 0;
    int tries = 0;

    while(goldAmount > 0 && tries < 30) {
        int randChance = d100();
        // 30% chance its gold
        if(randChance >= 0 && randChance < 30) {
            // if were at the dregs just throw it all in gold.
            if(goldAmount < 150) {
                goldToAddToChest = goldToAddToChest + goldAmount;
                goldAmount = goldAmount - goldAmount;
            } else {
                int randGold = Random(goldAmount);
                goldToAddToChest = goldToAddToChest + randGold;
                goldAmount = goldAmount - randGold;
            }
        // %15 chance its a potion
        } else if(randChance >= 30 && randChance < 45) {
           //WriteTimestampedLogEntry("createPotionInChest");
           goldAmount = createPotionInChest(chest, goldAmount, difficulty_lvl);
           //WriteTimestampedLogEntry("createPotionInChest - end");
        // %10 chance its an armor
        } else if(randChance >= 45 && randChance < 55) {
            //WriteTimestampedLogEntry("createArmorInChest");
            goldAmount = createArmorInChest(chest, goldAmount, difficulty_lvl);
            //WriteTimestampedLogEntry("createArmorInChest - end");
        // %20 chance its a gem
        } else if(randChance >= 55 && randChance < 75) {
            //WriteTimestampedLogEntry("createGemInChest");
            goldAmount = createGemInChest(chest, goldAmount, difficulty_lvl);
            //WriteTimestampedLogEntry("createGemInChest - end");
        // %15 chance its jewelery
        } else if(randChance >= 75 && randChance < 90) {
            //WriteTimestampedLogEntry("createJewelryInChest");
            goldAmount = createJewelryInChest(chest, goldAmount, difficulty_lvl);
            //WriteTimestampedLogEntry("createJewelryInChest - end");
        // %10 chance its a weapon
        } else if(randChance >= 90 && randChance <= 100) {
            //WriteTimestampedLogEntry("createWeaponInChest");
            goldAmount = createWeaponInChest(chest, goldAmount, difficulty_lvl);
            //WriteTimestampedLogEntry("createWeaponInChest - end");
        }

        tries = tries + 1;
    }
    //WriteTimestampedLogEntry("The End");
    if(goldToAddToChest > 0) {
        CreateItemOnObject("nw_it_gold001", chest, goldToAddToChest);
    }
}
