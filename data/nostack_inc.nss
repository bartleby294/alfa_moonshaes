#include "x2_inc_itemprop"
#include "nw_o0_itemmaker"
#include "nw_i0_spells"
#include "x2_inc_switches"

struct HighestAbilityItem
{
// for returning the highest scoring ability item of a particular ability score
object oItem;
int nScore;
};

struct ItemProperty
{
// for returning an item propery and modifier
    itemproperty ip;
    int nModifier;
    int nFound;
};
//This function safely adds an ability bonus effect to a target, checking for stacking
void DoNoStackAbilityBonus(object oCaster, object oTarget, int nModifier, int nAbility, float fDuration);
// removes ability bonus spells for the ability constant nAbility
void RemoveMagicAbilityBonus(object oTarget, int nAbility);
// applies a penalty of nPenalty score to ability nAbility
void ApplyAbilityPenalty(object oItem, int nPenalty, int nAbility);
// removes a property of nItemPropertyType and Subtype from oItem and returns the property's modifier
int RemovePropertyAndReturnModifier(object oItem, int nItemPropertyType, int nItemPropertySubType = -1);
//Finds the highest bonus item of nType and nSubtype and returns it as well as its score
struct HighestAbilityItem GetHighestBonusItem(object oPC, int nType, int nSubType);
//Finds the highest bonus item of nType and nSubtype on a PC, excluding one item
struct HighestAbilityItem GetHighestBonusItemExcludeOne(object oPC, int nType, int nSubType, object oExclude);
//Gets the total bonus from all items to a particular ability score
int GetTotalAbilityItemBonus(object oPC, int nAbility, int nExclude=0);
//Gets the item property of nType and nSubType on oItem
struct ItemProperty GetItemProperty(object oItem, int nType, int nSubType);
//Restores all items to original state. If nSkill is 0, ability items, if it's 1, skill items.
void RestoreAllItems(object oPC, int nAbility, int nSkill = 0);
//Restores an ability item that's been penalized by this script
void RestoreAbilityItem(object oItem, int nAbility);
//Checks what ability bonuses an item has and writes to nAbilityBonus0-5, local vars on the item
void HasItemAbilityBonus(object oItem);
//Checks of an item has skill bonuses on it and writes to nSkillBonus0-26, local vars on the item
void HasItemSkillBonus(object oItem);
//Restores a skill item neutralized by this script
void RestoreSkillItem(object oItem, int nSkill);
//Neutralizes a skill item and sets its old bonus to
//nSkillX local var on the item where X is the row number of the skill from 0-26
void NeutralizeSkillItem(object oItem, int nSkill);
//Neutralizes all items but one on a PC for the skill nSkill
void NeutralizeAllExcludeOne(object oPC, int nSkill, object oExclude);
//Neutralizes all items but two on a PC for the skill nSkill
void NeutralizeAllExcludeTwo(object oPC, int nSkill, object oExclude, object oExclude2);
void DoNoStackDivinePower();

