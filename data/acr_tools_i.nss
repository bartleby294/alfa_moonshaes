////////////////////////////////////////////////////////////////////////////////
//
//  System Name : ALFA Core Rules
//     Filename : acr_tools_i.nss
//      Version : 0.1
//         Date : 4/1/06
//       Author : Ronan
//
//  Local Variable Prefix = None, stand-alone functions shouldn't need any!
//
//  Description
//  Various tools used in conjuction with the ALFA core scripts. Only stand-
//  alone functions should go here! Anything more complex should get its own
//  file.
//
//  Revision History
////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////
// Includes ////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////
// Constants ///////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////

const int BIT_1     = 1;
const int BIT_2     = 2;
const int BIT_3     = 4;
const int BIT_4     = 8;
const int BIT_5     = 16;
const int BIT_6     = 32;
const int BIT_7     = 64;
const int BIT_8     = 128;
const int BIT_9     = 256;
const int BIT_10    = 512;
const int BIT_11    = 1024;
const int BIT_12    = 2048;
const int BIT_13    = 4096;
const int BIT_14    = 8192;
const int BIT_15    = 16384;
const int BIT_16    = 32768;
const int BIT_17    = 65536;
const int BIT_18    = 131072;
const int BIT_19    = 262144;
const int BIT_20    = 524288;
const int BIT_21    = 1048576;
const int BIT_22    = 2097152;
const int BIT_23    = 4194304;
const int BIT_24    = 8388608;
const int BIT_25    = 16777216;
const int BIT_26    = 33554432;
const int BIT_27    = 67108864;
const int BIT_28    = 134217728;
const int BIT_29    = 268435456;
const int BIT_30    = 536870912;
const int BIT_31    = 1073741824;
const int BIT_32    = 2147483648;

const int MAX_INT = 2147483647;
const int MIN_INT = -2147483648;
const float MAX_FLOAT = 340282300000000000000000000000000000000.0;
const float MIN_FLOAT = -340282300000000000000000000000000000000.0;

const int INT_SIZE = 32;

const int DAYS_PER_MONTH = 28;

const float PC_PERCEPTION_RANGE = 40.0;

const int ARMOR_TYPE_INVALID = 0;
const int ARMOR_TYPE_CLOTHING = 1;
const int ARMOR_TYPE_LIGHT = 2;
const int ARMOR_TYPE_MEDIUM = 3;
const int ARMOR_TYPE_HEAVY = 4;

////////////////////////////////////////////////////////////////////////////////
// Structures //////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////
// Global Variables ////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////
// Function Prototypes /////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////

// Gets the effective caster level oPC has in nClass's spell list.
// Returns 0 on error.
int GetClassCasterLevel(int nClass, object oPC);

// Returns the ability score (one of the ABILITY_* constants) nClasses uses
// to cast spells.
// Returns 0 on error.
int GetCasterClassAbilityScore(int nClass);

// Destroy oObject's inventory, but does not touch equiped items.
// Returns the number of items destroyed.
//int DestroyInventory(object oObject);

// Returns a string which uniquely identifies oObject.
// This functions on PCs, DMs and other objects, but only PC and DM values will
// still be valid after a server reset, and even those could change if a player
// changes his player name.
// In other words, don't expect this to work 100% of the time across PC logouts.
string GetUniqueIdentifierForObject(object oObject);

// Returns an area based on its tag and resref.
// Returns OBJECT_INVALID if no matching area is found.
object GetAreaFromTagAndResref(string sResRef, string sTag);

// Returns a location in oNewArea with the same position and facing as
// lOldLocation.
location GetLocationInDifferentArea(location lOldLocation, object oNewArea);

// Sets oCreature's hit points to nHp, healing or harming the target as is
// necissary. Any damage delt is done using nDamageType.
// This function cannot set a creature's hit points above its maximum, and it
// does not account for damage resistances or immunities to nDamageType.
void SetHitPoints(object oCreature, int nHp, int nDamageType);

// If nInt is less than nMin, nMin is returned.
// If nInt is greater than nMax, nMax is returned.
// Otherwise nInt is returned.
int ApplyIntegerLimit(int nInt, int nMin, int nMax);

