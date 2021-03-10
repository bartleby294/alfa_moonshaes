#include "x0_i0_stringlib"

int SKILL_CLIMB = 28;
int SKILL_SENSE = 29;
int SKILL_FORGERY = 30;
int SKILL_INNUENDO = 31;
int SKILL_JUMP = 32;
int SKILL_SWIM = 33;





//Function to check if an item is in the inventory of the anvil.
int HasItem(string sItem){
 object oInventory = GetFirstItemInInventory(OBJECT_SELF);
 while (GetIsObjectValid(oInventory) == TRUE)
    {
        //sItemToTake = GetTag(oInventory);


        if(GetTag(oInventory) == sItem)
        {
            return TRUE;
        }


        oInventory = GetNextItemInInventory(OBJECT_SELF);

    }
    return FALSE;

}



//Function to get the weapon size for DC adjustment
int GetWeaponSize(object oWeapon){


if( GetBaseItemType(oWeapon) == BASE_ITEM_DAGGER ||
    GetBaseItemType(oWeapon) == BASE_ITEM_SLING ||
    GetBaseItemType(oWeapon) == BASE_ITEM_DART ||
    GetBaseItemType(oWeapon) == BASE_ITEM_GLOVES ||
    GetBaseItemType(oWeapon) == 213 ||        //shovel
    GetBaseItemType(oWeapon) == 215 ||        //nunchuck
    GetBaseItemType(oWeapon) == BASE_ITEM_KUKRI )
return 1;

if( GetBaseItemType(oWeapon) == BASE_ITEM_LIGHTMACE ||
    GetBaseItemType(oWeapon) == BASE_ITEM_SICKLE ||
    GetBaseItemType(oWeapon) == BASE_ITEM_ARROW ||
    GetBaseItemType(oWeapon) == BASE_ITEM_BOLT ||
    GetBaseItemType(oWeapon) == BASE_ITEM_BULLET ||
    GetBaseItemType(oWeapon) == BASE_ITEM_HANDAXE ||
    GetBaseItemType(oWeapon) == 212 ||        //Pickaxe
    GetBaseItemType(oWeapon) == 213 ||        //Tools
    GetBaseItemType(oWeapon) == 214 ||        //Sai
    GetBaseItemType(oWeapon) == 215 ||        //Nunchuck
    GetBaseItemType(oWeapon) == 216 ||        //Tools
    GetBaseItemType(oWeapon) == 217 ||        //Lance
    GetBaseItemType(oWeapon) == BASE_ITEM_SHORTSWORD ||
    GetBaseItemType(oWeapon) == BASE_ITEM_SHORTSPEAR ||
    GetBaseItemType(oWeapon) == BASE_ITEM_KAMA ||
    GetBaseItemType(oWeapon) == BASE_ITEM_LIGHTHAMMER ||
    GetBaseItemType(oWeapon) == BASE_ITEM_CLUB ||
    GetBaseItemType(oWeapon) == BASE_ITEM_WHIP
    )
return 2;

if(
    GetBaseItemType(oWeapon) == BASE_ITEM_MAGICSTAFF ||
    GetBaseItemType(oWeapon) == BASE_ITEM_MORNINGSTAR ||
    GetBaseItemType(oWeapon) == BASE_ITEM_BATTLEAXE ||
    GetBaseItemType(oWeapon) == BASE_ITEM_THROWINGAXE ||
    GetBaseItemType(oWeapon) == BASE_ITEM_LIGHTFLAIL ||
    GetBaseItemType(oWeapon) == BASE_ITEM_LONGSWORD ||
    GetBaseItemType(oWeapon) == BASE_ITEM_SCIMITAR ||
    GetBaseItemType(oWeapon) == BASE_ITEM_WARHAMMER ||
    GetBaseItemType(oWeapon) == BASE_ITEM_LIGHTCROSSBOW ||
    GetBaseItemType(oWeapon) == BASE_ITEM_SHORTBOW

    )
return 3;

if( GetBaseItemType(oWeapon) == BASE_ITEM_QUARTERSTAFF ||
    GetBaseItemType(oWeapon) == BASE_ITEM_GREATAXE ||
    GetBaseItemType(oWeapon) == BASE_ITEM_GREATSWORD ||
    GetBaseItemType(oWeapon) == BASE_ITEM_HALBERD ||
    GetBaseItemType(oWeapon) == BASE_ITEM_HEAVYFLAIL ||
    GetBaseItemType(oWeapon) == BASE_ITEM_TRIDENT ||
    GetBaseItemType(oWeapon) == 210 ||        //greathammer
    GetBaseItemType(oWeapon) == BASE_ITEM_SCYTHE
    )
return 4;

if( GetBaseItemType(oWeapon) == BASE_ITEM_DIREMACE ||
    GetBaseItemType(oWeapon) == BASE_ITEM_DOUBLEAXE ||
    GetBaseItemType(oWeapon) == BASE_ITEM_TWOBLADEDSWORD ||
    GetBaseItemType(oWeapon) == BASE_ITEM_BASTARDSWORD ||
    GetBaseItemType(oWeapon) == BASE_ITEM_DWARVENWARAXE ||
    GetBaseItemType(oWeapon) == BASE_ITEM_RAPIER ||
    GetBaseItemType(oWeapon) == BASE_ITEM_LONGBOW ||
    GetBaseItemType(oWeapon) == BASE_ITEM_HEAVYCROSSBOW ||
    GetBaseItemType(oWeapon) == BASE_ITEM_KATANA
    )
return 5;


SpeakString("Unknown Weapon Type:" + IntToString(GetBaseItemType(oWeapon)));

return -1;



}


//Get the highest attribute

int GetHighAbility(object oPC){

int iAbility = ABILITY_STRENGTH;
int iScore = 0;

iScore = GetAbilityScore(oPC, ABILITY_STRENGTH, FALSE);



if(iScore < GetAbilityScore(oPC, ABILITY_DEXTERITY, FALSE)){
  iScore = GetAbilityScore(oPC, ABILITY_DEXTERITY, FALSE);
  iAbility = ABILITY_DEXTERITY;
}
if(iScore == GetAbilityScore(oPC, ABILITY_DEXTERITY, FALSE && d2() == 1)){
  iScore = GetAbilityScore(oPC, ABILITY_DEXTERITY, FALSE);
  iAbility = ABILITY_DEXTERITY;
}
if(iScore < GetAbilityScore(oPC, ABILITY_CONSTITUTION, FALSE)){
  iScore = GetAbilityScore(oPC, ABILITY_CONSTITUTION, FALSE);
  iAbility = ABILITY_CONSTITUTION;
}
if(iScore == GetAbilityScore(oPC, ABILITY_CONSTITUTION, FALSE) && d2() == 1){
  iScore = GetAbilityScore(oPC, ABILITY_CONSTITUTION, FALSE);
  iAbility = ABILITY_CONSTITUTION;
}
if(iScore < GetAbilityScore(oPC, ABILITY_INTELLIGENCE, FALSE)){
  iScore = GetAbilityScore(oPC, ABILITY_INTELLIGENCE, FALSE);
  iAbility = ABILITY_INTELLIGENCE;
}
if(iScore == GetAbilityScore(oPC, ABILITY_INTELLIGENCE, FALSE) && d2() == 1){
  iScore = GetAbilityScore(oPC, ABILITY_INTELLIGENCE, FALSE);
  iAbility = ABILITY_INTELLIGENCE;
}
if(iScore < GetAbilityScore(oPC, ABILITY_WISDOM, FALSE)){
  iScore = GetAbilityScore(oPC, ABILITY_WISDOM, FALSE);
  iAbility = ABILITY_WISDOM;
}
if(iScore == GetAbilityScore(oPC, ABILITY_WISDOM, FALSE) && d2() == 1){
  iScore = GetAbilityScore(oPC, ABILITY_WISDOM, FALSE);
  iAbility = ABILITY_WISDOM;
}
if(iScore < GetAbilityScore(oPC, ABILITY_CHARISMA, FALSE)){
  iScore = GetAbilityScore(oPC, ABILITY_CHARISMA, FALSE);
  iAbility = ABILITY_CHARISMA;
}
if(iScore == GetAbilityScore(oPC, ABILITY_CHARISMA, FALSE) && d2() == 1){
  iScore = GetAbilityScore(oPC, ABILITY_CHARISMA, FALSE);
  iAbility = ABILITY_CHARISMA;
}

return iAbility;

}



