#include "_btb_util"

int higherGemPrice(string tag, int curPrice) {
    int gemPrice = getItemCostFromTag(tag);
    if(gemPrice > curPrice) {
        return gemPrice;
    }
    return curPrice;
}

int getHighestGemPrice() {

    int highestPrice = 0;

    //Amber
    highestPrice = higherGemPrice("014_gem_001", highestPrice);
    //Andar
    highestPrice = higherGemPrice("014_gem_048", highestPrice);
    //Angelar's Skin
    highestPrice = higherGemPrice("014_gem_034", highestPrice);
    //Aquamarine
    highestPrice = higherGemPrice("014_gem_080", highestPrice);
    // Azurite
    highestPrice = higherGemPrice("014_gem_062", highestPrice);
    // Banded Agate
    highestPrice = higherGemPrice("014_gem_005", highestPrice);
    // Beljuril
    highestPrice = higherGemPrice("014_gem_045", highestPrice);
    // Black Opal
    highestPrice = higherGemPrice("014_gem_046", highestPrice);
    // Black Pearl
    highestPrice = higherGemPrice("blackpearl", highestPrice);
    // Bloodstone
    highestPrice = higherGemPrice("bloodstone", highestPrice);
    // Blue Corundum
    highestPrice = higherGemPrice("014_gem_084", highestPrice);
    // Blue Quartz
    highestPrice = higherGemPrice("014_gem_007", highestPrice);
    // Blue Topaz
    highestPrice = higherGemPrice("014_gem_030", highestPrice);
    // Fire Opal
    highestPrice = higherGemPrice("014_gem_010", highestPrice);
    // Freshwater Pearl
    highestPrice = higherGemPrice("014_gem_063", highestPrice);
    // Golden-Yellow Topaz
    highestPrice = higherGemPrice("014_gem_029", highestPrice);
    // Hematite
    highestPrice = higherGemPrice("014_gem_014", highestPrice);
    // Hyaline
    highestPrice = higherGemPrice("014_gem_047", highestPrice);
    // Hydrophane
    highestPrice = higherGemPrice("014_gem_040", highestPrice);
    // Iol
    highestPrice = higherGemPrice("014_gem_051", highestPrice);
    // Iolite
    highestPrice = higherGemPrice("014_gem_069", highestPrice);
    // Irtios
    highestPrice = higherGemPrice("014_gem_052", highestPrice);
    // Ivory
    highestPrice = higherGemPrice("014_gem_041", highestPrice);
    // Jacinth
    highestPrice = higherGemPrice("014_gem_042", highestPrice);
    // Jade
    highestPrice = higherGemPrice("014_gem_015", highestPrice);
    // Jasper
    highestPrice = higherGemPrice("014_gem_070", highestPrice);
    // Jet
    highestPrice = higherGemPrice("014_gem_016", highestPrice);
    // King's Tears
    highestPrice = higherGemPrice("014_gem_053", highestPrice);
    // Laeral's Tears
    highestPrice = higherGemPrice("014_gem_054", highestPrice);
    // Lapis Lazuli
    highestPrice = higherGemPrice("014_gem_017", highestPrice);
    // Moonstone
    highestPrice = higherGemPrice("014_gem_019", highestPrice);
    // Moss Agate
    highestPrice = higherGemPrice("014_gem_020", highestPrice);
    // Nelvine
    highestPrice = higherGemPrice("014_gem_064", highestPrice);
    // Obsidian
    highestPrice = higherGemPrice("014_gem_021", highestPrice);
    // Onyx
    highestPrice = higherGemPrice("014_gem_071", highestPrice);
    // Orl
    highestPrice = higherGemPrice("014_gem_055", highestPrice);
    // Orprase
    highestPrice = higherGemPrice("014_gem_056", highestPrice);
    // Pearl
    highestPrice = higherGemPrice("089_pearl", highestPrice);
    // Perfect Emerald
    highestPrice = higherGemPrice("014_gem_085", highestPrice);
    // Peridot
    highestPrice = higherGemPrice("014_gem_024", highestPrice);
    // Purple Corundum
    highestPrice = higherGemPrice("014_gem_083", highestPrice);
    // Ravenar
    highestPrice = higherGemPrice("014_gem_058", highestPrice);
    // Red Garnet
    highestPrice = higherGemPrice("014_gem_013", highestPrice);
    // Red Tears
    highestPrice = higherGemPrice("014_gem_044", highestPrice);
    // Rhodochrosite
    highestPrice = higherGemPrice("014_gem_065", highestPrice);
    // Rock Crystal
    highestPrice = higherGemPrice("014_gem_059", highestPrice);
    // Rose Quartz
    highestPrice = higherGemPrice("014_gem_072", highestPrice);
    // Sanidine
    highestPrice = higherGemPrice("014_gem_026", highestPrice);
    // Sard
    highestPrice = higherGemPrice("014_gem_075", highestPrice);
    // Sardonyx
    highestPrice = higherGemPrice("014_gem_060", highestPrice);
    // Smoky Quartz
    highestPrice = higherGemPrice("014_gem_033", highestPrice);
    // Spodumene
    highestPrice = higherGemPrice("014_gem_043", highestPrice);
    // Star Rose Quartz
    highestPrice = higherGemPrice("014_gem_073", highestPrice);
    // Star Sapphire
    highestPrice = higherGemPrice("014_gem_027", highestPrice);
    // Tchazar
    highestPrice = higherGemPrice("014_gem_061", highestPrice);
    // Tiger Eye Agate
    highestPrice = higherGemPrice("014_gem_028", highestPrice);
    // Tomb Jade
    highestPrice = higherGemPrice("014_gem_039", highestPrice);
    // Tourmaline
    highestPrice = higherGemPrice("014_gem_079", highestPrice);
    // Turquoise
    highestPrice = higherGemPrice("014_gem_031", highestPrice);
    // Violet Garnet
    highestPrice = higherGemPrice("014_gem_082", highestPrice);
    // Violine
    highestPrice = higherGemPrice("014_gem_037", highestPrice);
    // Water Opal
    highestPrice = higherGemPrice("014_gem_023", highestPrice);
    // Waterstar
    highestPrice = higherGemPrice("014_gem_038", highestPrice);
    // White Opal
    highestPrice = higherGemPrice("014_gem_022", highestPrice);
    // White Pearl
    highestPrice = higherGemPrice("014_gem_078", highestPrice);
    // Zircon
    highestPrice = higherGemPrice("014_gem_032", highestPrice);

    return highestPrice;

}