//This function is to be placed in the OnEquip event if you want to ensure 3E skill stacking
//MAKE SURE YOU PLACE NoSkillStackOnUnEquip in the corresponding OnUnEquip event
void NoSkillStackOnEquip(object oPCEquipper, object oItemEquipped)
{
    int nHasSkill = 0; //do they have the skill?
    struct HighestAbilityItem iHighest; //highest skill bonus score item
    int i; // to cycle skills from 0 to 26

    //SendMessageToPC(oPCEquipper, "Skillitem equiped");

    HasItemSkillBonus(oItemEquipped);

    for (i=0; i<27; ++i) {
        //Does the item equipped have a SkillBonus of type i?
        nHasSkill = GetLocalArrayInt(oItemEquipped, "nSkillBonus", i);
        if (nHasSkill) {
            //Restore all the neutralized skill items
            RestoreAllItems(oPCEquipper, i, 1);
            //find the highest skill item for skill i and neutralize all items except it
            iHighest = GetHighestBonusItem(oPCEquipper, ITEM_PROPERTY_SKILL_BONUS, i);
            NeutralizeAllExcludeOne(oPCEquipper, i, iHighest.oItem);
        }
        nHasSkill = 0;
    }
return;

}
//This function is to be placed in the OnEquip event if you want to ensure 3E Ability stacking
//MAKE SURE YOU PLACE NoAbilityStackOnUnEquip in the corresponding OnUnEquip event
void NoAbilityStackOnEquip(object oPCEquipper, object oItemEquipped)
{
    struct HighestAbilityItem iHighest;
    int i;
    int nTotal = 0; //total ability bonus
    int nDifference = 0; //difference between total and highest single item
    int nHasAbility = 0; //does the item even have an ability bonus?
    HasItemAbilityBonus(oItemEquipped); //set local vars on object if it has ability bonuses

    for (i=0;i<6;++i) {
        nHasAbility = GetLocalArrayInt(oItemEquipped, "nAbilityBonus", i);
        if (nHasAbility) {
            // Remove buffs for the corresponding ability score.
            AssignCommand(oItemEquipped, RemoveMagicAbilityBonus(oPCEquipper, i));
            RestoreAllItems(oPCEquipper, i);
            // get the highest item and total and the difference between them
            iHighest = GetHighestBonusItem(oPCEquipper, ITEM_PROPERTY_ABILITY_BONUS, i);
            nTotal = GetTotalAbilityItemBonus(oPCEquipper, i);
            nDifference = nTotal - iHighest.nScore;
            // If there is a difference, compensate with a penalty on the highest item.
            if (nDifference > 0){
                ApplyAbilityPenalty(iHighest.oItem, nDifference, i);
                SendMessageToPC(oPCEquipper, "You have equipped multiple items that provide an ability score bonus. They will not stack.");
            }
        }
        nHasAbility = 0; //loop again
    }
}
//This function MUST be in the OnUnEquip event if you are using NoSkillStackOnEquip
void NoSkillStackOnUnEquip(object oPCEquipper, object oItemEquipped)
{
//This is similar to the Equip event, except that you must compensate for the fact
//that the unequipped item is still on the character when this even triggers.
//Thus, you must exclude it when calculating the bonuses.
    int i;
    int nHasSkill = 0;
    struct HighestAbilityItem iHighest;

    for (i=0; i<27; ++i) {
        nHasSkill = GetLocalArrayInt(oItemEquipped, "nSkillBonus", i);
        if (nHasSkill) {
            RestoreAllItems(oPCEquipper, i, 1);
            iHighest = GetHighestBonusItemExcludeOne(oPCEquipper, ITEM_PROPERTY_SKILL_BONUS, i, oItemEquipped);
            NeutralizeAllExcludeTwo(oPCEquipper, i, iHighest.oItem, oItemEquipped);
        }
        nHasSkill = 0;
    }
    return;
}

//This function MUST be in the OnUnEquip event if you are using NoAbilityStackOnEquip
void NoAbilityStackOnUnEquip(object oPCEquipper, object oItemEquipped)
{
//See noSkillStackOnUnEquip for explanation of the exclusions of particular items
//Bioware writes very strange Event triggers
    struct HighestAbilityItem iHighest;
    struct ItemProperty isProp;
    int i;
    int nUnEquipValue = 0;
    int nTotal = 0;
    int nDifference = 0;
    int nHasAbility = 0;

    for (i=0; i<6;++i) {
        nHasAbility = GetLocalArrayInt(oItemEquipped, "nAbilityBonus", i);
        if (nHasAbility) {
            isProp = GetItemProperty(oItemEquipped, ITEM_PROPERTY_ABILITY_BONUS, i);
            nUnEquipValue = isProp.nModifier;
            RestoreAbilityItem(oItemEquipped, i);
            iHighest = GetHighestBonusItemExcludeOne(oPCEquipper, ITEM_PROPERTY_ABILITY_BONUS, i, oItemEquipped);
            nTotal = GetTotalAbilityItemBonus(oPCEquipper, i, nUnEquipValue);
            nDifference = nTotal - iHighest.nScore;
            RestoreAbilityItem(iHighest.oItem, i);
            if (nDifference > 0)
                ApplyAbilityPenalty(iHighest.oItem, nDifference, i);
        }
        nHasAbility = 0;
    }
    return;
}
void DoNoStackAbilityBonus(object oCaster, object oTarget, int nModifier, int nAbility, float fDuration)
{
    effect eAbil;
    struct HighestAbilityItem sItem;

    sItem = GetHighestBonusItem(oTarget, ITEM_PROPERTY_ABILITY_BONUS, nAbility);
    nModifier -= sItem.nScore;
    if (nModifier < 1)
        SendMessageToPC(oCaster, "The target's ability score items are too powerful for this spell to have any effect!");
    else {
        eAbil = EffectAbilityIncrease(nAbility,nModifier);
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eAbil, oTarget, fDuration);
    }
}

