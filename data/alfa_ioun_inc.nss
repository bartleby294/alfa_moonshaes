void TurnOffStone(object oPC, object oItem)
{
    effect eEffect = GetFirstEffect(oPC);
    while(GetIsEffectValid( eEffect))
    {
      if (GetEffectCreator( eEffect) == oItem)
      {
        RemoveEffect(oPC, eEffect);
      }
      eEffect = GetNextEffect(oPC);
    }
}

// Just dull. No effect
void Stone_Grey(object oPC, object oItem)
{
 AssignCommand( oItem, ApplyEffectToObject( DURATION_TYPE_PERMANENT, SupernaturalEffect( EffectVisualEffect( 753)), oPC));
}

// +1 Deflection bonus to AC
void Stone_Rose(object oPC, object oItem)
{
 AssignCommand( oPC, ApplyEffectToObject( DURATION_TYPE_PERMANENT, SupernaturalEffect( EffectLinkEffects( EffectVisualEffect( 754), EffectACIncrease( 1, AC_DEFLECTION_BONUS, AC_VS_DAMAGE_TYPE_ALL))), oPC));
}

// No food or water needed
void Stone_Clear(object oPC, object oItem)
{
 AssignCommand( oItem, ApplyEffectToObject( DURATION_TYPE_PERMANENT, SupernaturalEffect( EffectVisualEffect( 755)), oPC));
 SetLocalInt( oPC, "NoFoodNeeded", TRUE);
 SetLocalInt( oPC, "NoWaterNeeded", TRUE);
}

// Adds +2 Strength
void Stone_PaleBlue(object oPC, object oItem)
{
 AssignCommand( oItem, ApplyEffectToObject( DURATION_TYPE_PERMANENT, SupernaturalEffect( EffectLinkEffects( EffectVisualEffect( 756), EffectAbilityIncrease( ABILITY_STRENGTH, 2))), oPC));
}

// Adds +2 Intelligence
void Stone_ScarletBlue(object oPC, object oItem)
{
 AssignCommand( oItem, ApplyEffectToObject( DURATION_TYPE_PERMANENT, SupernaturalEffect( EffectLinkEffects( EffectVisualEffect( 757), EffectAbilityIncrease( ABILITY_INTELLIGENCE, 2))), oPC));
}

// Adds +2 Wisdom
void Stone_IncanBlue(object oPC, object oItem)
{
 AssignCommand( oItem, ApplyEffectToObject( DURATION_TYPE_PERMANENT, SupernaturalEffect( EffectLinkEffects( EffectVisualEffect( 758), EffectAbilityIncrease( ABILITY_WISDOM, 2))), oPC));
}

// Adds +2 Dexterity
void Stone_Red(object oPC, object oItem)
{
 AssignCommand( oItem, ApplyEffectToObject( DURATION_TYPE_PERMANENT, SupernaturalEffect( EffectLinkEffects( EffectVisualEffect( 759), EffectAbilityIncrease( ABILITY_DEXTERITY, 2))), oPC));
}

// Adds +2 Constitution
void Stone_Pink(object oPC, object oItem)
{
 AssignCommand( oItem, ApplyEffectToObject( DURATION_TYPE_PERMANENT, SupernaturalEffect( EffectLinkEffects( EffectVisualEffect( 760), EffectAbilityIncrease( ABILITY_CONSTITUTION, 2))), oPC));
}

// Adds +2 Charisma
void Stone_PinkGreen(object oPC, object oItem)
{
 AssignCommand( oItem, ApplyEffectToObject( DURATION_TYPE_PERMANENT, SupernaturalEffect( EffectLinkEffects( EffectVisualEffect( 761), EffectAbilityIncrease( ABILITY_CHARISMA, 2))), oPC));
}

// Gives Listen +2, Spot +2, Search +2
void Stone_Blue(object oPC, object oItem)
{
 AssignCommand( oItem, ApplyEffectToObject( DURATION_TYPE_PERMANENT, SupernaturalEffect( EffectLinkEffects( EffectLinkEffects( EffectLinkEffects( EffectVisualEffect( 762), EffectSkillIncrease( SKILL_SPOT, 2)), EffectSkillIncrease( SKILL_LISTEN, 2)), EffectSkillIncrease( SKILL_SEARCH, 2))), oPC));
}

