#include "x2_inc_itemprop"

const int ALFA_WEALTH_POSITION_OVER_LIMIT = 5;
const int ALFA_WEALTH_POSITION_HIGH = 4;
const int ALFA_WEALTH_POSITION_AVERAGE = 3;
const int ALFA_WEALTH_POSITION_LOW = 2;
const int ALFA_WEALTH_POSITION_VERY_LOW = 1;
const int ALFA_WEALTH_POSITION_ERROR = 0;

const string ALFA_TRADEBAR_RESREF = "alfa_tradebar";

struct WealthStruct {
    int wealth;
    int averageLevel;
    int highLevel;
    int lowLevel;
    int limitLevel;
    int position;
    float percentXPToNextLevel;
    float percentToNextWealthLevel;
};

string ReadableIntToString(int num) {
/*    string str = IntToString(num);
    int i;
    int length = GetStringLength(str);

    for(i=0; i<((length-1)/3); i++) {
        InsertString(str, ",", (i+1)
    }*/
    return IntToString(num);
}

/*int GetIsWeapon(object oItem) {
    int baseType = GetBaseItemType(oItem);

    switch(baseType) {
        case BASE_ITEM_BASTARDSWORD:
            return 1;
            break;

        case BASE_ITEM_BATTLEAXE:
            return 1;
            break;

        case BASE_ITEM_CLUB:
            return 1;
            break;

        case BASE_ITEM_DAGGER:
            return 1;
            break;

        case BASE_ITEM_DIREMACE:
            return 1;
            break;

        case BASE_ITEM_DOUBLEAXE:
            return 1;
            break;

        case BASE_ITEM_DWARVENWARAXE:
            return 1;
            break;

        case BASE_ITEM_GREATAXE:
            return 1;
            break;

        case BASE_ITEM_GREATSWORD:
            return 1;
            break;

        case BASE_ITEM_HALBERD:
            return 1;
            break;

        case BASE_ITEM_HANDAXE:
            return 1;
            break;

        case BASE_ITEM_HEAVYCROSSBOW:
            return 1;
            break;

        case BASE_ITEM_HEAVYFLAIL:
            return 1;
            break;

        case BASE_ITEM_KAMA:
            return 1;
            break;

        case BASE_ITEM_KATANA:
            return 1;
            break;

        case BASE_ITEM_KUKRI:
            return 1;
            break;

        case BASE_ITEM_LIGHTCROSSBOW:
            return 1;
            break;

        case BASE_ITEM_LIGHTFLAIL:
            return 1;
            break;

        case BASE_ITEM_LIGHTHAMMER:
            return 1;
            break;

        case BASE_ITEM_LIGHTMACE:
            return 1;
            break;

        case BASE_ITEM_LONGBOW:
            return 1;
            break;

        case BASE_ITEM_LONGSWORD:
            return 1;
            break;

        case BASE_ITEM_MORNINGSTAR:
            return 1;
            break;

        case BASE_ITEM_QUARTERSTAFF:
            return 1;
            break;

        case BASE_ITEM_RAPIER:
            return 1;
            break;

        case BASE_ITEM_RING:
            return 1;
            break;

        case BASE_ITEM_SCIMITAR:
            return 1;
            break;

        case BASE_ITEM_SCYTHE:
            return 1;
            break;

        case BASE_ITEM_SHORTBOW:
            return 1;
            break;

        case BASE_ITEM_SHORTSPEAR:
            return 1;
            break;

        case BASE_ITEM_SHORTSWORD:
            return 1;
            break;

        case BASE_ITEM_SHURIKEN:
            return 1;
            break;

        case BASE_ITEM_SICKLE:
            return 1;
            break;

        case BASE_ITEM_TWOBLADEDSWORD:
            return 1;
            break;

        case BASE_ITEM_WARHAMMER:
            return 1;
            break;

        case BASE_ITEM_WHIP:
            return 1;
            break;
    }
    return 0;
}

int GetIsArmor(object oItem) {
    int baseType = GetBaseItemType(oItem);

    return (baseType == BASE_ITEM_ARMOR || baseType == BASE_ITEM_SMALLSHIELD || baseType == BASE_ITEM_TOWERSHIELD || baseType == BASE_ITEM_LARGESHIELD);
}

int GetIsAmmo(object oItem) {
    int baseType = GetBaseItemType(oItem);

    switch(baseType) {
        case BASE_ITEM_ARROW:
            return 1;
            break;

        case BASE_ITEM_BOLT:
            return 1;
            break;
        case BASE_ITEM_BULLET:
            return 1;
            break;

        case BASE_ITEM_DART:
            return 1;
            break;

        case BASE_ITEM_SHURIKEN:
            return 1;
            break;
    }
}

int GetPropertyValue(itemproperty prop, object report) {

    int propType = GetItemPropertyType(prop);

    switch(propType) {
            case ITEM_PROPERTY_ABILITY_BONUS:
            break;
            case ITEM_PROPERTY_AC_BONUS:
            break;
            case ITEM_PROPERTY_AC_BONUS_VS_ALIGNMENT_GROUP:
            break;
            case ITEM_PROPERTY_AC_BONUS_VS_DAMAGE_TYPE:
            break;
            case ITEM_PROPERTY_AC_BONUS_VS_RACIAL_GROUP:
            break;
            case ITEM_PROPERTY_AC_BONUS_VS_SPECIFIC_ALIGNMENT:
            break;
            case ITEM_PROPERTY_ARCANE_SPELL_FAILURE:
            break;
            case ITEM_PROPERTY_ATTACK_BONUS:
            break;
            case ITEM_PROPERTY_ATTACK_BONUS_VS_ALIGNMENT_GROUP:
            break;
            case ITEM_PROPERTY_ATTACK_BONUS_VS_RACIAL_GROUP:
            break;
            case ITEM_PROPERTY_ATTACK_BONUS_VS_SPECIFIC_ALIGNMENT:
            break;
            case ITEM_PROPERTY_BASE_ITEM_WEIGHT_REDUCTION:
            break;
            case ITEM_PROPERTY_BONUS_FEAT:
            break;
            case ITEM_PROPERTY_BONUS_SPELL_SLOT_OF_LEVEL_N:
            break;
            case ITEM_PROPERTY_CAST_SPELL:
            break;
            case ITEM_PROPERTY_DAMAGE_BONUS:
            break;
            case ITEM_PROPERTY_DAMAGE_BONUS_VS_ALIGNMENT_GROUP:
            break;
            case ITEM_PROPERTY_DAMAGE_BONUS_VS_RACIAL_GROUP:
            break;
            case ITEM_PROPERTY_DAMAGE_BONUS_VS_SPECIFIC_ALIGNMENT:
            break;
            case ITEM_PROPERTY_DAMAGE_REDUCTION:
            break;
            case ITEM_PROPERTY_DAMAGE_RESISTANCE:
            break;
            case ITEM_PROPERTY_DAMAGE_VULNERABILITY:
            break;
            case ITEM_PROPERTY_DARKVISION:
            break;
            case ITEM_PROPERTY_DECREASED_ABILITY_SCORE:
            break;
            case ITEM_PROPERTY_DECREASED_AC:
            break;
            case ITEM_PROPERTY_DECREASED_ATTACK_MODIFIER:
            break;
            case ITEM_PROPERTY_DECREASED_DAMAGE:
            break;
            case ITEM_PROPERTY_DECREASED_ENHANCEMENT_MODIFIER:
            break;
            case ITEM_PROPERTY_DECREASED_SAVING_THROWS:
            break;
            case ITEM_PROPERTY_DECREASED_SAVING_THROWS_SPECIFIC:
            break;
            case ITEM_PROPERTY_DECREASED_SKILL_MODIFIER:
            break;
            case ITEM_PROPERTY_ENHANCED_CONTAINER_REDUCED_WEIGHT:
            break;
            case ITEM_PROPERTY_ENHANCEMENT_BONUS:
            break;
            case ITEM_PROPERTY_ENHANCEMENT_BONUS_VS_ALIGNMENT_GROUP:
            break;
            case ITEM_PROPERTY_ENHANCEMENT_BONUS_VS_RACIAL_GROUP:
            break;
            case ITEM_PROPERTY_ENHANCEMENT_BONUS_VS_SPECIFIC_ALIGNEMENT:
            break;
            case ITEM_PROPERTY_EXTRA_MELEE_DAMAGE_TYPE:
            break;
            case ITEM_PROPERTY_EXTRA_RANGED_DAMAGE_TYPE:
            break;
            case ITEM_PROPERTY_FREEDOM_OF_MOVEMENT:
            break;
            case ITEM_PROPERTY_HASTE:
            break;
            case ITEM_PROPERTY_HEALERS_KIT:
            break;
            case ITEM_PROPERTY_HOLY_AVENGER:
            break;
            case ITEM_PROPERTY_IMMUNITY_DAMAGE_TYPE:
            break;
            case ITEM_PROPERTY_IMMUNITY_MISCELLANEOUS:
            break;
            case ITEM_PROPERTY_IMMUNITY_SPECIFIC_SPELL:
            break;
            case ITEM_PROPERTY_IMMUNITY_SPELL_SCHOOL:
            break;
            case ITEM_PROPERTY_IMMUNITY_SPELLS_BY_LEVEL:
            break;
            case ITEM_PROPERTY_IMPROVED_EVASION:
            break;
            case ITEM_PROPERTY_KEEN:
            break;
            case ITEM_PROPERTY_LIGHT:
            break;
            case ITEM_PROPERTY_MASSIVE_CRITICALS:
            break;
            case ITEM_PROPERTY_MIGHTY:
            break;
            case ITEM_PROPERTY_MIND_BLANK:
            break;
            case ITEM_PROPERTY_MONSTER_DAMAGE:
            break;
            case ITEM_PROPERTY_NO_DAMAGE:
            break;
            case ITEM_PROPERTY_ON_HIT_PROPERTIES:
            break;
            case ITEM_PROPERTY_ON_MONSTER_HIT:
            break;
            case ITEM_PROPERTY_ONHITCASTSPELL:
            break;
            case ITEM_PROPERTY_POISON:
            break;
            case ITEM_PROPERTY_REGENERATION:
            break;
            case ITEM_PROPERTY_REGENERATION_VAMPIRIC:
            break;
            case ITEM_PROPERTY_SAVING_THROW_BONUS:
            break;
            case ITEM_PROPERTY_SAVING_THROW_BONUS_SPECIFIC:
            break;
            case ITEM_PROPERTY_SKILL_BONUS:
            break;
            case ITEM_PROPERTY_SPECIAL_WALK:
            break;
            case ITEM_PROPERTY_SPELL_RESISTANCE:
            break;
            case ITEM_PROPERTY_THIEVES_TOOLS:
            break;
            case ITEM_PROPERTY_TRAP:
            break;
            case ITEM_PROPERTY_TRUE_SEEING:
            break;
            case ITEM_PROPERTY_TURN_RESISTANCE:
            break;
            case ITEM_PROPERTY_UNLIMITED_AMMUNITION:
            break;
            case ITEM_PROPERTY_USE_LIMITATION_ALIGNMENT_GROUP:
            break;
            case ITEM_PROPERTY_USE_LIMITATION_CLASS:
            break;
            case ITEM_PROPERTY_USE_LIMITATION_RACIAL_TYPE:
            break;
            case ITEM_PROPERTY_USE_LIMITATION_SPECIFIC_ALIGNMENT:
            break;
            case ITEM_PROPERTY_USE_LIMITATION_TILESET:
            break;
            case ITEM_PROPERTY_VISUALEFFECT:
            break;
            case ITEM_PROPERTY_WEIGHT_INCREASE:
            break;
        }
}

float GetItemPropertyEffectivePlus(object oItem, itemproperty prop) {
    float plus;

    int propType = GetItemPropertyType(prop);
    int propSubtype = GetItemPropertySubType(prop);

        switch(propType) {
            case ITEM_PROPERTY_ARCANE_SPELL_FAILURE:
                break;
            case ITEM_PROPERTY_BONUS_FEAT:

                switch(propSubtype) {
                    case IP_CONST_FEAT_ALERTNESS:
                        break;

                    case IP_CONST_FEAT_AMBIDEXTROUS:
                        break;

                    case IP_CONST_FEAT_ARMOR_PROF_HEAVY:
                        break;

                    case IP_CONST_FEAT_ARMOR_PROF_LIGHT:
                        break;

                    case IP_CONST_FEAT_ARMOR_PROF_MEDIUM:
                        break;

                    case IP_CONST_FEAT_CLEAVE:
                        break;

                    case IP_CONST_FEAT_COMBAT_CASTING:
                        break;

                    case IP_CONST_FEAT_DODGE:
                        break;

                    case IP_CONST_FEAT_EXTRA_TURNING:
                        break;

                    case IP_CONST_FEAT_IMPCRITUNARM:
                        break;

                    case IP_CONST_FEAT_KNOCKDOWN:
                        break;

                    case IP_CONST_FEAT_POINTBLANK:
                        break;

                    case IP_CONST_FEAT_POWERATTACK:
                        break;

                    case IP_CONST_FEAT_SPELLFOCUSABJ:
                        break;

                    case IP_CONST_FEAT_SPELLFOCUSCON:
                        break;

                    case IP_CONST_FEAT_SPELLFOCUSDIV:
                        break;

                    case IP_CONST_FEAT_SPELLFOCUSENC:
                        break;

                    case IP_CONST_FEAT_SPELLFOCUSEVO:
                        break;

                    case IP_CONST_FEAT_SPELLFOCUSILL:
                        break;

                    case IP_CONST_FEAT_SPELLFOCUSNEC:
                        break;

                    case IP_CONST_FEAT_SPELLPENETRATION:
                        break;

                    case IP_CONST_FEAT_TWO_WEAPON_FIGHTING:
                        break;

                    case IP_CONST_FEAT_WEAPFINESSE:
                        break;

                    case IP_CONST_FEAT_WEAPON_PROF_EXOTIC:
                        break;

                    case IP_CONST_FEAT_WEAPON_PROF_MARTIAL:
                        break;

                    case IP_CONST_FEAT_WEAPON_PROF_SIMPLE:
                        break;

                    case IP_CONST_FEAT_WEAPSPEUNARM:
                        break;
                }

                break;
            case ITEM_PROPERTY_SPELL_RESISTANCE:
                break;
        }
}*/