void RemoveMagicAbilityBonus(object oPC, int nAbility)
{
    switch (nAbility)
    {
        case ABILITY_STRENGTH:
            RemoveEffectsFromSpell(oPC, SPELL_BULLS_STRENGTH);
            RemoveEffectsFromSpell(oPC, SPELL_GREATER_BULLS_STRENGTH);
            RemoveEffectsFromSpell(oPC, SPELL_DIVINE_POWER);
        break;
        case ABILITY_DEXTERITY:
            RemoveEffectsFromSpell(oPC, SPELL_CATS_GRACE);
            RemoveEffectsFromSpell(oPC, SPELL_GREATER_CATS_GRACE);
        break;
        case ABILITY_CONSTITUTION:
            RemoveEffectsFromSpell(oPC, SPELL_ENDURANCE);
            RemoveEffectsFromSpell(oPC, SPELL_GREATER_ENDURANCE);
        break;
        case ABILITY_INTELLIGENCE:
            RemoveEffectsFromSpell(oPC, SPELL_FOXS_CUNNING);
            RemoveEffectsFromSpell(oPC, SPELL_GREATER_FOXS_CUNNING);
        break;
        case ABILITY_WISDOM:
            RemoveEffectsFromSpell(oPC, SPELL_OWLS_WISDOM);
            RemoveEffectsFromSpell(oPC, SPELL_GREATER_OWLS_WISDOM);
        break;
        case ABILITY_CHARISMA:
            RemoveEffectsFromSpell(oPC, SPELL_EAGLE_SPLEDOR);
            RemoveEffectsFromSpell(oPC, SPELL_GREATER_EAGLE_SPLENDOR);
        break;
    }
}

void HasItemAbilityBonus(object oItem)
{
    itemproperty ip = GetFirstItemProperty(oItem);

    while (GetIsItemPropertyValid(ip))
    {
        if (GetItemPropertyType(ip) == ITEM_PROPERTY_ABILITY_BONUS)
            SetLocalArrayInt(oItem, "nAbilityBonus", GetItemPropertySubType(ip), 1);
        ip = GetNextItemProperty(oItem);
    }
}

void RestoreAbilityItem(object oItem, int nAbility)
{
    itemproperty ipAbil = ItemPropertyAbilityBonus(nAbility, 1);

    if (IPGetItemHasProperty(oItem, ipAbil, DURATION_TYPE_PERMANENT))
        IPRemoveMatchingItemProperties(oItem, ITEM_PROPERTY_DECREASED_ABILITY_SCORE, DURATION_TYPE_PERMANENT, nAbility);
}

void RestoreSkillItem(object oItem, int nSkill)
{
    int nModifier = 0;
    itemproperty ipAbil;
    nModifier = GetLocalInt(oItem, "nSkill" + IntToString(nSkill));

    if (nModifier > 0) {
        ipAbil = ItemPropertySkillBonus(nSkill, nModifier);
        IPSafeAddItemProperty(oItem, ipAbil);
        DeleteLocalInt(oItem, "nSkill" + IntToString(nSkill));
    }
}
void RestoreAllItems(object oPC, int nAbility, int nSkill = 0)
{
    int i;
    object oSlot;

    for (i = 0; i < NUM_INVENTORY_SLOTS; ++i) {
        oSlot=GetItemInSlot(i, oPC);
        if (GetIsObjectValid(oSlot))
            if (nSkill)
                RestoreSkillItem(oSlot, nAbility);
            else
                RestoreAbilityItem(oSlot, nAbility);
    }
}