// No air needed
void Stone_Iridscent(object oPC, object oItem)
{
 SetLocalInt( oPC, "NoAirNeeded", TRUE);
 AssignCommand( oItem, ApplyEffectToObject( DURATION_TYPE_PERMANENT, SupernaturalEffect( EffectVisualEffect( 764)), oPC));
}

// +1 bonus to Checks, Saves and Attacks
void Stone_Palegreen(object oPC, object oItem)
{
 AssignCommand( oItem, ApplyEffectToObject( DURATION_TYPE_PERMANENT, SupernaturalEffect( EffectLinkEffects( EffectLinkEffects( EffectLinkEffects( EffectVisualEffect( 765), EffectAttackIncrease( 1, ATTACK_BONUS_MISC)), EffectSavingThrowIncrease( SAVING_THROW_ALL, 1, SAVING_THROW_TYPE_ALL)), EffectSkillIncrease( SKILL_ALL_SKILLS, 1))), oPC));
}

// Regenerates 1 hp pr Hour
void Stone_White(object oPC, object oItem)
{
AssignCommand( oItem,
ApplyEffectToObject( DURATION_TYPE_PERMANENT, SupernaturalEffect( EffectLinkEffects( EffectVisualEffect( 766), EffectRegenerate( 1, HoursToSeconds(1)))), oPC));
}

// Absorbs up to level 4
void Stone_Lavender(object oPC, object oItem)
{
 AssignCommand( oItem, ApplyEffectToObject( DURATION_TYPE_PERMANENT, SupernaturalEffect( EffectVisualEffect( 767)), oPC));
 SetLocalObject(oPC, "AbsorbVar4", oItem);
}

// Absorbs up to level 8
void Stone_Lavendergreen(object oPC, object oItem)
{
 AssignCommand( oItem, ApplyEffectToObject( DURATION_TYPE_PERMANENT, SupernaturalEffect( EffectVisualEffect( 768)), oPC));
 SetLocalObject(oPC, "AbsorbVar8", oItem);
}