//Get the lowest attribute

int GetLowAbility(object oPC){

int iAbility = ABILITY_STRENGTH;
int iScore = 0;

iScore = GetAbilityScore(oPC, ABILITY_STRENGTH, FALSE);



if(iScore > GetAbilityScore(oPC, ABILITY_DEXTERITY, FALSE)){
  iScore = GetAbilityScore(oPC, ABILITY_DEXTERITY, FALSE);
  iAbility = ABILITY_DEXTERITY;
}
if(iScore > GetAbilityScore(oPC, ABILITY_CONSTITUTION, FALSE)){
  iScore = GetAbilityScore(oPC, ABILITY_CONSTITUTION, FALSE);
  iAbility = ABILITY_CONSTITUTION;
}
if(iScore > GetAbilityScore(oPC, ABILITY_INTELLIGENCE, FALSE)){
  iScore = GetAbilityScore(oPC, ABILITY_INTELLIGENCE, FALSE);
  iAbility = ABILITY_INTELLIGENCE;
}
if(iScore > GetAbilityScore(oPC, ABILITY_WISDOM, FALSE)){
  iScore = GetAbilityScore(oPC, ABILITY_WISDOM, FALSE);
  iAbility = ABILITY_WISDOM;
}
if(iScore > GetAbilityScore(oPC, ABILITY_CHARISMA, FALSE)){
  iScore = GetAbilityScore(oPC, ABILITY_CHARISMA, FALSE);
  iAbility = ABILITY_CHARISMA;
}

return iAbility;

}





void GoodEffect(object oWeapon, object oPC){

int nWeight;
int nBonus = 0;

int nAbility;

int i;
int nSkill;
int nSave;
int nDamageType;
int nAlignGroup;
int nAlignGroupOp;

int iMultiplier = 0;



//Weight Reduction

if(HasItem("ay_ingot_iron")){
  nWeight = IP_CONST_REDUCEDWEIGHT_80_PERCENT;
  nBonus = 1;
}
else if(HasItem("ay_ingot_silver")){
  nWeight = IP_CONST_REDUCEDWEIGHT_60_PERCENT;
  nBonus = 2;
}
else if(HasItem("ay_ingot_dsteel")){
  nWeight = IP_CONST_REDUCEDWEIGHT_40_PERCENT;
  nBonus = 3;
}
else if(HasItem("ay_ingot_adaman")){
  nWeight = IP_CONST_REDUCEDWEIGHT_20_PERCENT;
  nBonus = 4;
}
else if(HasItem("ay_ingot_mithral")){
  nWeight = IP_CONST_REDUCEDWEIGHT_10_PERCENT;
  nBonus = 5;
}

AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyWeightReduction(nWeight),oWeapon);


nAbility = GetHighAbility(oPC);

//PC based

/*int SKILL_CLIMB = 28;
int SKILL_SENSE = 29;
int SKILL_FORGERY = 30;
int SKILL_INNUENDO = 31;
int SKILL_JUMP = 32;
int SKILL_SWIM = 33;
int SKILL_RIDE = 34;*/


i = Random(100);

if(i >= 20){

  if(nAbility == ABILITY_STRENGTH){
    nSave = IP_CONST_SAVEBASETYPE_FORTITUDE;
    SendMessageToPC(oPC, "Some of your Strength goes into the weapon");
    switch(Random(4)){
      case 0:
        nSkill = SKILL_DISCIPLINE;
        break;
      case 1:
        nSkill = SKILL_CLIMB;
        break;
      case 2:
        nSkill = SKILL_JUMP;
        break;
      case 3:
        nSkill = SKILL_SWIM;
        break;
    }

  }

  if(nAbility == ABILITY_DEXTERITY){
    nSave = IP_CONST_SAVEBASETYPE_REFLEX;
    SendMessageToPC(oPC, "Some of your Dexterity goes into the weapon");
    switch(Random(7)){
      case 0:
        nSkill = SKILL_HIDE;
        break;
      case 1:
        nSkill = SKILL_MOVE_SILENTLY;
        break;
      case 2:
        nSkill = SKILL_OPEN_LOCK;
        break;
      case 3:
        nSkill = SKILL_PARRY;
        break;
      case 4:
        nSkill = SKILL_PICK_POCKET;
        break;
      case 5:
        nSkill = SKILL_SET_TRAP;
        break;
      case 6:
        nSkill = SKILL_TUMBLE;
        break;
    }

  }

  if(nAbility == ABILITY_CONSTITUTION){
    nSave = IP_CONST_SAVEBASETYPE_FORTITUDE;
    SendMessageToPC(oPC, "Some of your Constitution goes into the weapon");
    switch(Random(4)){
      case 0:
        nSkill = SKILL_DISCIPLINE;
        break;
      case 1:
        nSkill = SKILL_CONCENTRATION;
        break;
      case 2:
        nSkill = SKILL_JUMP;
        break;
      case 3:
        nSkill = SKILL_SWIM;
        break;
    }

  }


  if(nAbility == ABILITY_INTELLIGENCE){
    nSave = IP_CONST_SAVEBASETYPE_WILL;
    SendMessageToPC(oPC, "Some of your Intellect goes into the weapon");
    switch(Random(7)){
      case 0:
        nSkill = SKILL_APPRAISE;
        break;
      case 1:
        nSkill = SKILL_CRAFT_ARMOR;
        break;
      case 2:
        nSkill = SKILL_CRAFT_TRAP;
        break;
      case 3:
        nSkill = SKILL_DISABLE_TRAP;
        break;
      case 4:
        nSkill = SKILL_LORE;
        break;
      case 5:
        nSkill = SKILL_SEARCH;
        break;
      case 6:
        nSkill = SKILL_SPELLCRAFT;
        break;
    }

  }



  if(nAbility == ABILITY_WISDOM){
    nSave = IP_CONST_SAVEBASETYPE_WILL;
    SendMessageToPC(oPC, "Some of your Wisdom goes into the weapon");
    switch(Random(4)){
      case 0:
        nSkill = SKILL_HEAL;
        break;
      case 1:
        nSkill = SKILL_LISTEN;
        break;
      case 2:
        nSkill = SKILL_SPOT;
        break;
      case 3:
        nSkill = SKILL_SENSE;
        break;
    }

  }



  if(nAbility == ABILITY_CHARISMA){
    nSave = IP_CONST_SAVEBASETYPE_REFLEX;
    SendMessageToPC(oPC, "Some of your Charm goes into the weapon");
    switch(Random(7)){
      case 0:
        nSkill = SKILL_ANIMAL_EMPATHY;
        break;
      case 1:
        nSkill = SKILL_BLUFF;
        break;
      case 2:
        nSkill = SKILL_INTIMIDATE;
        break;
      case 3:
        nSkill = SKILL_PERFORM;
        break;
      case 4:
        nSkill = SKILL_PERSUADE;
        break;
      case 5:
        nSkill = SKILL_TAUNT;
        break;
      case 6:
        nSkill = SKILL_USE_MAGIC_DEVICE;
        break;
    }

  }



  if(i >= 20 && i <= 50)
    AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertySkillBonus(nSkill, Random(nBonus)+1), oWeapon);
  else if(i > 50 && i <= 90){
    if(nAbility == ABILITY_CHARISMA)
      AddItemProperty(DURATION_TYPE_PERMANENT, ItemPropertyBonusSavingThrowVsX(IP_CONST_SAVEVS_UNIVERSAL, Random(nBonus)+1),oWeapon);
    else
      AddItemProperty(DURATION_TYPE_PERMANENT, ItemPropertyBonusSavingThrow(nSave, Random(nBonus)+1),oWeapon);
  }
  else if( i > 90)
    AddItemProperty(DURATION_TYPE_PERMANENT, ItemPropertyAbilityBonus(nAbility, Random(nBonus)+1),oWeapon);

}

