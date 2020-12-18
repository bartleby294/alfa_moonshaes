/*  lib_baseitem version 1.2
    Den, Project Lead at Carpe Terra (http://carpeterra.com)

    Thanks to: Eyrdan for armor logic; InterSlayer & Kevin Carr for
    item name and weight data; Grommit666 for preposition error checking

    History:    1.0 initial release
                1.1 - added GetBaseItemBroke function
                    - added GetBaseItemHasModel function
                    - fixed prepositions always based on item name
                      even if unidentified
                    - added logic to handle robe/shirt/tunic/outfit/
                      breastplate/scroll
                1.2 - added new SoU/HoU baseitem types to GetBaseItemName
                    - depreciated GetBaseItemWeight (GetWeight function)
                    - depreciated GetBaseItemEncumbrance (cache icon size with Get2da)
*/

string GetBaseItemName(object oItem);
string GetBaseItemPreposition(object oItem);
int GetBaseItemBroke(object oItem, int iValueBonus=5);
int GetBaseItemHasModel(object oItem);

// ========================================================== //
string GetBaseItemName(object oItem) {
// ========================================================== //
/* adapted from Party Loot Notification by InterSlayer and GetArmorType by Eyrdan */
    int iBaseItemType = GetBaseItemType(oItem);
    string sBaseItem;
    if (iBaseItemType == 16) {
        if (TestStringAgainstPattern("**(robe)**", GetName(oItem))) return "robe";
        int bIdentified = GetIdentified(oItem);
        SetIdentified(oItem,FALSE);
        switch (GetGoldPieceValue(oItem)) {
            case    1: sBaseItem = "clothing"; break;
            case    5: sBaseItem = "padded armor"; break;
            case   10: sBaseItem = "leather armor"; break;
            case   15: sBaseItem = "studded leather armor"; break;
            case  100: sBaseItem = "scalemail armor"; break; // Chain Shirt/Scale Mail
            case  150: sBaseItem = "chainmail armor"; break; // Chainmail/Breastplate
            case  200: sBaseItem = "splintmail armor"; break; // Splint Mail/Banded Mail
            case  600: sBaseItem = "half-plate armor"; break; // Half-Plate
            case 1500: sBaseItem = "plate armor"; break; // Full Plate
            default  : sBaseItem = "armor"; break;
        }
        SetIdentified(oItem,bIdentified);
        return sBaseItem;
    }
    switch (iBaseItemType) {
        case 0: sBaseItem = "short sword"; break;
        case 1: sBaseItem = "long sword"; break;
        case 2: sBaseItem = "battle axe"; break;
        case 3: sBaseItem = "bastard sword"; break;
        case 4: sBaseItem = "light flail"; break;
        case 5: sBaseItem = "war hammer"; break;
        case 6: sBaseItem = "heavy crossbow"; break;
        case 7: sBaseItem = "light crossbow"; break;
        case 8: sBaseItem = "longbow"; break;
        case 9: sBaseItem = "light mace"; break;
        case 10: sBaseItem = "halberd"; break;
        case 11: sBaseItem = "shortbow"; break;
        case 12: sBaseItem = "two-bladed sword"; break;
        case 13: sBaseItem = "great sword"; break;
        case 14: sBaseItem = "small shield"; break;
        case 15: sBaseItem = "torch"; break;
//        case 16: sBaseItem = "armor"; break;
        case 17: sBaseItem = "helmet"; break;
        case 18: sBaseItem = "great axe"; break;
        case 19: sBaseItem = "amulet"; break;
        case 20: sBaseItem = "arrows"; break;
        case 21: sBaseItem = "belt"; break;
        case 22: sBaseItem = "dagger"; break;
        case 24: sBaseItem = "small item"; break;
        case 25: sBaseItem = "bolts"; break;
        case 26: sBaseItem = "boots"; break;
        case 27: sBaseItem = "bullets"; break;
        case 28: sBaseItem = "club"; break;
        case 29: sBaseItem = "medium-sized item"; break; // 39?
        case 31: sBaseItem = "darts"; break;
        case 32: sBaseItem = "dire mace"; break;
        case 33: sBaseItem = "double axe"; break;
        case 34: sBaseItem = "large-sized item"; break;
        case 35: sBaseItem = "heavy flail"; break;
        case 36: sBaseItem = "gloves"; break;
        case 37: sBaseItem = "light hammer"; break;
        case 38: sBaseItem = "handaxe"; break;
        case 39: sBaseItem = "healer's kit"; break;
        case 40: sBaseItem = "kama"; break;
        case 41: sBaseItem = "katana"; break;
        case 42: sBaseItem = "kukri"; break;
        case 44: sBaseItem = "rod"; break;
        case 45: sBaseItem = "staff"; break;
        case 46: sBaseItem = "wand"; break;
        case 47: sBaseItem = "morningstar"; break;
        case 49: sBaseItem = "potion"; break;
        case 50: sBaseItem = "quarterstaff"; break;
        case 51: sBaseItem = "rapier"; break;
        case 52: sBaseItem = "ring"; break;
        case 53: sBaseItem = "scimitar"; break;
        case 55: sBaseItem = "scythe"; break;
        case 56: sBaseItem = "large shield"; break;
        case 57: sBaseItem = "tower shield"; break;
        case 58: sBaseItem = "short spear"; break;
        case 59: sBaseItem = "shuriken"; break;
        case 60: sBaseItem = "sickle"; break;
        case 61: sBaseItem = "sling"; break;
        case 62: sBaseItem = "thieves' tools"; break;
        case 63: sBaseItem = "throwing axes"; break;
        case 64: sBaseItem = "trap kit"; break;
        case 65: sBaseItem = "key"; break;
        case 66: sBaseItem = "container"; break;
//        case 69: sBaseItem = "BASE_ITEM_CSLASHWEAPON"; break;
//        case 70: sBaseItem = "BASE_ITEM_CPIERCWEAPON"; break;
//        case 71: sBaseItem = "BASE_ITEM_CBLUDGWEAPON"; break;
//        case 72: sBaseItem = "BASE_ITEM_CSLSHPRCWEAP"; break;
//        case 73: sBaseItem = "BASE_ITEM_CREATUREITEM"; break;
        case 74: sBaseItem = "book"; break;
        case 75: sBaseItem = "scroll"; break;
//        case 76: sBaseItem = "gold"; break;
        case 77: sBaseItem = "gem"; break;
        case 78: sBaseItem = "bracers"; break;
        case 79: sBaseItem = "thin-sized item"; break;
        case 80: sBaseItem = "cloak"; break;
        case 81: sBaseItem = "flask"; break;
        case 101: sBaseItem = "empty potion bottle"; break;
        case 102: sBaseItem = "scroll"; break;
        case 103: sBaseItem = "wand"; break;
        case 104: sBaseItem = "potion"; break;
        case 105: sBaseItem = "scroll"; break;
        case 106: sBaseItem = "wand"; break;
        case 108: sBaseItem = "war axe"; break;
        case 109: sBaseItem = "basic crafting component"; break;
        case 110: sBaseItem = "small crafting component"; break;
        case 111: sBaseItem = "whip"; break;
        case 112: sBaseItem = "crafting base material"; break;
//        case 256: sBaseItem = "nothing"; break;
        default: sBaseItem = "unknown object"; break;
    }
    return sBaseItem;
}