// Get the spell level of the spell.
int GetSpellLevel(int nSpell)
{
int nLevel;

switch (nSpell)
{
case 1:      // Aid
     nLevel = 2; if (GetLastSpellCastClass() == CLASS_TYPE_RANGER) nLevel =3;   break;
case 3:      // Barkskin
     nLevel = 2;    break;
case 4:      // Bestow Curse
     nLevel = 3; if (GetLastSpellCastClass() == CLASS_TYPE_WIZARD)     nLevel =4;   if (GetLastSpellCastClass() == CLASS_TYPE_SORCERER)   nLevel =4;    break;
case 6:      // Bless
     nLevel = 1;     break;
case 8:      //Blindness and Deafness
    nLevel = 2; if (GetLastSpellCastClass() == CLASS_TYPE_CLERIC)  nLevel =3;    break;
case 9:      // Bull's Strength
     nLevel = 2;      break;
case 10:     // Burning Hands
     nLevel = 1;      break;
case 11:     //Call Lightning
     nLevel = 3;      break;
case 13:      // Cat's Grace
     nLevel = 2;      break;
case 14:     // Chain Lightning
     nLevel = 6;      break;
case 15:     // Charm Monster
     nLevel = 4;      break;
case 16:    // Charm Person
     nLevel = 1;      break;
case 17:   // Charm Person or Animal
     nLevel = 2;      break;
case 19:  // Circle of Doom
    nLevel = 5;       break;
case 21:         // Clarity
     nLevel = 3;
     if (GetLastSpellCastClass() == CLASS_TYPE_BARD)
       nLevel =2;     break;
case 24:         // Color Spray
     nLevel = 1;      break;
case 26:         // Confusion
     nLevel = 4;
     if (GetLastSpellCastClass() == CLASS_TYPE_BARD)
       nLevel =3;
     break;
case 27:         // Contagion
     nLevel = 4;
     if (GetLastSpellCastClass() == CLASS_TYPE_CLERIC)
       nLevel =3;
     if (GetLastSpellCastClass() == CLASS_TYPE_DRUID)
       nLevel =3;
     break;
case 31:      // Cure Critical Wounds
     nLevel = 4;
     if (GetLastSpellCastClass() == CLASS_TYPE_DRUID)
       nLevel =5;
     break;
case 32:      // Cure Light Wounds
     nLevel = 1;
     break;
case 33:      // Cure Minor Wounds
     nLevel = 1;
     break;
case 34:      // Cure Moderate Wounds
     nLevel = 2;
     if (GetLastSpellCastClass() == CLASS_TYPE_DRUID)
       nLevel =3;
     if (GetLastSpellCastClass() == CLASS_TYPE_PALADIN)
       nLevel =3;
     if (GetLastSpellCastClass() == CLASS_TYPE_RANGER)
       nLevel =3;
     break;
case 35:      // Cure Serious Wounds
     nLevel = 3;
     if (GetLastSpellCastClass() == CLASS_TYPE_DRUID)
       nLevel =4;
     if (GetLastSpellCastClass() == CLASS_TYPE_PALADIN)
       nLevel =4;
     if (GetLastSpellCastClass() == CLASS_TYPE_RANGER)
       nLevel =4;
     break;
case 37:       // Daze
    nLevel = 1;
    break;
case 38:      // Death Ward
    nLevel = 4;
    if (GetLastSpellCastClass() == CLASS_TYPE_DRUID)
       nLevel =5;
    break;
case 40:
    nLevel = 4;
    if (GetLastSpellCastClass() == CLASS_TYPE_WIZARD)
       nLevel =5;
    if (GetLastSpellCastClass() == CLASS_TYPE_SORCERER)
       nLevel =5;
    break;
case 41:      // Dispel Magic
    nLevel = 3;
     if (GetLastSpellCastClass() == CLASS_TYPE_DRUID)
       nLevel =4;
    break;
case 42:     // Divine Power
    nLevel = 4;
    break;
case 43:      // Dominate Animal
    nLevel = 3;
    break;
case 45:    // Dominate Person
    nLevel = 4;
    if (GetLastSpellCastClass() == CLASS_TYPE_WIZARD)
       nLevel =5;
    if (GetLastSpellCastClass() == CLASS_TYPE_SORCERER)
       nLevel =5;
    break;
case 46:      // Doom
    nLevel = 1;
    break;
case 47:      // Elemental Shield
    nLevel = 4;
    break;
case 49:      // Endurance
    nLevel = 2;
    break;
case 50:      // Endure Elements
    nLevel = 1;
    break;
case 52:      // Enervation
    nLevel = 4;
    break;
case 55:      // Feeble Mind
    nLevel = 5;
    break;
case 56:          // Finger of Death
    nLevel = 7;
    if (GetLastSpellCastClass() == CLASS_TYPE_DRUID)
       nLevel =8;
    break;
case 59:     // Flame Arrow
    nLevel = 3;
    break;
case 60:      // Flame Lash
    nLevel = 2;
    break;
case 61:      // Flame Strike
    nLevel = 5;
    if (GetLastSpellCastClass() == CLASS_TYPE_DRUID)
       nLevel =4;
    break;
case 62:       // Freedom of Movement
    nLevel = 3;
    break;
case 64:       // Ghoul Touch
    nLevel = 2;
    break;
case 65:       // Globe of Invulnerability
    nLevel = 6;
    break;
case 66:       // Grease
    nLevel = 1;
    break;
case 67:       // Greater Dispelling
    nLevel = 6;
    if (GetLastSpellCastClass() == CLASS_TYPE_BARD)
       nLevel =5;
    break;
case 70:       // Greater Restoration
    nLevel = 7;      break;
case 74:     // Greater Stoneskin
    nLevel = 6;       break;
case 76:   // Hammer of the Gods
    nLevel = 4;       break;
case 77:    // Harm
    nLevel = 6;
     if (GetLastSpellCastClass() == CLASS_TYPE_DRUID)
       nLevel =7;    break;
case 78:     // Haste
    nLevel = 3;
    break;
case 79:      //Heal
    nLevel = 6;
     if (GetLastSpellCastClass() == CLASS_TYPE_DRUID)
       nLevel =7;
    break;
case 80:    // Healing Circle
    nLevel = 5;
     if (GetLastSpellCastClass() == CLASS_TYPE_DRUID)
       nLevel =6;
    break;
case 81:      // Hold Animal
    nLevel = 2;
    break;
case 82:      // Hold Monster
    nLevel = 4;
    if (GetLastSpellCastClass() == CLASS_TYPE_WIZARD)
       nLevel =5;
    if (GetLastSpellCastClass() == CLASS_TYPE_SORCERER)
       nLevel =5;
    break;
case 83:      // Hold Person
    nLevel = 2;
    if (GetLastSpellCastClass() == CLASS_TYPE_WIZARD)
       nLevel =3;
    if (GetLastSpellCastClass() == CLASS_TYPE_SORCERER)
       nLevel =3;
    break;
case 86:       // Identify
    nLevel = 1;
    break;
case 88:       // Improved Invisibility
    nLevel = 4;
    break;
case 90:      //Invisibility
     nLevel = 2;
     break;
case 91:     // Invisibility Purge
    nLevel = 3;
    break;
case 92:      // Invisibility Sphere
    nLevel = 3;
    break;
case 93:      // Knock
    nLevel = 2;
    break;
case 94:      //Lesser Dispell
     nLevel = 2;
     if (GetLastSpellCastClass() == CLASS_TYPE_BARD)
       nLevel =1;
     break;
case 95:     // Lesser Mind Blank
    nLevel = 5;
    break;
case 97:     // Restoration
    nLevel = 2;
    break;
case 98:   // Lesser Spell Brack
    nLevel = 4;
    break;
case 99:   // Lesser Spell Mantle
    nLevel = 5;
    break;
case 100:   // Light
    nLevel = 1;
    break;
case 101:  // Lightning Bolt
    nLevel = 3;
    break;
case 102:    // Mage Armor
     nLevel = 1;
     break;
case 107:    // Magic Missile
     nLevel = 1;
     break;
case 110:    // Mass Blindness and Deafness
     nLevel = 8;
     break;
case 113:       // Mass Haste
     nLevel = 6;
     break;
case 114:       // Mass Heal
     nLevel = 8;
     if (GetLastSpellCastClass() == CLASS_TYPE_DRUID)
       nLevel =99;
     break;
case 115:      // Acid Arrow
     nLevel = 2;
     break;
case 117:     // Mind Blank
     nLevel = 8;
     break;
case 119:     // Minor Globe of Invulnerability
     nLevel = 4;
     break;
case 120:     // Ghostly Visage
     nLevel = 2;
     break;
case 121:     // Ethereal Visage
     nLevel = 5;
     if (GetLastSpellCastClass() == CLASS_TYPE_WIZARD)
       nLevel =6;
     if (GetLastSpellCastClass() == CLASS_TYPE_SORCERER)
       nLevel =6;
     break;
case 125:// Negative Energy Protection
     nLevel = 3;
     break;
case 126:     // Neutralize Poison
     nLevel = 4;
    if (GetLastSpellCastClass() == CLASS_TYPE_DRUID)
       nLevel =3;
     if (GetLastSpellCastClass() == CLASS_TYPE_RANGER)
       nLevel =3;
     break;
case 127:       // Phantasmal Killer
     nLevel = 4;
     break;
case 129:       // Poison
     nLevel = 4;
     if (GetLastSpellCastClass() == CLASS_TYPE_DRUID)
       nLevel =3;
     break;
case 130:     // Polymorph Self
     nLevel = 4;
     break;
case 133:     //Prayer
     nLevel = 3;
     break;
case 134:    //Premonition
     nLevel = 1;
     break;
case 135:    // Prismatic Spray
     nLevel = 7;
     break;
case 137:    // Protection from Elements
     nLevel = 3;
     if (GetLastSpellCastClass() == CLASS_TYPE_RANGER)
       nLevel =2;
     break;
case 141:    // Protection from Spells
     nLevel = 7;
     break;
case 143:    //  Ray of Enfeeblement
     nLevel = 1;
     break;
case 144:    // Ray of Frost
     nLevel = 1;
     break;
case 146:    // Remove Curse
     nLevel = 3;
     if (GetLastSpellCastClass() == CLASS_TYPE_WIZARD)
       nLevel =4;
     if (GetLastSpellCastClass() == CLASS_TYPE_SORCERER)
       nLevel =4;
     break;
case 147:    // Remove Disease
     nLevel = 3;
     break;
case 149:    //Remove Paralysis
     nLevel = 1;
     break;
case 150:    // Resist Elements
     nLevel = 2;
     if (GetLastSpellCastClass() == CLASS_TYPE_RANGER)
       nLevel =4;
     break;
case 151:   // Resistance
     nLevel = 1;
     break;
case 152:    // Restoration
     nLevel = 4;
     break;
case 154:    // Sanctuary
     nLevel = 1;
     break;
case 155:     //
     nLevel = 1;
     break;
case 156:     // Searing Light
     nLevel = 3;
     break;
case 157:     // See Invisibility
     nLevel = 2;
     break;
case 163:     // Silence
     nLevel = 2;
     break;
case 164:     // Slay Living
     nLevel = 5;
     break;
case 166:     // Slow
     nLevel = 3;
     break;
case 168:     // Spell Resistance
     nLevel = 5;
     break;
case 169:     // Mantle
     nLevel = 7;
     break;
case 172:     // Stoneskin
     nLevel = 4;
     break;
case 184:     // Tenser's Transformation
     nLevel = 6;
     break;
case 188:     // Campiric Touch
     nLevel = 3;
     break;
case 354:  // Eagle's Splendor
     nLevel = 1;
     break;
case 355:   // Owl's Wisdom
     nLevel = 1;
     break;
case 356:   // Fox's Cunning
     nLevel = 1;
     break;
case 357:    // Greater Eagle Splendor
     nLevel = 6;
     break;
case 358:    // Greater Owl's Wisdom
     nLevel = 6;
     break;
case 359:    // Greater Fox's Cunning
     nLevel = 6;
     break;
case 360:    // Greater Bull's Strength
     nLevel = 6;
     break;
case 361:    // Greater Cat's Grace
     nLevel = 6;
     break;
case 362:    // Greater Endurance
     nLevel = 6;
     break;
case 364:    // Creeping Doom
     nLevel = 7;
     break;
case 366:    // Destruction
     nLevel = 7;
     break;
case 369:    // Energy Buffer
     nLevel = 6;
     if (GetLastSpellCastClass() == CLASS_TYPE_WIZARD)
       nLevel =5;
     if (GetLastSpellCastClass() == CLASS_TYPE_SORCERER)
       nLevel =5;
     break;
case 371:    // Negative Energy Ray
     nLevel = 1;
     if (GetLastSpellCastClass() == CLASS_TYPE_CLERIC)
       nLevel =2;
     break;
case 374:    //Regenerate
     nLevel = 7;
     if (GetLastSpellCastClass() == CLASS_TYPE_DRUID)
       nLevel =6;
     break;
case 376:          // Legend Lore
     nLevel = 6;
     if (GetLastSpellCastClass() == CLASS_TYPE_BARD)
       nLevel =4;
     break;
case 377:          // Find Traps
     nLevel = 3;
     if (GetLastSpellCastClass() == CLASS_TYPE_CLERIC)
       nLevel =2;
     break;
case 414:          // Divine Favor
     nLevel = 1;
     break;
case 415:          // True Strike
     nLevel = 1;
     break;
case 416:          // Flare
     nLevel = 1;
     break;
case 417:          // Shield
     nLevel = 1;
     break;
case 418:          // Entropic Shield
     nLevel = 1;
     break;
case 420:          // One With the Land
     nLevel = 2;
     break;
case 421:          // Camoflage
     nLevel = 1;
     break;
case 422:          // Blood Frenzy
     nLevel = 2;
     break;
case 424:   // Acid Splash
     nLevel = 1;
     break;
case 425:   // Quillfire
     nLevel = 3;
     break;
case 430:   // Banishment
     nLevel = 6;
     if (GetLastSpellCastClass() == CLASS_TYPE_WIZARD)
       nLevel =7;
     if (GetLastSpellCastClass() == CLASS_TYPE_SORCERER)
       nLevel =7;
     break;
case 431: // Inflict Minor Wounds
     nLevel = 1;
     break;
case 432:   // Inflict Light Wounds
     nLevel = 1;
     break;
case 433:   // Inflict Moderate Wounds
     nLevel = 2;
     break;
case 434:   // Inflict Serious Wounds
     nLevel = 3;
     break;
case 435:   // Inflict Critical Wounds
     nLevel = 4;
     break ;
case 437:
    nLevel = 6;
    break;
case 439:
    nLevel = 1;
    break;
case 440:     // Firebrand
    nLevel = 5;
    break;
case 441:     // Wounding Whispers
    nLevel = 3;
    break;
case 442:      // Amplify
     nLevel = 1;
     break;
case 445:     // Dirge
    nLevel = 6;
    break;
case 447:     // Isaacs Lesser Missile Storm
    nLevel = 4;
    break;
case 448:     // Isaacs Greater Missle Storm
    nLevel = 6;
    break;
case 449:   // Bane
     nLevel = 1;
     break;
case 450:   // Shield of Faith
     nLevel = 1;
     break;
case 455:   // Mass Camoflage
     nLevel = 4;
     break;
case 456:   // Expeditious Retreat
     nLevel = 1;
     break;
case 457:   // Tasha Hideous Laughter
     nLevel = 2;
     break;
case 458:   // Displacement
     nLevel = 2;
     break;
case 459:  //  Bigbys Interposing Hand
     nLevel = 5;
     break;
case 460:  //  Bigbys Forceful Hand
     nLevel = 6;
     break;
case 461:   // Bigbys Grasping Hand
     nLevel = 7;
     break;
case 462:   // Bigbys Clenched Fist
     nLevel = 8;
     break;
case 485:   // Flesh to Stone
     nLevel = 6;
     break;
case 486:   // Stone to Flesh
     nLevel = 6;
     break;
case 513:   // Infestation of Maggots
    nLevel = 3;
    break;
case 514:   // Healing Sting
    nLevel = 3;    break;
case 516:   // Ball Lightning
     nLevel = 5;       break;
case 517:   // Battletide
     nLevel = 5;        break;
case 518:   // Combust
     nLevel = 2;        break;
case 519:   // Death Armor
     nLevel = 5;        break;
case 520:   // Gedlees Electric Loop
     nLevel = 2;       break;
case 522:   // Ironguts
     nLevel = 1;        break;
case 523:   // Mesil's Acid Breath
     nLevel = 3;        break;
case 524:   // Mesil's Acid Sheath
     nLevel = 5;         break;
case 525:   // Monstrous Regeneration
     nLevel = 5;         break;
case 526:   // Scintillating Sphere
     nLevel = 3;         break;
case 527:   // Stone Bones
     nLevel = 2;break;
case 541:   // Blackstaff
     nLevel = 8;break;
case 543:   /* Ice Dagger*/     nLevel = 1;break;
default:  nLevel = 999;break;
}

return nLevel;
}