///////GEMS///////
string getRandomGem() {
    switch (Random(66)) {
        case(0):
            //Ambee
            return "014_gem_001";
        case(1):
            //Andar
            return "014_gem_048";
        case(2):
            //Angelar's Skin
            return "014_gem_034";
        case(3):
            //Aquamarine
            return "014_gem_080";
        case(4):
            // Azurite
            return "014_gem_062";
        case(5):
            // Banded Agate
            return "014_gem_005";
        case(6):
            // Beljuril
            return "014_gem_045";
        case(7):
            // Black Opal
            return "014_gem_046";
        case(8):
            // Black Pearl
            return "blackpearl";
        case(9):
            // Bloodstone
            return "bloodstone";
        case(10):
            // Blue Corundum
            return "014_gem_084";
        case(11):
            // Blue Quartz
            return "014_gem_007";
        case(12):
            // Blue Topaz
            return "014_gem_030";
        case(13):
            // Fire Opal
            return "014_gem_010";
        case(14):
            // Freshwater Pearl
            return "014_gem_063";
        case(15):
            // Golden-Yellow Topaz
            return "014_gem_029";
        case(16):
            // Hematite
            return "014_gem_014";
        case(17):
            // Hyaline
            return "014_gem_047";
        case(18):
            // Hydrophane
            return "014_gem_040";
        case(19):
            // Iol
            return "014_gem_051";
        case(20):
            // Iolite
            return "014_gem_069";
        case(21):
            // Irtios
            return "014_gem_052";
        case(22):
            // Ivory
            return "014_gem_041";
        case(23):
            // Jacinth
            return "014_gem_042";
        case(24):
            // Jade
            return "014_gem_015";
        case(25):
            // Jasper
            return "014_gem_070";
        case(26):
            // Jet
            return "014_gem_016";
        case(27):
            // King's Tears
            return "014_gem_053";
        case(28):
            // Laeral's Tears
            return "014_gem_054";
        case(29):
            // Lapis Lazuli
            return "014_gem_017";
        case(30):
            // Moonstone
            return "014_gem_019";
        case(31):
            // Moss Agate
            return "014_gem_020";
        case(32):
            // Nelvine
            return "014_gem_064";
        case(33):
            // Obsidian
            return "014_gem_021";
        case(34):
            // Onyx
            return "014_gem_071";
        case(35):
            // Orl
            return "014_gem_055";
        case(36):
            // Orprase
            return "014_gem_056";
        case(37):
            // Pearl
            return "089_pearl";
        case(38):
            // Perfect Emerald
            return "014_gem_085";
        case(39):
            // Peridot
            return "014_gem_024";
        case(40):
            // Purple Corundum
            return "014_gem_083";
        case(41):
            // Ravenar
            return "014_gem_058";
        case(42):
            // Red Garnet
            return "014_gem_013";
        case(43):
            // Red Tears
            return "014_gem_044";
        case(44):
            // Rhodochrosite
            return "014_gem_065";
        case(45):
            // Rock Crystal
            return "014_gem_059";
        case(46):
            // Rose Quartz
            return "014_gem_072";
        case(47):
            // Sanidine
            return "014_gem_026";
        case(48):
            // Sard
            return "014_gem_075";
        case(49):
            // Sardonyx
            return "014_gem_060";
        case(50):
            // Smoky Quartz
            return "014_gem_033";
        case(51):
            // Spodumene
            return "014_gem_043";
        case(52):
            // Star Rose Quartz
            return "014_gem_073";
        case(53):
            // Star Sapphire
            return "014_gem_027";
        case(54):
            // Tchazar
            return "014_gem_061";
        case(55):
            // Tiger Eye Agate
            return "014_gem_028";
        case(56):
            // Tomb Jade
            return "014_gem_039";
        case(57):
            // Tourmaline
            return "014_gem_079";
        case(58):
            // Turquoise
            return "014_gem_031";
        case(59):
            // Violet Garnet
            return "014_gem_082";
        case(60):
            // Violine
            return "014_gem_037";
        case(61):
            // Water Opal
            return "014_gem_023";
        case(62):
            // Waterstar
            return "014_gem_038";
        case(63):
            // White Opal
            return "014_gem_022";
        case(64):
            // White Pearl
            return "014_gem_078";
        case(65):
            // Zircon
            return "014_gem_032";
    }
    return "";
}