// Returns the experience points normal creatures need to reach nLevel;
int GetXpNeededForLevel(int nLevel);

// Returns 1 if oArea is an area, 0 otherwise.
int GetIsArea(object oArea);

// Increments local integer sVarName on oObject by nIncrement, then returns the
// final value.
int IncrementLocalInt(object oObject, string sVarName, int nIncrement);

// Increments local float sVarName on oObject by fIncrement, then returns the
// final value.
float IncrementLocalFloat(object oObject, string sVarName, float fIncrement);

// Sets the nBit of local integer sVarName on oObject to 1 if nValue is nonzero.
// Otherwise, sets the bit to 0.
int SetLocalBit(object oObject, string sVarName, int nBit, int nValue);

// Generates a random float value between fMin and fMax.
// Does not error checking on inputs.
float RandomFloat(float fMin = 0.0, float fMax = 1.0);

// Makes a new interger out of nNum, starting at bit nStartBit and ending at
// nEndBit.
// Does not error checking on inputs. Valid values for nStartBit and nEndBit are
// from 1 to INT_MAX.
int GetPiecewiseInteger(int nNum, int nStartBit, int nEndBit);

// Returns an object's name, tag and resref in a string, in the form:
// [Name] (tagged [Tag] of resref [ResRef])
string GetObjectInfoAsString(object oObject);

// Returns the type of an object as a string ("creature", "item", "door", etc).
string GetObjectTypeName(int nObjectType);

// Returns the name of oItem's base item type, or "" if there is an error.
string GetBaseItemTypeName(object oItem);

// Returns oItem's armor class before any item properties are taken into
// account. Returns -1 if oItem is not armor.
int GetBaseArmorClass(object oItem);

// Returns oItem's spell failure % before any item properties are taken into
// account. Returns -1 if oItem is not armor.
int GetBaseSpellFailure(object oItem);

// Returns a string of the type of armor oArmor is. Possible results are:
// "padded", "leather", "studded leather", "chain shirt", "hide", "scail mail",
// "chainmail", "breastplate", "splint mail", "banded mail", "half plate",
// "full plate".
string GetArmorTypeName(object oArmor);

// Gets the greatest property associated with item property of type nPropertyType
// on item oItem. Returns 0 if oItem is not an item, or if no such item property
// is found.
int GetHighestItemPropertyParam1(object oItem, int nType);

// Gets the greatest value associated with item property of type nPropertyType
// on item oItem. Returns 0 if oItem is not an item, or if no such item property
// is found.
int GetHighestItemPropertyParam1Value(object oItem, int nType);

// Returns the SKILL_KNOWLEDGE_* constant of the skill which indicates knowlege
// of race nRace. Returns -1 on an error, or if there is no appropriate skill.
// Follows the D20 SRD.
//int GetKnowlegeSkillOfRace(int nRace);

// Returns 1 if there is a PC, DM, or DM-possesssed creature in oArea.
// Returns 0 otherwise.
int GetArePCsInArea(object oArea);

// Gets the first item possessed by oCreature that has a resref sResRef.
// Returns OBJECT_INVALID if nothing is found.
object GetItemOfResRefPossessedBy(object oCreature, string sResRef);

// Returns 1 if nNum is in the window defined by nStart and nEnd. The window can
// be circular, so that nEnd wraps around and has a lower value than nStart.
int GetIsIntegerInWindow(int nNum, int nStart, int nEnd);

//! Returns the number of seconds until the time specified in the arguments.
int GetSecondsUntil(int nYear, int nMonth, int nDay, int nHour, int nMinute, int nSecond);

//! Gets a local integer from oObject, adds it to a bitwise boolean nFlags at
//! bit nBit, and deletes the original local integer.
int CombineBooleanLocalInt(int nFlags, object oObject, string sVarName, int nBit);