void StoreSpell(object oTarget)
{
int nSpell = GetSpellId();
int nLevel = GetSpellLevel(nSpell);

int nAmount = GetLocalInt(oTarget, "spell_points");
object oThing = GetItemActivated();

string sFinal;

if ((nLevel >6) || (nLevel >nAmount))
 {
 SetLocalInt(oTarget, "SPELL_CANC", TRUE);
 SendMessageToPC(GetItemPossessor(oTarget),"Nothing seems to have happened.");
 return;
 }

nAmount = nAmount - nLevel;
SetLocalInt(oTarget, "spell_points", nAmount);

string sStore = GetLocalString(oThing, "spell_store");
int nLength = GetStringLength(sStore);
int nSt1 = FindSubString(sStore, "A");
int nSt2 = FindSubString(sStore, "B");
int nSt3 = FindSubString(sStore, "C");
int nSt4 = FindSubString(sStore, "D");
int nSt5 = FindSubString(sStore, "E");
int nSt6 = FindSubString(sStore, "F");

if (nSt1 == 0)
 sFinal = IntToString(nSpell) + GetStringRight(sStore, (nLength-nSt1));
else if ((nSt2-nSt1) == 1)
 sFinal = GetStringLeft(sStore, nSt2) + IntToString(nSpell) + GetStringRight(sStore, (nLength-nSt2));
else if ((nSt3-nSt2) == 1)
 sFinal = GetStringLeft(sStore, nSt3) + IntToString(nSpell) + GetStringRight(sStore, (nLength-nSt3));
else if ((nSt4-nSt3) == 1)
 sFinal = GetStringLeft(sStore, nSt4) + IntToString(nSpell) + GetStringRight(sStore, (nLength-nSt4));
else if ((nSt5-nSt4) == 1)
 sFinal = GetStringLeft(sStore, nSt5) + IntToString(nSpell) + GetStringRight(sStore, (nLength-nSt5));
else if ((nSt6-nSt5) == 1)
 sFinal = GetStringLeft(sStore, nSt6) + IntToString(nSpell) + GetStringRight(sStore, (nLength-nSt6));


SetLocalString(oThing, "spell_store", sFinal);

SendMessageToPC(GetItemPossessor(oTarget),"The spell seems to have been stored into the stone.");

SetLocalInt(oTarget, "SPELL_CANC", TRUE);
return;
}


