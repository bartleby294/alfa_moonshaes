#include "x0_i0_stringlib"
#include "_btb_craft_util"

/*
 * Get the weapon size for DC adjustment.
 */
int GetWeaponSize(object oWeapon) {

    if (GetBaseItemType(oWeapon) == BASE_ITEM_DAGGER
        || GetBaseItemType(oWeapon) == BASE_ITEM_SLING
        || GetBaseItemType(oWeapon) == BASE_ITEM_DART
        || GetBaseItemType(oWeapon) == BASE_ITEM_GLOVES
        || GetBaseItemType(oWeapon) == 213 //shovel
        || GetBaseItemType(oWeapon) == 215 //nunchuck
        || GetBaseItemType(oWeapon) == BASE_ITEM_KUKRI) {
        return WEAPON_TYPE_TINY;
    }

    if (GetBaseItemType(oWeapon) == BASE_ITEM_LIGHTMACE
        || GetBaseItemType(oWeapon) == BASE_ITEM_SICKLE
        || GetBaseItemType(oWeapon) == BASE_ITEM_ARROW
        || GetBaseItemType(oWeapon) == BASE_ITEM_BOLT
        || GetBaseItemType(oWeapon) == BASE_ITEM_BULLET
        || GetBaseItemType(oWeapon) == BASE_ITEM_HANDAXE
        || GetBaseItemType(oWeapon) == 212 //Pickaxe
        || GetBaseItemType(oWeapon) == 213 //Tools
        || GetBaseItemType(oWeapon) == 214 //Sai
        || GetBaseItemType(oWeapon) == 215 //Nunchuck
        || GetBaseItemType(oWeapon) == 216 //Tools
        || GetBaseItemType(oWeapon) == 217 //Lance
        || GetBaseItemType(oWeapon) == BASE_ITEM_SHORTSWORD
        || GetBaseItemType(oWeapon) == BASE_ITEM_SHORTSPEAR
        || GetBaseItemType(oWeapon) == BASE_ITEM_KAMA
        || GetBaseItemType(oWeapon) == BASE_ITEM_LIGHTHAMMER
        || GetBaseItemType(oWeapon) == BASE_ITEM_CLUB
        || GetBaseItemType(oWeapon) == BASE_ITEM_WHIP) {
        return WEAPON_TYPE_SMALL;
    }

    if (GetBaseItemType(oWeapon) == BASE_ITEM_MAGICSTAFF
        || GetBaseItemType(oWeapon) == BASE_ITEM_MORNINGSTAR
        || GetBaseItemType(oWeapon) == BASE_ITEM_BATTLEAXE
        || GetBaseItemType(oWeapon) == BASE_ITEM_THROWINGAXE
        || GetBaseItemType(oWeapon) == BASE_ITEM_LIGHTFLAIL
        || GetBaseItemType(oWeapon) == BASE_ITEM_LONGSWORD
        || GetBaseItemType(oWeapon) == BASE_ITEM_SCIMITAR
        || GetBaseItemType(oWeapon) == BASE_ITEM_WARHAMMER
        || GetBaseItemType(oWeapon) == BASE_ITEM_LIGHTCROSSBOW
        || GetBaseItemType(oWeapon) == BASE_ITEM_SHORTBOW) {
        return WEAPON_TYPE_MEDIUM;
    }

    if (GetBaseItemType(oWeapon) == BASE_ITEM_QUARTERSTAFF
        || GetBaseItemType(oWeapon) == BASE_ITEM_GREATAXE
        || GetBaseItemType(oWeapon) == BASE_ITEM_GREATSWORD
        || GetBaseItemType(oWeapon) == BASE_ITEM_HALBERD
        || GetBaseItemType(oWeapon) == BASE_ITEM_HEAVYFLAIL
        || GetBaseItemType(oWeapon) == BASE_ITEM_TRIDENT
        || GetBaseItemType(oWeapon) == 210 //greathammer
        || GetBaseItemType(oWeapon) == BASE_ITEM_SCYTHE) {
        return WEAPON_TYPE_LARGE;
    }

    if (GetBaseItemType(oWeapon) == BASE_ITEM_DIREMACE
        || GetBaseItemType(oWeapon) == BASE_ITEM_DOUBLEAXE
        || GetBaseItemType(oWeapon) == BASE_ITEM_TWOBLADEDSWORD
        || GetBaseItemType(oWeapon) == BASE_ITEM_BASTARDSWORD
        || GetBaseItemType(oWeapon) == BASE_ITEM_DWARVENWARAXE
        || GetBaseItemType(oWeapon) == BASE_ITEM_RAPIER
        || GetBaseItemType(oWeapon) == BASE_ITEM_LONGBOW
        || GetBaseItemType(oWeapon) == BASE_ITEM_HEAVYCROSSBOW
        || GetBaseItemType(oWeapon) == BASE_ITEM_KATANA) {
        return WEAPON_TYPE_HUGE;
    }

    SpeakString("Unknown Weapon Type:" + IntToString(GetBaseItemType(oWeapon)));

    return WEAPON_TYPE_UNKNOWN;
}