//! Returns the EffectMovementSpeedIncrease() (or decrease) effect needed to
//! increase oCreature's speed as if oCreature did not have any feats and class
//! altered increasing his speed. In other words, this function returns an
//! reduced movement compinsating for hard-coded movement speed feats like
//! barbarian endurance and monk speed.
//!   - fMovementChange: The desired movement speed modifier, with 1.0 being no change, 1.5 being 50% faster, and 0.5 being 50% slower.
effect EffectAdjustedMovementSpeed(object oCreature, float fMovementChange);

//! Returns the ARMOR_TYPE_* constant corresponding to the type of armor passed,
//! or ARMOR_TYPE_INVALID if oItem is not a valid armor item.
int GetArmorType(object oItem);

//! Sets oPC's skill to nRanks, increasing or decreasing it as necissary.
effect EffectSetSkillTo(object oPC, int nSkill, int nRanks);

////////////////////////////////////////////////////////////////////////////////
// Function Definitions ////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////

int GetClassCasterLevel(int nClass, object oPC) {
    int nLevels = GetLevelByClass(nClass, oPC);
    if(nClass == CLASS_TYPE_PALADIN || nClass == CLASS_TYPE_RANGER)
        {
        if(nLevels < 4)
        {
            return 0;
        }
        return nLevels / 2;
    } else {
        return GetLevelByClass(nClass, oPC);
    }
}

int GetCasterClassAbilityScore(int nClass) {
    switch(nClass) {
        case CLASS_TYPE_BARD:
        case CLASS_TYPE_SORCERER:
            return ABILITY_CHARISMA;

        case CLASS_TYPE_WIZARD:
            return ABILITY_INTELLIGENCE;

        case CLASS_TYPE_CLERIC:
        case CLASS_TYPE_DRUID:
        case CLASS_TYPE_PALADIN:
        case CLASS_TYPE_RANGER:
            return ABILITY_WISDOM;
    }
    return 0;
}

/*int DestroyInventory(object oObject) {
    object oItem = GetFirstItemInInventory();
    int nCount = 0;

    while(GetIsObjectValid(oItem)) {
        DestroyObject(oItem);
        nCount++;
    }
    return nCount;
}*/

string GetUniqueIdentifierForObject(object oObject) {
    if(GetIsPC(oObject) || GetIsDM(oObject)) {
        return GetPCPlayerName(oObject) + GetName(oObject);
    } else {
        return ObjectToString(oObject);
    }
}

object GetAreaFromTagAndResref(string sResRef, string sTag) {
    object oArea;
    int i = 0;
    while(TRUE) {
        oArea = GetObjectByTag(sTag, i);
        if(oArea == OBJECT_INVALID) {
            return OBJECT_INVALID;
        } else if(GetTag(oArea) == sTag) {
            return oArea;
        }
    }
    return OBJECT_INVALID;
}

location GetLocationInDifferentArea(location lOldLocation, object oNewArea) {
    return Location(oNewArea, GetPositionFromLocation(lOldLocation), GetFacingFromLocation(lOldLocation));
}

void SetHitPoints(object oCreature, int nHp, int nDamageType) {
    int nCurrentHp = GetCurrentHitPoints(oCreature);
    int nMaxHp = GetMaxHitPoints(oCreature);
    if(nHp > nCurrentHp) {
        ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectHeal(nHp), oCreature);
    } else if(nHp < nCurrentHp) {
        ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectDamage(nHp, nDamageType), oCreature);
    }
}

int ApplyIntegerLimit(int nInt, int nMin, int nMax) {
    if(nInt < nMin) {
        return nMin;
    } else if(nInt > nMax) {
        return nMax;
    } else {
        return nInt;
    }
}

int GetXpNeededForLevel(int nLevel) {
    return FloatToInt(1000 * (nLevel - 1) * ( IntToFloat(nLevel) / 2.0 ));
}

int GetIsArea(object oArea) {
    return (GetIsAreaNatural(oArea) != AREA_INVALID);
}

int IncrementLocalInt(object oObject, string sVarName, int nIncrement) {
    int num = GetLocalInt(oObject, sVarName);
    num += nIncrement;
    SetLocalInt(oObject, sVarName, num);
    return num;
}

