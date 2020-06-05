//
//  NWSubracesList
//
//  Function that creates a list defining all available subraces.
//
//  (c) Shir'le E. Illios, 2002 (shirle@drowwanderer.com)
//
////////////////////////////////////////////////////////


// This file contains the data defining the subraces. In this way it is very
// easy to change existing subraces or add new ones. Below follows an
// explanation of the functions and fields available to set the subrace data.
//
//
// SEI_CreateSubrace( Subrace, Base race, Description )
//
//  This function creates a new subrace. The first parameter must be a unique
//  ID number to define the subrace (best would be to add to the SUBRACE_ enum
//  list). The second parameter is the base race on which the subrace is based
//  and the third parameter is a textual descriptive name for the subrace.
//
//
// SEI_AddFieldText( subrace struct, Text )
//
//  This function adds a text that the subrace will recognize. When a character
//  of the subrace's base race has this text somewhere in their "Subrace" field
//  (on their character sheet) the character will be seen as a character of this
//  subrace. Multiple texts can be added to allow for maximum compatibility.
//
//
// SEI_AddTrait( subrace struct, "<trait>" )
//
//  This function adds a subrace trait (as represented by an effect) to the
//  character. Each trait consists of a string that the script will interpret
//  and translate to the correct effect. For this a strict syntax must be
//  followed. Below is a list of all the texts it recognizes. Everything between
//  angular brackets "<>" has it's own section with tokens to put there. Thus a
//  trait can be 'constructed'.
//
// trait:
// - "ac_inc <amount>"                      = AC Increase by amount
// - "ac_dec <amount>"                      = AC decrease by amount
// - "attack_inc <amount>"                  = Attack increase by amount
// - "attack_dec <amount>"                  = Attack decrease by amount
// - "immune <immunity-type>"               = Immunity to immunity-type
// - "ex <trait>"                           = Make trait extraordinary
// - "su <trait>"                           = Make trait supernatural
// - "m <trait>"                            = Only males characters get this trait
// - "f <trait>"                            = Only females characters get this trait
// - "ability_inc <ability> <amount>"       = Increase ability by amount
// - "ability_dec <ability> <amount>"       = Decrease ability by amount
// - "skill_inc <skill> <amount>"           = Increase skill by amount
// - "skill_dec <skill> <amount>"           = Decrease skill by amount
// - "vs <race> <trait>"                    = Make trait against race
// - "save_inc <save> <amount> <save-type>" = Increase saving throws of save and save-type by amount
// - "save_dec <save> <amount> <save-type>" = Decrease saving throws of save and save-type by amount
//
// ability:
// - "0" = ABILITY_STRENGTH
// - "1" = ABILITY_DEXTERITY
// - "2" = ABILITY_CONSTITUTION
// - "3" = ABILITY_INTELLIGENCE
// - "4" = ABILITY_WISDOM
// - "5" = ABILITY_CHARISMA
//
// immunity-type:
// -  "0" = IMMUNITY_TYPE_NONE
// -  "1" = IMMUNITY_TYPE_MIND_SPELLS
// -  "2" = IMMUNITY_TYPE_POISON
// -  "3" = IMMUNITY_TYPE_DISEASE
// -  "4" = IMMUNITY_TYPE_FEAR
// -  "5" = IMMUNITY_TYPE_TRAP
// -  "6" = IMMUNITY_TYPE_PARALYSIS
// -  "7" = IMMUNITY_TYPE_BLINDNESS
// -  "8" = IMMUNITY_TYPE_DEAFNESS
// -  "9" = IMMUNITY_TYPE_SLOW
// - "10" = IMMUNITY_TYPE_ENTANGLE
// - "11" = IMMUNITY_TYPE_SILENCE
// - "12" = IMMUNITY_TYPE_STUN
// - "13" = IMMUNITY_TYPE_SLEEP
// - "14" = IMMUNITY_TYPE_CHARM
// - "15" = IMMUNITY_TYPE_DOMINATE
// - "16" = IMMUNITY_TYPE_CONFUSED
// - "17" = IMMUNITY_TYPE_CURSED
// - "18" = IMMUNITY_TYPE_DAZED
// - "19" = IMMUNITY_TYPE_ABILITY_DECREASE
// - "20" = IMMUNITY_TYPE_ATTACK_DECREASE
// - "21" = IMMUNITY_TYPE_DAMAGE_DECREASE
// - "22" = IMMUNITY_TYPE_DAMAGE_IMMUNITY_DECREASE
// - "23" = IMMUNITY_TYPE_AC_DECREASE
// - "24" = IMMUNITY_TYPE_MOVEMENT_SPEED_DECREASE
// - "25" = IMMUNITY_TYPE_SAVING_THROW_DECREASE
// - "26" = IMMUNITY_TYPE_SPELL_RESISTANCE_DECREASE
// - "27" = IMMUNITY_TYPE_SKILL_DECREASE
// - "28" = IMMUNITY_TYPE_KNOCKDOWN
// - "29" = IMMUNITY_TYPE_NEGATIVE_LEVEL
// - "30" = IMMUNITY_TYPE_SNEAK_ATTACK
// - "31" = IMMUNITY_TYPE_CRITICAL_HIT
// - "32" = IMMUNITY_TYPE_DEATH
//
// race:
// -  "0" = RACIAL_TYPE_DWARF
// -  "1" = RACIAL_TYPE_ELF
// -  "2" = RACIAL_TYPE_GNOME
// -  "3" = RACIAL_TYPE_HALFLING
// -  "4" = RACIAL_TYPE_HALFELF
// -  "5" = RACIAL_TYPE_HALFORC
// -  "6" = RACIAL_TYPE_HUMAN
// -  "7" = RACIAL_TYPE_ABERRATION
// -  "8" = RACIAL_TYPE_ANIMAL
// -  "9" = RACIAL_TYPE_BEAST
// - "10" = RACIAL_TYPE_CONSTRUCT
// - "11" = RACIAL_TYPE_DRAGON
// - "12" = RACIAL_TYPE_HUMANOID_GOBLINOID
// - "13" = RACIAL_TYPE_HUMANOID_MONSTROUS
// - "14" = RACIAL_TYPE_HUMANOID_ORC
// - "15" = RACIAL_TYPE_HUMANOID_REPTILIAN
// - "16" = RACIAL_TYPE_ELEMENTAL
// - "17" = RACIAL_TYPE_FEY
// - "18" = RACIAL_TYPE_GIANT
// - "19" = RACIAL_TYPE_MAGICAL_BEAST
// - "20" = RACIAL_TYPE_OUTSIDER
// - "23" = RACIAL_TYPE_SHAPECHANGER
// - "24" = RACIAL_TYPE_UNDEAD
// - "25" = RACIAL_TYPE_VERMIN
// - "28" = RACIAL_TYPE_ALL
// - "29" = RACIAL_TYPE_INVALID
//
// save:
// - "0" = SAVING_THROW_ALL
// - "1" = SAVING_THROW_FORT
// - "2" = SAVING_THROW_REFLEX
// - "3" = SAVING_THROW_WILL
//
// save-type:
// -  "0" = SAVING_THROW_TYPE_ALL
// -  "1" = SAVING_THROW_TYPE_MIND_SPELLS
// -  "2" = SAVING_THROW_TYPE_POISON
// -  "3" = SAVING_THROW_TYPE_DISEASE
// -  "4" = SAVING_THROW_TYPE_FEAR
// -  "5" = SAVING_THROW_TYPE_SONIC
// -  "6" = SAVING_THROW_TYPE_ACID
// -  "7" = SAVING_THROW_TYPE_FIRE
// -  "8" = SAVING_THROW_TYPE_ELECTRICITY
// -  "9" = SAVING_THROW_TYPE_POSITIVE
// - "10" = SAVING_THROW_TYPE_NEGATIVE
// - "11" = SAVING_THROW_TYPE_DEATH
// - "12" = SAVING_THROW_TYPE_COLD
// - "13" = SAVING_THROW_TYPE_DIVINE
// - "14" = SAVING_THROW_TYPE_TRAP
// - "15" = SAVING_THROW_TYPE_SPELL
// - "16" = SAVING_THROW_TYPE_GOOD
// - "17" = SAVING_THROW_TYPE_EVIL
// - "18" = SAVING_THROW_TYPE_LAW
// - "19" = SAVING_THROW_TYPE_CHAOS
//
// skill:
// -   "0" = SKILL_ANIMAL_EMPATHY
// -   "1" = SKILL_CONCENTRATION
// -   "2" = SKILL_DISABLE_TRAP
// -   "3" = SKILL_DISCIPLINE
// -   "4" = SKILL_HEAL
// -   "5" = SKILL_HIDE
// -   "6" = SKILL_LISTEN
// -   "7" = SKILL_LORE
// -   "8" = SKILL_MOVE_SILENTLY
// -   "9" = SKILL_OPEN_LOCK
// -  "10" = SKILL_PARRY
// -  "11" = SKILL_PERFORM
// -  "12" = SKILL_PERSUADE
// -  "13" = SKILL_PICK_POCKET
// -  "14" = SKILL_SEARCH
// -  "15" = SKILL_SET_TRAP
// -  "16" = SKILL_SPELLCRAFT
// -  "17" = SKILL_SPOT
// -  "18" = SKILL_TAUNT
// -  "19" = SKILL_USE_MAGIC_DEVICE
// - "255" = SKILL_ALL_SKILLS
//
//
// stSubrace.m_nLightSensitivity = <sensitivity level>;
//
//  This field sets the subrace's light sensitivity. Characters sensitive to
//  bright light get a penalty based on the light sensitivity. Note that while
//  light blindness isn't included in the light sensitivity, a subrace must have
//  a light sensitivity of at least 1 to have light blindness.
//
// sensitivity level:
//  0 = Not sensitive to bright light.
//  1 = Exposure to bright light give a -1 penalty.
//  2 = Exposure to bright light give a -2 penalty.
//
//
// stSubrace.m_nStonecunning = <TRUE/FALSE>;
//
//  This field describes if the subrace gives stonecunning. Characters with
//  stonecunning will have a higher search and hide skill while underground.
//
//
// stSubrace.m_nSpellLikeAbility = <spell-like ability>;
//
//  This field describes which spell-like ability the subrace gives. Currently
//  there are three spell-like abilities supported (based on spells available
//  in NWN): Blindness/deafness, darkness and invisibility. A subrace can only
//  have one spell-like ability.
//
// spell-like ability:
//  0 = No spell-like ability.
//  1 = Blindness/deafness
//  2 = Darkness
//  3 = Invisibility
//
//
// stSubrace.m_bSpellResistance = <TRUE/FALSE>;
//
//  This field describes if the subrace grants spell resistance. If granted the
//  spell resistance will be 11 + character level.
//
//
// stSubrace.m_nFavoredClassF = <favored class>;
// stSubrace.m_nFavoredClassM = <favored class>;
//
//  These fields set the favored class for the subrace (for females and males
//  respectively). If no favored class is specified then the base race's favored
//  class will be used. Use "CLASS_TYPE_INVALID" to have a character's highest
//  class be their favored class.
//
// favored class:
//  CLASS_TYPE_BARBARIAN
//  CLASS_TYPE_BARD
//  CLASS_TYPE_CLERIC
//  CLASS_TYPE_DRUID
//  CLASS_TYPE_FIGHTER
//  CLASS_TYPE_MONK
//  CLASS_TYPE_PALADIN
//  CLASS_TYPE_RANGER
//  CLASS_TYPE_ROGUE
//  CLASS_TYPE_SORCERER
//  CLASS_TYPE_WIZARD
//  CLASS_TYPE_INVALID
//
//
// stSubrace.m_nECLAdd = <amount to add for ECL>;
//
//  These fields set how much must be added to the subrace's level to get to
//  the effective character level. This is used to define the powerful races.
//
//
// stSubrace.m_bIsDefault = <TRUE/FALSE>;
//
//  This field sets if the subrace is the default race for the base race. Only
//  use it if you know what you're doing.
//
//
// SEI_SaveSubrace( subrace struct )
//
//  Once the subrace is completely defined this function saves the data so
//  that characters can become this subrace when they enter.