void AddRangerBonus(int feat, object oPC, int threshold, int nBonus,
                    int raceType, object oWeapon) {
    if (GetHasFeat(feat, oPC)
        && (d100() + (GetLevelByClass(CLASS_TYPE_RANGER, oPC) * 5)
            > threshold + (10 * nBonus)))

        AddItemProperty(DURATION_TYPE_PERMANENT,
            ItemPropertyDamageBonusVsRace(raceType, Random(3),
                Random(nBonus) + 1), oWeapon);
}

void RemoveWeaponProperty(object oWeapon, int iProperty)
{
    itemproperty nProperty = GetFirstItemProperty(oWeapon);
    while (GetIsItemPropertyValid(nProperty)) {
        if (GetItemPropertyType(nProperty) == iProperty)
            RemoveItemProperty(oWeapon, nProperty);
        nProperty = GetNextItemProperty(oWeapon);
    }
    return;
}
/**
 *  Remove any objects associated with weapon crafting from the anvil.
 */
void CleanItems()
{
    object oInventory = GetFirstItemInInventory(OBJECT_SELF);
    while (GetIsObjectValid(oInventory) == TRUE) {
        if(IsCraftWeaponItem(GetTag(oInventory))){
            DestroyObject(oInventory);
        }
        oInventory = GetNextItemInInventory(OBJECT_SELF);
    }
    return;
}

// Get the number of properties on an item for DC adjustment
int GetNumProperties(object oWeapon)
{
    int nNum = 0;
    itemproperty nProperty = GetFirstItemProperty(oWeapon);
    while (GetIsItemPropertyValid(nProperty)) {
        int nType = GetItemPropertyType(nProperty);
        if (!(nType == ITEM_PROPERTY_BASE_ITEM_WEIGHT_REDUCTION
            || nType == ITEM_PROPERTY_DAMAGE_VULNERABILITY
            || nType == ITEM_PROPERTY_DECREASED_ABILITY_SCORE
            || nType == ITEM_PROPERTY_DECREASED_AC
            || nType == ITEM_PROPERTY_DECREASED_ATTACK_MODIFIER
            || nType == ITEM_PROPERTY_DECREASED_DAMAGE
            || nType == ITEM_PROPERTY_DECREASED_ENHANCEMENT_MODIFIER
            || nType == ITEM_PROPERTY_DECREASED_SAVING_THROWS
            || nType == ITEM_PROPERTY_DECREASED_SAVING_THROWS_SPECIFIC
            || nType == ITEM_PROPERTY_DECREASED_SKILL_MODIFIER
            || nType == ITEM_PROPERTY_NO_DAMAGE
            || nType == ITEM_PROPERTY_USE_LIMITATION_ALIGNMENT_GROUP
            || nType == ITEM_PROPERTY_USE_LIMITATION_CLASS
            || nType == ITEM_PROPERTY_USE_LIMITATION_RACIAL_TYPE
            || nType == ITEM_PROPERTY_USE_LIMITATION_SPECIFIC_ALIGNMENT
            || nType == ITEM_PROPERTY_WEIGHT_INCREASE)) {
            nNum++;
        }

        nProperty = GetNextItemProperty(oWeapon);
    }

    return nNum;
}

int GetSizeDC(int iSize, object oPC) {

    if (iSize == WEAPON_TYPE_TINY) {
        return -4;
    } else if (iSize == WEAPON_TYPE_SMALL) {
        return -2;
    } else if (iSize == WEAPON_TYPE_MEDIUM) {
        return 0;
    } else if (iSize == WEAPON_TYPE_LARGE) {
        return 1;
    } else if (iSize == WEAPON_TYPE_HUGE) {
        return 4;
    }

    return 4;
}

int GetGoldPieceDCValue(int iValue) {

    if (iValue <= 15) {
        return -5;
    } else if (iValue > 15 && iValue <= 120) {
        return 0;
    } else if (iValue > 120 && iValue <= 850) {
        return 2;
    } else if (iValue > 850 && iValue <= 1620) {
        return 3;
    } else if (iValue > 1620 && iValue <= 3000) {
        return 4;
    } else if (iValue > 3000 && iValue <= 6000) {
        return 5;
    } else if (iValue > 6000 && iValue <= 9000) {
        return 6;
    } else if (iValue > 9000 && iValue <= 12000) {
        return 8;
    } else if (iValue > 12000) {
        return 10;
    }

    return 10;
}

int GetNumPropertiesDC(int iProperty) {

    if (iProperty == 0) {
        return -2;
    } else {
        return (iProperty * iProperty) - (2 * iProperty) + 2;
    }

    return (iProperty * iProperty) - (2 * iProperty) + 2;
}

int GetBaseModDC() {

    int iModDC = -1;
    if (HasItem(IRON_INGOT_TAG)) {
        iModDC = 0;
    }
    else if (HasItem(SILVER_INGOT_TAG)) {
        iModDC = 1;
        if (HasItem(OBSIDIAN_INGOT_TAG)) {
            iModDC = iModDC + 5;
        }
    }
    else if (HasItem(COLD_INGOT_TAG)) {
        iModDC = 1;
        if (HasItem(OBSIDIAN_INGOT_TAG)) {
            iModDC = iModDC + 5;
        }
    }
    else if (HasItem(DARK_STEEL_INGOT_TAG)) {
        iModDC = 2;
        if (HasItem(OBSIDIAN_INGOT_TAG)) {
            iModDC = iModDC + 5;
        }
    }
    else if (HasItem(ADAMANTIUM_INGOT_TAG)) {
        iModDC = 4;
        if (HasItem(OBSIDIAN_INGOT_TAG)) {
            iModDC = iModDC + 5;
        }
    }
    else if (HasItem(MITHRAL_INGOT_TAG)) {
        iModDC = 6;
        if (HasItem(OBSIDIAN_INGOT_TAG)) {
            iModDC = iModDC + 5;
        }
    }

    return iModDC;
}