//Generic


i = Random(100) + GetSkillRank(SKILL_CRAFT_WEAPON, oPC) - (10 * nBonus);

if(i >= 50){
  if(d2() == 1)
    AddItemProperty(DURATION_TYPE_PERMANENT, ItemPropertyAttackBonus(nBonus+1),oWeapon);

  else{
    switch(d3()){
      case 1:
        nDamageType = IP_CONST_DAMAGETYPE_SLASHING;
        break;
      case 2:
        nDamageType = IP_CONST_DAMAGETYPE_PIERCING;
        break;
      case 3:
        nDamageType = IP_CONST_DAMAGETYPE_BLUDGEONING;
        break;
    }
    AddItemProperty(DURATION_TYPE_PERMANENT, ItemPropertyDamageBonus(nDamageType, nBonus+1),oWeapon);


  }
}



//Alignment based


i = GetGoodEvilValue(oPC);
if(GetGoodEvilValue(oPC) <= 30){
  i = 100 - GetGoodEvilValue(oPC);
  nAlignGroup = IP_CONST_ALIGNMENTGROUP_GOOD;
  nDamageType = IP_CONST_DAMAGETYPE_NEGATIVE;
  nAlignGroupOp = IP_CONST_ALIGNMENTGROUP_EVIL;
}
if(GetGoodEvilValue(oPC) > 30 && GetGoodEvilValue(oPC) < 70){
  nAlignGroup = IP_CONST_ALIGNMENTGROUP_NEUTRAL;
  if(GetGoodEvilValue(oPC) <= 50)
    i = GetGoodEvilValue(oPC) + 40;
  else
    i = (100 - GetGoodEvilValue(oPC)) + 40;
  nDamageType = IP_CONST_DAMAGETYPE_MAGICAL;
  nAlignGroupOp = IP_CONST_ALIGNMENTGROUP_NEUTRAL;
}
if(GetGoodEvilValue(oPC) >= 70){
  i = GetGoodEvilValue(oPC);
  nAlignGroup = IP_CONST_ALIGNMENTGROUP_EVIL;
  nAlignGroupOp = IP_CONST_ALIGNMENTGROUP_GOOD;
  if(d2()==1) nDamageType = IP_CONST_DAMAGETYPE_POSITIVE;
  else nDamageType = IP_CONST_DAMAGETYPE_DIVINE;
}




if(Random(100) + (i - 70) >= 98){

  SendMessageToPC(oPC, "Some of your Alignment goes into the weapon");
  switch(d3()){
    case 1:
      AddItemProperty(DURATION_TYPE_PERMANENT, ItemPropertyAttackBonusVsAlign(nAlignGroup, nBonus+1),oWeapon);
      break;

    case 2:
      AddItemProperty(DURATION_TYPE_PERMANENT, ItemPropertyACBonusVsAlign(nAlignGroup, Random(nBonus)+1),oWeapon);
      break;

    case 3:
      AddItemProperty(DURATION_TYPE_PERMANENT, ItemPropertyDamageBonusVsAlign(nAlignGroup, nDamageType, nBonus+1),oWeapon);
      break;
  }
  AddItemProperty(DURATION_TYPE_PERMANENT, ItemPropertyLimitUseByAlign(nAlignGroupOp),oWeapon);

  if(d100() > 70 && (GetLevelByClass(CLASS_TYPE_CLERIC, oPC) || GetLevelByClass(CLASS_TYPE_PALADIN, oPC))){
    if(d6() <= 3)
      AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyBonusFeat(IP_CONST_FEAT_EXTRA_TURNING),oWeapon);
    else{
      AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyCastSpell(IP_CONST_CASTSPELL_DIVINE_MIGHT_5, IP_CONST_CASTSPELL_NUMUSES_1_CHARGE_PER_USE),oWeapon);
      SetItemCharges(oWeapon, 50);
    }
  }

}



//Class based

if(GetHasFeat(FEAT_FAVORED_ENEMY_ABERRATION, oPC) && (d100() + (GetLevelByClass(CLASS_TYPE_RANGER, oPC) * 5) > 70 +  (10 * nBonus)))
  AddItemProperty(DURATION_TYPE_PERMANENT, ItemPropertyDamageBonusVsRace(IP_CONST_RACIALTYPE_ABERRATION, Random(3), Random(nBonus)+1),oWeapon);

if(GetHasFeat(FEAT_FAVORED_ENEMY_ANIMAL, oPC) && (d100() + (GetLevelByClass(CLASS_TYPE_RANGER, oPC) * 5) > 70+  (10 * nBonus)))
  AddItemProperty(DURATION_TYPE_PERMANENT, ItemPropertyDamageBonusVsRace(IP_CONST_RACIALTYPE_ANIMAL, Random(3), Random(nBonus)+1),oWeapon);

if(GetHasFeat(FEAT_FAVORED_ENEMY_BEAST, oPC) && (d100() + (GetLevelByClass(CLASS_TYPE_RANGER, oPC) * 5) > 70+  (10 * nBonus)))
  AddItemProperty(DURATION_TYPE_PERMANENT, ItemPropertyDamageBonusVsRace(IP_CONST_RACIALTYPE_BEAST, Random(3), Random(nBonus)+1),oWeapon);

if(GetHasFeat(FEAT_FAVORED_ENEMY_CONSTRUCT, oPC) && (d100() + (GetLevelByClass(CLASS_TYPE_RANGER, oPC) * 5) > 70+  (10 * nBonus)))
  AddItemProperty(DURATION_TYPE_PERMANENT, ItemPropertyDamageBonusVsRace(IP_CONST_RACIALTYPE_CONSTRUCT, Random(3), Random(nBonus)+1),oWeapon);

if(GetHasFeat(FEAT_FAVORED_ENEMY_DRAGON, oPC) && (d100() + (GetLevelByClass(CLASS_TYPE_RANGER, oPC) * 5) > 85+  (70 * nBonus)))
  AddItemProperty(DURATION_TYPE_PERMANENT, ItemPropertyDamageBonusVsRace(IP_CONST_RACIALTYPE_DRAGON, Random(3), Random(nBonus)+1),oWeapon);

if(GetHasFeat(FEAT_FAVORED_ENEMY_DWARF, oPC) && (d100() + (GetLevelByClass(CLASS_TYPE_RANGER, oPC) * 5) > 85+  (70 * nBonus)))
  AddItemProperty(DURATION_TYPE_PERMANENT, ItemPropertyDamageBonusVsRace(IP_CONST_RACIALTYPE_DWARF, Random(3), Random(nBonus)+1),oWeapon);

if(GetHasFeat(FEAT_FAVORED_ENEMY_ELEMENTAL, oPC) && (d100() + (GetLevelByClass(CLASS_TYPE_RANGER, oPC) * 5) > 70+  (10 * nBonus)))
  AddItemProperty(DURATION_TYPE_PERMANENT, ItemPropertyDamageBonusVsRace(IP_CONST_RACIALTYPE_ELEMENTAL, Random(3), Random(nBonus)+1),oWeapon);

if(GetHasFeat(FEAT_FAVORED_ENEMY_ELF, oPC) && (d100() + (GetLevelByClass(CLASS_TYPE_RANGER, oPC) * 5) > 70+  (10 * nBonus)))
  AddItemProperty(DURATION_TYPE_PERMANENT, ItemPropertyDamageBonusVsRace(IP_CONST_RACIALTYPE_ELF, Random(3), Random(nBonus)+1),oWeapon);

if(GetHasFeat(FEAT_FAVORED_ENEMY_FEY, oPC) && (d100() + (GetLevelByClass(CLASS_TYPE_RANGER, oPC) * 5) > 70+  (10 * nBonus)))
  AddItemProperty(DURATION_TYPE_PERMANENT, ItemPropertyDamageBonusVsRace(IP_CONST_RACIALTYPE_FEY, Random(3), Random(nBonus)+1),oWeapon);