void ApplyAbilityPenalty(object oItem, int nPenalty, int nAbility)
{
    itemproperty ipAbil;


    if (nPenalty > 10)
        nPenalty = 10;

    ipAbil = ItemPropertyDecreaseAbility(nAbility, nPenalty);
    IPSafeAddItemProperty(oItem, ipAbil);
}
void HasItemSkillBonus(object oItem)
{
    itemproperty ip = GetFirstItemProperty(oItem);

    while (GetIsItemPropertyValid(ip))
    {
        if (GetItemPropertyType(ip) == ITEM_PROPERTY_SKILL_BONUS)
            SetLocalArrayInt(oItem, "nSkillBonus", GetItemPropertySubType(ip), 1);
        ip = GetNextItemProperty(oItem);
    }
}
void NeutralizeSkillItem(object oItem, int nSkill)
{
    int nModifier = 0;

    nModifier = RemovePropertyAndReturnModifier(oItem, ITEM_PROPERTY_SKILL_BONUS, nSkill);

    if (nModifier > 0) {
        SetLocalInt(oItem, "nSkill" + IntToString(nSkill), nModifier);
    }
}
void NeutralizeAllExcludeOne(object oPC, int nSkill, object oExclude)
{
    int i;
    object oSlot;
    int nTriggered;

    for (i = 0; i < 18; ++i) {
        oSlot=GetItemInSlot(i, oPC);
        if (GetIsObjectValid(oSlot))
        if (oExclude != oSlot)
           NeutralizeSkillItem(oSlot, nSkill);
    }
}
void NeutralizeAllExcludeTwo(object oPC, int nSkill, object oExclude, object oExclude2)
{
    int i;
    object oSlot;

    for (i = 0; i < NUM_INVENTORY_SLOTS; ++i) {
        oSlot=GetItemInSlot(i, oPC);
        if (GetIsObjectValid(oSlot))
        if (oExclude != oSlot && oExclude2 != oSlot)
           NeutralizeSkillItem(oSlot, nSkill);
    }
}
struct HighestAbilityItem GetHighestBonusItem(object oPC, int nType, int nSubType)
{
    struct HighestAbilityItem iHighest;
    struct ItemProperty isProp;
    object oSlot;
    int i;
    itemproperty ipAbil;
    iHighest.nScore = 0;

    for (i = 0; i < NUM_INVENTORY_SLOTS; ++i) {
        oSlot=GetItemInSlot(i, oPC);
        if (GetIsObjectValid(oSlot)) {
            isProp = GetItemProperty(oSlot, nType, nSubType);
            if (isProp.nFound) {
                if (isProp.nModifier > iHighest.nScore) {
                    iHighest.nScore = isProp.nModifier;
                    iHighest.oItem = oSlot;
                }
            }
        }
    }
    string msg1 = IntToString(iHighest.nScore);
    string msg2 = "Highest modifier is "+msg1;
    //SendMessageToPC(oPC, msg2);

    return iHighest;
}


struct HighestAbilityItem GetHighestBonusItemExcludeOne(object oPC, int nType, int nSubType, object oExclude)
{
    struct HighestAbilityItem iHighest;
    struct ItemProperty isProp;
    object oSlot;
    int i;
    itemproperty ipAbil;
    iHighest.nScore = 0;

    for (i = 0; i < NUM_INVENTORY_SLOTS; ++i) {
        oSlot=GetItemInSlot(i, oPC);
        if (GetIsObjectValid(oSlot)) {
             isProp = GetItemProperty(oSlot, nType, nSubType);
             if (oExclude != oSlot)
                if (isProp.nFound) {

                    if (isProp.nModifier > iHighest.nScore) {
                        iHighest.nScore = isProp.nModifier;
                        iHighest.oItem = oSlot;
                }
            }
        }
    }

    return iHighest;
}