int GetItemValue(object oItem) { /*, object report) {
    if(!GetIsObjectValid(oItem))
        return 0;

    int baseItemType = GetBaseItemType(oItem);
    int value=0;
    float plus;

    itemproperty prop = GetFirstItemProperty(oItem);
    while(GetIsItemPropertyValid(prop)) {



        prop = GetNextItemProperty(oItem);
    }

    if(value == 0)
        return GetGoldPieceValue(oItem);
        else return value;*/

    if(GetResRef(oItem) == ALFA_TRADEBAR_RESREF)
        return 500;

    int value;
    if(GetPlotFlag(oItem)) {
        SetPlotFlag(oItem, 0);
        value = GetGoldPieceValue(oItem);
        SetPlotFlag(oItem, 1);
    } else {
            value = GetGoldPieceValue(oItem);
    }
    return value;
}

int GetLootableItemValue(object oItem) {
    if(GetDroppableFlag(oItem) && !GetPlotFlag(oItem))
        return GetItemValue(oItem);
        else return 0;
}

int GetLootableWealth(object oPC) {     // Should mainly be used for computing the wealth of spawns.
    int wealth=0;

    object oItem = GetFirstItemInInventory(oPC);
    while(GetIsObjectValid(oItem)) {
        wealth += GetLootableItemValue(oItem);
        oItem = GetNextItemInInventory(oPC);
    }

    wealth += GetLootableItemValue(GetItemInSlot(INVENTORY_SLOT_ARMS, oPC));
    wealth += GetLootableItemValue(GetItemInSlot(INVENTORY_SLOT_ARROWS, oPC));
    wealth += GetLootableItemValue(GetItemInSlot(INVENTORY_SLOT_BELT, oPC));
    wealth += GetLootableItemValue(GetItemInSlot(INVENTORY_SLOT_BOLTS, oPC));
    wealth += GetLootableItemValue(GetItemInSlot(INVENTORY_SLOT_BOOTS, oPC));
    wealth += GetLootableItemValue(GetItemInSlot(INVENTORY_SLOT_BULLETS, oPC));
    wealth += GetLootableItemValue(GetItemInSlot(INVENTORY_SLOT_CHEST, oPC));
    wealth += GetLootableItemValue(GetItemInSlot(INVENTORY_SLOT_CLOAK, oPC));
    wealth += GetLootableItemValue(GetItemInSlot(INVENTORY_SLOT_HEAD, oPC));
    wealth += GetLootableItemValue(GetItemInSlot(INVENTORY_SLOT_LEFTHAND, oPC));
    wealth += GetLootableItemValue(GetItemInSlot(INVENTORY_SLOT_LEFTRING, oPC));
    wealth += GetLootableItemValue(GetItemInSlot(INVENTORY_SLOT_NECK, oPC));
    wealth += GetLootableItemValue(GetItemInSlot(INVENTORY_SLOT_RIGHTHAND, oPC));
    wealth += GetLootableItemValue(GetItemInSlot(INVENTORY_SLOT_RIGHTRING, oPC));
    wealth += GetGold(oPC);

    return wealth;
}