// **************************************************************
// ** Forward declarations
// **********************

// Private function for the subraces script. Do not use.
struct Subrace SEI_CreateSubrace( int a_nSubrace, int a_nBaseRace, string a_sDescription );

// Private function for the subraces script. Do not use.
struct Subrace SEI_AddFieldText( struct Subrace a_stSubrace, string a_sText );

// Private function for the subraces script. Do not use.
struct Subrace SEI_AddTrait( struct Subrace a_stSubrace, string a_sTrait );

// Private function for the subraces script. Do not use.
void SEI_SaveSubrace( struct Subrace a_stSubrace );


// Define all available subraces.
//
void SEI_DefineSubraces()
{

    struct Subrace stSubrace;


    ////////////////////////////////////////////////////////////////////////////
    // Default subraces
    ////////////////////////////////////////////////////////////////////////////

    // SEI_NOTE: The favored classes for the default subraces need to be the
    //           same as the favored classes for the base races in NWN.
    //           Only change the default subraces if you know what you're doing.

    // Define the "Shield Dwarf" subrace (dwarf default).
    stSubrace = SEI_CreateSubrace( SUBRACE_DWARF_SHIELD, RACIAL_TYPE_DWARF, "Shield Dwarf" );
    stSubrace = SEI_AddFieldText( stSubrace, "shield" );    // "shield dwarf"
    // The favored class for dwarves is fighter.
    stSubrace.m_nFavoredClassF = CLASS_TYPE_FIGHTER;
    stSubrace.m_nFavoredClassM = CLASS_TYPE_FIGHTER;
    stSubrace.m_bIsDefault = TRUE;
    SEI_SaveSubrace( stSubrace );

    // Define the "Moon Elf" subrace (elf default).
    stSubrace = SEI_CreateSubrace( SUBRACE_ELF_MOON, RACIAL_TYPE_ELF, "Moon Elf" );
    stSubrace = SEI_AddFieldText( stSubrace, "moon" );      // "moon elf"
    stSubrace = SEI_AddFieldText( stSubrace, "silver" );    // "silver elf"
    stSubrace = SEI_AddFieldText( stSubrace, "gray" );      // "gray elf"
    stSubrace = SEI_AddFieldText( stSubrace, "grey" );      // "grey elf"
    stSubrace = SEI_AddFieldText( stSubrace, "teu-tel" );   // "Teu-Tel'Quessir"
    // The favored class for elves is wizard.
    stSubrace.m_nFavoredClassF = CLASS_TYPE_WIZARD;
    stSubrace.m_nFavoredClassM = CLASS_TYPE_WIZARD;
    stSubrace.m_bIsDefault = TRUE;
    SEI_SaveSubrace( stSubrace );

    // Define the "Rock Gnome" subrace (gnome default).
    stSubrace = SEI_CreateSubrace( SUBRACE_GNOME_ROCK, RACIAL_TYPE_GNOME, "Rock Gnome" );
    stSubrace = SEI_AddFieldText( stSubrace, "rock" );
    // The favored class for gnomes is illusionist (wizard in NWN).
    stSubrace.m_nFavoredClassF = CLASS_TYPE_WIZARD;
    stSubrace.m_nFavoredClassM = CLASS_TYPE_WIZARD;
    stSubrace.m_bIsDefault = TRUE;
    SEI_SaveSubrace( stSubrace );

    // Define the "Half-elf" subrace (half-elf default).
    stSubrace = SEI_CreateSubrace( SUBRACE_HALFELF, RACIAL_TYPE_HALFELF, "Half-elf" );
    // The favored class for half-elves is any.
    stSubrace.m_nFavoredClassF = CLASS_TYPE_INVALID;
    stSubrace.m_nFavoredClassM = CLASS_TYPE_INVALID;
    stSubrace.m_bIsDefault = TRUE;
    SEI_SaveSubrace( stSubrace );

    // Define the "Half-orc" subrace (half-orc).
    stSubrace = SEI_CreateSubrace( SUBRACE_HALFORC, RACIAL_TYPE_HALFORC, "Half-orc" );
    // The favored class for half-orcs is barbarian.
    stSubrace.m_nFavoredClassF = CLASS_TYPE_BARBARIAN;
    stSubrace.m_nFavoredClassM = CLASS_TYPE_BARBARIAN;
    stSubrace.m_bIsDefault = TRUE;
    SEI_SaveSubrace( stSubrace );

    // Define the "Lightfoot Halfling" subrace (halfling default).
    stSubrace = SEI_CreateSubrace( SUBRACE_HALFLING_LIGHTFOOT, RACIAL_TYPE_HALFLING, "Lightfoot Halfling" );
    stSubrace = SEI_AddFieldText( stSubrace, "light" );
    // The favored class for halflings is rogue.
    stSubrace.m_nFavoredClassF = CLASS_TYPE_ROGUE;
    stSubrace.m_nFavoredClassM = CLASS_TYPE_ROGUE;
    stSubrace.m_bIsDefault = TRUE;
    SEI_SaveSubrace( stSubrace );

    // Define the "Human" subrace (human default).
    stSubrace = SEI_CreateSubrace( SUBRACE_HUMAN, RACIAL_TYPE_HUMAN, "Human" );
    // The favored class for elves is any.
    stSubrace.m_nFavoredClassF = CLASS_TYPE_INVALID;
    stSubrace.m_nFavoredClassM = CLASS_TYPE_INVALID;
    stSubrace.m_bIsDefault = TRUE;
    SEI_SaveSubrace( stSubrace );


    ////////////////////////////////////////////////////////////////////////////
    // Additional subraces
    ////////////////////////////////////////////////////////////////////////////

    // Define the "Gold Dwarf" subrace.
    stSubrace = SEI_CreateSubrace( SUBRACE_DWARF_GOLD, RACIAL_TYPE_DWARF, "Gold Dwarf" );
    stSubrace = SEI_AddFieldText( stSubrace, "gold" );      // "gold dwarf"
    // Gold dwarves get +2 Con, -2 Dex instead of the standard +2 Con, -2 Cha.
    stSubrace = SEI_AddTrait( stSubrace, "ability_inc 5 2" );       // +2 Cha
    stSubrace = SEI_AddTrait( stSubrace, "ability_dec 1 2" );       // -2 Dex
    // Gold dwarves get +1 attack against aberrations instead of against orcs and goblinoids.
    stSubrace = SEI_AddTrait( stSubrace, "vs 14 attack_dec 1" );    // -1 attack vs orcs
    stSubrace = SEI_AddTrait( stSubrace, "vs 12 attack_dec 1" );    // -1 attack vs goblinoids
    stSubrace = SEI_AddTrait( stSubrace, "vs 7 attack_inc 1" );     // +1 attack vs aberrations
    SEI_SaveSubrace( stSubrace );

    // Define the "Gray Dwarf" subrace.
    stSubrace = SEI_CreateSubrace( SUBRACE_DWARF_GRAY, RACIAL_TYPE_DWARF, "Gray Dwarf (Duergar)" );
    stSubrace = SEI_AddFieldText( stSubrace, "gray" );      // "gray dwarf"
    stSubrace = SEI_AddFieldText( stSubrace, "grey" );      // "grey dwarf"
    stSubrace = SEI_AddFieldText( stSubrace, "deep" );      // "deep dwarf"
    stSubrace = SEI_AddFieldText( stSubrace, "duergar" );   // "duergar"
    // Gray dwarves get +2 Con, -4 Cha instead of the standard +2 Con, -2 Cha.
    stSubrace = SEI_AddTrait( stSubrace, "ability_dec 5 2" );       // -2 Cha
    // Gray dwarves get immunity to paralysis, phantasms, and magic or alchemical poisons (but not normal poisons).
    // SEI_NOTE: Removed the phantasms one and replaced it with immunity to all poisons.
    stSubrace = SEI_AddTrait( stSubrace, "immune 6" );              // Immune to paralysis
    stSubrace = SEI_AddTrait( stSubrace, "immune 2" );              // Immune to poison
    // Gray dwarves get +4 racial bonus on Move Silently checks.
    stSubrace = SEI_AddTrait( stSubrace, "skill_inc 8 4" );         // +4 to Move Silently
    // Gray dwarves get +1 racial bonus on Listen and Spot checks.
    stSubrace = SEI_AddTrait( stSubrace, "skill_inc 6 1" );         // +1 to Listen
    stSubrace = SEI_AddTrait( stSubrace, "skill_inc 17 1" );        // +1 to Spot
    // Gray dwarves are sensitive to bright light.
    stSubrace.m_nLightSensitivity = 2;                              // Light sensitivity level 2
    // Gray dwarves get the invisibility spell-like ability.
    stSubrace.m_nSpellLikeAbility = 3;                              // Invisibility
    // Gray dwarves get a +2 level adjustment for being a powerful race
    stSubrace.m_nECLAdd = 2;                                        // ECL + 2
    SEI_SaveSubrace( stSubrace );


    // Define the "Dark Elf" subrace.
    stSubrace = SEI_CreateSubrace( SUBRACE_ELF_DARK, RACIAL_TYPE_ELF, "Dark Elf (Drow)" );
    stSubrace = SEI_AddFieldText( stSubrace, "drow" );      // "drow"
    stSubrace = SEI_AddFieldText( stSubrace, "dark" );      // "dark elf"
    stSubrace = SEI_AddFieldText( stSubrace, "black" );     // "black elf"
    stSubrace = SEI_AddFieldText( stSubrace, "ilythiiri" ); // "Ilythiiri"
    stSubrace = SEI_AddFieldText( stSubrace, "dhaeraow" );  // "Dhaerow"
    stSubrace = SEI_AddFieldText( stSubrace, "mori" );      // "Mori'Quessir"
    stSubrace = SEI_AddFieldText( stSubrace, "ssri-tel" );  // "Ssri-Tel'Quessir"
    stSubrace = SEI_AddFieldText( stSubrace, "gothrim" );   // "Tel'gothrim"
    // Drow get +2 Dex, -2 Con, +2 Int, +2 Cha instead of the standard +2 Dex, -2 Con.
    stSubrace = SEI_AddTrait( stSubrace, "ability_inc 3 2" );       // +2 Int
    stSubrace = SEI_AddTrait( stSubrace, "ability_inc 5 2" );       // +2 Cha
    // Drow get a +2 racial bonus on Will saves against spells and spell-like abilities.
    stSubrace = SEI_AddTrait( stSubrace, "save_inc 3 2 15" );       // +2 Will save against spells
    stSubrace = SEI_AddTrait( stSubrace, "save_inc 3 2 1" );        // +2 Will save against mind-spells
    // Drow get darkvision.
    stSubrace = SEI_AddTrait( stSubrace, "darkvision" );            // Darkvision
    // Drow are sensitive to bright light.
    stSubrace.m_nLightSensitivity = 1;                              // Light sensitivity level 1
    // Drow are blinded when coming into bright light.
    stSubrace.m_fLightBlindness = 6.0;                              // Blinded for 6 seconds
    // Drow get spell resistance.
    stSubrace.m_bSpellResistance = TRUE;                            // Spell resistance
    // Drow get the darkness spell-like ability.
    stSubrace.m_nSpellLikeAbility = 2;                              // Darkness
    // Drow get a +2 level adjustment for being a powerful race
    stSubrace.m_nECLAdd = 2;                                        // ECL + 2
    // Drow females have cleric as their favored class.
    stSubrace.m_nFavoredClassF = CLASS_TYPE_CLERIC;                 // Favored class: Cleric
    SEI_SaveSubrace( stSubrace );

    // Define the "Sun Elf" subrace.
    stSubrace = SEI_CreateSubrace( SUBRACE_ELF_SUN, RACIAL_TYPE_ELF, "Sun Elf" );
    stSubrace = SEI_AddFieldText( stSubrace, "sun" );       // "sun elf"
    stSubrace = SEI_AddFieldText( stSubrace, "gold" );      // "gold elf"
    stSubrace = SEI_AddFieldText( stSubrace, "ar-tel" );    // "Ar-Tel'Quessir"
    // Sun elves get +2 Int, -2 Con instead of the standard +2 Dex, -2 Con.
    stSubrace = SEI_AddTrait( stSubrace, "ability_inc 3 2" );       // +2 Int
    stSubrace = SEI_AddTrait( stSubrace, "ability_dec 1 2" );       // -2 Dex
    SEI_SaveSubrace( stSubrace );

    // Define the "Wild Elf" subrace.
    stSubrace = SEI_CreateSubrace( SUBRACE_ELF_WILD, RACIAL_TYPE_ELF, "Wild Elf" );
    stSubrace = SEI_AddFieldText( stSubrace, "wild" );      // "wild elf"
    stSubrace = SEI_AddFieldText( stSubrace, "savage" );    // "savage elf"
    stSubrace = SEI_AddFieldText( stSubrace, "sy-tel" );    // "Sy-Tel'Quessir"
    // Wild elves get +2 Dex, -2 Int instead of the standard +2 Dex, -2 Con.
    stSubrace = SEI_AddTrait( stSubrace, "ability_inc 2 2" );       // +2 Con
    stSubrace = SEI_AddTrait( stSubrace, "ability_dec 3 2" );       // -2 Int
    // [Errata] Wild elves have sorcerer as their favored class.
    stSubrace.m_nFavoredClassF = CLASS_TYPE_SORCERER;               // Favored class: Sorcerer
    stSubrace.m_nFavoredClassM = CLASS_TYPE_SORCERER;               // Favored class: Sorcerer
    SEI_SaveSubrace( stSubrace );

    // Define the "Wood Elf" subrace.
    stSubrace = SEI_CreateSubrace( SUBRACE_ELF_WOOD, RACIAL_TYPE_ELF, "Wood Elf" );
    stSubrace = SEI_AddFieldText( stSubrace, "wood" );      // "wood elf"
    stSubrace = SEI_AddFieldText( stSubrace, "green" );     // "green elf"
    stSubrace = SEI_AddFieldText( stSubrace, "forest" );    // "forest elf"
    // Wood elves get +2 Str, +2 Dex, -2 Con, -2 Int, -2 Cha instead of the standard +2 Dex, -2 Con.
    stSubrace = SEI_AddTrait( stSubrace, "ability_inc 0 2" );       // +2 Str
    stSubrace = SEI_AddTrait( stSubrace, "ability_dec 3 2" );       // -2 Int
    stSubrace = SEI_AddTrait( stSubrace, "ability_dec 5 2" );       // -2 Cha
    // [Errata] Wood elves have ranger as their favored class.
    stSubrace.m_nFavoredClassF = CLASS_TYPE_RANGER;                 // Favored class: Ranger
    stSubrace.m_nFavoredClassM = CLASS_TYPE_RANGER;                 // Favored class: Ranger
    SEI_SaveSubrace( stSubrace );


    // Define the "Deep Gnome" subrace.
    stSubrace = SEI_CreateSubrace( SUBRACE_GNOME_DEEP, RACIAL_TYPE_GNOME, "Deep Gnome (Svirfneblin)" );
    stSubrace = SEI_AddFieldText( stSubrace, "deep" );
    stSubrace = SEI_AddFieldText( stSubrace, "svirfneblin" );
    // Deep gnomes get -2 Str, +2 Dex, +2 Wis, -4 Cha instead of the standard +2 Con, -2 Str.
    stSubrace = SEI_AddTrait( stSubrace, "ability_inc 1 2" );       // +2 Dex
    stSubrace = SEI_AddTrait( stSubrace, "ability_inc 4 2" );       // +2 Wis
    stSubrace = SEI_AddTrait( stSubrace, "ability_dec 2 2" );       // -2 Con
    stSubrace = SEI_AddTrait( stSubrace, "ability_dec 5 4" );       // -4 Cha
    // Deep gnomes get a +4 dodge bonus against all creatures (and no special bonus against giants).
    stSubrace = SEI_AddTrait( stSubrace, "vs 18 ac_dec 4" );        // -4 AC vs giants
    stSubrace = SEI_AddTrait( stSubrace, "ac_inc 4" );              // +4 AC
    // Deep gnomes get a +2 racial bonus on all saving throws.
    stSubrace = SEI_AddTrait( stSubrace, "save_inc 0 2 0" );        // +2 save bonus
    // Deep gnomes get a +2 racial bonus on Hide checks.
    stSubrace = SEI_AddTrait( stSubrace, "skill_inc 5 2" );         // +2 to Hide
    // Deep gnomes get darkvision.
    stSubrace = SEI_AddTrait( stSubrace, "darkvision" );            // Darkvision
    // Deep gnomes get spell resistance.
    stSubrace.m_bSpellResistance = TRUE;                            // Spell resistance
    // Deep gnomes get stonecunning.
    stSubrace.m_nStonecunning = TRUE;                               // Stonecunning
    // Deep gnomes get the blindness spell-like ability.
    stSubrace.m_nSpellLikeAbility = 1;                              // Blindness/deafness
    // Drow get a +3 level adjustment for being a powerful race
    stSubrace.m_nECLAdd = 3;                                        // ECL + 3
    SEI_SaveSubrace( stSubrace );


    // Define the "Ghostwise Halfling" subrace.
    stSubrace = SEI_CreateSubrace( SUBRACE_HALFLING_GHOSTWISE, RACIAL_TYPE_HALFLING, "Ghostwise Halfling" );
    stSubrace = SEI_AddFieldText( stSubrace, "ghost" );
    // Ghostwise halflings do not receive the standard Halfling +1 racial bonus on all saving throws.
    stSubrace = SEI_AddTrait( stSubrace, "save_dec 0 1 0" );        // -1 save penalty
    SEI_SaveSubrace( stSubrace );

    // Define the "Strongheart Halfling" subrace.
    stSubrace = SEI_CreateSubrace( SUBRACE_HALFLING_STRONGHEART, RACIAL_TYPE_HALFLING, "Strongheart Halfling" );
    stSubrace = SEI_AddFieldText( stSubrace, "strong" );
    // Strongheart halflings do not receive the standard Halfling +1 racial bonus on all saving throws.
    stSubrace = SEI_AddTrait( stSubrace, "save_dec 0 1 0" );        // -1 save penalty
    SEI_SaveSubrace( stSubrace );

    // Define the "Half-drow" subrace.
    stSubrace = SEI_CreateSubrace( SUBRACE_HALFDROW, RACIAL_TYPE_HALFELF, "Half-drow" );
    stSubrace = SEI_AddFieldText( stSubrace, "drow" );      // "drow"
    stSubrace = SEI_AddFieldText( stSubrace, "dark" );      // "dark elf"
    stSubrace = SEI_AddFieldText( stSubrace, "crinti" );      // "Crinti"
    // Half-drow get darkvision.
    stSubrace = SEI_AddTrait( stSubrace, "darkvision" );            // Darkvision
    // The favored class for half-drow is any.
    stSubrace.m_nFavoredClassF = CLASS_TYPE_INVALID;
    stSubrace.m_nFavoredClassM = CLASS_TYPE_INVALID;
    SEI_SaveSubrace( stSubrace );


    // SEI_NOTE: New subraces can be added here.


} // End SEI_DefineSubraces