int GetTotalAbilityItemBonus(object oPC, int nAbility, int nSubtract=0)
{
    int i;
    struct ItemProperty isProp;
    object oSlot;
    int nTotal = 0;
    for (i = 0; i < NUM_INVENTORY_SLOTS; ++i) {
            oSlot = GetItemInSlot(i, oPC);
            isProp = GetItemProperty(oSlot, ITEM_PROPERTY_ABILITY_BONUS, nAbility);
            nTotal += isProp.nModifier;
    }
    nTotal -= nSubtract;
    if (nTotal > 12) nTotal = 12;

    return nTotal;
}
struct ItemProperty GetItemProperty(object oItem, int nType, int nSubType)
{
    itemproperty ip = GetFirstItemProperty(oItem);
    struct ItemProperty isProp;
    isProp.nFound = 0;
    isProp.nModifier = 0;
    //PrintString ("Filter - T:" + IntToString(GetItemPropertyType(ipCompareTo))+ " S: " + IntToString(GetItemPropertySubType(ipCompareTo)) + " (Ignore: " + IntToString (bIgnoreSubType) + ") D:" + IntToString(nDurationCompare));
    while (GetIsItemPropertyValid(ip))
    {
        // PrintString ("Testing - T: " + IntToString(GetItemPropertyType(ip)));
        if ((GetItemPropertyType(ip) == nType))
        {
             //PrintString ("**Testing - S: " + IntToString(GetItemPropertySubType(ip)));
             if (GetItemPropertySubType(ip) == nSubType)
             {
               // PrintString ("***Testing - d: " + IntToString(GetItemPropertyDurationType(ip)));
                if (GetItemPropertyDurationType(ip) == DURATION_TYPE_PERMANENT)
                {
                    //PrintString ("***FOUND");
                    isProp.nFound = 1;
                    isProp.nModifier = GetItemPropertyCostTableValue(ip);
                    isProp.ip = ip;
                      return isProp; // if duration is not ignored and durationtypes are equal, true
                 }
            }
        }
        ip = GetNextItemProperty(oItem);
    }
    return isProp;
}
int RemovePropertyAndReturnModifier(object oItem, int nItemPropertyType, int nItemPropertySubType = -1)
{
    itemproperty ip = GetFirstItemProperty(oItem);
    int nBonus = 0;
    // valid ip?
    while (GetIsItemPropertyValid(ip))
    {
        // same property type?
        if ((GetItemPropertyType(ip) == nItemPropertyType))
        {
            // permanent property?
            if (GetItemPropertyDurationType(ip) == DURATION_TYPE_PERMANENT)
            {
                 // same subtype or subtype ignored
                 if  (GetItemPropertySubType(ip) == nItemPropertySubType || nItemPropertySubType == -1)
                 {
                      nBonus = GetItemPropertyCostTableValue(ip);
                      RemoveItemProperty(oItem, ip);
                 }
            }
        }
        ip = GetNextItemProperty(oItem);
    }
    return nBonus;
}
int DoNoStackingOfAbilityScores()
{
// This is the spellhook for the no stacking script
// It overrides ability score spells to prevent them from inadvertently stacking
// with items.
// IF YOU MAKE NEW ABILITY SCORE OR SKILL BONUS SPELLS:
// You need to put them in here and in RemoveMagicAbilityBonus in inc_nostack
// so that they do not stack with items.

// Alternatively, leave them out so that they DO stack(to represent non-enhancement bonuses)


    int nSpell = GetSpellId();
    int nModify = 0; //ability score modifier
    int nActivate = 0; //which type of ability booster is activated, 1 = level 2.
    int nAbility = 0; //which ability score
    object oTarget = GetSpellTargetObject();
    //if an ability booster spell is cast, then trigger our version of the spell

    if (GetIsObjectValid(oTarget) && GetObjectType(oTarget) == OBJECT_TYPE_ITEM)
        return FALSE;

    //SendMessageToPC(OBJECT_SELF, IntToString(nSpell)+" "+IntToString(SPELL_ENDURANCE));
    switch (nSpell)
    {
        case SPELL_CATS_GRACE:
            nActivate = 1;
            nAbility = ABILITY_DEXTERITY;
        break;
        case SPELL_BULLS_STRENGTH:
            nActivate = 1;
            nAbility = ABILITY_STRENGTH;
        break;
        case SPELL_EAGLE_SPLEDOR:
            nActivate = 1;
            nAbility = ABILITY_CHARISMA;
        break;
        case SPELL_ENDURANCE:
            nActivate = 1;
            nAbility = ABILITY_CONSTITUTION;
        break;
        case SPELL_FOXS_CUNNING:
            nActivate = 1;
            nAbility = ABILITY_INTELLIGENCE;
        break;
        case SPELL_OWLS_WISDOM:
            nActivate = 1;
            nAbility = ABILITY_WISDOM;
        break;
        case SPELL_GREATER_BULLS_STRENGTH:
            nActivate = 2;
            nAbility = ABILITY_STRENGTH;
        break;
        case SPELL_GREATER_CATS_GRACE:
            nActivate = 2;
            nAbility = ABILITY_DEXTERITY;
        break;
        case SPELL_GREATER_EAGLE_SPLENDOR:
            nActivate = 2;
            nAbility = ABILITY_CHARISMA;
        break;
        case SPELL_GREATER_ENDURANCE:
            nActivate = 2;
            nAbility = ABILITY_CONSTITUTION;
        break;
        case SPELL_GREATER_FOXS_CUNNING:
            nActivate = 2;
            nAbility = ABILITY_INTELLIGENCE;
        break;
        case SPELL_GREATER_OWLS_WISDOM:
            nActivate = 2;
            nAbility = ABILITY_WISDOM;
        break;
        case SPELL_DIVINE_POWER:
            nActivate = 3;
        break;
        default:
            nActivate = 0;
        //do nothing
        break;
    }

        if (nActivate == 1 || nActivate == 2) {
            // Do the level 2 and level 6 ability score booster spells.
            // SendMessageToPC(OBJECT_SELF, "Spellhook Activated.");
            SetModuleOverrideSpellScriptFinished();
            if (nActivate == 1)
                nModify = d4()+1;
            else if (nActivate == 2)
                nModify = d4(2)+1;

            //Declare major variables
            object oTarget = GetSpellTargetObject();
            effect eVis = EffectVisualEffect(VFX_IMP_IMPROVE_ABILITY_SCORE);
            int nCasterLvl = GetCasterLevel(OBJECT_SELF);

            float fDuration = HoursToSeconds(nCasterLvl);
            int nMetaMagic = GetMetaMagicFeat();
            //Signal the spell cast at event
            SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELL_BULLS_STRENGTH, FALSE));
            //Enter Metamagic conditions
            if (nMetaMagic == METAMAGIC_MAXIMIZE) {
                if (nActivate == 1)
                    nModify = 5;//Damage is at max
                if (nActivate == 2)
                    nModify = 9;
            }
            if (nMetaMagic == METAMAGIC_EMPOWER) {
                nModify = nModify + (nModify/2);
            }
            if (nMetaMagic == METAMAGIC_EXTEND) {
                fDuration = fDuration * 2.0;    //Duration is +100%
            }
            ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget);
            DoNoStackAbilityBonus(OBJECT_SELF, oTarget, nModify, nAbility, fDuration);
            return TRUE;
        }
        else if (nActivate == 3) {
            SetModuleOverrideSpellScriptFinished();
            DoNoStackDivinePower();
            return TRUE;
        }
        return FALSE;

 }