float IncrementLocalFloat(object oObject, string sVarName, float fIncrement) {
    float num = GetLocalFloat(oObject, sVarName);
    num += fIncrement;
    SetLocalFloat(oObject, sVarName, num);
    return num;
}

int SetLocalBit(object oObject, string sVarName, int nBit, int nValue) {
    int nNum = GetLocalInt(oObject, sVarName);
    if(nValue) {
        nNum | (1 << nBit);
    } else {
        nNum & (0 << nBit);
    }
    SetLocalInt(oObject, sVarName, nNum);
    return nNum;
}

float RandomFloat(float fMin = 0.0, float fMax = 1.0) {
    return (fMax - fMin) * IntToFloat(Random(MAX_INT)) / IntToFloat(MAX_INT) - fMin;
}

int GetPiecewiseInteger(int nNum, int nStartBit, int nEndBit) {
    int nShift = INT_SIZE - nEndBit;
    nNum = nNum << nShift;
    return ( nNum >>> (nShift - nStartBit + 1 ) );
}

string GetObjectInfoAsString(object oObject) {
    return GetName(oObject) + " (tagged '" + GetTag(oObject) + "' of resref '" + GetResRef(oObject) + "')";
}

string GetObjectTypeName(int nObjectType) {
    switch(nObjectType) {
        case OBJECT_TYPE_ALL:
            return "all";
        case OBJECT_TYPE_AREA_OF_EFFECT:
            return "area of effect";
        case OBJECT_TYPE_CREATURE:
            return "creature";
        case OBJECT_TYPE_DOOR:
            return "door";
        case OBJECT_TYPE_ENCOUNTER:
            return "encounter";
        case OBJECT_TYPE_ITEM:
            return "item";
        case OBJECT_TYPE_PLACEABLE:
            return "placable";
        case OBJECT_TYPE_STORE:
            return "store";
        case OBJECT_TYPE_TRIGGER:
            return "trigger";
        case OBJECT_TYPE_WAYPOINT:
            return "waypoint";
    }
    return "invalid";
}