// ========================================================== //
string GetBaseItemPreposition(object oItem) {
// ========================================================== //
    int iItemType = GetBaseItemType(oItem);
    string sItemName = GetBaseItemName(oItem);
    if (GetIdentified(oItem)) sItemName = GetName(oItem);
    if (GetStringLeft(sItemName,3) == "The") { return ""; } // do nothing
    else if (iItemType==16) { // armor
        if (!TestStringAgainstPattern("**(breastplate|shirt|robe|tunic|outfit)**", sItemName)) return "a suit of ";
    }
    else if (iItemType==26
            || iItemType==36
            || iItemType==78) { return "a pair of "; } // pair of boots/bracers/gloves
    else if (iItemType==20
            || iItemType==25
            || iItemType==27
            || iItemType==31
            || iItemType==59
            || iItemType==63
            || iItemType==76) { return "some "; } // some ammunition/gold
    else if (iItemType==62) { return "a set of "; } // thieves' tools
    else if (iItemType==75 && GetIdentified(oItem)) { return "a scroll of "; }
    string sFirstLetter = GetStringLowerCase(GetStringLeft(sItemName,1));
    if (sFirstLetter == "a"
     || sFirstLetter == "e"
     || sFirstLetter == "i"
     || sFirstLetter == "o"
     || sFirstLetter == "u") { return "an "; }
    return "a ";
}