void DoNoStackDivinePower()
{
        object oTarget = GetSpellTargetObject();
        int nLevel = GetCasterLevel(OBJECT_SELF);
        int nHP = nLevel;
        int nAttack = nLevel - ((nLevel/4)*3) ;
        int nMetaMagic = GetMetaMagicFeat();
        effect eVis = EffectVisualEffect(VFX_IMP_SUPER_HEROISM);
        effect eHP = EffectTemporaryHitpoints(nHP);
        effect eAttack = EffectAttackIncrease(nAttack);
        effect eAttackMod = EffectModifyAttacks(CalcNumberOfAttacks());
        effect eDur = EffectVisualEffect(VFX_DUR_CESSATE_POSITIVE);
        effect eLink = EffectLinkEffects(eAttack, eAttackMod);

        eLink = EffectLinkEffects(eLink, eDur);

        //Meta-Magic
        if(nMetaMagic == METAMAGIC_EXTEND)
        {
            nLevel *= 2;
        }
        RemoveEffectsFromSpell(oTarget, GetSpellId());
        RemoveTempHitPoints();
        float fDuration = RoundsToSeconds(nLevel);
        //Fire cast spell at event for the specified target
        SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELL_DIVINE_POWER, FALSE));

        //Apply Link and VFX effects to the target
        DoNoStackAbilityBonus(OBJECT_SELF, OBJECT_SELF, 6, ABILITY_STRENGTH, fDuration);
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oTarget, fDuration);
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eHP, oTarget, fDuration);
        ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget);
}