string GetBaseItemTypeName(object oItem) {
    if(!GetIsObjectValid(oItem) || GetObjectType(oItem) != OBJECT_TYPE_ITEM) {
        return "";
    }

    switch(GetBaseItemType(oItem)) {
        case BASE_ITEM_AMULET:
            return "amulet";
        case BASE_ITEM_ARMOR:
            return "armor";
        case BASE_ITEM_ARROW:
            return "arrow";
        case BASE_ITEM_BASTARDSWORD:
            return "bastard sword";
        case BASE_ITEM_BATTLEAXE:
            return "battle axe";
        case BASE_ITEM_BELT:
            return "belt";
        case BASE_ITEM_BLANK_POTION:
            return "blank potion";
        case BASE_ITEM_BLANK_SCROLL:
            return "blank scroll";
        case BASE_ITEM_BLANK_WAND:
            return "blank wand";
        case BASE_ITEM_BOLT:
            return "bolt";
        case BASE_ITEM_BOOK:
            return "book";
        case BASE_ITEM_BOOTS:
            return "boots";
        case BASE_ITEM_BRACER:
            return "bracer";
        case BASE_ITEM_BULLET:
            return "bullet";
        case BASE_ITEM_CBLUDGWEAPON:
            return "creature bludgeoning weapon";
        case BASE_ITEM_CLUB:
            return "club";
        case BASE_ITEM_CPIERCWEAPON:
            return "creature pierce weapon";
        case BASE_ITEM_CRAFTMATERIALMED:
            return "craft material medium";
        case BASE_ITEM_CRAFTMATERIALSML:
            return "craft material small";
        case BASE_ITEM_CREATUREITEM:
            return "creature hide";
        case BASE_ITEM_CSLASHWEAPON:
            return "creature slash weapon";
        case BASE_ITEM_CSLSHPRCWEAP:
            return "creature slashing and piercing weapon";
        case BASE_ITEM_DAGGER:
            return "dagger";
        case BASE_ITEM_DART:
            return "dart";
        case BASE_ITEM_DIREMACE:
            return "dire mace";
        case BASE_ITEM_DOUBLEAXE:
            return "double axe";
        case BASE_ITEM_DWARVENWARAXE:
            return "dwarven war axe";
        case BASE_ITEM_ENCHANTED_POTION:
            return "enchanted potion";
        case BASE_ITEM_ENCHANTED_SCROLL:
            return "enchanted scroll";
        case BASE_ITEM_ENCHANTED_WAND:
            return "enchanted wand";
        case BASE_ITEM_GEM:
            return "gem";
        case BASE_ITEM_GLOVES:
            return "gloves";
        case BASE_ITEM_GOLD:
            return "gold";
        case BASE_ITEM_GREATAXE:
            return "greataxe";
        case BASE_ITEM_GREATSWORD:
            return "greatsword";
        case BASE_ITEM_GRENADE:
            return "grenade";
        case BASE_ITEM_HALBERD:
            return "halberd";
        case BASE_ITEM_HANDAXE:
            return "handaxe";
        case BASE_ITEM_HEALERSKIT:
            return "healer's kit";
        case BASE_ITEM_HEAVYCROSSBOW:
            return "heavy crossbow";
        case BASE_ITEM_HEAVYFLAIL:
            return "heavy flail";
        case BASE_ITEM_HELMET:
            return "helmet";
        case BASE_ITEM_INVALID:
            return "invalid";
        case BASE_ITEM_KAMA:
            return "kama";
        case BASE_ITEM_KATANA:
            return "katana";
        case BASE_ITEM_KEY:
            return "key";
        case BASE_ITEM_KUKRI:
            return "kukri";
        case BASE_ITEM_LARGEBOX:
            return "large box";
        case BASE_ITEM_LARGESHIELD:
            return "large shield";
        case BASE_ITEM_LIGHTCROSSBOW:
            return "light crossbow";
        case BASE_ITEM_LIGHTFLAIL:
            return "light flail";
        case BASE_ITEM_LIGHTHAMMER:
            return "light hammer";
        case BASE_ITEM_LIGHTMACE:
            return "light mace";
        case BASE_ITEM_LONGBOW:
            return "longbow";
        case BASE_ITEM_LONGSWORD:
            return "longsword";
        case BASE_ITEM_MAGICROD:
            return "magic rod";
        case BASE_ITEM_MAGICSTAFF:
            return "magic staff";
        case BASE_ITEM_MAGICWAND:
            return "magic wand";
        case BASE_ITEM_MISCLARGE:
            return "miscellaneous large";
        case BASE_ITEM_MISCMEDIUM:
            return "miscellaneous medium";
        case BASE_ITEM_MISCSMALL:
            return "miscellaneous small";
        case BASE_ITEM_MISCTALL:
            return "miscellaneous tall";
        case BASE_ITEM_MISCTHIN:
            return "miscellaneous thin";
        case BASE_ITEM_MISCWIDE:
            return "miscellaneous wide";
        case BASE_ITEM_MORNINGSTAR:
            return "morningstar";
        case BASE_ITEM_POTIONS:
            return "potions";
        case BASE_ITEM_QUARTERSTAFF:
            return "quarterstaff";
        case BASE_ITEM_RAPIER:
            return "rapier";
        case BASE_ITEM_RING:
            return "ring";
        case BASE_ITEM_SCIMITAR:
            return "scimitar";
        case BASE_ITEM_SCROLL:
            return "scroll";
        case BASE_ITEM_SCYTHE:
            return "scythe";
        case BASE_ITEM_SHORTBOW:
            return "short bow";
        case BASE_ITEM_SHORTSPEAR:
            return "short spear";
        case BASE_ITEM_SHORTSWORD:
            return "short sword";
        case BASE_ITEM_SHURIKEN:
            return "shuriken";
        case BASE_ITEM_SICKLE:
            return "sickle";
        case BASE_ITEM_SLING:
            return "sling";
        case BASE_ITEM_SMALLSHIELD:
            return "small shield";
        case BASE_ITEM_SPELLSCROLL:
            return "spell scroll";
        case BASE_ITEM_THIEVESTOOLS:
            return "thieve's tools";
        case BASE_ITEM_THROWINGAXE:
            return "throwing axe";
        case BASE_ITEM_TORCH:
            return "torch";
        case BASE_ITEM_TOWERSHIELD:
            return "tower shield";
        case BASE_ITEM_TRAPKIT:
            return "trap kit";
        case BASE_ITEM_TRIDENT:
            return "trident";
        case BASE_ITEM_TWOBLADEDSWORD:
            return "two-bladed sword";
        case BASE_ITEM_WARHAMMER:
            return "warhammer";
        case BASE_ITEM_WHIP:
            return "whip";    }
    return "";
}

