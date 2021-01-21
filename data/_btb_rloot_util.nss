#include "x2_inc_itemprop"

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
    int skillAmt = GetItemTypeBonusAmount(oArmor, ITEM_PROPERTY_SKILL_BONUS,
                                           skillNum) + 1;
    // Check if we already have some of that skill
    IPSafeAddItemProperty(oArmor, ItemPropertySkillBonus(skillNum, skillAmt),
                            0.0, X2_IP_ADDPROP_POLICY_REPLACE_EXISTING);
    return oArmor;
}

object RandomSavingThrowBoost(object oArmor) {
    // Pick a random saving throw
    int saveNum = Random(20);
    int saveAmt = GetItemTypeBonusAmount(oArmor,
                                          ITEM_PROPERTY_SAVING_THROW_BONUS,
                                          saveNum) + 1;
    // Check if we already have some of that saving throw
    IPSafeAddItemProperty(oArmor,
                           ItemPropertyBonusSavingThrow(saveNum, saveAmt), 0.0,
                           X2_IP_ADDPROP_POLICY_REPLACE_EXISTING);
    return oArmor;
}

object RandomAbilityBoost(object oArmor) {
    // Pick a random ability
    int abilityNum = Random(20);
    int abilityAmt = GetItemTypeBonusAmount(oArmor, ITEM_PROPERTY_ABILITY_BONUS,
                                             abilityNum) + 1;
    // Check if we already have some of that ability
    IPSafeAddItemProperty(oArmor,
                           ItemPropertyAbilityBonus(abilityNum, abilityAmt),
                           0.0, X2_IP_ADDPROP_POLICY_REPLACE_EXISTING);
    return oArmor;
}

object ACBoostVsAlign(object obj) {
    // Pick a random alignment
    int alignBoostNum = Random(5) + 1;
    int alignBoostAmt = GetItemTypeBonusAmount(obj,
                                      ITEM_PROPERTY_AC_BONUS_VS_ALIGNMENT_GROUP,
                                      alignBoostNum) + 1;
    // Check if we already have some of that ability
    IPSafeAddItemProperty(obj, ItemPropertyACBonusVsAlign(alignBoostNum,
                           alignBoostAmt), 0.0,
                           X2_IP_ADDPROP_POLICY_REPLACE_EXISTING);
    return obj;
}

object ACBoostVsDmgType(object obj) {
    // Pick a random alignment
    int dmgBoostNum = Random(5) + 1;
    int dmgBoostAmt = GetItemTypeBonusAmount(obj,
                                      ITEM_PROPERTY_AC_BONUS_VS_DAMAGE_TYPE,
                                      dmgBoostNum) + 1;
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
    int raceBoostAmt = GetItemTypeBonusAmount(obj,
                                      ITEM_PROPERTY_AC_BONUS_VS_RACIAL_GROUP,
                                      raceBoostNum) + 1;
    // Check if we already have some of that ability
    IPSafeAddItemProperty(obj,
                           ItemPropertyACBonusVsRace(raceBoostNum,
                           raceBoostAmt), 0.0,
                           X2_IP_ADDPROP_POLICY_REPLACE_EXISTING);
    return obj;
}

object ACBoost(object obj) {
    int acAmt = GetItemBonusAmount(obj, ITEM_PROPERTY_AC_BONUS) + 1;
    // Check if we already have some of that ability
    IPSafeAddItemProperty(obj,
                           ItemPropertyACBonus(acAmt),
                           0.0, X2_IP_ADDPROP_POLICY_REPLACE_EXISTING);
    return obj;
}