if(GetHasFeat(FEAT_FAVORED_ENEMY_GIANT, oPC) && (d100() + (GetLevelByClass(CLASS_TYPE_RANGER, oPC) * 5) > 70+  (10 * nBonus)))
  AddItemProperty(DURATION_TYPE_PERMANENT, ItemPropertyDamageBonusVsRace(IP_CONST_RACIALTYPE_GIANT, Random(3), Random(nBonus)+1),oWeapon);

if(GetHasFeat(FEAT_FAVORED_ENEMY_GOBLINOID, oPC) && (d100() + (GetLevelByClass(CLASS_TYPE_RANGER, oPC) * 5) > 70+  (10 * nBonus)))
  AddItemProperty(DURATION_TYPE_PERMANENT, ItemPropertyDamageBonusVsRace(IP_CONST_RACIALTYPE_HUMANOID_GOBLINOID, Random(3), Random(nBonus)+1),oWeapon);

if(GetHasFeat(FEAT_FAVORED_ENEMY_GNOME, oPC) && (d100() + (GetLevelByClass(CLASS_TYPE_RANGER, oPC) * 5) > 70+  (10 * nBonus)))
  AddItemProperty(DURATION_TYPE_PERMANENT, ItemPropertyDamageBonusVsRace(IP_CONST_RACIALTYPE_GNOME, Random(3), Random(nBonus)+1),oWeapon);

if(GetHasFeat(FEAT_FAVORED_ENEMY_HALFELF, oPC) && (d100() + (GetLevelByClass(CLASS_TYPE_RANGER, oPC) * 5) > 70+  (10 * nBonus)))
  AddItemProperty(DURATION_TYPE_PERMANENT, ItemPropertyDamageBonusVsRace(IP_CONST_RACIALTYPE_HALFELF, Random(3), Random(nBonus)+1),oWeapon);

if(GetHasFeat(FEAT_FAVORED_ENEMY_HALFLING, oPC) && (d100() + (GetLevelByClass(CLASS_TYPE_RANGER, oPC) * 5) > 70+  (10 * nBonus)))
  AddItemProperty(DURATION_TYPE_PERMANENT, ItemPropertyDamageBonusVsRace(IP_CONST_RACIALTYPE_HALFLING, Random(3), Random(nBonus)+1),oWeapon);

if(GetHasFeat(FEAT_FAVORED_ENEMY_HALFORC, oPC) && (d100() + (GetLevelByClass(CLASS_TYPE_RANGER, oPC) * 5) > 70+  (10 * nBonus)))
  AddItemProperty(DURATION_TYPE_PERMANENT, ItemPropertyDamageBonusVsRace(IP_CONST_RACIALTYPE_HALFORC, Random(3), Random(nBonus)+1),oWeapon);

if(GetHasFeat(FEAT_FAVORED_ENEMY_HUMAN, oPC) && (d100() + (GetLevelByClass(CLASS_TYPE_RANGER, oPC) * 5) > 70+  (10 * nBonus)))
  AddItemProperty(DURATION_TYPE_PERMANENT, ItemPropertyDamageBonusVsRace(IP_CONST_RACIALTYPE_HUMAN, Random(3), Random(nBonus)+1),oWeapon);

if(GetHasFeat(FEAT_FAVORED_ENEMY_MAGICAL_BEAST, oPC) && (d100() + (GetLevelByClass(CLASS_TYPE_RANGER, oPC) * 5) > 70+  (10 * nBonus)))
  AddItemProperty(DURATION_TYPE_PERMANENT, ItemPropertyDamageBonusVsRace(IP_CONST_RACIALTYPE_MAGICAL_BEAST, Random(3), Random(nBonus)+1),oWeapon);

if(GetHasFeat(FEAT_FAVORED_ENEMY_MONSTROUS, oPC) && (d100() + (GetLevelByClass(CLASS_TYPE_RANGER, oPC) * 5) > 70+  (10 * nBonus)))
  AddItemProperty(DURATION_TYPE_PERMANENT, ItemPropertyDamageBonusVsRace(IP_CONST_RACIALTYPE_HUMANOID_MONSTROUS, Random(3), Random(nBonus)+1),oWeapon);

if(GetHasFeat(FEAT_FAVORED_ENEMY_ORC, oPC) && (d100() + (GetLevelByClass(CLASS_TYPE_RANGER, oPC) * 5) > 85+  (10 * nBonus)))
  AddItemProperty(DURATION_TYPE_PERMANENT, ItemPropertyDamageBonusVsRace(IP_CONST_RACIALTYPE_HUMANOID_ORC, Random(3), Random(nBonus)+1),oWeapon);

if(GetHasFeat(FEAT_FAVORED_ENEMY_OUTSIDER, oPC) && (d100() + (GetLevelByClass(CLASS_TYPE_RANGER, oPC) * 5) > 70+  (10 * nBonus)))
  AddItemProperty(DURATION_TYPE_PERMANENT, ItemPropertyDamageBonusVsRace(IP_CONST_RACIALTYPE_OUTSIDER, Random(3), Random(nBonus)+1),oWeapon);

if(GetHasFeat(FEAT_FAVORED_ENEMY_REPTILIAN, oPC) && (d100() + (GetLevelByClass(CLASS_TYPE_RANGER, oPC) * 5) > 70+  (10 * nBonus)))
  AddItemProperty(DURATION_TYPE_PERMANENT, ItemPropertyDamageBonusVsRace(IP_CONST_RACIALTYPE_HUMANOID_REPTILIAN, Random(3), Random(nBonus)+1),oWeapon);

if(GetHasFeat(FEAT_FAVORED_ENEMY_SHAPECHANGER, oPC) && (d100() + (GetLevelByClass(CLASS_TYPE_RANGER, oPC) * 5) > 70))
  AddItemProperty(DURATION_TYPE_PERMANENT, ItemPropertyDamageBonusVsRace(IP_CONST_RACIALTYPE_SHAPECHANGER, Random(3), Random(nBonus)+1),oWeapon);

if(GetHasFeat(FEAT_FAVORED_ENEMY_UNDEAD, oPC) && (d100() + (GetLevelByClass(CLASS_TYPE_RANGER, oPC) * 5) > 70+  (10 * nBonus)))
  AddItemProperty(DURATION_TYPE_PERMANENT, ItemPropertyDamageBonusVsRace(IP_CONST_RACIALTYPE_UNDEAD, Random(3), Random(nBonus)+1),oWeapon);

if(GetHasFeat(FEAT_FAVORED_ENEMY_VERMIN, oPC) && (d100() + (GetLevelByClass(CLASS_TYPE_RANGER, oPC) * 5) > 70+  (10 * nBonus)))
  AddItemProperty(DURATION_TYPE_PERMANENT, ItemPropertyDamageBonusVsRace(IP_CONST_RACIALTYPE_VERMIN, Random(3), Random(nBonus)+1),oWeapon);



if(GetLevelByClass(CLASS_TYPE_BARD, oPC)){
  if(Random(100) + GetSkillRank(SKILL_PERFORM ,oPC) > 70 +  (10 * nBonus)){
    SendMessageToPC(oPC, "Some of your Bard abilities go into the weapon");
    AddItemProperty(DURATION_TYPE_PERMANENT, ItemPropertyDamageBonus(IP_CONST_DAMAGETYPE_SONIC, Random(nBonus)+1),oWeapon);
  }
}



//ranged weapons

if(GetBaseItemType(oWeapon) == BASE_ITEM_LIGHTCROSSBOW ||
   GetBaseItemType(oWeapon) == BASE_ITEM_LONGBOW ||
   GetBaseItemType(oWeapon) == BASE_ITEM_SHORTBOW ||
   GetBaseItemType(oWeapon) == BASE_ITEM_HEAVYCROSSBOW ||
   GetBaseItemType(oWeapon) == BASE_ITEM_SHURIKEN
   )
   {
   if(GetAbilityModifier(ABILITY_STRENGTH, oPC) > 0)
     AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyMaxRangeStrengthMod(Random(GetAbilityModifier(ABILITY_STRENGTH, oPC)) +1),oWeapon);






   }









//Two Hander weapons