int GetTotalWealth(object oPC, object oDM = OBJECT_INVALID, int valueCap = 0) {
    int wealth=0;
    int value;
    object oItem = GetFirstItemInInventory(oPC);
    while(GetIsObjectValid(oItem)) {
        value = GetItemValue(oItem);
        wealth += value;
        //SendMessageToAllDMs(GetName(oItem) + ": " + IntToString(value));
        if(GetIsObjectValid(oDM) && value > valueCap) {
            SendMessageToPC(oDM, GetName(oItem) + ": " + IntToString(value));
        }
        oItem = GetNextItemInInventory(oPC);
    }

    oItem = GetItemInSlot(INVENTORY_SLOT_ARMS, oPC);
    value = GetItemValue(oItem);
    if(GetIsObjectValid(oDM) && value > valueCap) {
            SendMessageToPC(oDM, GetName(oItem) + ": " + IntToString(value));
    }
    wealth += value;

    oItem = GetItemInSlot(INVENTORY_SLOT_ARROWS, oPC);
    value = GetItemValue(oItem);
    if(GetIsObjectValid(oDM) && value > valueCap) {
            SendMessageToPC(oDM, GetName(oItem) + ": " + IntToString(value));
    }
    wealth += value;

    oItem = GetItemInSlot(INVENTORY_SLOT_BELT, oPC);
    value = GetItemValue(oItem);
    if(GetIsObjectValid(oDM) && value > valueCap) {
            SendMessageToPC(oDM, GetName(oItem) + ": " + IntToString(value));
    }
    wealth += value;

    oItem = GetItemInSlot(INVENTORY_SLOT_BOLTS, oPC);
    value = GetItemValue(oItem);
    if(GetIsObjectValid(oDM) && value > valueCap) {
            SendMessageToPC(oDM, GetName(oItem) + ": " + IntToString(value));
    }
    wealth += value;

    oItem = GetItemInSlot(INVENTORY_SLOT_BOOTS, oPC);
    value = GetItemValue(oItem);
    if(GetIsObjectValid(oDM) && value > valueCap) {
            SendMessageToPC(oDM, GetName(oItem) + ": " + IntToString(value));
    }
    wealth += value;

    oItem = GetItemInSlot(INVENTORY_SLOT_BULLETS, oPC);
    value = GetItemValue(oItem);
    if(GetIsObjectValid(oDM) && value > valueCap) {
            SendMessageToPC(oDM, GetName(oItem) + ": " + IntToString(value));
    }
    wealth += value;

    oItem = GetItemInSlot(INVENTORY_SLOT_CHEST, oPC);
    value = GetItemValue(oItem);
    if(GetIsObjectValid(oDM) && value > valueCap) {
            SendMessageToPC(oDM, GetName(oItem) + ": " + IntToString(value));
    }
    wealth += value;

    oItem = GetItemInSlot(INVENTORY_SLOT_CLOAK, oPC);
    value = GetItemValue(oItem);
    if(GetIsObjectValid(oDM) && value > valueCap) {
            SendMessageToPC(oDM, GetName(oItem) + ": " + IntToString(value));
    }
    wealth += value;

    oItem = GetItemInSlot(INVENTORY_SLOT_HEAD, oPC);
    value = GetItemValue(oItem);
    if(GetIsObjectValid(oDM) && value > valueCap) {
            SendMessageToPC(oDM, GetName(oItem) + ": " + IntToString(value));
    }
    wealth += value;

    oItem = GetItemInSlot(INVENTORY_SLOT_LEFTHAND, oPC);
    value = GetItemValue(oItem);
    if(GetIsObjectValid(oDM) && value > valueCap) {
            SendMessageToPC(oDM, GetName(oItem) + ": " + IntToString(value));
    }
    wealth += value;

    oItem = GetItemInSlot(INVENTORY_SLOT_LEFTRING, oPC);
    value = GetItemValue(oItem);
    if(GetIsObjectValid(oDM) && value > valueCap) {
            SendMessageToPC(oDM, GetName(oItem) + ": " + IntToString(value));
    }
    wealth += value;

    oItem = GetItemInSlot(INVENTORY_SLOT_NECK, oPC);
    value = GetItemValue(oItem);
    if(GetIsObjectValid(oDM) && value > valueCap) {
            SendMessageToPC(oDM, GetName(oItem) + ": " + IntToString(value));
    }
    wealth += value;

    oItem = GetItemInSlot(INVENTORY_SLOT_RIGHTHAND, oPC);
    value = GetItemValue(oItem);
    if(GetIsObjectValid(oDM) && value > valueCap) {
            SendMessageToPC(oDM, GetName(oItem) + ": " + IntToString(value));
    }
    wealth += value;

    oItem = GetItemInSlot(INVENTORY_SLOT_RIGHTRING, oPC);
    value = GetItemValue(oItem);
    if(GetIsObjectValid(oDM) && value > valueCap) {
            SendMessageToPC(oDM, GetName(oItem) + ": " + IntToString(value));
    }
    wealth += value;

    wealth += GetGold(oPC);

    return wealth;
}