void GoodEffect(object oWeapon, object oPC, int nBonus) {

    int nSkill;
    int nSave;
    int nDamageType;
    int nAlignGroup;
    int nAlignGroupOp;
    int iMultiplier = 0;
    int randPercent = Random(100);
    int nAbility = GetHighAbility(oPC);

    // Weight Reduction
    AddItemProperty(DURATION_TYPE_PERMANENT,
        ItemPropertyWeightReduction(nBonus), oWeapon);

    // Random Skill/Save/Ability Bonus
    if (randPercent >= 20) {
        // Pick saving throws and skills.
        if (nAbility == ABILITY_STRENGTH) {
            nSave = IP_CONST_SAVEBASETYPE_FORTITUDE;
            nSkill = RandomStrSkill();
            SendMessageToPC(oPC, "Some of your Strength goes into the weapon");
        } else if (nAbility == ABILITY_DEXTERITY) {
            nSave = IP_CONST_SAVEBASETYPE_REFLEX;
            nSkill = RandomDexSkill();
            SendMessageToPC(oPC, "Some of your Dexterity goes into the weapon");
        } else if (nAbility == ABILITY_CONSTITUTION) {
            nSave = IP_CONST_SAVEBASETYPE_FORTITUDE;
            nSkill = RandomConSkill();
            SendMessageToPC(oPC, "Some of your Constitution goes into the weapon");
        } else if (nAbility == ABILITY_INTELLIGENCE) {
            nSave = IP_CONST_SAVEBASETYPE_WILL;
            nSkill = RandomIntSkill();
            SendMessageToPC(oPC, "Some of your Intellect goes into the weapon");
        } else if (nAbility == ABILITY_WISDOM) {
            nSave = IP_CONST_SAVEBASETYPE_WILL;
            nSkill = RandomWisSkill();
            SendMessageToPC(oPC, "Some of your Wisdom goes into the weapon");
        } else if (nAbility == ABILITY_CHARISMA) {
            nSave = IP_CONST_SAVEBASETYPE_REFLEX;
            nSkill = RandomCharSkill();
            SendMessageToPC(oPC, "Some of your Charm goes into the weapon");
        }

        // 20% - 50% add skill bonus
        if (randPercent <= 50) {
            AddItemProperty(DURATION_TYPE_PERMANENT,
                ItemPropertySkillBonus(nSkill, Random(nBonus) + 1), oWeapon);
        // 50% - 90% add saving throw bonus
        } else if (randPercent <= 90) {
            if (nAbility == ABILITY_CHARISMA) {
                AddItemProperty(DURATION_TYPE_PERMANENT,
                    ItemPropertyBonusSavingThrowVsX(IP_CONST_SAVEVS_UNIVERSAL,
                        Random(nBonus) + 1), oWeapon);
            } else {
                AddItemProperty(DURATION_TYPE_PERMANENT,
                    ItemPropertyBonusSavingThrow(nSave, Random(nBonus) + 1),
                        oWeapon);
            }
        // 90% - 100% add ability bonus
        } else {
            AddItemProperty(DURATION_TYPE_PERMANENT,
                ItemPropertyAbilityBonus(nAbility, Random(nBonus) + 1), oWeapon);
        }
    }

    // Generic attack damage or attack bonus.
    randPercent = Random(100)
        + GetSkillRank(SKILL_CRAFT_WEAPON, oPC) - (10 * nBonus);

    if (randPercent >= 50) {
        if (d2() == 1) {
            AddItemProperty(DURATION_TYPE_PERMANENT,
                ItemPropertyAttackBonus(nBonus + 1), oWeapon);
        } else {
            AddItemProperty(DURATION_TYPE_PERMANENT,
                ItemPropertyDamageBonus(GetRandDmgType(), nBonus + 1), oWeapon);
        }
    }

    // Alignment
    int alignOffset = 100 - GetGoodEvilValue(oPC);
    if (GetGoodEvilValue(oPC) <= 30) {
        nAlignGroup = IP_CONST_ALIGNMENTGROUP_GOOD;
        nDamageType = IP_CONST_DAMAGETYPE_NEGATIVE;
        nAlignGroupOp = IP_CONST_ALIGNMENTGROUP_EVIL;
    }
    if (GetGoodEvilValue(oPC) > 30 && GetGoodEvilValue(oPC) < 70) {
        nAlignGroup = IP_CONST_ALIGNMENTGROUP_NEUTRAL;
        if (GetGoodEvilValue(oPC) <= 50) {
            alignOffset = GetGoodEvilValue(oPC) + 40;
        } else {
            alignOffset = (100 - GetGoodEvilValue(oPC)) + 40;
        }
        nDamageType = IP_CONST_DAMAGETYPE_MAGICAL;
        nAlignGroupOp = IP_CONST_ALIGNMENTGROUP_NEUTRAL;
    }
    if (GetGoodEvilValue(oPC) >= 70) {
        alignOffset = GetGoodEvilValue(oPC);
        nAlignGroup = IP_CONST_ALIGNMENTGROUP_EVIL;
        nAlignGroupOp = IP_CONST_ALIGNMENTGROUP_GOOD;
        if (d2() == 1) {
            nDamageType = IP_CONST_DAMAGETYPE_POSITIVE;
        } else {
            nDamageType = IP_CONST_DAMAGETYPE_DIVINE;
        }
    }

    if (Random(100) + (alignOffset - 70) >= 98) {
        SendMessageToPC(oPC, "Some of your Alignment goes into the weapon");
        AddRandomAlignmentBonus(nAlignGroup, nBonus, oWeapon, nDamageType);
        AddItemProperty(DURATION_TYPE_PERMANENT,
            ItemPropertyLimitUseByAlign(nAlignGroupOp), oWeapon);

        if (d100() > 70 && (GetLevelByClass(CLASS_TYPE_CLERIC, oPC)
            || GetLevelByClass(CLASS_TYPE_PALADIN, oPC))) {
            if (d6() <= 3) {
                AddItemProperty(DURATION_TYPE_PERMANENT,
                    ItemPropertyBonusFeat(IP_CONST_FEAT_EXTRA_TURNING), oWeapon);
            } else {
                AddItemProperty(DURATION_TYPE_PERMANENT,
                    ItemPropertyCastSpell(IP_CONST_CASTSPELL_DIVINE_MIGHT_5,
                        IP_CONST_CASTSPELL_NUMUSES_1_CHARGE_PER_USE), oWeapon);
                SetItemCharges(oWeapon, 50);
            }
        }
    }

    // Class based
    AddRangerBonus(FEAT_FAVORED_ENEMY_ABERRATION, oPC, 70, nBonus,
        IP_CONST_RACIALTYPE_ABERRATION, oWeapon);
    AddRangerBonus(FEAT_FAVORED_ENEMY_ANIMAL, oPC, 70, nBonus,
        IP_CONST_RACIALTYPE_ANIMAL, oWeapon);
    AddRangerBonus(FEAT_FAVORED_ENEMY_BEAST, oPC, 70, nBonus,
        IP_CONST_RACIALTYPE_BEAST, oWeapon);
    AddRangerBonus(FEAT_FAVORED_ENEMY_CONSTRUCT, oPC, 70, nBonus,
        IP_CONST_RACIALTYPE_CONSTRUCT, oWeapon);
    AddRangerBonus(FEAT_FAVORED_ENEMY_DRAGON, oPC, 85, nBonus,
        IP_CONST_RACIALTYPE_DRAGON, oWeapon);
    AddRangerBonus(FEAT_FAVORED_ENEMY_DWARF, oPC, 70, nBonus,
        IP_CONST_RACIALTYPE_DWARF, oWeapon);
    AddRangerBonus(FEAT_FAVORED_ENEMY_ELEMENTAL, oPC, 70, nBonus,
        IP_CONST_RACIALTYPE_ELEMENTAL, oWeapon);
    AddRangerBonus(FEAT_FAVORED_ENEMY_ELF, oPC, 70, nBonus,
        IP_CONST_RACIALTYPE_ELF, oWeapon);
    AddRangerBonus(FEAT_FAVORED_ENEMY_FEY, oPC, 70, nBonus,
        IP_CONST_RACIALTYPE_FEY, oWeapon);
    AddRangerBonus(FEAT_FAVORED_ENEMY_GIANT, oPC, 70, nBonus,
        IP_CONST_RACIALTYPE_GIANT, oWeapon);
    AddRangerBonus(FEAT_FAVORED_ENEMY_GOBLINOID, oPC, 70, nBonus,
        IP_CONST_RACIALTYPE_HUMANOID_GOBLINOID, oWeapon);
    AddRangerBonus(FEAT_FAVORED_ENEMY_GNOME, oPC, 70, nBonus,
        IP_CONST_RACIALTYPE_GNOME, oWeapon);
    AddRangerBonus(FEAT_FAVORED_ENEMY_HALFELF, oPC, 70, nBonus,
        IP_CONST_RACIALTYPE_HALFELF, oWeapon);
    AddRangerBonus(FEAT_FAVORED_ENEMY_HALFLING, oPC, 70, nBonus,
        IP_CONST_RACIALTYPE_HALFLING, oWeapon);
    AddRangerBonus(FEAT_FAVORED_ENEMY_HUMAN, oPC, 70, nBonus,
        IP_CONST_RACIALTYPE_HUMAN, oWeapon);
    AddRangerBonus(FEAT_FAVORED_ENEMY_MAGICAL_BEAST, oPC, 70, nBonus,
        IP_CONST_RACIALTYPE_MAGICAL_BEAST, oWeapon);
    AddRangerBonus(FEAT_FAVORED_ENEMY_MONSTROUS, oPC, 70, nBonus,
        IP_CONST_RACIALTYPE_HUMANOID_MONSTROUS, oWeapon);
    AddRangerBonus(FEAT_FAVORED_ENEMY_ORC, oPC, 70, nBonus,
        IP_CONST_RACIALTYPE_HUMANOID_ORC, oWeapon);
    AddRangerBonus(FEAT_FAVORED_ENEMY_OUTSIDER, oPC, 70, nBonus,
        IP_CONST_RACIALTYPE_OUTSIDER, oWeapon);
    AddRangerBonus(FEAT_FAVORED_ENEMY_REPTILIAN, oPC, 70, nBonus,
        IP_CONST_RACIALTYPE_HUMANOID_REPTILIAN, oWeapon);
    AddRangerBonus(FEAT_FAVORED_ENEMY_SHAPECHANGER, oPC, 70, nBonus,
        IP_CONST_RACIALTYPE_SHAPECHANGER, oWeapon);
    AddRangerBonus(FEAT_FAVORED_ENEMY_UNDEAD, oPC, 70, nBonus,
        IP_CONST_RACIALTYPE_UNDEAD, oWeapon);
    AddRangerBonus(FEAT_FAVORED_ENEMY_VERMIN, oPC, 70, nBonus,
        IP_CONST_RACIALTYPE_VERMIN, oWeapon);

    if (GetLevelByClass(CLASS_TYPE_BARD, oPC)) {
        if (Random(100) + GetSkillRank(SKILL_PERFORM, oPC) > 70 + (10 * nBonus)) {
            SendMessageToPC(oPC, "Some of your Bard abilities go into the weapon");
            AddItemProperty(DURATION_TYPE_PERMANENT,
                ItemPropertyDamageBonus(IP_CONST_DAMAGETYPE_SONIC,
                    Random(nBonus) + 1), oWeapon);
        }
    }

    //ranged weapons
    if (GetBaseItemType(oWeapon) == BASE_ITEM_LIGHTCROSSBOW
        || GetBaseItemType(oWeapon) == BASE_ITEM_LONGBOW
        || GetBaseItemType(oWeapon) == BASE_ITEM_SHORTBOW
        || GetBaseItemType(oWeapon) == BASE_ITEM_HEAVYCROSSBOW
        || GetBaseItemType(oWeapon) == BASE_ITEM_SHURIKEN) {
        if (GetAbilityModifier(ABILITY_STRENGTH, oPC) > 0)
            AddItemProperty(DURATION_TYPE_PERMANENT,
                ItemPropertyMaxRangeStrengthMod(Random(
                    GetAbilityModifier(ABILITY_STRENGTH, oPC)) + 1), oWeapon);
    }

    //Two Hander weapons
    if (GetWeaponSize(oWeapon) == WEAPON_TYPE_LARGE) {
        addRandomLageWeaponBonus(nBonus, oWeapon);
    }
    return;
}