if(GetWeaponSize(oWeapon) == 4){

  switch(d6()){
    case 1:
      AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyMassiveCritical(Random(nBonus)+1),oWeapon);
      break;
    case 2:
      AddItemProperty(DURATION_TYPE_PERMANENT, ItemPropertyACBonus(Random(nBonus)+1),oWeapon);
      break;
    case 3:
      AddItemProperty(DURATION_TYPE_PERMANENT, ItemPropertyDamageBonus(IP_CONST_DAMAGETYPE_PIERCING, nBonus+1),oWeapon);
      break;
    case 4:
      AddItemProperty(DURATION_TYPE_PERMANENT, ItemPropertyDamageBonus(IP_CONST_DAMAGETYPE_BLUDGEONING, nBonus+1),oWeapon);
      break;
    case 5:
      AddItemProperty(DURATION_TYPE_PERMANENT, ItemPropertyDamageBonus(IP_CONST_DAMAGETYPE_SLASHING, nBonus+1),oWeapon);
      break;
  }
}


}





void BadEffect(object oWeapon, object oPC){


int nWeight;
int nBonus = 0;

int nAbility;

int i;
int nSkill;
int nSave;
int nDamageType;
int nAlignGroup;
int nAlignGroupOp;



//Weight Increase

if(HasItem("ay_ingot_iron")){
  nWeight = IP_CONST_WEIGHTINCREASE_5_LBS;
  nBonus = 1;
}
else if(HasItem("ay_ingot_silver")){
  nWeight = IP_CONST_WEIGHTINCREASE_10_LBS;
  nBonus = 2;
}
else if(HasItem("ay_ingot_dsteel")){
  nWeight = IP_CONST_WEIGHTINCREASE_15_LBS;
  nBonus = 3;
}
else if(HasItem("ay_ingot_adaman")){
  nWeight = IP_CONST_WEIGHTINCREASE_15_LBS;
  nBonus = 4;
}
else if(HasItem("ay_ingot_mithral")){
  nWeight = IP_CONST_WEIGHTINCREASE_30_LBS;
  nBonus = 5;
}

AddItemProperty(DURATION_TYPE_PERMANENT, ItemPropertyWeightIncrease(nWeight),oWeapon);


nAbility = GetLowAbility(oPC);

if(i >= 20){

  if(nAbility == ABILITY_STRENGTH){
    nSave = IP_CONST_SAVEBASETYPE_FORTITUDE;
    SendMessageToPC(oPC, "Some of your Weakness goes into the weapon");
    switch(Random(4)){
      case 0:
        nSkill = SKILL_DISCIPLINE;
        break;
      case 1:
        nSkill = SKILL_CLIMB;
        break;
      case 2:
        nSkill = SKILL_JUMP;
        break;
      case 3:
        nSkill = SKILL_SWIM;
        break;
    }

  }

  if(nAbility == ABILITY_DEXTERITY){
    nSave = IP_CONST_SAVEBASETYPE_REFLEX;
    SendMessageToPC(oPC, "Some of your Clumsiness goes into the weapon");
    switch(Random(7)){
      case 0:
        nSkill = SKILL_HIDE;
        break;
      case 1:
        nSkill = SKILL_MOVE_SILENTLY;
        break;
      case 2:
        nSkill = SKILL_OPEN_LOCK;
        break;
      case 3:
        nSkill = SKILL_PARRY;
        break;
      case 4:
        nSkill = SKILL_PICK_POCKET;
        break;
      case 5:
        nSkill = SKILL_SET_TRAP;
        break;
      case 6:
        nSkill = SKILL_TUMBLE;
        break;
    }

  }

  if(nAbility == ABILITY_CONSTITUTION){
    nSave = IP_CONST_SAVEBASETYPE_FORTITUDE;
    SendMessageToPC(oPC, "Some of your Frailty goes into the weapon");
    switch(Random(4)){
      case 0:
        nSkill = SKILL_DISCIPLINE;
        break;
      case 1:
        nSkill = SKILL_CONCENTRATION;
        break;
      case 2:
        nSkill = SKILL_JUMP;
        break;
      case 3:
        nSkill = SKILL_SWIM;
        break;
    }

  }


  if(nAbility == ABILITY_INTELLIGENCE){
    nSave = IP_CONST_SAVEBASETYPE_WILL;
    SendMessageToPC(oPC, "Some of your Stupidity goes into the weapon");
    switch(Random(7)){
      case 0:
        nSkill = SKILL_APPRAISE;
        break;
      case 1:
        nSkill = SKILL_CRAFT_ARMOR;
        break;
      case 2:
        nSkill = SKILL_CRAFT_TRAP;
        break;
      case 3:
        nSkill = SKILL_DISABLE_TRAP;
        break;
      case 4:
        nSkill = SKILL_LORE;
        break;
      case 5:
        nSkill = SKILL_SEARCH;
        break;
      case 6:
        nSkill = SKILL_SPELLCRAFT;
        break;
    }

  }



  if(nAbility == ABILITY_WISDOM){
    nSave = IP_CONST_SAVEBASETYPE_WILL;
    SendMessageToPC(oPC, "Some of your Foolishness goes into the weapon");
    switch(Random(4)){
      case 0:
        nSkill = SKILL_HEAL;
        break;
      case 1:
        nSkill = SKILL_LISTEN;
        break;
      case 2:
        nSkill = SKILL_SPOT;
        break;
      case 3:
        nSkill = SKILL_SENSE;
        break;
    }

  }



  if(nAbility == ABILITY_CHARISMA){
    nSave = IP_CONST_SAVEBASETYPE_REFLEX;
    SendMessageToPC(oPC, "Some of your Ugliness goes into the weapon");
    switch(Random(7)){
      case 0:
        nSkill = SKILL_ANIMAL_EMPATHY;
        break;
      case 1:
        nSkill = SKILL_BLUFF;
        break;
      case 2:
        nSkill = SKILL_INTIMIDATE;
        break;
      case 3:
        nSkill = SKILL_PERFORM;
        break;
      case 4:
        nSkill = SKILL_PERSUADE;
        break;
      case 5:
        nSkill = SKILL_TAUNT;
        break;
      case 6:
        nSkill = SKILL_USE_MAGIC_DEVICE;
        break;
    }

  }



  if(i >= 20 && i <= 50)
    AddItemProperty(DURATION_TYPE_PERMANENT, ItemPropertyDecreaseSkill(nSkill, Random(nBonus)+1), oWeapon);
  else if(i >= 50 && i <= 90){
    if(nAbility == ABILITY_CHARISMA)
      AddItemProperty(DURATION_TYPE_PERMANENT, ItemPropertyReducedSavingThrowVsX(IP_CONST_SAVEVS_UNIVERSAL, Random(nBonus)+1),oWeapon);
    else
      AddItemProperty(DURATION_TYPE_PERMANENT, ItemPropertyReducedSavingThrow(nSave, Random(nBonus)+1),oWeapon);

  }
  else if(i > 90)
    AddItemProperty(DURATION_TYPE_PERMANENT, ItemPropertyDecreaseAbility(nAbility, Random(nBonus)+1),oWeapon);

}








i = GetGoodEvilValue(oPC);
if(GetGoodEvilValue(oPC) <= 30){
i = GetGoodEvilValue(oPC);
  nAlignGroup = IP_CONST_ALIGNMENTGROUP_EVIL;
  nAlignGroupOp = IP_CONST_ALIGNMENTGROUP_GOOD;
  if(d2()==1) nDamageType = IP_CONST_DAMAGETYPE_POSITIVE;
  else nDamageType = IP_CONST_DAMAGETYPE_DIVINE;
}
if(GetGoodEvilValue(oPC) > 30 && GetGoodEvilValue(oPC) < 70){
  nAlignGroup = IP_CONST_ALIGNMENTGROUP_NEUTRAL;
  if(GetGoodEvilValue(oPC) <= 50)
    i = GetGoodEvilValue(oPC) + 40;
  else
    i = (100 - GetGoodEvilValue(oPC)) + 40;
  nDamageType = IP_CONST_DAMAGETYPE_MAGICAL;
  nAlignGroupOp = IP_CONST_ALIGNMENTGROUP_NEUTRAL;
}
if(GetGoodEvilValue(oPC) >= 70){
  i = 100 - GetGoodEvilValue(oPC);
  nAlignGroup = IP_CONST_ALIGNMENTGROUP_GOOD;
  nDamageType = IP_CONST_DAMAGETYPE_NEGATIVE;
  nAlignGroupOp = IP_CONST_ALIGNMENTGROUP_EVIL;
}




if(Random(100) + i/10 >= 80){

  SendMessageToPC(oPC, "Some of your Alignment goes into the weapon");

  AddItemProperty(DURATION_TYPE_PERMANENT, ItemPropertyDamageVulnerability(nDamageType, Random(nBonus)+1),oWeapon);

}


i = Random(100) - GetSkillRank(SKILL_CRAFT_WEAPON, oPC);

if(i >= 50){
  if(d2() == 1){
    AddItemProperty(DURATION_TYPE_PERMANENT, ItemPropertyAttackPenalty(Random(nBonus)+1),oWeapon);
  }
  else{
    AddItemProperty(DURATION_TYPE_PERMANENT, ItemPropertyDamagePenalty(Random(nBonus)+1),oWeapon);
  }
}





/*

AddItemProperty(DURATION_TYPE_PERMANENT, ItemPropertyDecreaseAC(nModifierType, nBonus),oWeapon);

*/

}




