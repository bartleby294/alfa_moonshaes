#include "_btb_rand_potion"
#include "_btb_rand_armor"
#include "_btb_rand_gem"
#include "_btb_rand_weapon"
#include "_btb_rand_jewelr"
#include "_btb_util"

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
    //string say1 = "randGemTag: " + randGemTag;
    //string say2 = "iCost: " + IntToString(iCost);
    //AssignCommand(chest, ActionSpeakString(say1));
    //AssignCommand(chest, ActionSpeakString(say2));
    if(iCost != 0 && iCost <= goldAmount) {
        goldAmount = goldAmount - iCost;
        CreateItemOnObject(randGemTag, chest);
    }
    return goldAmount;
}

int createArmorInChest(object chest, int goldAmount, int difficulty_lvl,
                       object tempInvObj) {
    string randArmorResref = getRandomBaseArmor();
    int iCost = getItemCostFromTag(GetStringUpperCase(randArmorResref));
    if(iCost != 0 && iCost <= goldAmount) {
        WriteTimestampedLogEntry("randArmorResref: " + randArmorResref);
        object item = randomizeStyle(CreateItemOnObject(randArmorResref,
                                     tempInvObj));
        WriteTimestampedLogEntry("new acValue: " + IntToString(GetItemACValue(item)));
        ActionGiveItem(item, chest);
        float quality = d100() * difficulty_lvl * 1.0;
        float threshold = difficulty_lvl * 90.0;
        // 10% * difficulty_lvl chance its magic
        if(quality > threshold) {

        }
        goldAmount = goldAmount - iCost;
    }
    return goldAmount;
}

int createWeaponInChest(object chest, int goldAmount, int difficulty_lvl) {
    string randWeaponResref = getRandomBaseWeapon();
    int iCost = getItemCostFromTag(GetStringUpperCase(randWeaponResref));
    if(iCost != 0 && iCost <= goldAmount) {
        //goldAmount = goldAmount - iCost;
        object item = CreateItemOnObject(randWeaponResref, chest);
        float quality = d100() * difficulty_lvl * 1.0;
        float threshold = difficulty_lvl * 90.0;
        // 10% * difficulty_lvl chance its magic
        if(quality > threshold) {

        }
        goldAmount = goldAmount - iCost;
    }
    return goldAmount;
}

int createJewelryInChest(object chest, int goldAmount, int difficulty_lvl) {
    string randJewelryResref = getRandomJewelry();
    int iCost = getItemCostFromTag(GetStringUpperCase(randJewelryResref));
    if(iCost != 0 && iCost <= goldAmount) {
        //goldAmount = goldAmount - iCost;
        object item = CreateItemOnObject(randJewelryResref, chest);
        float quality = d100() * difficulty_lvl * 1.0;
        float threshold = difficulty_lvl * 90.0;
        // 10% * difficulty_lvl chance its magic
        if(quality > threshold) {

        }
        goldAmount = goldAmount - iCost;
    }
    return goldAmount;
}

//void fillChest(object chest, int goldAmount, int difficulty_lvl)
void generateLoot(int goldAmount, object chest, int difficulty_lvl)
{
    int goldToAddToChest = 0;
    object tempInvObj = CreateObject(OBJECT_TYPE_PLACEABLE, "tempinventoryobj",
                                     GetLocation(chest));
    while(goldAmount > 0) {
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
            goldAmount = createPotionInChest(chest, goldAmount, difficulty_lvl);
        // %10 chance its an armor
        } else if(randChance >= 45 && randChance < 55) {
            goldAmount = createArmorInChest(chest, goldAmount, difficulty_lvl, tempInvObj);
        // %20 chance its a gem
        } else if(randChance >= 55 && randChance < 75) {
            goldAmount = createGemInChest(chest, goldAmount, difficulty_lvl);
        // %15 chance its jewelery
        } else if(randChance >= 75 && randChance < 90) {
            goldAmount = createJewelryInChest(chest, goldAmount, difficulty_lvl);
        // %10 chance its a weapon
        } else if(randChance >= 90 && randChance <= 100) {
            goldAmount = createWeaponInChest(chest, goldAmount, difficulty_lvl);
        }
    }

    if(goldToAddToChest > 0) {
        CreateItemOnObject("nw_it_gold001", chest, goldToAddToChest);
    }

    DestroyObject(tempInvObj);
}
