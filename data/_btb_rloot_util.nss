#include "x2_inc_itemprop"
#include "_btb_rloot_spell"

int square(int base, int power) {
    int rv = 1;
    while(power > 0){
        rv = rv * base;
        power = power - 1;
    }
    return rv;
}

int GetItemTypeBonusAmount(object oItem, int type, int nSubType)
{
    itemproperty ip = GetFirstItemProperty(oItem);

    while (GetIsItemPropertyValid(ip))
    {
        if (GetItemPropertyType(ip) == type) {
            if(GetItemPropertySubType(ip) == nSubType) {
                return GetItemPropertyCostTable(ip);
            }
        }
        ip = GetNextItemProperty(oItem);
    }

    return 0;
}

int GetItemBonusAmount(object oItem, int type)
{
    itemproperty ip = GetFirstItemProperty(oItem);

    while (GetIsItemPropertyValid(ip))
    {
        if (GetItemPropertyType(ip) == type) {
            return GetItemPropertyCostTable(ip);
        }
        ip = GetNextItemProperty(oItem);
    }

    return 0;
}

object RandomSkillBoost(object oArmor) {
    // Pick a random skill
    int skillNum = Random(30);
    if(skillNum == 28) {
        skillNum = 657;
    }
    if(skillNum == 29) {
        skillNum = 656;
    }
    //WriteTimestampedLogEntry("skillNum: " + IntToString(skillNum));
    int skillAmt = GetItemTypeBonusAmount(oArmor, ITEM_PROPERTY_SKILL_BONUS,
                                           skillNum) + 1;
    //WriteTimestampedLogEntry("skillAmt: " + IntToString(skillAmt));
    // Check if we already have some of that skill
    IPSafeAddItemProperty(oArmor, ItemPropertySkillBonus(skillNum, skillAmt),
                            0.0, X2_IP_ADDPROP_POLICY_REPLACE_EXISTING);
    return oArmor;
}

object RandomSavingThrowBoost(object oArmor) {
    // Pick a random saving throw
    int saveNum = Random(20);
    //WriteTimestampedLogEntry("saveNum: " + IntToString(saveNum));
    int saveAmt = GetItemTypeBonusAmount(oArmor,
                                          ITEM_PROPERTY_SAVING_THROW_BONUS,
                                          saveNum) + 1;
    //WriteTimestampedLogEntry("saveAmt: " + IntToString(saveAmt));
    // Check if we already have some of that saving throw
    IPSafeAddItemProperty(oArmor,
                           ItemPropertyBonusSavingThrow(saveNum, saveAmt), 0.0,
                           X2_IP_ADDPROP_POLICY_REPLACE_EXISTING);
    return oArmor;
}

object RandomAbilityBoost(object oArmor) {
    // Pick a random ability
    int abilityNum = Random(20);
    //WriteTimestampedLogEntry("skillNum: " + IntToString(abilityNum));
    int abilityAmt = GetItemTypeBonusAmount(oArmor, ITEM_PROPERTY_ABILITY_BONUS,
                                             abilityNum) + 1;
    //WriteTimestampedLogEntry("abilityAmt: " + IntToString(abilityAmt));
    // Check if we already have some of that ability
    IPSafeAddItemProperty(oArmor,
                           ItemPropertyAbilityBonus(abilityNum, abilityAmt),
                           0.0, X2_IP_ADDPROP_POLICY_REPLACE_EXISTING);
    return oArmor;
}

object ACBoostVsAlign(object obj) {
    // Pick a random alignment
    int alignBoostNum = Random(5) + 1;
    //WriteTimestampedLogEntry("alignBoostNum: " + IntToString(alignBoostNum));
    int alignBoostAmt = GetItemTypeBonusAmount(obj,
                                      ITEM_PROPERTY_AC_BONUS_VS_ALIGNMENT_GROUP,
                                      alignBoostNum) + 1;
    //WriteTimestampedLogEntry("alignBoostAmt: " + IntToString(alignBoostAmt));
    // Check if we already have some of that ability
    IPSafeAddItemProperty(obj, ItemPropertyACBonusVsAlign(alignBoostNum,
                           alignBoostAmt), 0.0,
                           X2_IP_ADDPROP_POLICY_REPLACE_EXISTING);
    return obj;
}

