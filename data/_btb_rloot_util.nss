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

object RandomSkillBoost(object oArmor){
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

object RandomSavingThrowBoost(object oArmor){
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

object RandomAbilityBoost(object oArmor){
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

