#include "_btb_rand_potion"
#include "_btb_rand_armor"
#include "_btb_rand_gem"
#include "_btb_rand_weapon"
#include "_btb_rand_jewelr"
#include "_btb_util"

int createPotionInChest(object chest, int goldAmount) {
    string randPotionResref = getRandomPotion();
    int iCost = getItemCostFromTag(GetStringUpperCase(randPotionResref));
    if(iCost <= goldAmount) {
        goldAmount = goldAmount - iCost;
        CreateItemOnObject(randPotionResref, chest);
    }
    return goldAmount;
}

int createGemInChest(object chest, int goldAmount) {
    string randGemTag = getRandomGem();
    int iCost = getItemCostFromTag(randGemTag);
    if(iCost <= goldAmount) {
        goldAmount = goldAmount - iCost;
        CreateItemOnObject(randGemTag, chest);
    }
    return goldAmount;
}

int createArmorInChest(object chest, int goldAmount, int difficulty_lvl) {
    string randArmorResref = getRandomBaseArmor();
    int iCost = getItemCostFromTag(GetStringUpperCase(randArmorResref));
    if(iCost <= goldAmount) {
        //goldAmount = goldAmount - iCost;
        object item = CreateItemOnObject(randArmorResref, chest);
        int quality = d100();
        // chance its magic
        if(quality) {

        }


    }
    return goldAmount;
}


//void fillChest(object chest, int goldAmount, int difficulty_lvl)
void main()
{
    object chest;
    int goldAmount;
    int difficulty_lvl;
    int goldToAddToChest = 0;
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
            goldAmount = createPotionInChest(chest, goldAmount);
        // %10 chance its an armor
        } else if(randChance >= 45 && randChance < 55) {
            goldAmount = createArmorInChest(chest, goldAmount, difficulty_lvl);
        // %20 chance its a gem
        } else if(randChance >= 55 && randChance < 75) {
            goldAmount = createPotionInChest(chest, goldAmount);
        // %15 chance its jewelery
        } else if(randChance >= 75 && randChance < 90) {
            string randJewelryTag = GetStringUpperCase(getRandomJewelry());
        // %10 chance its a weapon
        } else if(randChance >= 90 && randChance <= 100) {
            string randWeaponTag = GetStringUpperCase(getRandomBaseWeapon());
        }
    }
}