object ACBoostVsDmgType(object obj) {
    // Pick a random alignment
    int dmgBoostNum = Random(5) + 1;
    //WriteTimestampedLogEntry("dmgBoostNum: " + IntToString(dmgBoostNum));
    int dmgBoostAmt = GetItemTypeBonusAmount(obj,
                                      ITEM_PROPERTY_AC_BONUS_VS_DAMAGE_TYPE,
                                      dmgBoostNum) + 1;
    //WriteTimestampedLogEntry("dmgBoostAmt: " + IntToString(dmgBoostAmt));
    // Check if we already have some of that ability
    IPSafeAddItemProperty(obj,
                           ItemPropertyACBonusVsDmgType(dmgBoostNum,
                           dmgBoostAmt), 0.0,
                           X2_IP_ADDPROP_POLICY_REPLACE_EXISTING);
    return obj;
}

object ACBoostVsRace(object obj) {
    // Pick a random Race
    int raceBoostNum = Random(25);
    //WriteTimestampedLogEntry("raceBoostNum: " + IntToString(raceBoostNum));
    int raceBoostAmt = GetItemTypeBonusAmount(obj,
                                      ITEM_PROPERTY_AC_BONUS_VS_RACIAL_GROUP,
                                      raceBoostNum) + 1;
    //WriteTimestampedLogEntry("raceBoostAmt: " + IntToString(raceBoostAmt));
    // Check if we already have some of that ability
    IPSafeAddItemProperty(obj,
                           ItemPropertyACBonusVsRace(raceBoostNum,
                           raceBoostAmt), 0.0,
                           X2_IP_ADDPROP_POLICY_REPLACE_EXISTING);
    return obj;
}

object ACBoost(object obj) {
    int acAmt = GetItemBonusAmount(obj, ITEM_PROPERTY_AC_BONUS) + 1;
    //WriteTimestampedLogEntry("acAmt: " + IntToString(acAmt));
    // Check if we already have some of that ability
    IPSafeAddItemProperty(obj,
                           ItemPropertyACBonus(acAmt),
                           0.0, X2_IP_ADDPROP_POLICY_REPLACE_EXISTING);
    return obj;
}

object AttackBonusVsAlign(object obj) {
    // Pick a random alignment
    int alignBoostNum = Random(5) + 1;
    //WriteTimestampedLogEntry("alignBoostNum: " + IntToString(alignBoostNum));
    int alignBoostAmt = GetItemTypeBonusAmount(obj,
                                      ITEM_PROPERTY_ATTACK_BONUS_VS_ALIGNMENT_GROUP,
                                      alignBoostNum) + 1;
    //WriteTimestampedLogEntry("alignBoostAmt: " + IntToString(alignBoostAmt));
    // Check if we already have some of that ability
    IPSafeAddItemProperty(obj, ItemPropertyAttackBonusVsAlign(alignBoostNum,
                           alignBoostAmt), 0.0,
                           X2_IP_ADDPROP_POLICY_REPLACE_EXISTING);
    return obj;
}

object AttackBonusVsRace(object obj) {
    // Pick a random Race
    int raceBoostNum = Random(25);
    //WriteTimestampedLogEntry("raceBoostNum: " + IntToString(raceBoostNum));
    int raceBoostAmt = GetItemTypeBonusAmount(obj,
                                      ITEM_PROPERTY_ATTACK_BONUS_VS_RACIAL_GROUP,
                                      raceBoostNum) + 1;
    //WriteTimestampedLogEntry("raceBoostAmt: " + IntToString(raceBoostAmt));
    // Check if we already have some of that ability
    IPSafeAddItemProperty(obj,
                           ItemPropertyAttackBonusVsRace(raceBoostNum,
                           raceBoostAmt), 0.0,
                           X2_IP_ADDPROP_POLICY_REPLACE_EXISTING);
    return obj;
}

object AttackBonus(object obj) {
    int attackAmt = GetItemBonusAmount(obj, ITEM_PROPERTY_ATTACK_BONUS) + 1;
    //WriteTimestampedLogEntry("acAmt: " + IntToString(acAmt));
    // Check if we already have some of that ability
    IPSafeAddItemProperty(obj,
                           ItemPropertyAttackBonus(attackAmt),
                           0.0, X2_IP_ADDPROP_POLICY_REPLACE_EXISTING);
    return obj;
}