void AsorbSpell(object oTarget)
{
int nCheck = GetLocalInt(oTarget, "s767");
int nCheck2 = GetLocalInt(oTarget, "s768");
int nPoints;
object oThing;
int nSpell = GetSpellId();
int nLevel = GetSpellLevel(nSpell);

// Gets the activated stone or the highest if both is active
if ((nCheck == 1 && nCheck2 == 1) || (nCheck == 0 && nCheck2 == 1))
 oThing = GetLocalObject(oTarget, "AbsorbVar8");
else if (nCheck == 1 && nCheck2 == 0)
 oThing = GetLocalObject(oTarget, "AbsorbVar4");

nPoints = GetLocalInt(oThing, "AbsVal");

  // If LavenderStone and spell level 5 or higher, make
  // sure it does not work.
  if ((nCheck == 1 && nCheck2 == 0))
    {
    if (nLevel >= 5)
      nLevel = 999;
    }

  // Check if there are enough points left in the stone to asorb
  if(nLevel <= nPoints)
  {
  nPoints = nPoints - nLevel;
  SetLocalInt(oTarget, "SPELL_CANC", TRUE);
  SetLocalInt(oThing, "AbsVal", nPoints);
  SendMessageToPC(oTarget,"The spell seems to have been asorbed by the stone.");
  }

  // Destroys the stone if it reaches zero points.
  if (nPoints == 0)
  {
    if (((nCheck == 1 && nCheck2 == 1) || (nCheck == 0 && nCheck2 == 1))&& GetIsObjectValid(oTarget))
      {
      DeleteLocalObject(oTarget, "AbsorbVar8");
      DelayCommand(0.1, DestroyObject( oThing));
      CreateItemOnObject("alfa_ioun_s753", oTarget,1);
      SendMessageToPC(oTarget,"The stone turns dull and gray.");
      }
    else if ((nCheck == 1 && nCheck2 == 0)&& GetIsObjectValid(oTarget))
      {
      DeleteLocalObject(oTarget, "AbsorbVar4");
      DelayCommand(0.1, DestroyObject( oThing));
      CreateItemOnObject("alfa_ioun_s753", oTarget,1);
      SendMessageToPC(oTarget,"The stone turns dull and gray.");
      }

    effect eEffect = GetFirstEffect(oTarget);
    while(GetIsEffectValid( eEffect))
    {
      if (GetEffectCreator( eEffect) == oThing)
        RemoveEffect(oTarget, eEffect);
      eEffect = GetNextEffect(oTarget);
    }
  }
}