void RemoveWeaponProperty(object oWeapon, int iProperty){

 itemproperty nProperty = GetFirstItemProperty(oWeapon);

  while(GetIsItemPropertyValid(nProperty)){
    if(GetItemPropertyType(nProperty) == iProperty)
      RemoveItemProperty(oWeapon, nProperty);
    nProperty = GetNextItemProperty(oWeapon);
  }

}







void CleanItems(){
  //string  sItemToTake;
  object oInventory = GetFirstItemInInventory(OBJECT_SELF);
  while (GetIsObjectValid(oInventory) == TRUE)
    {
        //sItemToTake = GetTag(oInventory);

        DestroyObject(oInventory);

        oInventory = GetNextItemInInventory(OBJECT_SELF);

    }
  return;
}









//Function to get the number of properties on an item for DC adjustment

int GetNumProperties(object oWeapon){
int nNum = 0;

itemproperty nProperty;

nProperty = GetFirstItemProperty(oWeapon);

int nType;

while(GetIsItemPropertyValid(nProperty)){
  nType = GetItemPropertyType(nProperty);
  if(nType == ITEM_PROPERTY_BASE_ITEM_WEIGHT_REDUCTION ||
     nType == ITEM_PROPERTY_DAMAGE_VULNERABILITY ||
     nType == ITEM_PROPERTY_DECREASED_ABILITY_SCORE ||
     nType == ITEM_PROPERTY_DECREASED_AC ||
     nType == ITEM_PROPERTY_DECREASED_ATTACK_MODIFIER ||
     nType == ITEM_PROPERTY_DECREASED_DAMAGE ||
     nType == ITEM_PROPERTY_DECREASED_ENHANCEMENT_MODIFIER ||
     nType == ITEM_PROPERTY_DECREASED_SAVING_THROWS ||
     nType == ITEM_PROPERTY_DECREASED_SAVING_THROWS_SPECIFIC ||
     nType == ITEM_PROPERTY_DECREASED_SKILL_MODIFIER ||
     nType == ITEM_PROPERTY_NO_DAMAGE ||
     nType == ITEM_PROPERTY_USE_LIMITATION_ALIGNMENT_GROUP ||
     nType == ITEM_PROPERTY_USE_LIMITATION_CLASS ||
     nType == ITEM_PROPERTY_USE_LIMITATION_RACIAL_TYPE ||
     nType == ITEM_PROPERTY_USE_LIMITATION_SPECIFIC_ALIGNMENT ||
     nType == ITEM_PROPERTY_WEIGHT_INCREASE){

    ;//SpeakString("Bad item property doesn't count!");
  }
  else{
    nNum++;

  }
  nProperty = GetNextItemProperty(oWeapon);
}


return nNum;

}