int GetBaseArmorClass(object oItem) {
    // FIX ME !!
    // This just doesn't work. Any way to get the AC of an item property?
    if(!GetIsObjectValid(oItem) || GetBaseItemType(oItem) != BASE_ITEM_ARMOR) {
        return -1;
    }
    //SendMessageToPC(GetFirstPC(), "Highest: " + IntToString(GetHighestItemPropertyParam1Value(oItem, ITEM_PROPERTY_AC_BONUS)));
    return GetAC(oItem) - GetHighestItemPropertyParam1Value(oItem, ITEM_PROPERTY_AC_BONUS);
}

int GetBaseSpellFailure(object oItem) {
    if(!GetIsObjectValid(oItem) || GetBaseItemType(oItem) != BASE_ITEM_ARMOR) {
        return -1;
    }
    return GetArcaneSpellFailure(oItem) + GetHighestItemPropertyParam1(oItem, ITEM_PROPERTY_ARCANE_SPELL_FAILURE);
}

string GetArmorTypeName(object oArmor) {
    // FIX ME !!!
    // Come NWN2, all 3.5 armor types?
    return "";
}

int GetHighestItemPropertyParam1Value(object oItem, int nType) {
    itemproperty ip = GetFirstItemProperty(oItem);
    int nMax;
    int bInitialized = 0;
    while( GetIsItemPropertyValid(ip) ) {
        if(GetItemPropertyType(ip) == nType) {
            int nValue = GetItemPropertyParam1Value(ip);

            if(nValue > nMax || !bInitialized) {
                nMax = nValue;
                bInitialized = 1;
            }
        }
        ip = GetNextItemProperty(oItem);
    }
    return nMax;
}

int GetHighestItemPropertyParam1(object oItem, int nType) {
    itemproperty ip = GetFirstItemProperty(oItem);
    int nMax = 0;
    while( GetIsItemPropertyValid(ip) ) {
        if(GetItemPropertyType(ip) == nType) {
            int nValue = GetItemPropertyParam1(ip);
            if(nValue > nMax) {
                nMax = nValue;
            }
        }
        ip = GetNextItemProperty(oItem);
    }
    return nMax;
}

/*int GetKnowlegeSkillOfRace(int nRace) {
    switch(nRace) {
        case RACIAL_TYPE_DRAGON:
        case RACIAL_TYPE_CONSTRUCT:
        case RACIAL_TYPE_MAGICAL_BEAST:
            return SKILL_KNOWLEDGE_ARCANA;

        case RACIAL_TYPE_ABERRATION:
        case RACIAL_TYPE_OOZE:
            return SKILL_KNOWLEDGE_DUNGEONEERING;

        case RACIAL_TYPE_ANIMAL:
        case RACIAL_TYPE_BEAST:
        case RACIAL_TYPE_FEY:
        case RACIAL_TYPE_GIANT:
        case RACIAL_TYPE_HUMANOID_MONSTROUS:
        case RACIAL_TYPE_HUMANOID_GOBLINOID:
        case RACIAL_TYPE_HUMANOID_ORC:
        case RACIAL_TYPE_HUMANOID_REPTILIAN:
        case RACIAL_TYPE_SHAPECHANGER:
        // FIX ME!! Racial type plant?
        case RACIAL_TYPE_VERMIN:
            return SKILL_KNOWLEDGE_NATURE;

        case RACIAL_TYPE_UNDEAD:
            return SKILL_KNOWLEDGE_RELIGION;

        case RACIAL_TYPE_OUTSIDER:
        case RACIAL_TYPE_ELEMENTAL:
            return SKILL_KNOWLEDGE_THE_PLANES;
    }
    return -1;
}*/