int GetLevelTargetWealthAverage(int level) {
    switch(level) {
        case 1:
            return 300;
            break;

        case 2:
            return 1175;
            break;

        case 3:
            return 3500;
            break;

        case 4:
            return 7025;
            break;

        case 5:
            return 11700;
            break;

        case 6:
            return 16900;
            break;

        case 7:
            return 24700;
            break;

        case 8:
            return 35100;
            break;

        case 9:
            return 46800;
            break;

        case 10:
            return 63700;
            break;

        case 11:
            return 85800;
            break;

        case 12:
            return 114400;
            break;

        case 13:
            return 143000;
            break;

        case 14:
            return 195000;
            break;

        case 15:
            return 260000;
            break;

        case 16:
            return 338000;
            break;

        case 17:
            return 442000;
            break;

        case 18:
            return 572000;
            break;

        case 19:
            return 754000;
            break;

        case 20:
            return 988000;
            break;
    }
    return 0;
}

int factorial(int num) {
    int i, ans=0;

    for(i=1; i<=num; i++) {
        ans += i;
    }

    return ans;
}

struct WealthStruct GetWealthInfo(object oPC) {
    struct WealthStruct info;

    info.wealth = GetTotalWealth(oPC);

    int level = GetHitDice(oPC);
    int thisLevelAverageWealth = GetLevelTargetWealthAverage(level);
    int nextLevelAverageWealth = GetLevelTargetWealthAverage(level + 1);