// Which stone is being activated or deactivated
void WhichStone(object oPC, object oItem)
{
string sWhich = GetStringRight(GetTag(oItem),3);
int nWhich = StringToInt(sWhich) -753;
switch (nWhich)
{
case 0:
     Stone_Grey(oPC, oItem);
     break;
case 1:
     Stone_Rose(oPC, oItem);
     break;
case 2:
     Stone_Clear(oPC, oItem);
     break;
case 3:
     Stone_PaleBlue(oPC, oItem);
     break;
case 4:
     Stone_ScarletBlue(oPC, oItem);
     break;
case 5:
     Stone_IncanBlue(oPC, oItem);
     break;
case 6:
     Stone_Red(oPC, oItem);
     break;
case 7:
     Stone_Pink(oPC, oItem);
     break;
case 8:
     Stone_PinkGreen(oPC, oItem);
     break;
case 9:
     Stone_Blue(oPC, oItem);
     break;
//case 10:
//     Stone_Purple(oPC, oItem);
//     break;
case 11:
     Stone_Iridscent(oPC, oItem);
     break;
case 12:
     Stone_Palegreen(oPC, oItem);
     break;
case 13:
     Stone_White(oPC, oItem);
     break;
case 14:
     Stone_Lavender(oPC, oItem);
     break;
case 15:
     Stone_Lavendergreen(oPC, oItem);
     break;
default:
     SendMessageToPC(oPC, "Nothing seemed to happen");
     return;
     break;
}
}