void BadEffect(object oWeapon, object oPC, int nBonus)
{
    int nSave;
    int nSkill;
    int nWeight;
    int nDamageType;
    int nAlignGroup;
    int nAlignGroupOp;
    int randPercent = Random(100);
    int nAbility = GetLowAbility(oPC);

    //Weight Increase
    if (nBonus == IRON_INGOT) {
        nWeight = IP_CONST_WEIGHTINCREASE_5_LBS;
    } else if (nBonus == SILVER_INGOT) {
        nWeight = IP_CONST_WEIGHTINCREASE_10_LBS;
    } else if (nBonus == DARK_STEEL_INGOT || nBonus == ADAMANTIUM_INGOT) {
        nWeight = IP_CONST_WEIGHTINCREASE_15_LBS;
    } else if (nBonus == MITHRAL_INGOT) {
        nWeight = IP_CONST_WEIGHTINCREASE_30_LBS;
    }

    AddItemProperty(DURATION_TYPE_PERMANENT,
        ItemPropertyWeightIncrease(nWeight), oWeapon);

    // Random Skill/Save/Ability Weakness
    if (randPercent >= 20) {
        // Pick saving throws and skills.
        if (nAbility == ABILITY_STRENGTH) {
            nSave = IP_CONST_SAVEBASETYPE_FORTITUDE;
            nSkill = RandomStrSkill();
            SendMessageToPC(oPC, "Some of your Weakness goes into the weapon");
        } else if (nAbility == ABILITY_DEXTERITY) {
            nSave = IP_CONST_SAVEBASETYPE_REFLEX;
            nSkill = RandomDexSkill();
            SendMessageToPC(oPC, "Some of your Clumsiness goes into the weapon");
        } else if (nAbility == ABILITY_CONSTITUTION) {
            nSave = IP_CONST_SAVEBASETYPE_FORTITUDE;
            nSkill = RandomConSkill();
            SendMessageToPC(oPC, "Some of your Frailty goes into the weapon");
        } else if (nAbility == ABILITY_INTELLIGENCE) {
            nSave = IP_CONST_SAVEBASETYPE_WILL;
            nSkill = RandomIntSkill();
            SendMessageToPC(oPC, "Some of your Stupidity goes into the weapon");
        } else if (nAbility == ABILITY_WISDOM) {
            nSave = IP_CONST_SAVEBASETYPE_WILL;
            nSkill = RandomWisSkill();
            SendMessageToPC(oPC, "Some of your Foolishness goes into the weapon");
        } else if (nAbility == ABILITY_CHARISMA) {
            nSave = IP_CONST_SAVEBASETYPE_REFLEX;
            nSkill = RandomCharSkill();
            SendMessageToPC(oPC, "Some of your Ugliness goes into the weapon");
        }

        // 20% - 50% decrease skill bonus
        if (randPercent <= 50) {
            AddItemProperty(DURATION_TYPE_PERMANENT,
                ItemPropertyDecreaseSkill(nSkill, Random(nBonus) + 1), oWeapon);
        // 50% - 90% decrease saving throw
        } else if (randPercent <= 90) {
            if (nAbility == ABILITY_CHARISMA) {
                AddItemProperty(DURATION_TYPE_PERMANENT,
                    ItemPropertyReducedSavingThrowVsX(IP_CONST_SAVEVS_UNIVERSAL,
                        Random(nBonus) + 1), oWeapon);
            } else {
                AddItemProperty(DURATION_TYPE_PERMANENT,
                    ItemPropertyReducedSavingThrow(nSave, Random(nBonus) + 1),
                        oWeapon);
            }
        }
        // 90% - 100% decrease ability bonus
        else {
            AddItemProperty(DURATION_TYPE_PERMANENT,
                ItemPropertyDecreaseAbility(nAbility, Random(nBonus) + 1),
                    oWeapon);
        }
    }

    // Alignment Based Weakness
    int alignOffset = GetGoodEvilValue(oPC);
    if (GetGoodEvilValue(oPC) <= 30) {
        nAlignGroup = IP_CONST_ALIGNMENTGROUP_EVIL;
        if (d2() == 1) {
            nDamageType = IP_CONST_DAMAGETYPE_POSITIVE;
        } else {
            nDamageType = IP_CONST_DAMAGETYPE_DIVINE;
        }
        nAlignGroupOp = IP_CONST_ALIGNMENTGROUP_GOOD;
    }
    if (GetGoodEvilValue(oPC) > 30 && GetGoodEvilValue(oPC) < 70) {
        if (GetGoodEvilValue(oPC) <= 50) {
            alignOffset = GetGoodEvilValue(oPC) + 40;
        } else {
            alignOffset = (100 - GetGoodEvilValue(oPC)) + 40;
        }
        nAlignGroup = IP_CONST_ALIGNMENTGROUP_NEUTRAL;
        nDamageType = IP_CONST_DAMAGETYPE_MAGICAL;
        nAlignGroupOp = IP_CONST_ALIGNMENTGROUP_NEUTRAL;
    }
    if (GetGoodEvilValue(oPC) >= 70) {
        alignOffset = 100 - GetGoodEvilValue(oPC);
        nAlignGroup = IP_CONST_ALIGNMENTGROUP_GOOD;
        nDamageType = IP_CONST_DAMAGETYPE_NEGATIVE;
        nAlignGroupOp = IP_CONST_ALIGNMENTGROUP_EVIL;
    }

    if (Random(100) + alignOffset / 10 >= 80) {
        SendMessageToPC(oPC, "Some of your Alignment goes into the weapon");
        AddItemProperty(DURATION_TYPE_PERMANENT,
            ItemPropertyDamageVulnerability(nDamageType, Random(nBonus) + 1),
                oWeapon);
    }

    // Crafted Based Weakness
    randPercent = Random(100) - GetSkillRank(SKILL_CRAFT_WEAPON, oPC);
    if (randPercent >= 50) {
        if (d2() == 1) {
            AddItemProperty(DURATION_TYPE_PERMANENT,
                ItemPropertyAttackPenalty(Random(nBonus) + 1), oWeapon);
        }
        else {
            AddItemProperty(DURATION_TYPE_PERMANENT,
                ItemPropertyDamagePenalty(Random(nBonus) + 1), oWeapon);
        }
    }
    return;
}

