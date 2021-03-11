#include "x0_i0_stringlib"
#include "x2_inc_craft"
#include "x2_inc_switches"

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


  int bIdentified = GetIdentified(oWeapon);


  int nType = -1;
  int iType = GetBaseItemType(oWeapon);


  if (GetBaseItemType(oWeapon) == BASE_ITEM_ARMOR){



    SetIdentified(oWeapon,FALSE);
    switch (GetGoldPieceValue(oWeapon))
    {
        case    1: nType = 0; break; // None
        case    5: nType = 1; break; // Padded
        case   10: nType = 2; break; // Leather
        case   15: nType = 3; break; // Studded Leather / Hide
        case  100: nType = 4; break; // Chain Shirt / Scale Mail
        case  150: nType = 5; break; // Chainmail / Breastplate
        case  200: nType = 6; break; // Splint Mail / Banded Mail
        case  600: nType = 7; break; // Half-Plate
        case 1500: nType = 8; break; // Full Plate
    }
    // Restore the identified flag, and return armor type.
    SetIdentified(oWeapon,bIdentified);

    return nType;

  }

  if( GetBaseItemType(oWeapon) == BASE_ITEM_HELMET ||
      GetBaseItemType(oWeapon) == BASE_ITEM_SMALLSHIELD
    )
  return 2;

  if( GetBaseItemType(oWeapon) == BASE_ITEM_LARGESHIELD
    )
  return 3;

  if( GetBaseItemType(oWeapon) == BASE_ITEM_TOWERSHIELD
    )
  return 4;





  if( GetBaseItemType(oWeapon) == BASE_ITEM_DAGGER ||
      GetBaseItemType(oWeapon) == BASE_ITEM_SLING ||
      GetBaseItemType(oWeapon) == BASE_ITEM_BLANK_WAND ||
      GetBaseItemType(oWeapon) == 212 ||   //pickaxe
      GetBaseItemType(oWeapon) == 213 ||   //shovel
      GetBaseItemType(oWeapon) == 215 ||   //nunchucks
      GetBaseItemType(oWeapon) == BASE_ITEM_KUKRI
      )
  return 1;

  if( GetBaseItemType(oWeapon) == BASE_ITEM_LIGHTMACE ||
      GetBaseItemType(oWeapon) == BASE_ITEM_SICKLE ||
      GetBaseItemType(oWeapon) == BASE_ITEM_HANDAXE ||
      GetBaseItemType(oWeapon) == BASE_ITEM_SHORTSWORD ||
      GetBaseItemType(oWeapon) == BASE_ITEM_SHORTSPEAR ||
      GetBaseItemType(oWeapon) == BASE_ITEM_KAMA ||
      GetBaseItemType(oWeapon) == BASE_ITEM_LIGHTHAMMER ||
      GetBaseItemType(oWeapon) == BASE_ITEM_CLUB ||
      GetBaseItemType(oWeapon) == BASE_ITEM_WHIP
    )
  return 2;

  if(
      GetBaseItemType(oWeapon) == BASE_ITEM_MORNINGSTAR ||
      GetBaseItemType(oWeapon) == BASE_ITEM_BATTLEAXE ||
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
      GetBaseItemType(oWeapon) == 210 ||   //Greathammer
      GetBaseItemType(oWeapon) == BASE_ITEM_TRIDENT ||
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











  if( iType == BASE_ITEM_AMULET ||
      iType == BASE_ITEM_RING
  )
  return 0;

  if( iType == BASE_ITEM_BELT ||
      iType == BASE_ITEM_BOOTS ||
      iType == BASE_ITEM_BRACER ||
      iType == BASE_ITEM_CLOAK ||
      iType == BASE_ITEM_GLOVES ||
      iType == BASE_ITEM_MAGICSTAFF
  )
  return 1;

  if( iType == BASE_ITEM_ARROW ||
      iType == BASE_ITEM_BOLT ||
      iType == BASE_ITEM_BULLET ||
      iType == BASE_ITEM_DART ||
      iType == BASE_ITEM_SHURIKEN ||
      iType == BASE_ITEM_THROWINGAXE
  )
  return 9;








  SpeakString("Unknown Item Type:" + IntToString(GetBaseItemType(oWeapon)));

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




//Weight Reduction

if(HasItem("ay_ingot_iron")){
  //nWeight = IP_CONST_REDUCEDWEIGHT_80_PERCENT;
  nBonus = 1;
}
else if(HasItem("ay_ingot_silver")){
  //nWeight = IP_CONST_REDUCEDWEIGHT_60_PERCENT;
  nBonus = 2;
}
else if(HasItem("ay_ingot_dsteel")){
  //nWeight = IP_CONST_REDUCEDWEIGHT_40_PERCENT;
  nBonus = 3;
}
else if(HasItem("ay_ingot_adaman")){
  //nWeight = IP_CONST_REDUCEDWEIGHT_20_PERCENT;
  nBonus = 4;
}
else if(HasItem("ay_ingot_mithral")){
  //nWeight = IP_CONST_REDUCEDWEIGHT_10_PERCENT;
  nBonus = 5;
}

//AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyWeightReduction(nWeight),oWeapon);


nAbility = GetHighAbility(oPC);

//PC based

/*int SKILL_CLIMB = 28;
int SKILL_SENSE = 29;
int SKILL_FORGERY = 30;
int SKILL_INNUENDO = 31;
int SKILL_JUMP = 32;
int SKILL_SWIM = 33;
int SKILL_RIDE = 34;*/


i = Random(100) + 1;

if(TRUE){

  if(nAbility == ABILITY_STRENGTH){
    nSave = IP_CONST_SAVEBASETYPE_FORTITUDE;
    SendMessageToPC(oPC, "Some of your Strength goes into the item");
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
    SendMessageToPC(oPC, "Some of your Dexterity goes into the item");
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
    SendMessageToPC(oPC, "Some of your Constitution goes into the item");
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
    SendMessageToPC(oPC, "Some of your Intellect goes into the item");
    switch(Random(7)){
      case 0:
        nSkill = SKILL_CRAFT_WEAPON;
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
    SendMessageToPC(oPC, "Some of your Wisdom goes into the item");
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
    SendMessageToPC(oPC, "Some of your Charm goes into the item");
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



  if(i >= 0 && i <= 33)
    AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertySkillBonus(nSkill, Random(nBonus)+1), oWeapon);
  else if(i >= 33 && i <= 66){
    if(nAbility == ABILITY_CHARISMA)
      AddItemProperty(DURATION_TYPE_PERMANENT, ItemPropertyBonusSavingThrowVsX(IP_CONST_SAVEVS_UNIVERSAL, Random(nBonus)+1),oWeapon);
    else
      AddItemProperty(DURATION_TYPE_PERMANENT, ItemPropertyBonusSavingThrow(nSave, Random(nBonus)+1),oWeapon);
  }
  else if( i > 66)
    AddItemProperty(DURATION_TYPE_PERMANENT, ItemPropertyAbilityBonus(nAbility, Random(nBonus)+1),oWeapon);

}

//Generic


i = Random(100) + GetSkillRank(SKILL_SPELLCRAFT, oPC);

if(i > 65 + (10* nBonus)){
  if(GetLevelByClass(CLASS_TYPE_BARD,  oPC))
    AddItemProperty(DURATION_TYPE_PERMANENT, ItemPropertyBonusLevelSpell(IP_CONST_CLASS_BARD, Random(nBonus)+1), oWeapon );
  if(GetLevelByClass(CLASS_TYPE_CLERIC,  oPC))
    AddItemProperty(DURATION_TYPE_PERMANENT, ItemPropertyBonusLevelSpell(IP_CONST_CLASS_CLERIC, Random(nBonus)+1), oWeapon );
  if(GetLevelByClass(CLASS_TYPE_DRUID,  oPC))
    AddItemProperty(DURATION_TYPE_PERMANENT, ItemPropertyBonusLevelSpell(IP_CONST_CLASS_DRUID, Random(nBonus)+1),oWeapon);
  if(GetLevelByClass(CLASS_TYPE_PALADIN,  oPC))
    AddItemProperty(DURATION_TYPE_PERMANENT, ItemPropertyBonusLevelSpell(IP_CONST_CLASS_PALADIN, Random(nBonus)+1),oWeapon);
  if(GetLevelByClass(CLASS_TYPE_RANGER,  oPC))
    AddItemProperty(DURATION_TYPE_PERMANENT, ItemPropertyBonusLevelSpell(IP_CONST_CLASS_RANGER, Random(nBonus)+1),oWeapon);
  if(GetLevelByClass(CLASS_TYPE_SORCERER,  oPC))
    AddItemProperty(DURATION_TYPE_PERMANENT, ItemPropertyBonusLevelSpell(IP_CONST_CLASS_SORCERER, Random(nBonus)+1),oWeapon);
  if(GetLevelByClass(CLASS_TYPE_WIZARD,  oPC))
    AddItemProperty(DURATION_TYPE_PERMANENT, ItemPropertyBonusLevelSpell(IP_CONST_CLASS_WIZARD, Random(nBonus)+1),oWeapon);
}





//Alignment based

/*
i = GetGoodEvilValue(oPC);
if(GetGoodEvilValue(oPC) <= 30){
  i = 100 - GetGoodEvilValue(oPC);
  nAlignGroup = IP_CONST_ALIGNMENTGROUP_GOOD;
  nDamageType = DAMAGE_TYPE_NEGATIVE;
  nAlignGroupOp = IP_CONST_ALIGNMENTGROUP_EVIL;
}
if(GetGoodEvilValue(oPC) > 30 && GetGoodEvilValue(oPC) < 70){
  nAlignGroup = IP_CONST_ALIGNMENTGROUP_NEUTRAL;
  i = 0;
  nDamageType = DAMAGE_TYPE_SONIC;
  nAlignGroupOp = IP_CONST_ALIGNMENTGROUP_NEUTRAL;
}
if(GetGoodEvilValue(oPC) >= 70){
  i = GetGoodEvilValue(oPC);
  nAlignGroup = IP_CONST_ALIGNMENTGROUP_EVIL;
  nAlignGroupOp = IP_CONST_ALIGNMENTGROUP_GOOD;
  if(d2()==1) nDamageType = DAMAGE_TYPE_POSITIVE;
  else nDamageType = DAMAGE_TYPE_DIVINE;
}




if(Random(100) + (i - 70) >= 80){

  SendMessageToPC(oPC, "Some of your Alignment goes into the weapon");
  switch(d3()){
    case 1:
      AddItemProperty(DURATION_TYPE_PERMANENT, ItemPropertyAttackBonusVsAlign(nAlignGroup, nBonus+1),oWeapon);
      break;

    case 2:
      AddItemProperty(DURATION_TYPE_PERMANENT, ItemPropertyACBonusVsAlign(nAlignGroup, Random(nBonus)+1),oWeapon);
      break;

    case 3:
      AddItemProperty(DURATION_TYPE_PERMANENT, ItemPropertyDamageResistance(DAMAGE_TYPE_NEGATIVE, nBonus+1),oWeapon);
      break;
  }
  AddItemProperty(DURATION_TYPE_PERMANENT, ItemPropertyLimitUseByAlign(nAlignGroupOp),oWeapon);

}



//Class based

if(GetHasFeat(FEAT_FAVORED_ENEMY_ABERRATION, oPC))
  AddItemProperty(DURATION_TYPE_PERMANENT, ItemPropertyACBonusVsRace(IP_CONST_RACIALTYPE_ABERRATION, nBonus+1), oWeapon);

if(GetHasFeat(FEAT_FAVORED_ENEMY_ANIMAL, oPC))
  AddItemProperty(DURATION_TYPE_PERMANENT, ItemPropertyACBonusVsRace(IP_CONST_RACIALTYPE_ANIMAL, nBonus+1),oWeapon);

if(GetHasFeat(FEAT_FAVORED_ENEMY_BEAST, oPC))
  AddItemProperty(DURATION_TYPE_PERMANENT, ItemPropertyACBonusVsRace(IP_CONST_RACIALTYPE_BEAST, nBonus+1),oWeapon);

if(GetHasFeat(FEAT_FAVORED_ENEMY_CONSTRUCT, oPC))
  AddItemProperty(DURATION_TYPE_PERMANENT, ItemPropertyACBonusVsRace(IP_CONST_RACIALTYPE_CONSTRUCT, nBonus+1),oWeapon);

if(GetHasFeat(FEAT_FAVORED_ENEMY_DRAGON, oPC))
  AddItemProperty(DURATION_TYPE_PERMANENT, ItemPropertyACBonusVsRace(IP_CONST_RACIALTYPE_DRAGON, nBonus+1),oWeapon);

if(GetHasFeat(FEAT_FAVORED_ENEMY_DWARF, oPC))
  AddItemProperty(DURATION_TYPE_PERMANENT, ItemPropertyACBonusVsRace(IP_CONST_RACIALTYPE_DWARF, nBonus+1),oWeapon);

if(GetHasFeat(FEAT_FAVORED_ENEMY_ELEMENTAL, oPC))
  AddItemProperty(DURATION_TYPE_PERMANENT, ItemPropertyACBonusVsRace(IP_CONST_RACIALTYPE_ELEMENTAL, nBonus+1),oWeapon);

if(GetHasFeat(FEAT_FAVORED_ENEMY_ELF, oPC))
  AddItemProperty(DURATION_TYPE_PERMANENT, ItemPropertyACBonusVsRace(IP_CONST_RACIALTYPE_ELF, nBonus+1),oWeapon);

if(GetHasFeat(FEAT_FAVORED_ENEMY_FEY, oPC))
  AddItemProperty(DURATION_TYPE_PERMANENT, ItemPropertyACBonusVsRace(IP_CONST_RACIALTYPE_FEY, nBonus+1),oWeapon);

if(GetHasFeat(FEAT_FAVORED_ENEMY_GIANT, oPC))
  AddItemProperty(DURATION_TYPE_PERMANENT, ItemPropertyACBonusVsRace(IP_CONST_RACIALTYPE_GIANT, nBonus+1),oWeapon);

if(GetHasFeat(FEAT_FAVORED_ENEMY_GOBLINOID, oPC))
  AddItemProperty(DURATION_TYPE_PERMANENT, ItemPropertyACBonusVsRace(IP_CONST_RACIALTYPE_HUMANOID_GOBLINOID, nBonus+1),oWeapon);

if(GetHasFeat(FEAT_FAVORED_ENEMY_GNOME, oPC))
  AddItemProperty(DURATION_TYPE_PERMANENT, ItemPropertyACBonusVsRace(IP_CONST_RACIALTYPE_GNOME, nBonus+1),oWeapon);

if(GetHasFeat(FEAT_FAVORED_ENEMY_HALFELF, oPC))
  AddItemProperty(DURATION_TYPE_PERMANENT, ItemPropertyACBonusVsRace(IP_CONST_RACIALTYPE_HALFELF, nBonus+1),oWeapon);

if(GetHasFeat(FEAT_FAVORED_ENEMY_HALFLING, oPC))
  AddItemProperty(DURATION_TYPE_PERMANENT, ItemPropertyACBonusVsRace(IP_CONST_RACIALTYPE_HALFLING, nBonus+1),oWeapon);

if(GetHasFeat(FEAT_FAVORED_ENEMY_HALFORC, oPC))
  AddItemProperty(DURATION_TYPE_PERMANENT, ItemPropertyACBonusVsRace(IP_CONST_RACIALTYPE_HALFORC, nBonus+1),oWeapon);

if(GetHasFeat(FEAT_FAVORED_ENEMY_HUMAN, oPC))
  AddItemProperty(DURATION_TYPE_PERMANENT, ItemPropertyACBonusVsRace(IP_CONST_RACIALTYPE_HUMAN, nBonus+1),oWeapon);

if(GetHasFeat(FEAT_FAVORED_ENEMY_MAGICAL_BEAST, oPC))
  AddItemProperty(DURATION_TYPE_PERMANENT, ItemPropertyACBonusVsRace(IP_CONST_RACIALTYPE_MAGICAL_BEAST, nBonus+1),oWeapon);

if(GetHasFeat(FEAT_FAVORED_ENEMY_MONSTROUS, oPC))
  AddItemProperty(DURATION_TYPE_PERMANENT, ItemPropertyACBonusVsRace(IP_CONST_RACIALTYPE_HUMANOID_MONSTROUS, nBonus+1),oWeapon);

if(GetHasFeat(FEAT_FAVORED_ENEMY_ORC, oPC))
  AddItemProperty(DURATION_TYPE_PERMANENT, ItemPropertyACBonusVsRace(IP_CONST_RACIALTYPE_HUMANOID_ORC, nBonus+1),oWeapon);

if(GetHasFeat(FEAT_FAVORED_ENEMY_OUTSIDER, oPC))
  AddItemProperty(DURATION_TYPE_PERMANENT, ItemPropertyACBonusVsRace(IP_CONST_RACIALTYPE_OUTSIDER, nBonus+1),oWeapon);

if(GetHasFeat(FEAT_FAVORED_ENEMY_REPTILIAN, oPC))
  AddItemProperty(DURATION_TYPE_PERMANENT, ItemPropertyACBonusVsRace(IP_CONST_RACIALTYPE_HUMANOID_REPTILIAN, nBonus+1),oWeapon);

if(GetHasFeat(FEAT_FAVORED_ENEMY_SHAPECHANGER, oPC))
  AddItemProperty(DURATION_TYPE_PERMANENT, ItemPropertyACBonusVsRace(IP_CONST_RACIALTYPE_SHAPECHANGER, nBonus+1),oWeapon);

if(GetHasFeat(FEAT_FAVORED_ENEMY_UNDEAD, oPC))
  AddItemProperty(DURATION_TYPE_PERMANENT, ItemPropertyACBonusVsRace(IP_CONST_RACIALTYPE_UNDEAD, nBonus+1),oWeapon);

if(GetHasFeat(FEAT_FAVORED_ENEMY_VERMIN, oPC))
  AddItemProperty(DURATION_TYPE_PERMANENT, ItemPropertyACBonusVsRace(IP_CONST_RACIALTYPE_VERMIN, nBonus+1),oWeapon);
 */


if(GetHasFeat(FEAT_BARD_SONGS, oPC)){
  if(Random(100) + GetSkillRank(SKILL_PERFORM ,oPC) > 70 + (10 *nBonus))
    AddItemProperty(DURATION_TYPE_PERMANENT, ItemPropertyDamageResistance(DAMAGE_TYPE_SONIC, Random(nBonus)+1),oWeapon);
}







//Two Hander weapons

/*if(GetWeaponSize(oWeapon) == 4){

  switch(d6()){
    case 1:
      AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyMassiveCritical(Random(nBonus)+1),oWeapon);
      break;
    case 2:
      AddItemProperty(DURATION_TYPE_PERMANENT, ItemPropertyACBonus(Random(nBonus)+1),oWeapon);
      break;
    case 3:
      AddItemProperty(DURATION_TYPE_PERMANENT, ItemPropertyDamageBonus(DAMAGE_TYPE_PIERCING, nBonus+1),oWeapon);
      break;
    case 4:
      AddItemProperty(DURATION_TYPE_PERMANENT, ItemPropertyDamageBonus(DAMAGE_TYPE_BLUDGEONING, nBonus+1),oWeapon);
      break;
    case 5:
      AddItemProperty(DURATION_TYPE_PERMANENT, ItemPropertyDamageBonus(DAMAGE_TYPE_SLASHING, nBonus+1),oWeapon);
      break;
  }
} */


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
  if(d2()==1) nDamageType = DAMAGE_TYPE_POSITIVE;
  else nDamageType = DAMAGE_TYPE_DIVINE;
}
if(GetGoodEvilValue(oPC) > 30 && GetGoodEvilValue(oPC) < 70){
  nAlignGroup = IP_CONST_ALIGNMENTGROUP_NEUTRAL;
  i = 0;
  nDamageType = DAMAGE_TYPE_MAGICAL;
  nAlignGroupOp = IP_CONST_ALIGNMENTGROUP_NEUTRAL;
}
if(GetGoodEvilValue(oPC) >= 70){
  i = 100 - GetGoodEvilValue(oPC);
  nAlignGroup = IP_CONST_ALIGNMENTGROUP_GOOD;
  nDamageType = DAMAGE_TYPE_NEGATIVE;
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

itemproperty GetProperty(object oWeapon, int iProperty){

 itemproperty nProperty = GetFirstItemProperty(oWeapon);

  while(GetIsItemPropertyValid(nProperty)){
    if(GetItemPropertyType(nProperty) == iProperty)
      return nProperty;//RemoveItemProperty(oWeapon, nProperty);
    nProperty = GetNextItemProperty(oWeapon);
  }
  return nProperty;
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


object GetTarget(){

 object oInventory = GetFirstItemInInventory(OBJECT_SELF);
 int iType;
 while (GetIsObjectValid(oInventory) == TRUE)
    {
        //sItemToTake = GetTag(oInventory);

        iType = GetBaseItemType(oInventory);

        if(iType == BASE_ITEM_AMULET ||
           iType == BASE_ITEM_ARMOR ||
           iType == BASE_ITEM_BASTARDSWORD ||
           iType == BASE_ITEM_BATTLEAXE ||
           iType == BASE_ITEM_BELT ||
           iType == BASE_ITEM_BOOTS ||
           iType == BASE_ITEM_BRACER ||
           iType == BASE_ITEM_CLOAK ||
           iType == BASE_ITEM_CLUB ||
           iType == BASE_ITEM_DAGGER ||
           iType == BASE_ITEM_DIREMACE ||
           iType == BASE_ITEM_DOUBLEAXE ||
           iType == BASE_ITEM_DWARVENWARAXE ||
           iType == BASE_ITEM_BLANK_WAND ||
           iType == 212 ||   //pickaxe
           iType == 213 ||   //shovel
           iType == 215 ||   //nunchucks
           iType == BASE_ITEM_GLOVES ||
           iType == BASE_ITEM_GREATAXE ||
           iType == BASE_ITEM_GREATSWORD ||
           iType == BASE_ITEM_HALBERD ||
           iType == BASE_ITEM_HANDAXE ||
           iType == BASE_ITEM_HEAVYCROSSBOW ||
           iType == BASE_ITEM_HEAVYFLAIL ||
           iType == BASE_ITEM_HELMET ||
           iType == BASE_ITEM_KAMA ||
           iType == BASE_ITEM_KATANA ||
           iType == BASE_ITEM_KUKRI ||
           iType == BASE_ITEM_LARGESHIELD ||
           iType == BASE_ITEM_LIGHTCROSSBOW ||
           iType == BASE_ITEM_LIGHTFLAIL ||
           iType == BASE_ITEM_LIGHTHAMMER ||
           iType == BASE_ITEM_LIGHTMACE ||
           iType == BASE_ITEM_LONGBOW ||
           iType == BASE_ITEM_LONGSWORD ||
           iType == BASE_ITEM_MAGICSTAFF ||
           iType == BASE_ITEM_MORNINGSTAR ||
           iType == BASE_ITEM_QUARTERSTAFF ||
           iType == BASE_ITEM_RAPIER ||
           iType == BASE_ITEM_RING ||
           iType == BASE_ITEM_SCIMITAR ||
           iType == BASE_ITEM_SCYTHE ||
           iType == BASE_ITEM_SHORTBOW ||
           iType == BASE_ITEM_SHORTSPEAR ||
           iType == BASE_ITEM_SHORTSWORD ||
           iType == BASE_ITEM_SICKLE ||
           iType == BASE_ITEM_SLING ||
           iType == BASE_ITEM_SMALLSHIELD ||
           iType == BASE_ITEM_TOWERSHIELD ||
           iType == BASE_ITEM_TRIDENT ||
           iType == BASE_ITEM_TWOBLADEDSWORD ||
           iType == BASE_ITEM_WARHAMMER ||
           iType == BASE_ITEM_WHIP ||
           iType == BASE_ITEM_ARROW ||
           iType == BASE_ITEM_BOLT ||
           iType == BASE_ITEM_BULLET ||
           iType == BASE_ITEM_DART ||
           iType == BASE_ITEM_SHURIKEN ||
           iType == BASE_ITEM_THROWINGAXE
        )
        {
            return oInventory;
        }


        oInventory = GetNextItemInInventory(OBJECT_SELF);

    }
    return OBJECT_INVALID;

}


object GetScroll(){
 object oInventory = GetFirstItemInInventory(OBJECT_SELF);
 while (GetIsObjectValid(oInventory) == TRUE)
    {
        //sItemToTake = GetTag(oInventory);


        if(GetBaseItemType(oInventory) == BASE_ITEM_SCROLL || GetBaseItemType(oInventory) == BASE_ITEM_SPELLSCROLL)
        {
            return oInventory;
        }


        oInventory = GetNextItemInInventory(OBJECT_SELF);

    }
    return OBJECT_INVALID;

}

/*int TS_GetSpellLevel(int nSpellID)
{
    int nRet = 5;//StringToInt(Get2DAString(X2_CI_CRAFTING_SP_2DA, "Level", nSpellID));



//Level 0
if(nSpellID == IP_CONST_CASTSPELL_ACID_SPLASH_1 ||
nSpellID == IP_CONST_CASTSPELL_CURE_MINOR_WOUNDS_1       ||
nSpellID == IP_CONST_CASTSPELL_INFLICT_MINOR_WOUNDS_1 ||
nSpellID == IP_CONST_CASTSPELL_LIGHT_1                ||
nSpellID == IP_CONST_CASTSPELL_LIGHT_5                ||
nSpellID == IP_CONST_CASTSPELL_RESISTANCE_2           ||
nSpellID == IP_CONST_CASTSPELL_RESISTANCE_5           ||
nSpellID == IP_CONST_CASTSPELL_VIRTUE_1               ||
nSpellID == IP_CONST_CASTSPELL_DAZE_1                 ||
nSpellID == IP_CONST_CASTSPELL_ELECTRIC_JOLT_1        ||
nSpellID == IP_CONST_CASTSPELL_FLARE_1                ||
nSpellID == IP_CONST_CASTSPELL_RAY_OF_FROST_1
)
nRet = 0;


//1


if(nSpellID == IP_CONST_CASTSPELL_AMPLIFY_5                      ||
nSpellID == IP_CONST_CASTSPELL_BALAGARNSIRONHORN_7               ||
nSpellID == IP_CONST_CASTSPELL_BANE_5                            ||
nSpellID == IP_CONST_CASTSPELL_BLESS_2                           ||
nSpellID == IP_CONST_CASTSPELL_CURE_LIGHT_WOUNDS_2               ||
nSpellID == IP_CONST_CASTSPELL_CURE_LIGHT_WOUNDS_5               ||
nSpellID == IP_CONST_CASTSPELL_DIVINE_FAVOR_5                    ||
nSpellID == IP_CONST_CASTSPELL_DOOM_2                            ||
nSpellID == IP_CONST_CASTSPELL_DOOM_5                            ||
nSpellID == IP_CONST_CASTSPELL_ENDURE_ELEMENTS_2                 ||
nSpellID == IP_CONST_CASTSPELL_ENTROPIC_SHIELD_5                 ||
nSpellID == IP_CONST_CASTSPELL_INFLICT_LIGHT_WOUNDS_5            ||
nSpellID == IP_CONST_CASTSPELL_PROTECTION_FROM_ALIGNMENT_2       ||
nSpellID == IP_CONST_CASTSPELL_PROTECTION_FROM_ALIGNMENT_5       ||
nSpellID == IP_CONST_CASTSPELL_REMOVE_FEAR_2                     ||
nSpellID == IP_CONST_CASTSPELL_SANCTUARY_2                       ||
nSpellID == IP_CONST_CASTSPELL_SCARE_2                           ||
nSpellID == IP_CONST_CASTSPELL_SHIELD_OF_FAITH_5                 ||
nSpellID == IP_CONST_CASTSPELL_SUMMON_CREATURE_I_2               ||
nSpellID == IP_CONST_CASTSPELL_SUMMON_CREATURE_I_5               ||

nSpellID == IP_CONST_CASTSPELL_CAMOFLAGE_5                       ||
nSpellID == IP_CONST_CASTSPELL_ENTANGLE_2                        ||
nSpellID == IP_CONST_CASTSPELL_ENTANGLE_5                        ||
nSpellID == IP_CONST_CASTSPELL_MAGIC_FANG_5                      ||
nSpellID == IP_CONST_CASTSPELL_GREASE_2                          ||
nSpellID == IP_CONST_CASTSPELL_SLEEP_2                           ||
nSpellID == IP_CONST_CASTSPELL_SLEEP_5                           ||

nSpellID == IP_CONST_CASTSPELL_BURNING_HANDS_2                   ||
nSpellID == IP_CONST_CASTSPELL_BURNING_HANDS_5                   ||
nSpellID == IP_CONST_CASTSPELL_CHARM_PERSON_2                    ||
nSpellID == IP_CONST_CASTSPELL_CHARM_PERSON_10                   ||
nSpellID == IP_CONST_CASTSPELL_COLOR_SPRAY_2                     ||
nSpellID == IP_CONST_CASTSPELL_EXPEDITIOUS_RETREAT_5             ||
nSpellID == IP_CONST_CASTSPELL_IDENTIFY_3                        ||
nSpellID == IP_CONST_CASTSPELL_MAGE_ARMOR_2                      ||
nSpellID == IP_CONST_CASTSPELL_MAGIC_MISSILE_3                   ||
nSpellID == IP_CONST_CASTSPELL_MAGIC_MISSILE_5                   ||
nSpellID == IP_CONST_CASTSPELL_MAGIC_MISSILE_9                   ||
nSpellID == IP_CONST_CASTSPELL_NEGATIVE_ENERGY_RAY_1             ||
nSpellID == IP_CONST_CASTSPELL_NEGATIVE_ENERGY_RAY_3             ||
nSpellID == IP_CONST_CASTSPELL_NEGATIVE_ENERGY_RAY_5             ||
nSpellID == IP_CONST_CASTSPELL_NEGATIVE_ENERGY_RAY_7             ||
nSpellID == IP_CONST_CASTSPELL_NEGATIVE_ENERGY_RAY_9             ||
nSpellID == IP_CONST_CASTSPELL_RAY_OF_ENFEEBLEMENT_2             ||
nSpellID == IP_CONST_CASTSPELL_TRUE_STRIKE_5
)
nRet = 1;



//2

if(nSpellID == IP_CONST_CASTSPELL_AID_3                           ||
nSpellID == IP_CONST_CASTSPELL_AURAOFGLORY_7                   ||
nSpellID == IP_CONST_CASTSPELL_BARKSKIN_3                      ||
nSpellID == IP_CONST_CASTSPELL_BARKSKIN_6                      ||
nSpellID == IP_CONST_CASTSPELL_BARKSKIN_12                     ||
nSpellID == IP_CONST_CASTSPELL_BULLS_STRENGTH_3                ||
nSpellID == IP_CONST_CASTSPELL_BULLS_STRENGTH_10               ||
nSpellID == IP_CONST_CASTSPELL_BULLS_STRENGTH_15               ||
nSpellID == IP_CONST_CASTSPELL_CURE_MODERATE_WOUNDS_3          ||
nSpellID == IP_CONST_CASTSPELL_CURE_MODERATE_WOUNDS_6          ||
nSpellID == IP_CONST_CASTSPELL_CURE_MODERATE_WOUNDS_10         ||
nSpellID == IP_CONST_CASTSPELL_DARKNESS_3                      ||
nSpellID == IP_CONST_CASTSPELL_EAGLE_SPLEDOR_3                 ||
nSpellID == IP_CONST_CASTSPELL_EAGLE_SPLEDOR_10                ||
nSpellID == IP_CONST_CASTSPELL_EAGLE_SPLEDOR_15                ||
nSpellID == IP_CONST_CASTSPELL_ENDURANCE_3                     ||
nSpellID == IP_CONST_CASTSPELL_ENDURANCE_10                    ||
nSpellID == IP_CONST_CASTSPELL_ENDURANCE_15                    ||
nSpellID == IP_CONST_CASTSPELL_FIND_TRAPS_3                    ||
nSpellID == IP_CONST_CASTSPELL_FOXS_CUNNING_3                  ||
nSpellID == IP_CONST_CASTSPELL_FOXS_CUNNING_10                 ||
nSpellID == IP_CONST_CASTSPELL_FOXS_CUNNING_15                 ||
nSpellID == IP_CONST_CASTSPELL_HOLD_PERSON_3                   ||
nSpellID == IP_CONST_CASTSPELL_INFLICT_MODERATE_WOUNDS_7       ||
nSpellID == IP_CONST_CASTSPELL_LESSER_DISPEL_3                 ||
nSpellID == IP_CONST_CASTSPELL_LESSER_DISPEL_5                 ||
nSpellID == IP_CONST_CASTSPELL_LESSER_RESTORATION_3            ||
nSpellID == IP_CONST_CASTSPELL_OWLS_WISDOM_10                  ||
nSpellID == IP_CONST_CASTSPELL_OWLS_WISDOM_15                  ||
nSpellID == IP_CONST_CASTSPELL_OWLS_WISDOM_3                   ||
nSpellID == IP_CONST_CASTSPELL_REMOVE_PARALYSIS_3              ||
nSpellID == IP_CONST_CASTSPELL_RESIST_ELEMENTS_3               ||
nSpellID == IP_CONST_CASTSPELL_RESIST_ELEMENTS_10              ||
nSpellID == IP_CONST_CASTSPELL_SILENCE_3                       ||
nSpellID == IP_CONST_CASTSPELL_SOUND_BURST_3                   ||

nSpellID == IP_CONST_CASTSPELL_BLOOD_FRENZY_7                  ||
nSpellID == IP_CONST_CASTSPELL_CHARM_PERSON_OR_ANIMAL_3        ||
nSpellID == IP_CONST_CASTSPELL_CHARM_PERSON_OR_ANIMAL_10       ||
nSpellID == IP_CONST_CASTSPELL_FLAME_LASH_3                    ||
nSpellID == IP_CONST_CASTSPELL_FLAME_LASH_10                   ||
nSpellID == IP_CONST_CASTSPELL_HOLD_ANIMAL_3                   ||
nSpellID == IP_CONST_CASTSPELL_ONE_WITH_THE_LAND_7             ||



nSpellID == IP_CONST_CASTSPELL_BLINDNESS_DEAFNESS_3            ||
nSpellID == IP_CONST_CASTSPELL_CATS_GRACE_3                    ||
nSpellID == IP_CONST_CASTSPELL_CATS_GRACE_10                   ||
nSpellID == IP_CONST_CASTSPELL_CATS_GRACE_15                   ||
nSpellID == IP_CONST_CASTSPELL_GHOSTLY_VISAGE_3                ||
nSpellID == IP_CONST_CASTSPELL_GHOSTLY_VISAGE_9                ||
nSpellID == IP_CONST_CASTSPELL_GHOSTLY_VISAGE_15               ||
nSpellID == IP_CONST_CASTSPELL_GHOUL_TOUCH_3                   ||
nSpellID == IP_CONST_CASTSPELL_INVISIBILITY_3                  ||
nSpellID == IP_CONST_CASTSPELL_KNOCK_3                         ||
nSpellID == IP_CONST_CASTSPELL_MELFS_ACID_ARROW_3              ||
nSpellID == IP_CONST_CASTSPELL_MELFS_ACID_ARROW_6              ||
nSpellID == IP_CONST_CASTSPELL_MELFS_ACID_ARROW_9              ||
nSpellID == IP_CONST_CASTSPELL_SEE_INVISIBILITY_3              ||
nSpellID == IP_CONST_CASTSPELL_SUMMON_CREATURE_II_3            ||
nSpellID == IP_CONST_CASTSPELL_TASHAS_HIDEOUS_LAUGHTER_7       ||
nSpellID == IP_CONST_CASTSPELL_WEB_3
)
nRet = 2;






//3

if(nSpellID == IP_CONST_CASTSPELL_ANIMATE_DEAD_5                    ||
nSpellID == IP_CONST_CASTSPELL_ANIMATE_DEAD_10                      ||
nSpellID == IP_CONST_CASTSPELL_ANIMATE_DEAD_15                      ||
nSpellID == IP_CONST_CASTSPELL_BESTOW_CURSE_5                       ||
nSpellID == IP_CONST_CASTSPELL_SUMMON_CREATURE_III_5                ||
nSpellID == IP_CONST_CASTSPELL_CLARITY_3                            ||
nSpellID == IP_CONST_CASTSPELL_CONTAGION_5                          ||
nSpellID == IP_CONST_CASTSPELL_CONTINUAL_FLAME_7                    ||
nSpellID == IP_CONST_CASTSPELL_CURE_SERIOUS_WOUNDS_5                ||
nSpellID == IP_CONST_CASTSPELL_CURE_SERIOUS_WOUNDS_10               ||
nSpellID == IP_CONST_CASTSPELL_DARKVISION_3                         ||
nSpellID == IP_CONST_CASTSPELL_DARKVISION_6                         ||
nSpellID == IP_CONST_CASTSPELL_DISPEL_MAGIC_5                       ||
nSpellID == IP_CONST_CASTSPELL_DISPEL_MAGIC_10                      ||
nSpellID == IP_CONST_CASTSPELL_INFLICT_SERIOUS_WOUNDS_9             ||
nSpellID == IP_CONST_CASTSPELL_MAGIC_CIRCLE_AGAINST_ALIGNMENT_5     ||
nSpellID == IP_CONST_CASTSPELL_NEGATIVE_ENERGY_PROTECTION_5         ||
nSpellID == IP_CONST_CASTSPELL_NEGATIVE_ENERGY_PROTECTION_10        ||
nSpellID == IP_CONST_CASTSPELL_NEGATIVE_ENERGY_PROTECTION_15        ||
nSpellID == IP_CONST_CASTSPELL_PRAYER_5                             ||
nSpellID == IP_CONST_CASTSPELL_PROTECTION_FROM_ELEMENTS_3           ||
nSpellID == IP_CONST_CASTSPELL_PROTECTION_FROM_ELEMENTS_10          ||
nSpellID == IP_CONST_CASTSPELL_REMOVE_BLINDNESS_DEAFNESS_5          ||
nSpellID == IP_CONST_CASTSPELL_REMOVE_CURSE_5                       ||
nSpellID == IP_CONST_CASTSPELL_REMOVE_DISEASE_5                     ||
nSpellID == IP_CONST_CASTSPELL_SEARING_LIGHT_5                      ||

nSpellID == IP_CONST_CASTSPELL_CHAIN_LIGHTNING_11                   ||
nSpellID == IP_CONST_CASTSPELL_CHAIN_LIGHTNING_15                   ||
nSpellID == IP_CONST_CASTSPELL_CHAIN_LIGHTNING_20                   ||
nSpellID == IP_CONST_CASTSPELL_DOMINATE_ANIMAL_5                    ||
nSpellID == IP_CONST_CASTSPELL_GREATER_MAGIC_FANG_9                 ||
nSpellID == IP_CONST_CASTSPELL_NEUTRALIZE_POISON_5                  ||
nSpellID == IP_CONST_CASTSPELL_POISON_5                             ||
nSpellID == IP_CONST_CASTSPELL_QUILLFIRE_8                          ||
nSpellID == IP_CONST_CASTSPELL_SPIKE_GROWTH_9                       ||


nSpellID == IP_CONST_CASTSPELL_CLAIRAUDIENCE_CLAIRVOYANCE_5         ||
nSpellID == IP_CONST_CASTSPELL_CLAIRAUDIENCE_CLAIRVOYANCE_10        ||
nSpellID == IP_CONST_CASTSPELL_CLAIRAUDIENCE_CLAIRVOYANCE_15        ||
nSpellID == IP_CONST_CASTSPELL_DISPLACEMENT_9                       ||
nSpellID == IP_CONST_CASTSPELL_FIREBALL_5                           ||
nSpellID == IP_CONST_CASTSPELL_FIREBALL_10                          ||
nSpellID == IP_CONST_CASTSPELL_FLAME_ARROW_5                        ||
nSpellID == IP_CONST_CASTSPELL_FLAME_ARROW_12                       ||
nSpellID == IP_CONST_CASTSPELL_FLAME_ARROW_18                       ||
nSpellID == IP_CONST_CASTSPELL_GUST_OF_WIND_10                      ||
nSpellID == IP_CONST_CASTSPELL_HASTE_5                              ||
nSpellID == IP_CONST_CASTSPELL_HASTE_10                             ||
nSpellID == IP_CONST_CASTSPELL_INVISIBILITY_SPHERE_5                ||
nSpellID == IP_CONST_CASTSPELL_LIGHTNING_BOLT_5                     ||
nSpellID == IP_CONST_CASTSPELL_LIGHTNING_BOLT_10                    ||
nSpellID == IP_CONST_CASTSPELL_NEGATIVE_ENERGY_BURST_5              ||
nSpellID == IP_CONST_CASTSPELL_NEGATIVE_ENERGY_BURST_10             ||
nSpellID == IP_CONST_CASTSPELL_SLOW_5                               ||
nSpellID == IP_CONST_CASTSPELL_STINKING_CLOUD_5                     ||
nSpellID == IP_CONST_CASTSPELL_VAMPIRIC_TOUCH_5                     ||
nSpellID == IP_CONST_CASTSPELL_WOUNDING_WHISPERS_9
)
nRet = 3;










    if(nSpellID > 2000) nRet = 5;

    return nRet;
} */
 int TS_GetSpellLevel(int nSpellID)
{
    int nRet = StringToInt(Get2DAString(X2_CI_CRAFTING_SP_2DA, "Level", nSpellID));

    if(nSpellID > 2000) nRet = 4;

    return nRet;
}







void main()
{
object oWeapon;
object oPC;
object oScroll;
int iSize;
int iSizeDC;

int iValue;
int iValueDC;

int iProperty;
int iPropertyDC;

int iModDC;

int iGemDC;

int iDC = 20;


int iSkill;
int iRoll;

int iDamageType = 0;
int iDamage = 0;

int i;

itemproperty nProperty;
itemproperty iProp;
int iSpellLevel;
int iSpellLevelDC;
int iSpellID;

struct sStringTokenizer sTok;


int iHits = GetLocalInt(OBJECT_SELF, "iHits");



SetLocalInt(OBJECT_SELF, "iHits", 0);

oPC = GetLastSpellCaster();
oWeapon = GetTarget(); //GetItemInSlot(INVENTORY_SLOT_LEFTHAND, oPC);
iSkill = GetSkillRank(SKILL_SPELLCRAFT, oPC);
iRoll = d20();

if(!GetHasFeat(FEAT_CRAFT_WAND, oPC) && !GetHasFeat(FEAT_CRAFT_HARPER_ITEM, oPC)){
  if(!GetIsDM(oPC)){
    SendMessageToPC(oPC, "You need the Craft Wand or Craft Harper Item Feat");
    return;
  }

}


if(!GetIsObjectValid(oWeapon)){

    SendMessageToPC(oPC, "No valid item found on bench.");
    return;

}

sTok = GetStringTokenizer(GetName(oWeapon), "+");

SendMessageToPC(oPC, "Item is: " + GetName(oWeapon));



//oScroll = GetScroll();
iSpellID = GetLastSpell();//GetItemPropertySubType(GetProperty(oScroll, ITEM_PROPERTY_CAST_SPELL));
//AddItemProperty(DURATION_TYPE_PERMANENT, ItemPropertyCastSpell(nSpellID, IP_CONST_CASTSPELL_NUMUSES_SINGLE_USE), oWeapon);
iSpellLevel = TS_GetSpellLevel(iSpellID);


//SendMessageToPC(oPC, "Spell Scroll is: " + GetName(oScroll));

SendMessageToPC(oPC, "Spell ID: " + IntToString(iSpellID));

SendMessageToPC(oPC, "Spell Level: " + IntToString(iSpellLevel));

if(iSpellLevel > 4){
    SendMessageToPC(oPC, "Spell Level too high or spell unknown.");
    if(!GetIsDM(oPC)) return;
}

iSpellLevelDC = (iSpellLevel + 1) * 2;
SendMessageToPC(oPC, "Spell Level DC: " + IntToString(iSpellLevelDC));




//Get Size and Modified DC for crafting

iSize = GetWeaponSize(oWeapon);


/*else if(iSize == 1) iSizeDC = -4;
else if(iSize == 2) iSizeDC = -2;
else if(iSize == 3) iSizeDC = 0;
else if(iSize == 4) iSizeDC = 1;
else if(iSize == 5) iSizeDC = 4;*/

if(iSize == -1) return;
else if(iSize == 0) iSizeDC = -2;  // None
else if(iSize == 1) iSizeDC = -1;  // Padded
else if(iSize == 2) iSizeDC = 0;   // Leather
else if(iSize == 3) iSizeDC = 1;   // Studded Leather / Hide
else if(iSize == 4) iSizeDC = 2;   // Chain Shirt / Scale Mail
else if(iSize == 5) iSizeDC = 3;   // Chainmail / Breastplate
else if(iSize == 6) iSizeDC = 4;   // Splint Mail / Banded Mail
else if(iSize == 7) iSizeDC = 5;   // Half-Plate
else if(iSize == 8) iSizeDC = 6;   // Full Plate
else if(iSize == 9) iSizeDC = 0;   // Ammo
else {
  SendMessageToPC(oPC, "Unknown item: " + IntToString(iSize));
  return;
}



SendMessageToPC(oPC, "Item size: " + IntToString(iSize));
SendMessageToPC(oPC, "Item size DC Adjustment: " + IntToString(iSizeDC));












//Get the number of properties on the weapon already

iProperty = GetNumProperties(oWeapon);

if(iProperty == 0) iPropertyDC = -2;
else iPropertyDC = (iProperty * iProperty) - (2 * iProperty) + 2;

SendMessageToPC(oPC, "Item Properties: " + IntToString(iProperty));
SendMessageToPC(oPC, "Item property DC Adjustment: " + IntToString(iPropertyDC));







//Get Gold value and Modified DC

iValue = GetGoldPieceValue(oWeapon);


if(iPropertyDC <= 0 && iSizeDC < 0 ){
  SendMessageToPC(oPC, "No properties on a small item! More expensive items will give a bonus to crafting!");
  if(iValue <= 15) iValueDC = 2;
  else if(iValue > 15 && iValue <= 120) iValueDC = 1;
  else if(iValue > 120 && iValue <= 850) iValueDC = 0;
  else if(iValue > 850 && iValue <= 1620) iValueDC = -1;
  else if(iValue > 1620 && iValue <= 3000) iValueDC = -2;
  else if(iValue > 3000 && iValue <= 6000) iValueDC = -3;
  else if(iValue > 6000 && iValue <= 9000) iValueDC = -4;
  else if(iValue > 9000 && iValue <= 12000) iValueDC = -5;
  else if(iValue > 12000) iValueDC = -6;

}

else{

  if(iValue <= 15) iValueDC = -5;
  else if(iValue > 15 && iValue <= 120) iValueDC = 0;
  else if(iValue > 120 && iValue <= 850) iValueDC = 1;
  else if(iValue > 850 && iValue <= 1620) iValueDC = 2;
  else if(iValue > 1620 && iValue <= 3000) iValueDC = 3;
  else if(iValue > 3000 && iValue <= 6000) iValueDC = 4;
  else if(iValue > 6000 && iValue <= 9000) iValueDC = 5;
  else if(iValue > 9000 && iValue <= 12000) iValueDC = 6;
  else if(iValue > 12000) iValueDC = 10;

}

SendMessageToPC(oPC, "Item value: " + IntToString(iValue));
SendMessageToPC(oPC, "Item value DC Adjustment: " + IntToString(iValueDC));












if(HasItem("ay_ingot_iron")){
  iModDC = 0;
  SendMessageToPC(oPC, "Item modification DC Adjustment: " + IntToString(iModDC));
}
else if(HasItem("ay_ingot_silver")){
  iModDC = 1;
  if(HasItem("ay_obsidian")){
    iModDC = iModDC + 5;
  }
  if(GetObjectType(oWeapon) == BASE_ITEM_BLANK_WAND){
    SendMessageToPC(oPC, "Wands can only be made with Iron");
    return;
  }
  SendMessageToPC(oPC, "Item modification DC Adjustment: " + IntToString(iModDC));
}
else if(HasItem("ay_ingot_dsteel")){
  iModDC = 2;
  if(HasItem("ay_obsidian")){
    iModDC = iModDC + 5;
  }
  if(GetObjectType(oWeapon) == BASE_ITEM_BLANK_WAND){
    SendMessageToPC(oPC, "Wands can only be made with Iron");
    return;
  }
  SendMessageToPC(oPC, "Item modification DC Adjustment: " + IntToString(iModDC));
}
else if(HasItem("ay_ingot_adaman")){
  iModDC = 4;
  if(HasItem("ay_obsidian")){
    iModDC = iModDC + 5;
  }
  if(GetObjectType(oWeapon) == BASE_ITEM_BLANK_WAND){
    SendMessageToPC(oPC, "Wands can only be made with Iron");
    return;
  }
  SendMessageToPC(oPC, "Item modification DC Adjustment: " + IntToString(iModDC));
}
else if(HasItem("ay_ingot_mithral")){
  iModDC = 6;
  if(HasItem("ay_obsidian")){
    iModDC = iModDC + 5;
  }
  if(GetObjectType(oWeapon) == BASE_ITEM_BLANK_WAND){
    SendMessageToPC(oPC, "Wands can only be made with Iron");
    return;
  }
  SendMessageToPC(oPC, "Item modification DC Adjustment: " + IntToString(iModDC));
}
else{
  SendMessageToPC(oPC, "No Item Found ");
  return;
}




iGemDC = 0;
if(HasItem("NW_IT_GEM006")){
  SendMessageToPC(oPC, "Item DC Gem Bonus: -3 " );
  iGemDC = -3;
}
if(HasItem("NW_IT_GEM012")){
  SendMessageToPC(oPC, "Item DC Gem Bonus: -4 " );
  iGemDC = -4;
}
if(HasItem("NW_IT_GEM008")){
  SendMessageToPC(oPC, "Item DC Gem Bonus: -1 " );
  iGemDC = -1 ;
}
if(HasItem("NW_IT_GEM005")){
  SendMessageToPC(oPC, "Item DC Gem Bonus: -2 " );
  iGemDC = -2;
}
if(GetHasFeat(FEAT_SPELL_FOCUS_ENCHANTMENT, oPC)){
  SendMessageToPC(oPC, "Spell Focus Enchantment Bonus: -2 " );
  iGemDC = iGemDC - 2;
}
/*if(GetHasFeat(FEAT_SPELL_FOCUS_ENCHANTMENT, oPC)){
  SendMessageToPC(oPC, "Spell Focus Enchantment Bonus: -2 " );
  iGemDC = -2;
} */



iDC = 20 + iValueDC + iSizeDC + iPropertyDC + iModDC + iSpellLevelDC + iGemDC;






SendMessageToPC(oPC, "*****");
SendMessageToPC(oPC, "*****");
SendMessageToPC(oPC, "Total DC: " + IntToString(iDC));
//SendMessageToPC(oPC, "Total DC to avoid negative effects: " + IntToString(iDC + 6));
SendMessageToPC(oPC, "*****");
SendMessageToPC(oPC, "*****");


int iXP = iDC * 15 * (iModDC+1) * iSpellLevel + iDC * 3 * (iSpellLevel+1) ;
iXP = iXP / 2;

SendMessageToPC(oPC, "Total XP Cost: " + IntToString(iXP));

if(GetXP(oPC) < (iXP )){
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

//iHits++;
//SetLocalInt(OBJECT_SELF, "iHits", iHits);
SetLocalInt(OBJECT_SELF, "iHits", 0);

/*if(iHits == 1){
  DelayCommand(32.0, SetLocalInt(OBJECT_SELF, "iHits", 0));

}
if(iHits < 5){
  FloatingTextStringOnCreature("*Works on forging the item* ..."+ IntToString(5 - iHits), oPC, FALSE);
  return;

}*/

/*if(iHits > 5){
  ClearAllActions(TRUE);

}

ClearAllActions(TRUE); */








//Actually craft after 5 hits.


SendMessageToPC(oPC, "*****");
SendMessageToPC(oPC, "*****");
SendMessageToPC(oPC, "Roll: "+ IntToString(iRoll) + ", Skill: " + IntToString(iSkill));
SendMessageToPC(oPC, "vs. DC: " + IntToString(iDC));
SendMessageToPC(oPC, "*****");
SendMessageToPC(oPC, "*****");



if(iRoll == 1 || (iRoll + iSkill < iDC)){
  SendMessageToPC(oPC, "Failure! ");


  if(d20() == 1 || (iRoll + iSkill <= iDC - 10)){
    SendMessageToPC(oPC, "Critical Failure! ");
    CleanItems();
  }
  else oWeapon = CopyItem(oWeapon, oPC, TRUE);

  CleanItems();


}
else{
  SendMessageToPC(oPC, "Success! ");

  if(iRoll == 20 || (iRoll + iSkill >= iDC + 10)){
    if(iSpellLevel != 0){
      SendMessageToPC(oPC, "You did a particularly good job on this one.");
      if(!GetIsDM(oPC)) GoodEffect(oWeapon, oPC);
    }
    else
      SendMessageToPC(oPC, "You cannot mastercraft level 0 spells.");
  }
  if(HasItem("004korsanturd")){
    SendMessageToPC(oPC, "There were some flaws in the process.");
    BadEffect(oWeapon, oPC);

  }

  if(GetBaseItemType(oWeapon) == BASE_ITEM_BLANK_WAND){

    DestroyObject(oWeapon);
    oWeapon = CreateItemOnObject("ay_blankwand");

    iProp = ItemPropertyLimitUseByClass(GetLocalInt(OBJECT_SELF, "CasterClass"));
    SendMessageToAllDMs("Last SpellCasatClass: " + IntToString(GetLocalInt(OBJECT_SELF, "CasterClass")));
    AddItemProperty(DURATION_TYPE_PERMANENT, iProp, oWeapon);
    //iProp = ItemPropertyLimitUseByClass(IP_CONST_CLASS_PALADIN);
    //AddItemProperty(DURATION_TYPE_PERMANENT, iProp, oWeapon);


  }

  if(HasItem("ay_arcane")){
      iProp = ItemPropertyLimitUseByClass(IP_CONST_CLASS_WIZARD);
      AddItemProperty(DURATION_TYPE_PERMANENT, iProp, oWeapon);
      iProp = ItemPropertyLimitUseByClass(IP_CONST_CLASS_SORCERER);
      AddItemProperty(DURATION_TYPE_PERMANENT, iProp, oWeapon);
      iProp = ItemPropertyLimitUseByClass(IP_CONST_CLASS_BARD);
      AddItemProperty(DURATION_TYPE_PERMANENT, iProp, oWeapon);
  }
  if(HasItem("ay_divine")){
      iProp = ItemPropertyLimitUseByClass(IP_CONST_CLASS_CLERIC);
      AddItemProperty(DURATION_TYPE_PERMANENT, iProp, oWeapon);
      iProp = ItemPropertyLimitUseByClass(IP_CONST_CLASS_DRUID);
      AddItemProperty(DURATION_TYPE_PERMANENT, iProp, oWeapon);
      iProp = ItemPropertyLimitUseByClass(IP_CONST_CLASS_PALADIN);
      AddItemProperty(DURATION_TYPE_PERMANENT, iProp, oWeapon);
      iProp = ItemPropertyLimitUseByClass(IP_CONST_CLASS_RANGER);
      AddItemProperty(DURATION_TYPE_PERMANENT, iProp, oWeapon);
  }







  if(HasItem("ay_ingot_iron")){
    //RemoveWeaponProperty(oWeapon, ITEM_PROPERTY_AC_BONUS);
    SetItemCharges(oWeapon, d20(2) + GetSkillRank(SKILL_SPELLCRAFT, oPC));
    if(GetIsDM(oPC)) SetItemCharges(oWeapon, 50);
    AddItemProperty(DURATION_TYPE_PERMANENT, ItemPropertyCastSpell(IPGetIPConstCastSpellFromSpellID(iSpellID), IP_CONST_CASTSPELL_NUMUSES_1_CHARGE_PER_USE), oWeapon);
  }
  else if(HasItem("ay_ingot_silver")){
   // RemoveWeaponProperty(oWeapon, ITEM_PROPERTY_AC_BONUS);
    AddItemProperty(DURATION_TYPE_PERMANENT, ItemPropertyCastSpell(IPGetIPConstCastSpellFromSpellID(iSpellID), IP_CONST_CASTSPELL_NUMUSES_1_USE_PER_DAY), oWeapon);
    /*if(iDamageType){
      RemoveWeaponProperty(oWeapon, ITEM_PROPERTY_IMMUNITY_DAMAGE_TYPE);
      AddItemProperty(DURATION_TYPE_PERMANENT, ItemPropertyDamageImmunity(iDamageType, iDamage),oWeapon);
      SendMessageToPC(oPC, "The armor glows with alchemical power ");
    } */
  //SendMessageToPC(oPC, "Weapon modification DC Adjustment: " + IntToString(iModDC));
  }
  else if(HasItem("ay_ingot_dsteel")){
    //RemoveWeaponProperty(oWeapon, ITEM_PROPERTY_AC_BONUS);
    AddItemProperty(DURATION_TYPE_PERMANENT, ItemPropertyCastSpell(IPGetIPConstCastSpellFromSpellID(iSpellID), IP_CONST_CASTSPELL_NUMUSES_2_USES_PER_DAY), oWeapon);
    /*if(iDamageType){
      RemoveWeaponProperty(oWeapon, ITEM_PROPERTY_IMMUNITY_DAMAGE_TYPE);
      AddItemProperty(DURATION_TYPE_PERMANENT, ItemPropertyDamageImmunity(iDamageType, iDamage),oWeapon);
      SendMessageToPC(oPC, "The armor glows with alchemical power ");
    }*/
  //SendMessageToPC(oPC, "Weapon modification DC Adjustment: " + IntToString(iModDC));
  }
  else if(HasItem("ay_ingot_adaman")){
    //RemoveWeaponProperty(oWeapon, ITEM_PROPERTY_AC_BONUS);
    AddItemProperty(DURATION_TYPE_PERMANENT, ItemPropertyCastSpell(IPGetIPConstCastSpellFromSpellID(iSpellID), IP_CONST_CASTSPELL_NUMUSES_3_USES_PER_DAY), oWeapon);
    /*if(iDamageType){
      RemoveWeaponProperty(oWeapon, ITEM_PROPERTY_IMMUNITY_DAMAGE_TYPE);
      AddItemProperty(DURATION_TYPE_PERMANENT, ItemPropertyDamageImmunity(iDamageType, iDamage),oWeapon);
      SendMessageToPC(oPC, "The armor glows with alchemical power ");
    } */
  //SendMessageToPC(oPC, "Weapon modification DC Adjustment: " + IntToString(iModDC));
  }
  else if(HasItem("ay_ingot_mithral")){
    //RemoveWeaponProperty(oWeapon, ITEM_PROPERTY_AC_BONUS);
    AddItemProperty(DURATION_TYPE_PERMANENT, ItemPropertyCastSpell(IPGetIPConstCastSpellFromSpellID(iSpellID), IP_CONST_CASTSPELL_NUMUSES_4_USES_PER_DAY), oWeapon);
    /*if(iDamageType){
      RemoveWeaponProperty(oWeapon, ITEM_PROPERTY_IMMUNITY_DAMAGE_TYPE);
      AddItemProperty(DURATION_TYPE_PERMANENT, ItemPropertyDamageImmunity(iDamageType, iDamage),oWeapon);
      SendMessageToPC(oPC, "The armor glows with alchemical power ");
    }*/
  //SendMessageToPC(oPC, "Weapon modification DC Adjustment: " + IntToString(iModDC));
  }
   else if(HasItem("ay_obsidian")){
    //RemoveWeaponProperty(oWeapon, ITEM_PROPERTY_AC_BONUS);
    AddItemProperty(DURATION_TYPE_PERMANENT, ItemPropertyOnHitCastSpell(iSpellID, Random(4) + 1), oWeapon);
    /*if(iDamageType){
      RemoveWeaponProperty(oWeapon, ITEM_PROPERTY_IMMUNITY_DAMAGE_TYPE);
      AddItemProperty(DURATION_TYPE_PERMANENT, ItemPropertyDamageImmunity(iDamageType, iDamage),oWeapon);
      SendMessageToPC(oPC, "The armor glows with alchemical power ");
    }*/
  //SendMessageToPC(oPC, "Weapon modification DC Adjustment: " + IntToString(iModDC));
  }



  //AddItemProperty(DURATION_TYPE_PERMANENT,ItemPropertyKeen(),oWeapon);






  SetXP(oPC, GetXP(oPC) -  iXP );


  oWeapon = CopyItem(oWeapon, oPC, TRUE);
  CleanItems();
  //while (HasMoreTokens(sTok)) {
  sTok = AdvanceToNextToken(sTok);
  //SpeakString("Next token: " + GetNextToken(sTok));
   // }
  //SendMessageToPC(oPC, "Ayergo result test: " + sTok.sOrig);
  if(!GetIsDM(oPC))
    SetName(oWeapon, GetName(oPC) + "'s Enchanted " + GetNextToken(sTok));
  if(!GetIsDM(oPC))
    SetDescription(oWeapon, "This has the mark of " + GetName(oPC));

  int iCasterLevel = GetCasterLevel(oPC);

  if( iCasterLevel > 0){
    SendMessageToPC(oPC, "Enchanted at Level: " + IntToString(iCasterLevel));
    SetTag(oWeapon, GetTag(oWeapon) + "_cl" + IntToString(iCasterLevel));

  }

  //SetStolenFlag(oWeapon, TRUE);


}










}