// ========================================================== //
int GetBaseItemBroke(object oItem, int iValueBonus=5) {
// ========================================================== //
/*  generates number from 0 to 100 chance of breaking
    for every 1000 gold, chance is decreased by iValueBonus
    returns 1=broke, 0=survived */
    int iBaseItemType = GetBaseItemType(oItem);
    int bIdentified = GetIdentified(oItem);
    SetIdentified(oItem,TRUE);
    iValueBonus = iValueBonus * GetGoldPieceValue(oItem)/1000;
    SetIdentified(oItem,bIdentified);
    int iRoll = d100();
    int iBreakIndex;
    if (iBaseItemType == 16) {
        SetIdentified(oItem,FALSE);
        switch (GetGoldPieceValue(oItem)) {
            case    1: iBreakIndex= 25; break; // clothing
            case    5: iBreakIndex= 20; break; // padded armor
            case   10: iBreakIndex= 15; break; // leather armor
            case   15: iBreakIndex= 10; break; // studded leather armor
            case  100: iBreakIndex= 5; break; // Chain Shirt/Scale Mail
            case  150: iBreakIndex= 5; break; // Chainmail/Breastplate
            case  200: iBreakIndex= 0; break; // Splint Mail/Banded Mail
            case  600: iBreakIndex= 0; break; // Half-Plate
            case 1500: iBreakIndex= 0; break; // Full Plate
            default  : iBreakIndex= 50; break; // other armor
        }
        SetIdentified(oItem,bIdentified);
        //SendMessageToPC(GetFirstPC(), "Checking item="+GetName(oItem)+" break="+IntToString(iBreakIndex)+" vs roll="+IntToString(iRoll)+" + bonus="+IntToString(iValueBonus));
        if (iBreakIndex < (iRoll+iValueBonus)) return 0;
        return 1;
    }
    switch (iBaseItemType) {
        case  0: iBreakIndex= 5; break; // short sword
        case  1: iBreakIndex= 5; break; // long sword
        case  2: iBreakIndex= 5; break; // battle axe
        case  3: iBreakIndex= 5; break; // bastard sword
        case  4: iBreakIndex= 5; break; // light flail
        case  5: iBreakIndex= 5; break; // war hammer
        case  6: iBreakIndex= 10; break; // heavy crossbow
        case  7: iBreakIndex= 15; break; // light crossbow
        case  8: iBreakIndex= 15; break; // longbow
        case  9: iBreakIndex= 5; break; // light mace
        case 10: iBreakIndex= 5; break; // halberd
        case 11: iBreakIndex= 20; break; // shortbow
        case 12: iBreakIndex= 5; break; // two-bladed sword
        case 13: iBreakIndex= 5; break; // great sword
        case 14: iBreakIndex= 5; break; // small shield
//        case 15: iBreakIndex= 0; break; // torch
        case 17: iBreakIndex= 20; break; // helmet
        case 18: iBreakIndex= 5; break; // great axe
        case 19: iBreakIndex= 30; break; // amulet
        case 20: iBreakIndex= 70; break; // arrows
        case 21: iBreakIndex= 20; break; // belt
        case 22: iBreakIndex= 5; break; // dagger
//        case 24: iBreakIndex= 0; break; // small item
//        case 25: iBreakIndex= 0; break; // bolts
        case 26: iBreakIndex= 20; break; // boots
//        case 27: iBreakIndex= 0; break; // bullets
        case 28: iBreakIndex= 5; break; // club
//        case 29: iBreakIndex= 0; break; // medium-sized item
        case 31: iBreakIndex= 70; break; // darts
        case 32: iBreakIndex= 5; break; // dire mace
        case 33: iBreakIndex= 5; break; // double axe
//        case 34: iBreakIndex= 0; break; // large-sized item
        case 35: iBreakIndex= 5; break; // heavy flail
        case 36: iBreakIndex= 20; break; // gloves
        case 37: iBreakIndex= 5; break; // light hammer
        case 38: iBreakIndex= 5; break; // handaxe
//        case 39: iBreakIndex= 0; break; // healer's kit
        case 40: iBreakIndex= 5; break; // kama
        case 41: iBreakIndex= 5; break; // katana
        case 42: iBreakIndex= 5; break; // kukri
//        case 43: iBreakIndex= 0; break; // tall-sized item
        case 44: iBreakIndex= 20; break; // rod
        case 45: iBreakIndex= 30; break; // staff
        case 46: iBreakIndex= 40; break; // wand
        case 47: iBreakIndex= 5; break; // morningstar
        case 49: iBreakIndex= 90; break; // potion
        case 50: iBreakIndex= 5; break; // quarterstaff
        case 51: iBreakIndex= 5; break; // rapier
        case 52: iBreakIndex= 20; break; // ring
        case 53: iBreakIndex= 5; break; // scimitar
//        case 54: iBreakIndex= 70; break; // scroll
        case 55: iBreakIndex= 5; break; // scythe
        case 56: iBreakIndex= 5; break; // large shield
        case 57: iBreakIndex= 5; break; // tower shield
        case 58: iBreakIndex= 5; break; // short spear
        case 59: iBreakIndex= 20; break; // shuriken
        case 60: iBreakIndex= 5; break; // sickle
//        case 61: iBreakIndex= 0; break; // sling
//        case 62: iBreakIndex= 0; break; // thieves' tools
        case 63: iBreakIndex= 20; break; // throwing axes
        case 64: iBreakIndex= 70; break; // trap kit
        case 65: iBreakIndex= 20; break; // key
//        case 66: iBreakIndex= 0; break; // container
//        case 68: iBreakIndex= 0; break; // wide-sized item
//        case 74: iBreakIndex= 0; break; // book
        case 75: iBreakIndex= 70; break; // scroll
        case 76: iBreakIndex= 100; break; //// gold - special case
//        case 77: iBreakIndex= 0; break; // gem
        case 78: iBreakIndex= 20; break; // bracers
//        case 79: iBreakIndex= 0; break; // thin-sized item
        case 80: iBreakIndex= 20; break; // cloak
        default: iBreakIndex= 50; break; // anything not listed or commented out
    }
    //SendMessageToPC(GetFirstPC(), "Checking item="+GetName(oItem)+" break="+IntToString(iBreakIndex)+" vs roll="+IntToString(iRoll)+" + bonus="+IntToString(iValueBonus));
    if (iBreakIndex < (iRoll+iValueBonus)) return 0;
    return 1;
}

