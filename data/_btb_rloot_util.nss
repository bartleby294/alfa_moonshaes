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