    int thisLevelXP = factorial(level - 1) * 1000;
    if(GetIsPC(oPC)) {
        info.percentXPToNextLevel = IntToFloat(GetXP(oPC) - thisLevelXP) / IntToFloat(level * 1000);
        info.averageLevel = FloatToInt( (info.percentXPToNextLevel * nextLevelAverageWealth) + ((1 - info.percentXPToNextLevel) * thisLevelAverageWealth) );
        info.highLevel = FloatToInt(info.averageLevel * 1.45);
        info.limitLevel = FloatToInt(info.averageLevel * 1.95);
        info.lowLevel = FloatToInt(info.averageLevel * 0.55);

        if(info.wealth >= info.limitLevel)
            info.position = ALFA_WEALTH_POSITION_OVER_LIMIT;
            else if(info.wealth >= info.highLevel)
                info.position = ALFA_WEALTH_POSITION_HIGH;
                else if(info.wealth >= info.averageLevel)
                    info.position = ALFA_WEALTH_POSITION_AVERAGE;
                    else if(info.wealth >= info.lowLevel)
                        info.position = ALFA_WEALTH_POSITION_LOW;
                        else info.position = ALFA_WEALTH_POSITION_VERY_LOW;
    }

    return info;
}

string GetWealthPositionAsString(int position) {

    switch(position) {
        case ALFA_WEALTH_POSITION_VERY_LOW:
            return "BELOW THE LOW MARK.";
        case ALFA_WEALTH_POSITION_LOW:
            return "Between low and average.";
        case ALFA_WEALTH_POSITION_AVERAGE:
            return "Between average and high.";
        case ALFA_WEALTH_POSITION_HIGH:
            return "Between high and the limit.";
        case ALFA_WEALTH_POSITION_OVER_LIMIT:
            return "OVER THE MAXIMUM LIMIT.";
    }
    return "ERROR";
}