void main()
{
    int iValue;
    int iValueDC;
    int iProperty;
    int iPropertyDC;
    itemproperty nProperty;
    int iDC = 20;
    int iDamage = 0;
    int iRoll = d20();
    int iDamageType = 0;
    int nBonus = GetBonus();
    object oPC = GetLastAttacker();
    object oWeapon = GetLastWeaponUsed(oPC);
    int iHits = GetLocalInt(OBJECT_SELF, "iHits");
    int iSkill  = GetSkillRank(SKILL_CRAFT_WEAPON, oPC);
    struct sStringTokenizer sTok = GetStringTokenizer(GetName(oWeapon), "+");

    if (!GetIsObjectValid(oWeapon)) {
        if (GetItemInSlot(INVENTORY_SLOT_ARROWS, oPC) != OBJECT_INVALID) {
            oWeapon = GetItemInSlot(INVENTORY_SLOT_ARROWS, oPC);
        } else if (GetItemInSlot(INVENTORY_SLOT_BOLTS, oPC) != OBJECT_INVALID) {
            oWeapon = GetItemInSlot(INVENTORY_SLOT_BOLTS, oPC);
        } else if (GetItemInSlot(INVENTORY_SLOT_BULLETS, oPC) != OBJECT_INVALID) {
            oWeapon = GetItemInSlot(INVENTORY_SLOT_BULLETS, oPC);
        } else if (GetItemInSlot(INVENTORY_SLOT_ARROWS, oPC) == OBJECT_INVALID
            && GetItemInSlot(INVENTORY_SLOT_BOLTS, oPC) == OBJECT_INVALID
            && GetItemInSlot(INVENTORY_SLOT_BULLETS, oPC) != OBJECT_INVALID) {
            SendMessageToPC(oPC, "Must use a valid weapon.");
            return;
        }
    }

    SendMessageToPC(oPC, "Weapon is: " + GetName(oWeapon));

    // Get Size and Modified DC for crafting
    int iSize = GetWeaponSize(oWeapon);
    if (iSize == WEAPON_TYPE_UNKNOWN) {
        return;
    }
    int iSizeDC = GetSizeDC(iSize, oPC);

    SendMessageToPC(oPC, "Weapon size: " + IntToString(iSize));
    SendMessageToPC(oPC, "Weapon size DC Adjustment: " + IntToString(iSizeDC));

    // Get Gold value and Modified DC
    iValue = GetGoldPieceValue(oWeapon);
    iValueDC = GetGoldPieceDCValue(iValue);

    SendMessageToPC(oPC, "Weapon value: " + IntToString(iValue));
    SendMessageToPC(oPC, "Weapon value DC Adjustment: "
        + IntToString(iValueDC));

    // Get number of properties on the weapon already
    iProperty = GetNumProperties(oWeapon);
    iPropertyDC = GetNumPropertiesDC(iProperty);

    SendMessageToPC(oPC, "Weapon Properties: " + IntToString(iProperty));
    SendMessageToPC(oPC, "Weapon property DC Adjustment: "
        + IntToString(iPropertyDC));

    // Get base mod dc
    int iModDC = GetBaseModDC();
    if(iModDC == -1) {
        SendMessageToPC(oPC, "No Item Found ");
        return;
    } else {
        SendMessageToPC(oPC, "Weapon modification DC Adjustment: "
            + IntToString(iModDC));
    }

    // Adjust base dc with alchemical dc
    if (iModDC) {
        if (HasItem(POTION_OF_FIRE_BREATH_TAG)) {
            iModDC = iModDC + 2;
            iDamageType = IP_CONST_DAMAGETYPE_FIRE;
            iDamage = IP_CONST_DAMAGEBONUS_1;
            if (HasItem(GEM_RUBY)) {
                iDamage = IP_CONST_DAMAGEBONUS_2;
                iModDC = iModDC + 2;
                if (HasItem(FIRE_ELEMENTAL_ESSENCE)) {
                    iDamage = IP_CONST_DAMAGEBONUS_1d4;
                    iModDC = iModDC + 2;
                }
            }
        } else if (HasItem(POTION_OF_ACID_BREATH_TAG)) {
            iModDC = iModDC + 2;
            iDamageType = IP_CONST_DAMAGETYPE_ACID;
            iDamage = IP_CONST_DAMAGEBONUS_1;
            if (HasItem("NW_IT_GEM012")) {
                iDamage = IP_CONST_DAMAGEBONUS_2;
                iModDC = iModDC + 2;
                if (HasItem(ACID_ELEMENTAL_ESSENCE)) {
                    iDamage = IP_CONST_DAMAGEBONUS_1d4;
                    iModDC = iModDC + 2;
                }
            }
        } else if (HasItem(POTION_OF_COLD_BREATH_TAG) && HasItem(COLD_INGOT_TAG)){
            iModDC = iModDC + 1;
            iDamageType = IP_CONST_DAMAGETYPE_COLD;
            iDamage = IP_CONST_DAMAGEBONUS_2;
            if (HasItem(GEM_SAPHIRE)) {
                iDamage = IP_CONST_DAMAGEBONUS_1d4;
                iModDC = iModDC + 2;
                if (HasItem(COLD_ELEMENTAL_ESSENCE)) {
                    iDamage = IP_CONST_DAMAGEBONUS_1d6;
                    iModDC = iModDC + 2;
                }
            }
        } else if (HasItem(POTION_OF_COLD_BREATH_TAG)) {
            iModDC = iModDC + 2;
            iDamageType = IP_CONST_DAMAGETYPE_COLD;
            iDamage = IP_CONST_DAMAGEBONUS_1;
            if (HasItem(GEM_SAPHIRE)) {
                iDamage = IP_CONST_DAMAGEBONUS_2;
                iModDC = iModDC + 2;
                if (HasItem(COLD_ELEMENTAL_ESSENCE)) {
                    iDamage = IP_CONST_DAMAGEBONUS_1d4;
                    iModDC = iModDC + 2;
                }
            }
        } else if (HasItem(POTION_OF_ELEC_BREATH_TAG)) {
            iModDC = iModDC + 2;
            iDamageType = IP_CONST_DAMAGETYPE_ELECTRICAL;
            iDamage = IP_CONST_DAMAGEBONUS_1;
            if (HasItem(GEM_DIAMOND)) {
                iDamage = IP_CONST_DAMAGEBONUS_2;
                iModDC = iModDC + 2;
                if (HasItem(ELEC_ELEMENTAL_ESSENCE)) {
                    iDamage = IP_CONST_DAMAGEBONUS_1d4;
                    iModDC = iModDC + 2;
                }
            }
        }

        if(iDamage > 0){
            SendMessageToPC(oPC,
                "Weapon modification DC Adjustment Alchemical: "
                    + IntToString(iModDC));
        }
    }

    iDC = 20 + iValueDC + iSizeDC + iPropertyDC + iModDC;

    if (GetItemStackSize(oWeapon) > 300) {
        SendMessageToPC(oPC, "You cannot craft more than 300 of an item.");
        return;
    }

    SendMessageToPC(oPC, "*****");
    SendMessageToPC(oPC, "*****");
    SendMessageToPC(oPC, "Total DC: " + IntToString(iDC));
    SendMessageToPC(oPC, "Total DC to avoid negative effects: "
        + IntToString(iDC + 6));
    SendMessageToPC(oPC, "*****");
    SendMessageToPC(oPC, "*****");
    SendMessageToPC(oPC, "Total XP Cost: "
        + IntToString(iDC * 10 * iModDC + iDC * 3));

    if (GetXP(oPC) < iDC * 10 * iModDC + iDC * 3) {
        if (!GetIsDM(oPC)) {
            SendMessageToPC(oPC, "Not enough XP ");
            return;
        }
    }

    DelayCommand(0.7, ApplyEffectToObject(DURATION_TYPE_INSTANT,
        EffectVisualEffect(VFX_COM_BLOOD_SPARK_LARGE), OBJECT_SELF));
    DelayCommand(0.7, ApplyEffectToObject(DURATION_TYPE_INSTANT,
        EffectVisualEffect(VFX_COM_BLOOD_SPARK_SMALL), oPC));

    iHits++;
    SetLocalInt(OBJECT_SELF, "iHits", iHits);

    if (iHits == 1) {
        DelayCommand(32.0, SetLocalInt(OBJECT_SELF, "iHits", 0));
    }
    if (iHits < 5) {
        FloatingTextStringOnCreature("*Works on forging the weapon* ..."
            + IntToString(5 - iHits), oPC, FALSE);
        return;
    }

    //Actually craft after 5 hits.
    SendMessageToPC(oPC, "Roll: " + IntToString(iRoll) + ", Skill: "
        + IntToString(iSkill));

    // If we fail hanlde that
    if (iRoll == 1 || (iRoll + iSkill < iDC)) {
        SendMessageToPC(oPC, "Failure! ");
        CleanItems();
        if (d20() == 1 || (iRoll + iSkill <= iDC - 10)) {
            SendMessageToPC(oPC, "Critical Failure! ");
            DestroyObject(oWeapon);
        }
    // If we succeed handle that
    } else {
        SendMessageToPC(oPC, "Success! ");

        if (iRoll == 20 || (iRoll + iSkill >= iDC + 10)) {
            SendMessageToPC(oPC, "You did a particularly good job on this one.");
            GoodEffect(oWeapon, oPC, nBonus);
        } if (iRoll + iSkill <= iDC + 5 || HasItem("004korsanturd")) {
            SendMessageToPC(oPC, "There were some flaws in the process.");
            BadEffect(oWeapon, oPC, nBonus);
        }

        RemoveWeaponProperty(oWeapon, ITEM_PROPERTY_ENHANCEMENT_BONUS);

        int enchantBonus = nBonus - 1;
        if(enchantBonus > 0) {
            AddItemProperty(DURATION_TYPE_PERMANENT,
                ItemPropertyEnhancementBonus(enchantBonus), oWeapon);
            if (GetBaseItemType(oWeapon) == BASE_ITEM_GLOVES)
                AddItemProperty(DURATION_TYPE_PERMANENT,
                    ItemPropertyAttackBonus(enchantBonus), oWeapon);
            if (iDamageType) {
                RemoveWeaponProperty(oWeapon, ITEM_PROPERTY_DAMAGE_BONUS);
                AddItemProperty(DURATION_TYPE_PERMANENT,
                    ItemPropertyDamageBonus(iDamageType, iDamage), oWeapon);
                SendMessageToPC(oPC, "The weapon glows with alchemical power ");
            }
        }

        // if cold iron add fey specific and fire weakness
        if (HasItem(COLD_INGOT_TAG)) {
            AddItemProperty(DURATION_TYPE_PERMANENT,
                ItemPropertyDamageVulnerability(IP_CONST_DAMAGETYPE_FIRE,
                    IP_CONST_DAMAGEVULNERABILITY_25_PERCENT), oWeapon);
            AddItemProperty(DURATION_TYPE_PERMANENT,
                ItemPropertyEnhancementBonusVsRace(IP_CONST_RACIALTYPE_FEY, 4),
                    oWeapon);
        }

        // if obsidian is present add spell resistance.
        if (HasItem(OBSIDIAN_INGOT_TAG)) {
            AddItemProperty(DURATION_TYPE_PERMANENT,
                ItemPropertyBonusSpellResistance(
                    IP_CONST_SPELLRESISTANCEBONUS_10), oWeapon);
        }

        SetXP(oPC, GetXP(oPC) - (iDC * 10 * iModDC + iDC * 3));
        CleanItems();
        sTok = AdvanceToNextToken(sTok);

        if (!GetIsDM(oPC)) {
            SetName(oWeapon, GetName(oPC) + "'s forged " + GetNextToken(sTok));
        }
        if (!GetIsDM(oPC)) {
            SetDescription(oWeapon, "This has the mark of " + GetName(oPC));
        }
        if (GetBaseItemType(oWeapon) == BASE_ITEM_ARROW
            || GetBaseItemType(oWeapon) == BASE_ITEM_BOLT
            || GetBaseItemType(oWeapon) == BASE_ITEM_BULLET) {
            SetTag(oWeapon, GetTag(oWeapon) + RandomName()
                + IntToString(GetBonus()));
        }
    }
}