object DmgBonusVsAlign(object obj) {
    // Pick a random alignment
    int dmgBoostNum = Random(5) + 1;
    int dmgType = square(2, Random(13));
    //WriteTimestampedLogEntry("dmgBoostNum: " + IntToString(dmgBoostNum));
    int dmgBoostAmt = GetItemTypeBonusAmount(obj,
                                      ITEM_PROPERTY_DAMAGE_BONUS_VS_ALIGNMENT_GROUP,
                                      dmgBoostNum) + 1;
    //WriteTimestampedLogEntry("dmgBoostAmt: " + IntToString(dmgBoostAmt));
    // Check if we already have some of that ability
    IPSafeAddItemProperty(obj,
                           ItemPropertyDamageBonusVsAlign(dmgBoostNum,
                           dmgType, dmgBoostAmt), 0.0,
                           X2_IP_ADDPROP_POLICY_REPLACE_EXISTING);
    return obj;
}

object DmgBonusVsRace(object obj) {
    // Pick a random Race
    int raceBoostNum = Random(25);
    int dmgType = square(2, Random(13));
    //WriteTimestampedLogEntry("raceBoostNum: " + IntToString(raceBoostNum));
    int raceBoostAmt = GetItemTypeBonusAmount(obj,
                                      ITEM_PROPERTY_DAMAGE_BONUS_VS_RACIAL_GROUP,
                                      raceBoostNum) + 1;
    //WriteTimestampedLogEntry("dmgBoostAmt: " + IntToString(dmgBoostAmt));
    // Check if we already have some of that ability
    IPSafeAddItemProperty(obj,
                           ItemPropertyDamageBonusVsRace(raceBoostNum,
                           dmgType, raceBoostAmt), 0.0,
                           X2_IP_ADDPROP_POLICY_REPLACE_EXISTING);
    return obj;
}

object DmgBonus(object obj) {
    // Pick a random alignment
    int dmgBoostNum = square(2, Random(13));
    //WriteTimestampedLogEntry("dmgBoostNum: " + IntToString(dmgBoostNum));
    int dmgBoostAmt = GetItemTypeBonusAmount(obj,
                                      ITEM_PROPERTY_DAMAGE_BONUS,
                                      dmgBoostNum) + 1;
    //WriteTimestampedLogEntry("dmgBoostAmt: " + IntToString(dmgBoostAmt));
    // Check if we already have some of that ability
    IPSafeAddItemProperty(obj,
                           ItemPropertyDamageBonus(dmgBoostNum,
                           dmgBoostAmt), 0.0,
                           X2_IP_ADDPROP_POLICY_REPLACE_EXISTING);
    return obj;
}

object EnchantmentBonus(object obj) {
    int enchantAmt = GetItemBonusAmount(obj, ITEM_PROPERTY_ENHANCEMENT_BONUS) + 1;
    //WriteTimestampedLogEntry("acAmt: " + IntToString(acAmt));
    // Check if we already have some of that ability
    // NOTHING HIGHER THAN +2!!!!!
    if(enchantAmt > 2) {
        return obj;
    }

    IPSafeAddItemProperty(obj,
                           ItemPropertyEnhancementBonus(enchantAmt),
                           0.0, X2_IP_ADDPROP_POLICY_REPLACE_EXISTING);
    return obj;
}

object MagicCharge(object obj, int difficulty_lvl) {

    int spellLvl = Random(difficulty_lvl - 3);
    int spellChoice = IP_CONST_CASTSPELL_LIGHT_5;

    if(spellLvl == 0) {
        spellChoice = RandomLvlZeroSpell();
    } else if(spellLvl == 1) {
        spellChoice =RandomLvlOneSpell();
    } else {
        spellChoice = RandomLvlTwoSpell();
    }

    SetItemCharges(obj, (spellLvl + 1) * Random(10));
    itemproperty spell = ItemPropertyCastSpell(spellChoice,
                                   IP_CONST_CASTSPELL_NUMUSES_1_CHARGE_PER_USE);
    IPSafeAddItemProperty(obj, spell, 0.0,
                                         X2_IP_ADDPROP_POLICY_REPLACE_EXISTING);
    return obj;
}