void PrintWealthInfo(object oDM, object oPC) {

    if(!GetIsObjectValid(oDM) || !GetIsObjectValid(oPC))
        return;

    SendMessageToPC(oDM, "----------------------------------");
    SendMessageToPC(oDM, GetName(oPC) + "'s wealth report:");
    SendMessageToPC(oDM, "------------------");

    int wealth = GetTotalWealth(oPC, oDM, 49);
    int level = GetHitDice(oPC);

    int thisLevelAverageWealth = GetLevelTargetWealthAverage(level);
    int nextLevelAverageWealth = GetLevelTargetWealthAverage(level + 1);

    int thisLevelXP = factorial(level - 1) * 1000;
    float percentToNextLevel = IntToFloat(GetXP(oPC) - thisLevelXP) / IntToFloat(level * 1000);
    int targetAverageWealth = FloatToInt( (percentToNextLevel * nextLevelAverageWealth) + ((1 - percentToNextLevel) * thisLevelAverageWealth) );
    int highWealth = FloatToInt(targetAverageWealth * 1.45);
    int limitWealth = FloatToInt(targetAverageWealth * 1.95);
    int lowWealth = FloatToInt(targetAverageWealth * 0.55);

    string statusString;
    if(wealth >= limitWealth)
        statusString = "OVER THE LIMIT";
        else if(wealth >= highWealth)
            statusString = "HIGH";
            else if(wealth >= targetAverageWealth)
                statusString = "AVERAGE";
                else if(wealth >= lowWealth)
                    statusString = "LOW";
                    else statusString = "VERY LOW";

    SendMessageToPC(oDM, "------------------");
    SendMessageToPC(oDM, "Current wealth: " + IntToString(wealth));
    SendMessageToPC(oDM, FloatToString(percentToNextLevel * 100, 2, 0) + "% to next level.");
    SendMessageToPC(oDM, "Current wealth status is: " + statusString);
    SendMessageToPC(oDM, "Weath targets:");
    SendMessageToPC(oDM, "Low: " + IntToString(lowWealth));
    SendMessageToPC(oDM, "Average: " + IntToString(targetAverageWealth));
    SendMessageToPC(oDM, "High: " + IntToString(highWealth));
    SendMessageToPC(oDM, "Limit: " + IntToString(limitWealth));
    SendMessageToPC(oDM, "----------------------------------");
}

int GetMaxGoldStaticValue(float CR) {
// y = a( atan(x) ) + b( x^0.5 ) + c( x^2 ) + d( x^-0.5 ) + offset
// sum of squared absolute error: 0.818283605737
    float temp = 0.0;
    // coefficients
    //float a = -4.4591625155394766E+01;
    //float b = -3.4622885497300318E+00;
    //float c = 1.5050001915248019E+00;
    //float d = -5.5337992613520342E+01;
    //float e = 9.5320737675283837E+01;
    float a = -40.4591625155394766;
    float b = -3.4622885497300318;
    float c = 1.5050001915248019;
    float d = -50.5337992613520342;
    float e = 90.5320737675283837;

    temp += a * atan(CR);
    temp += b * pow(CR, 0.5);
    temp += c * pow(CR, 2.0);
    temp += d * pow(CR, -0.5);
    temp += e;
    //int gold = temp;
    return FloatToInt(temp);
}

int GetAverageStaticValue(float CR) {
    return GetMaxGoldStaticValue(CR) * 2;
}

int GetMaxStaticValue(float CR) {
    return GetMaxGoldStaticValue(CR) * 4;
}