// ========================================================== //
int GetBaseItemHasModel(object oItem) {
// ========================================================== //
/*  returns 0 for default bag, 1 for custom base model, 2 for
    small stack items with model (potion), 3 for large stack
    items with model (gold, ammunition) */
    int iBaseItemType = GetBaseItemType(oItem);
    int iModel;
    switch (iBaseItemType) {
        case 19: iModel= 0; break; // amulet
        case 20: iModel= 3; break; // arrows
        case 21: iModel= 0; break; // belt
        case 24: iModel= 0; break; // small item
        case 25: iModel= 3; break; // bolts
        case 26: iModel= 0; break; // boots
        case 27: iModel= 0; break; // bullets
        case 29: iModel= 0; break; // medium-sized item
        case 31: iModel= 3; break; // darts
        case 34: iModel= 0; break; // large-sized item
        case 36: iModel= 0; break; // gloves
        case 39: iModel= 0; break; // healer's kit - small stack
//        case 43: iModel= 0; break; // tall-sized item
        case 49: iModel= 2; break; // potion - small stack
        case 52: iModel= 0; break; // ring
//        case 54: iModel= 0; break; // scroll
        case 59: iModel= 3; break; // shuriken
        case 62: iModel= 0; break; // thieves' tools - small stack
        case 63: iModel= 3; break; // throwing axes
        case 65: iModel= 0; break; // key
        case 66: iModel= 0; break; // container
//        case 68: iModel= 0; break; // wide-sized item
        case 74: iModel= 0; break; // book
        case 75: iModel= 0; break; // scroll - small stack
        case 76: iModel= 3; break; // gold
        case 77: iModel= 0; break; // gem - small stack
        case 78: iModel= 0; break; // bracers
        case 79: iModel= 0; break; // thin-sized item
        case 80: iModel= 0; break; // cloak
        case 256: iModel= 0; break; // plain old bag
        default: iModel=1; break; // most common (weapons+armor)
    }
    return iModel;
}

//void main(){}