string getRandomGemUnderCost(int goldAmount) {

    int limit = 0;
    string randGemTag = getRandomGem();
    int iCost = getItemCostFromTag(randGemTag);

    while(iCost > goldAmount) {
        if(limit > 100) {
            return "";
        }
       randGemTag = getRandomGem();
       iCost = getItemCostFromTag(randGemTag);
       limit++;
    }

    return randGemTag;
}

/**
 * Returns a random gem taking weighted cost into consideration.
 */
string getWeightedRandomGem(int gemLvl, int maxGemValue){
    int mostExpensiveGem = getHighestGemPrice();
    // get a random percentage scaled by most expensive gem inflate it by gemlvl
    float randSelection = (d100() * gemLvl * mostExpensiveGem * 1.0) / 100.0;

    int breakout = 0;
    string gemStr = getRandomGem();
    int gemPrice = getItemCostFromTag(gemStr);
    float gemPriceCeiling = gemPrice - (gemPrice * 0.05);

    /* Keep going till we have an acceptable gem that is not too expensive.*/
    while(randSelection < gemPriceCeiling
            && maxGemValue <= gemPrice
            && breakout < 65) {
        gemStr = getRandomGem();
        gemPrice = getItemCostFromTag(gemStr);
        gemPriceCeiling = gemPrice - (gemPrice * 0.05);
        breakout = breakout + 1;
    }

    if(randSelection < gemPriceCeiling && maxGemValue <= gemPrice) {
        return gemStr;
    }

    return "";
}