int GetArePCsInArea(object oArea) {
    object oPC = GetFirstPC();
    while(oPC != OBJECT_INVALID) {
        if(GetArea(oPC) == oArea) {
            return 1;
        }
        oPC = GetNextPC();
    }
    return 0;
}

object GetItemOfResRefPossessedBy(object oCreature, string sResRef) {
    object oItem = GetFirstItemInInventory(oCreature);

    while(oItem != OBJECT_INVALID) {
        if(GetResRef(oItem) == sResRef) {
            return oItem;
        }
        oItem = GetNextItemInInventory(oCreature);
    }
    return OBJECT_INVALID;
}

int GetIsIntegerInWindow(int nNum, int nStart, int nEnd) {
    return ( (nNum > nStart && ( nNum < nEnd || nEnd < nStart )) ||
             (nNum < nStart && nNum < nEnd) );
}

int GetSecondsUntil(int nYear, int nMonth, int nDay, int nHour, int nMinute, int nSecond) {
    int nTime = GetCalendarYear() - nYear;
    nTime = nTime * 12 + GetCalendarMonth() - nMonth;
    nTime = nTime * DAYS_PER_MONTH + GetCalendarDay() - nDay;
    nTime = nTime * 24 + GetTimeHour() - nHour;
    nTime = nTime * 60 + GetTimeMinute() - nMinute;
    return nTime * 60 + GetTimeSecond() - nSecond;
}

int CombineBooleanLocalInt(int nFlags, object oObject, string sVarName, int nBit) {
    if( GetLocalInt(oObject, sVarName) ) {
        nFlags = nFlags | nBit;
    }
    DeleteLocalInt(oObject, sVarName);
    return nFlags;
}

effect EffectAdjustedMovementSpeed(object oCreature, float fMovementChange) {
    if( GetHasFeat(FEAT_BARBARIAN_ENDURANCE, oCreature) ) {
        fMovementChange -= 0.1;
    }

    if( GetHasFeat(FEAT_MONK_ENDURANCE, oCreature) ) {
        // FIX ME !!!
        // GetArmorType doesn't work, because GetBaseArmorClass() doesn't work.
        // We'll assume the monk isn't wearing armor.
        //if( GetArmorType(GetItemInSlot(INVENTORY_SLOT_CHEST, oCreature)) != ARMOR_TYPE_CLOTHING ) {
            fMovementChange -= 0.1 * (GetLevelByClass(CLASS_TYPE_MONK, oCreature) / 3);
        //}
    }

    effect eMovement;
    if(fMovementChange > 1.0) {
        int nNum = FloatToInt((fMovementChange - 1.0) * 100);
        return EffectMovementSpeedIncrease( nNum );
    }
    int nNum = FloatToInt((1.0 - fMovementChange) * 100);
    return EffectMovementSpeedDecrease( nNum );
}

int GetArmorType(object oItem) {
    if(GetBaseItemType(oItem) != BASE_ITEM_ARMOR) {
        return ARMOR_TYPE_INVALID;
    }
    int nAC = GetBaseArmorClass(oItem);
    if(nAC < 1) {
        return ARMOR_TYPE_CLOTHING;
    } else if(nAC < 4) {
        return ARMOR_TYPE_LIGHT;
    } else if(nAC < 6) {
        return ARMOR_TYPE_MEDIUM;
    }
    return ARMOR_TYPE_HEAVY;
}

effect EffectSetSkillTo(object oPC, int nSkill, int nRanks) {
    int nModifier = nRanks - GetSkillRank(nSkill, oPC);

    if(nModifier > 0) {
        return EffectSkillIncrease(nSkill, nModifier);
    } else {
        int nAdjustment = nModifier - (nModifier * 2);
        return EffectSkillDecrease(nSkill, nAdjustment);
    }
}