void main()
{
object oWeapon;
object oPC;
int iSize;
int iSizeDC;

int iValue;
int iValueDC;

int iProperty;
int iPropertyDC;

int iModDC;

int iDC = 20;


int iSkill;
int iRoll;

int iDamageType = 0;
int iDamage = 0;

int i;

itemproperty nProperty;

struct sStringTokenizer sTok;


int iHits = GetLocalInt(OBJECT_SELF, "iHits");

int nBonus = 0;





oPC = GetLastAttacker();
oWeapon = GetLastWeaponUsed(oPC);
iSkill = GetSkillRank(SKILL_CRAFT_WEAPON, oPC);
iRoll = d20();


if(!GetIsObjectValid(oWeapon)){
  if(GetItemInSlot(INVENTORY_SLOT_ARROWS, oPC) != OBJECT_INVALID){
    oWeapon = GetItemInSlot(INVENTORY_SLOT_ARROWS ,oPC);
  }
  else if(GetItemInSlot(INVENTORY_SLOT_BOLTS, oPC) != OBJECT_INVALID){
    oWeapon = GetItemInSlot(INVENTORY_SLOT_BOLTS ,oPC);
  }
  else if(GetItemInSlot(INVENTORY_SLOT_BULLETS, oPC) != OBJECT_INVALID){
    oWeapon = GetItemInSlot(INVENTORY_SLOT_BULLETS, oPC);
  }
  else if(GetItemInSlot(INVENTORY_SLOT_ARROWS, oPC) == OBJECT_INVALID && GetItemInSlot(INVENTORY_SLOT_BOLTS, oPC) == OBJECT_INVALID && GetItemInSlot(INVENTORY_SLOT_BULLETS, oPC) != OBJECT_INVALID){
    SendMessageToPC(oPC, "Must use a valid weapon.");
    return;
  }
}

sTok = GetStringTokenizer(GetName(oWeapon), "+");
SendMessageToPC(oPC, "Weapon is: " + GetName(oWeapon));




//Get Size and Modified DC for crafting

iSize = GetWeaponSize(oWeapon);

if(iSize == -1) return;
else if(iSize == 1) iSizeDC = -4;
else if(iSize == 2) iSizeDC = -2;
else if(iSize == 3) iSizeDC = 0;
else if(iSize == 4) iSizeDC = 1;
else if(iSize == 5) iSizeDC = 4;

SendMessageToPC(oPC, "Weapon size: " + IntToString(iSize));
SendMessageToPC(oPC, "Weapon size DC Adjustment: " + IntToString(iSizeDC));






//Get Gold value and Modified DC

iValue = GetGoldPieceValue(oWeapon);

if(iValue <= 15) iValueDC = -5;
else if(iValue > 15 && iValue <= 120) iValueDC = 0;
else if(iValue > 120 && iValue <= 850) iValueDC = 2;
else if(iValue > 850 && iValue <= 1620) iValueDC = 3;
else if(iValue > 1620 && iValue <= 3000) iValueDC = 4;
else if(iValue > 3000 && iValue <= 6000) iValueDC = 5;
else if(iValue > 6000 && iValue <= 9000) iValueDC = 6;
else if(iValue > 9000 && iValue <= 12000) iValueDC = 8;
else if(iValue > 12000) iValueDC = 10;


SendMessageToPC(oPC, "Weapon value: " + IntToString(iValue));
SendMessageToPC(oPC, "Weapon value DC Adjustment: " + IntToString(iValueDC));





//Get the number of properties on the weapon already

iProperty = GetNumProperties(oWeapon);

//iPropertyDC = iProperty * iProperty;
if(iProperty == 0) iPropertyDC = -2;
else iPropertyDC = (iProperty * iProperty) - (2 * iProperty) + 2;

SendMessageToPC(oPC, "Weapon Properties: " + IntToString(iProperty));
SendMessageToPC(oPC, "Weapon property DC Adjustment: " + IntToString(iPropertyDC));


if(HasItem("ay_ingot_iron")){
  iModDC = 0;
  SendMessageToPC(oPC, "Weapon modification DC Adjustment: " + IntToString(iModDC));
}
else if(HasItem("ay_ingot_silver")){
  iModDC = 1;
  if(HasItem("ay_obsidian")){
    iModDC = iModDC + 5;
  }
  SendMessageToPC(oPC, "Weapon modification DC Adjustment: " + IntToString(iModDC));
}
else if(HasItem("ay_ingot_coldir")){
  iModDC = 1;
  if(HasItem("ay_obsidian")){
    iModDC = iModDC + 5;
  }
  SendMessageToPC(oPC, "Weapon modification DC Adjustment: " + IntToString(iModDC));
}
else if(HasItem("ay_ingot_dsteel")){
  iModDC = 2;
  if(HasItem("ay_obsidian")){
    iModDC = iModDC + 5;
  }
  SendMessageToPC(oPC, "Weapon modification DC Adjustment: " + IntToString(iModDC));
}
else if(HasItem("ay_ingot_adaman")){
  iModDC = 4;
  if(HasItem("ay_obsidian")){
    iModDC = iModDC + 5;
  }
  SendMessageToPC(oPC, "Weapon modification DC Adjustment: " + IntToString(iModDC));
}
else if(HasItem("ay_ingot_mithral")){
  iModDC = 6;
  if(HasItem("ay_obsidian")){
    iModDC = iModDC + 5;
  }
  SendMessageToPC(oPC, "Weapon modification DC Adjustment: " + IntToString(iModDC));
}
else{
  SendMessageToPC(oPC, "No Item Found ");
  return;
}

if(iModDC){
  if(HasItem("potionoffirebrea")){
    iModDC = iModDC + 2;
    iDamageType = IP_CONST_DAMAGETYPE_FIRE;
    iDamage = IP_CONST_DAMAGEBONUS_1;
    if(HasItem("NW_IT_GEM006")){
      iDamage = IP_CONST_DAMAGEBONUS_2;
      iModDC = iModDC + 2;
      if(HasItem("fireelementaless")){
        iDamage = IP_CONST_DAMAGEBONUS_1d4;
        iModDC = iModDC + 2;
      }
    }
    SendMessageToPC(oPC, "Weapon modification DC Adjustment Alchemical: " + IntToString(iModDC));
  }
  else if(HasItem("potacidbreath")){
    iModDC = iModDC + 2;
    iDamageType = IP_CONST_DAMAGETYPE_ACID;
    iDamage = IP_CONST_DAMAGEBONUS_1;
    if(HasItem("NW_IT_GEM012")){
      iDamage = IP_CONST_DAMAGEBONUS_2;
      iModDC = iModDC + 2;
      if(HasItem("acidelementaless")){
        iDamage = IP_CONST_DAMAGEBONUS_1d4;
        iModDC = iModDC + 2;
      }
    }
    SendMessageToPC(oPC, "Weapon modification DC Adjustment Alchemical: " + IntToString(iModDC));
  }
   else if(HasItem("potcoldbreath") && HasItem("ay_ingot_coldir")){
    iModDC = iModDC + 1;
    iDamageType = IP_CONST_DAMAGETYPE_COLD;
    iDamage = IP_CONST_DAMAGEBONUS_2;
    if(HasItem("NW_IT_GEM008")){
      iDamage = IP_CONST_DAMAGEBONUS_1d4;
      iModDC = iModDC + 2;
      if(HasItem("coldelementaless")){
        iDamage = IP_CONST_DAMAGEBONUS_1d6;
        iModDC = iModDC + 2;
      }
    }
    SendMessageToPC(oPC, "Weapon modification DC Adjustment Alchemical: " + IntToString(iModDC));
  }

  else if(HasItem("potcoldbreath")){
    iModDC = iModDC + 2;
    iDamageType = IP_CONST_DAMAGETYPE_COLD;
    iDamage = IP_CONST_DAMAGEBONUS_1;
    if(HasItem("NW_IT_GEM008")){
      iDamage = IP_CONST_DAMAGEBONUS_2;
      iModDC = iModDC + 2;
      if(HasItem("coldelementaless")){
        iDamage = IP_CONST_DAMAGEBONUS_1d4;
        iModDC = iModDC + 2;
      }
    }
    SendMessageToPC(oPC, "Weapon modification DC Adjustment Alchemical: " + IntToString(iModDC));
  }

  else if(HasItem("potelecbreath")){
    iModDC = iModDC + 2;
    iDamageType = IP_CONST_DAMAGETYPE_ELECTRICAL;
    iDamage = IP_CONST_DAMAGEBONUS_1;
    if(HasItem("NW_IT_GEM005")){
      iDamage = IP_CONST_DAMAGEBONUS_2;
      iModDC = iModDC + 2;
      if(HasItem("elecelementaless")){
        iDamage = IP_CONST_DAMAGEBONUS_1d4;
        iModDC = iModDC + 2;
      }
    }
    SendMessageToPC(oPC, "Weapon modification DC Adjustment Alchemical: " + IntToString(iModDC));
  }
}



iDC = 20 + iValueDC + iSizeDC + iPropertyDC + iModDC;

if(GetItemStackSize(oWeapon) > 300){
  SendMessageToPC(oPC, "You cannot do more than 300 of an item.");
  return;
}


SendMessageToPC(oPC, "*****");
SendMessageToPC(oPC, "*****");
SendMessageToPC(oPC, "Total DC: " + IntToString(iDC));
SendMessageToPC(oPC, "Total DC to avoid negative effects: " + IntToString(iDC + 6));
SendMessageToPC(oPC, "*****");
SendMessageToPC(oPC, "*****");



SendMessageToPC(oPC, "Total XP Cost: " + IntToString(iDC * 10 * iModDC + iDC * 3  ));

if(GetXP(oPC) < iDC * 10 * iModDC + iDC * 3  ){
  if(!GetIsDM(oPC)){
    SendMessageToPC(oPC, "Not enough XP ");
    return;
  }
}



/*for(i=28; i<35; i++){


  SendMessageToPC(oPC, "Skill num: "+ IntToString(i)+ "Rank: " + IntToString(GetSkillRank(i, oPC)));

}*/


//ApplyEffectToObject(DURATION_TYPE_INSTANT ,EffectVisualEffect(VFX_COM_SPARKS_PARRY), OBJECT_SELF);
DelayCommand(0.7, ApplyEffectToObject(DURATION_TYPE_INSTANT ,EffectVisualEffect(VFX_COM_BLOOD_SPARK_LARGE), OBJECT_SELF));
DelayCommand(0.7, ApplyEffectToObject(DURATION_TYPE_INSTANT ,EffectVisualEffect(VFX_COM_BLOOD_SPARK_SMALL), oPC));

iHits++;
SetLocalInt(OBJECT_SELF, "iHits", iHits);

if(iHits == 1){
  DelayCommand(32.0, SetLocalInt(OBJECT_SELF, "iHits", 0));

}
if(iHits < 5){
  FloatingTextStringOnCreature("*Works on forging the weapon* ..."+ IntToString(5 - iHits), oPC, FALSE);
  return;

}

/*if(iHits > 5){
  ClearAllActions(TRUE);

}

ClearAllActions(TRUE); */








//Actually craft after 5 hits.




SendMessageToPC(oPC, "Roll: "+ IntToString(iRoll) + ", Skill: " + IntToString(iSkill));

if(iRoll == 1 || (iRoll + iSkill < iDC)){
  SendMessageToPC(oPC, "Failure! ");
  CleanItems();
  if(d20() == 1 || (iRoll + iSkill <= iDC - 10)){
    SendMessageToPC(oPC, "Critical Failure! ");
    DestroyObject(oWeapon);
  }
}
else{
  SendMessageToPC(oPC, "Success! ");

  if(iRoll == 20 || (iRoll + iSkill >= iDC + 10)){
    SendMessageToPC(oPC, "You did a particularly good job on this one.");
    GoodEffect(oWeapon, oPC);
  }
  if(iRoll + iSkill <= iDC + 5 || HasItem("004korsanturd")){
    SendMessageToPC(oPC, "There were some flaws in the process.");
    BadEffect(oWeapon, oPC);

  }











  if(HasItem("ay_ingot_iron")){
    RemoveWeaponProperty(oWeapon, ITEM_PROPERTY_ENHANCEMENT_BONUS);
  }
  else if(HasItem("ay_ingot_silver")){
    RemoveWeaponProperty(oWeapon, ITEM_PROPERTY_ENHANCEMENT_BONUS);
    AddItemProperty(DURATION_TYPE_PERMANENT, ItemPropertyEnhancementBonus(1),oWeapon);
    if(GetBaseItemType(oWeapon) == BASE_ITEM_GLOVES) AddItemProperty(DURATION_TYPE_PERMANENT, ItemPropertyAttackBonus(1),oWeapon);
    if(iDamageType){
      RemoveWeaponProperty(oWeapon, ITEM_PROPERTY_DAMAGE_BONUS);
      AddItemProperty(DURATION_TYPE_PERMANENT, ItemPropertyDamageBonus(iDamageType, iDamage),oWeapon);
      SendMessageToPC(oPC, "The weapon glows with alchemical power ");
    }
  //SendMessageToPC(oPC, "Weapon modification DC Adjustment: " + IntToString(iModDC));
  }
  else if(HasItem("ay_ingot_coldir")){
    RemoveWeaponProperty(oWeapon, ITEM_PROPERTY_ENHANCEMENT_BONUS);
    AddItemProperty(DURATION_TYPE_PERMANENT, ItemPropertyEnhancementBonus(1),oWeapon);
    AddItemProperty(DURATION_TYPE_PERMANENT, ItemPropertyDamageVulnerability(IP_CONST_DAMAGETYPE_FIRE, IP_CONST_DAMAGEVULNERABILITY_25_PERCENT),oWeapon);
    AddItemProperty(DURATION_TYPE_PERMANENT, ItemPropertyEnhancementBonusVsRace(IP_CONST_RACIALTYPE_FEY, 4),oWeapon);
    if(GetBaseItemType(oWeapon) == BASE_ITEM_GLOVES) AddItemProperty(DURATION_TYPE_PERMANENT, ItemPropertyAttackBonus(1),oWeapon);
    if(iDamageType && iDamageType != IP_CONST_DAMAGETYPE_FIRE){
      RemoveWeaponProperty(oWeapon, ITEM_PROPERTY_DAMAGE_BONUS);
      AddItemProperty(DURATION_TYPE_PERMANENT, ItemPropertyDamageBonus(iDamageType, iDamage),oWeapon);
      SendMessageToPC(oPC, "The weapon glows with alchemical power ");
    }
  //SendMessageToPC(oPC, "Weapon modification DC Adjustment: " + IntToString(iModDC));
  }
  else if(HasItem("ay_ingot_dsteel")){
    RemoveWeaponProperty(oWeapon, ITEM_PROPERTY_ENHANCEMENT_BONUS);
    AddItemProperty(DURATION_TYPE_PERMANENT, ItemPropertyEnhancementBonus(2),oWeapon);
    if(GetBaseItemType(oWeapon) == BASE_ITEM_GLOVES) AddItemProperty(DURATION_TYPE_PERMANENT, ItemPropertyAttackBonus(2),oWeapon);
    if(iDamageType){
      RemoveWeaponProperty(oWeapon, ITEM_PROPERTY_DAMAGE_BONUS);
      AddItemProperty(DURATION_TYPE_PERMANENT, ItemPropertyDamageBonus(iDamageType, iDamage),oWeapon);
      SendMessageToPC(oPC, "The weapon glows with alchemical power ");
    }
  //SendMessageToPC(oPC, "Weapon modification DC Adjustment: " + IntToString(iModDC));
  }
  else if(HasItem("ay_ingot_adaman")){
    RemoveWeaponProperty(oWeapon, ITEM_PROPERTY_ENHANCEMENT_BONUS);
    AddItemProperty(DURATION_TYPE_PERMANENT, ItemPropertyEnhancementBonus(3),oWeapon);
    if(GetBaseItemType(oWeapon) == BASE_ITEM_GLOVES) AddItemProperty(DURATION_TYPE_PERMANENT, ItemPropertyAttackBonus(3),oWeapon);
    if(iDamageType){
      RemoveWeaponProperty(oWeapon, ITEM_PROPERTY_DAMAGE_BONUS);
      AddItemProperty(DURATION_TYPE_PERMANENT, ItemPropertyDamageBonus(iDamageType, iDamage),oWeapon);
      SendMessageToPC(oPC, "The weapon glows with alchemical power ");
    }
  //SendMessageToPC(oPC, "Weapon modification DC Adjustment: " + IntToString(iModDC));
  }
  else if(HasItem("ay_ingot_mithral")){
    RemoveWeaponProperty(oWeapon, ITEM_PROPERTY_ENHANCEMENT_BONUS);
    AddItemProperty(DURATION_TYPE_PERMANENT, ItemPropertyEnhancementBonus(4),oWeapon);
    if(GetBaseItemType(oWeapon) == BASE_ITEM_GLOVES) AddItemProperty(DURATION_TYPE_PERMANENT, ItemPropertyAttackBonus(4),oWeapon);
    if(iDamageType){
      RemoveWeaponProperty(oWeapon, ITEM_PROPERTY_DAMAGE_BONUS);
      AddItemProperty(DURATION_TYPE_PERMANENT, ItemPropertyDamageBonus(iDamageType, iDamage),oWeapon);
      SendMessageToPC(oPC, "The weapon glows with alchemical power ");
    }
  //SendMessageToPC(oPC, "Weapon modification DC Adjustment: " + IntToString(iModDC));
  }
  else if(HasItem("ay_obsidian")){
    //RemoveWeaponProperty(oWeapon, ITEM_PROPERTY_AC_BONUS);
    AddItemProperty(DURATION_TYPE_PERMANENT, ItemPropertyBonusSpellResistance(IP_CONST_SPELLRESISTANCEBONUS_10), oWeapon);
    /*if(iDamageType){
      RemoveWeaponProperty(oWeapon, ITEM_PROPERTY_IMMUNITY_DAMAGE_TYPE);
      AddItemProperty(DURATION_TYPE_PERMANENT, ItemPropertyDamageImmunity(iDamageType, iDamage),oWeapon);
      SendMessageToPC(oPC, "The armor glows with alchemical power ");
    }*/
  //SendMessageToPC(oPC, "Weapon modification DC Adjustment: " + IntToString(iModDC));
  }



  //AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyKeen(),oWeapon);






  SetXP(oPC, GetXP(oPC) - (iDC * 10 * iModDC + iDC * 3 ));
  CleanItems();
  //while (HasMoreTokens(sTok)) {
  sTok = AdvanceToNextToken(sTok);
  //SpeakString("Next token: " + GetNextToken(sTok));
   // }
  //SendMessageToPC(oPC, "Ayergo result test: " + sTok.sOrig);
  if(!GetIsDM(oPC))
    SetName(oWeapon, GetName(oPC) + "'s forged " + GetNextToken(sTok));
  if(!GetIsDM(oPC))
    SetDescription(oWeapon, "This has the mark of " + GetName(oPC));
  if(GetBaseItemType(oWeapon) == BASE_ITEM_ARROW || GetBaseItemType(oWeapon) == BASE_ITEM_BOLT || GetBaseItemType(oWeapon) == BASE_ITEM_BULLET){

    if(HasItem("ay_ingot_iron")){

    nBonus = 1;
    }
    else if(HasItem("ay_ingot_silver")){

    nBonus = 2;
    }
    else if(HasItem("ay_ingot_dsteel")){

    nBonus = 3;
    }
    else if(HasItem("ay_ingot_adaman")){

    nBonus = 4;
    }
    else if(HasItem("ay_ingot_mithral")){

    nBonus = 5;
    }

    //SetItemStackSize(oWeapon, 300);
    SetTag(oWeapon, GetTag(oWeapon) + RandomName() + IntToString(nBonus));



  }
  //SetStolenFlag(oWeapon, TRUE);


}










}

