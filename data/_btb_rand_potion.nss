#include "_btb_util"

int higherPotionPrice(string tag, int curPrice) {
    int potionPrice = getItemCostFromTag(tag);
    if(potionPrice > curPrice) {
        return potionPrice;
    }
    return curPrice;
}

int getHighestPotionPrice() {

    int highestPrice = 0;
    highestPrice = higherPotionPrice("nw_it_mpotion016", highestPrice);
    highestPrice = higherPotionPrice("nw_it_mpotion006", highestPrice);
    highestPrice = higherPotionPrice("nw_it_mpotion005", highestPrice);
    highestPrice = higherPotionPrice("nw_it_mpotion009", highestPrice);
    highestPrice = higherPotionPrice("nw_it_mpotion015", highestPrice);
    highestPrice = higherPotionPrice("nw_it_mpotion014", highestPrice);
    highestPrice = higherPotionPrice("nw_it_mpotion007", highestPrice);
    highestPrice = higherPotionPrice("nw_it_mpotion003", highestPrice);
    highestPrice = higherPotionPrice("nw_it_mpotion001", highestPrice);
    highestPrice = higherPotionPrice("nw_it_mpotion020", highestPrice);
    highestPrice = higherPotionPrice("nw_it_mpotion002", highestPrice);
    highestPrice = higherPotionPrice("x2_it_mpotion002", highestPrice);
    highestPrice = higherPotionPrice("nw_it_mpotion010", highestPrice);
    highestPrice = higherPotionPrice("nw_it_mpotion013", highestPrice);
    highestPrice = higherPotionPrice("nw_it_mpotion017", highestPrice);
    highestPrice = higherPotionPrice("nw_it_mpotion012", highestPrice);
    highestPrice = higherPotionPrice("nw_it_mpotion008", highestPrice);
    highestPrice = higherPotionPrice("x2_it_mpotion001", highestPrice);
    highestPrice = higherPotionPrice("nw_it_mpotion011", highestPrice);
    highestPrice = higherPotionPrice("nw_it_mpotion019", highestPrice);
    highestPrice = higherPotionPrice("nw_it_mpotion018", highestPrice);
    highestPrice = higherPotionPrice("nw_it_mpotion004", highestPrice);

    return highestPrice;

}


//////////POTIONS//////////
string getRandomPotion()
{
    /*Potions*/
    switch (Random(22)) {
        case 0:
            // Potion of Aid
            return "nw_it_mpotion016";
        case 1:
            // Potion of Antidote
            return "nw_it_mpotion006";
        case 2:
            // Potion of Barkskin
            return "nw_it_mpotion005";
        case 3:
            // Potion of Bless
            return "nw_it_mpotion009";
        case 4:
            // Potion of Bull's Strength
            return "nw_it_mpotion015";
        case 5:
            // Potion of Cat's Grace
            return "nw_it_mpotion014";
        case 6:
            // Potion of Clarity
            return "nw_it_mpotion007";
        case 7:
            // Potion of Cure Critical Wounds
            return "nw_it_mpotion003";
        case 8:
            // Potion of Cure Light Wounds
            return "nw_it_mpotion001";
        case 9:
            // Potion of Cure Moderate Wounds
            return "nw_it_mpotion020";
        case 10:
            // Potion of Cure Serious Wounds
            return "nw_it_mpotion002";
        case 11:
            // Potion of Death Armor
            return "x2_it_mpotion002";
        case 12:
            // Potion of Eagle's Splendor
            return "nw_it_mpotion010";
        case 13:
            // Potion of Endurance
            return "nw_it_mpotion013";
        case 14:
            // Potion of Fox's Cunning
            return "nw_it_mpotion017";
        case 15:
            // Potion of Heal
            return "nw_it_mpotion012";
        case 16:
            // Potion of Invisibility
            return "nw_it_mpotion008";
        case 17:
            // Potion of Ironguts
            return "x2_it_mpotion001";
        case 18:
            // Potion of Lesser Restoration
            return "nw_it_mpotion011";
        case 19:
            // Potion of Lore
            return "nw_it_mpotion019";
        case 20:
            // Potion of Owl's Wisdom
            return "nw_it_mpotion018";
        case 21:
            // Potion of Speed
            return "nw_it_mpotion004";
    }
    return "";
}

/**
 * Returns a random potion taking weighted cost into consideration.
 */
string getWeightedRandomPotion(int potionLvl, int maxPotionValue){
    int mostExpensivePotion = getHighestPotionPrice();
    // get a random percentage scaled by most expensive potion inflate it by
    // potionlvl
    float randSelection = (d100() * potionLvl * mostExpensivePotion * 1.0) / 100.0;

    int breakout = 0;
    string potionStr = getRandomPotion();
    int potionPrice = getItemCostFromTag(potionStr);
    float potionPriceCeiling = potionPrice - (potionPrice * 0.05);

    /* Keep going till we have an acceptable potion that is not too expensive.*/
    while(randSelection < potionPriceCeiling
            && maxPotionValue <= potionPrice
            && breakout < 65) {
        potionStr = getRandomPotion();
        potionPrice = getItemCostFromTag(potionStr);
        potionPriceCeiling = potionPrice - (potionPrice * 0.05);
        breakout = breakout + 1;
    }

    if(randSelection < potionPriceCeiling && maxPotionValue <= potionPrice) {
        return potionStr;
    }

    return "";
}
