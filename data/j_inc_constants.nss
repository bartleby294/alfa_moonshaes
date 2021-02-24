/************************ [Constants] ******************************************
    Filename: j_inc_constants
************************* [Constants] ******************************************
    This file just holds many constants, and many common functions (EG: Set
    and Get spawn in conditions) to stop repeating code.

    See workings for more information.
************************* [History] ********************************************
    1.3 - Added to make sure things are not repeated + constants in one place
************************* [Workings] *******************************************
    By using the SoU implimented way of defining static variables, "const" means
    I can have a whole include which will include all used variables - this
    keeps it all uniformed, and compiles better - as in all variable names
    will be valid.

    It may also help speed, as variables which are repeated, are going to be
    there to pick up from memory.

    If it does cause a lot of lag, more updates should clean this up.

    - To Do - Impliment better Debug system (see j_inc_debug) which you can
    uncomment them long debug strings so that they don't get added to compiled
    scripts if not used.
************************* [Arguments] ******************************************
    Arguments: N/A
************************* [Constants] *****************************************/

// This makes most scripts have debug anyway, and so its there :-).
// Multiple includes are ignored anyway :-D
#include "j_inc_debug"

// This is a seperate script from all others. It is executed if a creature wants
// to DetermineCombatRound. It must be seperate to have override and non-override
// versions working together.
const string COMBAT_FILE                            = "j_ai_detercombat";       // FILENAME

// Byond that, do NOT change the rest of these constants, unless you know
// what you are doing!
// I recommend not adding to this file either. Making your own constants
// file will make it full-proof.
//nw_walk_wp
// - FILE_
const string FILE_WALK_WAYPOINTS                    = "j_ai_walkwaypoin";       // FILENAME
const string FILE_RE_SET_WEAPONS                    = "j_ai_setweapons";        // FILENAME
// If we are dead when this fires, it destroys us
const string FILE_DEATH_CLEANUP                     = "j_ai_destroyself";       // FILENAME

// Heartbeat files. Speeds up (hopefully!) heartbeat calls and cirtainly heartbeat file size.
const string FILE_HEARTBEAT_TALENT_BUFF             = "j_ai_heart_buff";
const string FILE_HEARTBEAT_LOOT                    = "j_ai_heart_loot";
const string FILE_HEARTBEAT_ANIMATIONS              = "j_ai_heart_aimate";
const string FILE_HEARTBEAT_WALK_TO_PC              = "j_ai_heart_serch";

const string FILE_DRAGON_WING_BUFFET                = "j_ai_wingbuffet";
const string FILE_FLY_ATTACK                        = "j_ai_wingflying";

// Spell trigger creation file
const string FILE_SPELLTRIGGER_START                = "j_ai_spelltrig1";

// Special: custom AI script set to a standard local string to this:
const string AI_CUSTOM_AI_SCRIPT = "AI_CUSTOM_AI_SCRIPT";

/******************************************************************************/
// Simple constants to save re-typing ETC.
/******************************************************************************/
// Just trying this. It won't harm anything, as with the const word, if the
// numbers are not used, they are not added, but if they are, getting them from
// these might be better.
// - Especially used for imputting the spell talent numbers, and required
//   INT, WIS or CHA for that spell. :-D
const int iM10  = -10;// Dying threshold - die at -11
const int iM1   = -1;
const int i0    = 0;
const int i1    = 1;
const int i2    = 2;
const int i3    = 3;
const int i4    = 4;
const int i5    = 5;
const int i6    = 6;
const int i7    = 7;
const int i8    = 8;
const int i9    = 9;
const int i10   = 10;
const int i11   = 11;
const int i12   = 12;
const int i13   = 13;
const int i14   = 14;
const int i15   = 15;
const int i16   = 16;
const int i17   = 17;
const int i18   = 18;
const int i19   = 19;
const int i20   = 20;
const int i21   = 21;
const int i22   = 22;
const int i23   = 23;// SpellAllSpells
const int i24   = 24;
const int i25   = 25;
const int i30   = 30;
const int i35   = 35;
const int i40   = 40;// Here onwards are normally %'s
const int i50   = 50;
const int i60   = 60;
const int i70   = 70;
const int i80   = 80;
const int i90   = 90;
const int i99   = 99;
const int i100  = 100;
const int i150  = 150;// Limit for PW Stun

const float f0 = 0.0;
const float f1 = 1.0;
const float f2 = 2.0;
const float f3 = 3.0;
const float f4 = 4.0;
const float f5 = 5.0;
const float f6 = 6.0;// 1 heartbeat/round
const float f8 = 8.0;// Useful...for some reason
const float f9 = 9.0;
const float f10 = 10.0;
const float f11 = 11.0;// Range for some spell cones
const float f12 = 12.0;// 2 heartbeats/rounds
const float f15 = 15.0;
const float f16 = 16.0;// Double f8, the range of summon spells.
const float f18 = 18.0;// 3 heartbeats/rounds
const float f20 = 20.0;
const float f24 = 24.0;// 4 heartbeats/rounds
const float f30 = 30.0;
const float f35 = 35.0;
const float f40 = 40.0;
const float f50 = 50.0;
const float f60 = 60.0;

// Ranges for spells - from Ranges.2da
const float fTouchRange  = 2.25;
const float fShortRange  = 8.0;
const float fMediumRange = 20.0;
const float fLongRange   = 40.0;

// Types:
// S. = Stored
// FILENAME
// CONSTANT
// S.CONSTANT
// S.INTEGER
// S.OBJECT
// S.FLOAT

/******************************************************************************/
// Global overriding actions
/******************************************************************************/
// Leader thing
const int AI_SPECIAL_ACTIONS_ME_RUNNER              = 1;                        // CONSTANT
// Fleeing
const int AI_SPECIAL_ACTIONS_FLEE                   = 2;                        // CONSTANT
// Moving out of a pre-set AOE.
const int AI_SPECIAL_ACTIONS_MOVE_OUT_OF_AOE        = 3;                        // CONSTANT

// This is trap thing. If we (on heartbeat) start disarming a trap, can we
// ignore it in combat?
const string TRAP_CAN_IGNORE_IN_COMBAT              = "TRAP_CAN_IGNORE_IN_COMBAT";// S.INTEGER

// Override for all AI scripts
const string AI_TOGGLE                              = "AI_TOGGLE";              // INTEGER

// Set to a local int...
// 1 = Beholder AI
// 2 = Mindflayer AI
const string AI_SPECIAL_AI                          = "AI_SPECIAL_AI";

// Set to the last AI spell category cast.
const string ITEM_TALENT_VALUE                      = "ITEM_TALENT_VALUE";      // S.CONSTANT

    /*************************** Constant set-up *******************************
    We set up all global Spawn In Constants - hex numbers, used to check
    one integer stored OnSpawn for settings the AI should use.

    Also constants for strings, and local variables.
    **************************** Constant set-up ******************************/

/******************************************************************************/
// String constants not associated with On Spawn options. Usually values.
/******************************************************************************/
const string AI_INTELLIGENCE                        = "AI_INTELLIGENCE";        // S.INTEGER
const string AI_MORALE                              = "AI_MORALE";              // S.INTEGER
// Used for spontaeous spells, in the combat AI include and spell files.
const string AI_SPONTAEUOUSLY_CAST_HEALING          = "AI_SPONTAEUOUSLY_CAST_HEALING";// S.INTEGER
// The last level of what summoned animal we cast.
const string AI_LAST_SUMMONED_LEVEL                 = "AI_LAST_SUMMONED_LEVEL"; // S.INTEGER
// Stores (if got FEAT_TURN_UNDEAD) the max level of undead we can turn.
const string AI_TURNING_LEVEL                       = "AI_TURNING_LEVEL";       // S.INTEGER
// Stores the amount of spell levels we are totally immune to
// - Set to a local int.
const string AI_SPELL_IMMUNE_LEVEL                  = "AI_SPELL_IMMUNE_LEVEL";       // S.INTEGER

// Effects constants, actually set on the PC's too for performance :-)
const string AI_EFFECT_HEX                          = "AI_EFFECT_HEX";
const string AI_SPELL_HEX                           = "AI_SPELL_HEX";
const string AI_ABILITY_DECREASE                    = "AI_ABILITY_DECREASE";
// Timer for resetting PC effects
const string AI_TIMER_EFFECT_SET                    = "AI_TIMER_EFFECT_SET";
// This is not a timer, but if 1, it means the NPC uses Jasperre's AI and sets
// thier own effects
const string AI_JASPERRES_EFFECT_SET                = "AI_JASPERRES_EFFECT_SET";
// This is a timer for checking allies for spell effects, for buffing.
// - If TRUE, it won't loop around until it finds one to cast at.
// AI_TIMER_BUFF_ALLY_SPELL + IntToString(iSpell);
const string AI_TIMER_BUFF_ALLY_SPELL               = "AI_TIMER_BUFF_ALLY_SPELL";

// When set to TRUE, it will stop heartbeat flee casting spells
// Deleted when we reach our flee target.
const string AI_HEARTBEAT_FLEE_SPELLS               = "AI_HEARTBEAT_FLEE_SPELLS";// S.INTEGER

// Timer for blocking creatures, and allies re-initiating combat
const string AI_TIMER_BLOCKED                       = "AI_TIMER_BLOCKED";

// this is set for 0.1 second to stop multiple DetermineCombatRound scripts being called
// in a short space of time.
const string AI_DEFAULT_AI_COOLDOWN                 = "AI_DEFAULT_AI_COOLDOWN";

// If this timer is set On Death, it means we do NOT apply EffectDeath to self.
const string AI_TIMER_DEATH_EFFECT_DEATH            = "AI_TIMER_DEATH_EFFECT_DEATH";

/******************************************************************************/
// Spell Trigger numbers/constants/settings
/******************************************************************************/

// Sets to a cirtain condition
const string SPELLTRIGGER_NOT_GOT_FIRST_SPELL   = "AIST_FRST";// - When we !GetHasSpellEffect(iFirstSpell);
const string SPELLTRIGGER_DAMAGED_AT_PERCENT    = "AIST_DAMA";// - When we are below X percent of HP, it fires
const string SPELLTRIGGER_IMMOBILE              = "AIST_IMMB";// - When we are uncommandable/paralyzed/sleeping, etc.
const string SPELLTRIGGER_START_OF_COMBAT       = "AIST_STCM";// - Fired first, whatever condition

// Set up as:
// ASST_FRSTXY
// X - Spell trigger number (1-9)
// Y - Spell trigger spell stored  (1-9)
// Local integer
// MAXINT_ASST_FRST1
// Max number of spells in this trigger
// ASS_FRSTUSED
// This is set to TRUE if used up this round.
const string USED   = "USED";
// This is used for damage %, and is 1-100 for damage at % triggers.
const string VALUE  = "VALUE";
// Our spell trigger creature object
const string AI_SPELL_TRIGGER_CREATURE      = "AI_SPELL_TRIGGER_CREATURE";

// When max is set to -1, we actually reset this on rest event.

// Local on casters
// - Max no. of spells
const string AI_SPELLTRIG_MAXSPELLS = "AI_SPELLTRIG_MAXSPELLS";
// - Constant for prefix - EG: AIST_IMMB3 for the third Immobile spell trig.
const string AI_SPELLTRIG_PREFIX    = "AI_SPELLTRIG_PREFIX";

/******************************************************************************/
// These are the "forgotten" constants, for spells/feats in SoU.
/******************************************************************************/
// FEATS
// THese are the forgotten ones. Others are remembered.
// I have left OUT the ones which we cannot "use"

// These are blackguard. Note that they are under spell abilities, but I'd rather
// use them as ActionUseFeat.
const int AI_FEAT_BG_CREATE_UNDEAD                  = 474;                      // CONSTANT
const int AI_FEAT_BG_FIENDISH_SERVANT               = 475;                      // CONSTANT
// Othes
const int AI_FEAT_PM_CREATE_UNDEAD                  = 890;
const int AI_FEAT_PM_ANIMATE_DEAD                   = 889;
const int AI_FEAT_PM_CREATE_GREATER_UNDEAD          = 895;

// Polymorphing ones missing
const int AI_FEAT_EPIC_WILD_SHAPE_UNDEAD            = 872;
const int AI_FEAT_EPIC_WILD_SHAPE_DRAGON            = 873;
const int AI_FEAT_GREATER_WILDSHAPE_1               = 898;
const int AI_FEAT_GREATER_WILDSHAPE_2               = 900;
const int AI_FEAT_GREATER_WILDSHAPE_3               = 901;
const int AI_FEAT_HUMANOID_SHAPE                    = 902;
const int AI_FEAT_GREATER_WILDSHAPE_4               = 903;

const int AI_FEAT_EPIC_OUTSIDER_SHAPE               = 1060;
const int AI_FEAT_EPIC_CONSTRUCT_SHAPE              = 1061;
const int AI_FEAT_EPIC_SHIFTER_INFINITE_WILDSHAPE_1 = 1062;
const int AI_FEAT_EPIC_SHIFTER_INFINITE_WILDSHAPE_2 = 1063;
const int AI_FEAT_EPIC_SHIFTER_INFINITE_WILDSHAPE_3 = 1064;
const int AI_FEAT_EPIC_SHIFTER_INFINITE_WILDSHAPE_4 = 1065;
const int AI_FEAT_EPIC_SHIFTER_INFINITE_HUMANOID_SHAPE = 1066;
const int AI_FEAT_EPIC_DRUID_INFINITE_WILDSHAPE     = 1068;
const int AI_FEAT_EPIC_DRUID_INFINITE_ELEMENTAL_SHAPE = 1069;

const int AI_FEAT_EPIC_PLANAR_TURNING               = 854;

// Used in tunr undead checking. Faster then looping effects - GetHasSpellEffect(AI_SPELL_FEAT_TURN_UNDEAD);
const int AI_SPELL_FEAT_TURN_UNDEAD                 = 308;

const int AI_SPELL_EVIL_BLIGHT                      = 566;
const int AI_SPELL_FEAT_PLANAR_TURNING              = 643;

// Epic spells are feats, but act like spells.
const int AI_FEAT_EPIC_SPELL_MUMMY_DUST             = 874;
// SPELL_EPIC_MUMMY_DUST
const int AI_FEAT_EPIC_SPELL_DRAGON_KNIGHT          = 875;
// SPELL_EPIC_DRAGON_KNIGHT
const int AI_FEAT_EPIC_SPELL_HELLBALL               = 876;
const int AI_FEAT_EPIC_SPELL_EPIC_MAGE_ARMOR        = 877;
const int AI_FEAT_EPIC_SPELL_RUIN                   = 878;
const int AI_FEAT_EPIC_SPELL_EPIC_WARDING           = 990;

const int AI_SPELL_EPIC_WARDING                     = 695;

// healing ones missed
// Harm self - undead heal!
const int AI_SPELLABILITY_UNDEAD_HARM_SELF          = 759;
// Cure Others Critical Wounds
const int AI_SPELLABILITY_CURE_CRITICAL_WOUNDS_OTHER= 567;


// Subspell set to this:
const string AI_SPELL_SUB_SPELL_CAST = "AI_SPELL_SUB_SPELL_CAST";

// For checking if they have this spell's effects. Most are feats, if not all.
const int AI_SPELL_BARD_SONG                        = 411;                      // CONSTANT
const int AI_SPELL_CURSE_SONG                       = 644;                      // CONSTANT
// - hordes - still not in!
const int AI_SPELL_OWLS_INSIGHT                     = 438;                      // CONSTANT

// These are not anywhere, even though blackguard and AA ones are
const int AI_SPELL_HARPER_CATS_GRACE                = 481;
const int AI_SPELL_HARPER_EAGLE_SPLEDOR             = 482;

// Shifter only spells (monster abilities) that are limited
const int AI_SPELLABILITY_GWILDSHAPE_STONEGAZE      = 687;
const int AI_SPELLABILITY_GWILDSHAPE_DRIDER_DARKNESS= 688;
const int AI_SPELLABILITY_GWILDSHAPE_SPIKES         = 692;// Manticore Spikes - no limit
const int AI_SPELLABILITY_GWILDSHAPE_MINDBLAST      = 693;// GWildShape_Mindblast
const int AI_SPELLABILITY_VAMPIRE_DOMINATION_GAZE   = 800;// Dom gaze.

// Special monster abilities/other hordes spells
// - Some are shifter. Marked by SHIFT at end
const int AI_SPELLABILITY_HARPYSONG                 = 686;// SHIFT -  Harpysong
const int AI_SPELLABILITY_SUMMON_BAATEZU            = 701;
const int AI_SPELLABILITY_EYEBALL_RAY_0             = 710;// EyeballRay0
const int AI_SPELLABILITY_EYEBALL_RAY_1             = 711;// EyeballRay1
const int AI_SPELLABILITY_EYEBALL_RAY_2             = 712;// EyeballRay2
const int AI_SPELLABILITY_MINDFLAYER_MINDBLAST_10   = 713;// Mindflayer Mindblast 10
const int AI_SPELLABILITY_MINDFLAYER_PARAGON_MINDBLAST = 714;// Mindflayer Paragon Mindblast
const int AI_SPELLABILITY_GOLEM_RANGED_SLAM         = 715;
const int AI_SPELLABILITY_SUCKBRAIN                 = 716;// SuckBrain
const int AI_SPELLABILITY_BEHOLDER_MAGIC_CONE       = 727;// Beholder_Anti_Magic_Cone
const int AI_SPELLABILITY_BEBELITH_WEB              = 731;// Bebelith Web
const int AI_SPELLABILITY_BEHOLDER_ALLRAYS          = 736;// Beholder_Special_Spell_AI
const int AI_SPELLABILITY_PSIONIC_INERTIAL_BARRIER  = 741;// Psionic Inertial Barrier
const int AI_SPELLABILITY_SHADOWBLEND               = 757;// ShadowBlend - Shadow dragon.
const int AI_SPELLABILITY_AURA_OF_HELLFIRE          = 761;// Aura
const int AI_SPELLABILITY_HELL_INFERNO              = 762;// Hell Inferno - worse then SPELL_INFERNO
const int AI_SPELLABILITY_PSIONIC_MASS_CONCUSSION   = 763;// Damage to AOE - psiconic mass concussion
const int AI_SPELLABILITY_SHADOW_ATTACK             = 769;// SHIFTER Shadow Attack - also shifter
const int AI_SPELLABILITY_SLAAD_CHAOS_SPITTLE       = 770;// SHIFTER Slaad Chaos Spittle - also shifter
const int AI_SPELLABILITY_BATTLE_BOULDER_TOSS       = 773;
const int AI_SPELLABILITY_PRISMATIC_DEFLECTING_FORCE= 774;// Deflecting_Force
const int AI_SPELLABILITY_GIANT_HURL_ROCK           = 775;
const int AI_SPELLABILITY_ILLITHID_MINDBLAST        = 789;
const int AI_SPELLABILITY_VAMPIRE_INVISIBILITY      = 799;// SHIFTER Vampire Invis.
const int AI_SPELLABILITY_AZER_FIRE_BLAST           = 801;// SHIFTER Fire Blast.
const int AI_SPELLABILITY_SHIFTER_SPECTRE_ATTACK    = 802;// SHIFTER Spectire Attack.

// Constants for AOE's
const string AI_AOE_PER_STORM                   = "AOE_PER_STORM";
const string AI_AOE_PER_CREEPING_DOOM           = "AOE_PER_CREEPING_DOOM";
const string AI_AOE_PER_FOGSTINK                = "AOE_PER_FOGSTINK";
const string AI_AOE_PER_GREASE                  = "AOE_PER_GREASE";
const string AI_AOE_PER_WALLFIRE                = "AOE_PER_WALLFIRE";
const string AI_AOE_PER_WALLBLADE               = "AOE_PER_WALLBLADE";
const string AI_AOE_PER_FOGACID                 = "VFX_PER_FOGACID";
const string AI_AOE_PER_FOGFIRE                 = "VFX_PER_FOGFIRE";
const string AI_AOE_PER_FOGKILL                 = "AOE_PER_FOGKILL";
const string AI_AOE_PER_FOGMIND                 = "VFX_PER_FOGMIND";
const string AI_AOE_PER_ENTANGLE                = "VFX_PER_ENTANGLE";
const string AI_AOE_PER_EVARDS_BLACK_TENTACLES  = "VFX_PER_EVARDS_BLACK_TENTACLES";
const string AI_AOE_PER_FOGBEWILDERMENT         = "VFX_PER_FOGBEWILDERMENT";
const string AI_AOE_PER_STONEHOLD               = "VFX_PER_STONEHOLD";
const string AI_AOE_PER_WEB                     = "VFX_PER_WEB";

// When we ActionAttack
const int AI_NORMAL_MELEE_ATTACK                    = 1000;                     // CONSTANT
const int AI_PARRY_ATTACK                           = 2000;                     // CONSTANT

/******************************************************************************/
// The ignore string. If a creature has this set to anything but 0, then the AI ignores them.
/******************************************************************************/
const string AI_IGNORE_TOGGLE                       = "AI_IGNORE_TOGGLE";       // S.INTEGER

/******************************************************************************/
// String constants not associated with Different Workings during play.
/******************************************************************************/

// In Other AI, this is set on high damage
const string AI_MORALE_PENALTY                      = "AI_MORALE_PENALTY";      // S.INTEGER
// Set via. SetCurrentAction
const string AI_CURRENT_ACTION                      = "AI_CURRENT_ACTION";      // S.INTEGER
// This is set to TRUE once we have died once.
const string WE_HAVE_DIED_ONCE                      = "WE_HAVE_DIED_ONCE";      // S.INTEGER
// Amount of deaths.
const string AMOUNT_OF_DEATHS                       = "AMOUNT_OF_DEATHS";       // S.INTEGER
// Turns off death script firing at all - used for Bioware lootable stuff.
const string I_AM_TOTALLY_DEAD                      = "I_AM_TOTALLY_DEAD";       // S.INTEGER

const string MAX_ELEMENTAL_DAMAGE                   = "MAX_ELEMENTAL_DAMAGE";   // S.INTEGER
const string LAST_ELEMENTAL_DAMAGE                  = "LAST_ELEMENTAL_DAMAGE";  // S.INTEGER
// For this, it sets AI_HIGHEST_DAMAGER to the damager.
const string AI_HIGHEST_DAMAGE_AMOUNT               = "AI_HIGHEST_DAMAGE_AMOUNT";// S.INTEGER
// This needs the damager to be the stored "AI_STORED_LAST_ATTACKER"
const string AI_HIGHEST_PHISICAL_DAMAGE_AMOUNT      = "AI_HIGHEST_PHISICAL_DAMAGE_AMOUNT";// S.INTEGER
// Healing kits
const string AI_VALID_HEALING_KIT_OBJECT            = "AI_VALID_HEALING_KIT_OBJECT";// S.INTEGER
const string AI_VALID_HEALING_KITS                  = "AI_VALID_HEALING_KITS";  // S.INTEGER
// Set to TRUE before re-setting things, it ignores weapons, only does healing kits.
const string RESET_HEALING_KITS                     = "RESET_HEALING_KITS";     // S.INTEGER
// TRUE if any of the SoU animations are valid.
const string AI_VALID_ANIMATIONS                    = "AI_VALID_ANIMATIONS";

// The amounts set to these are waypoint things
const string WAYPOINT_RUN                           = "WAYPOINT_RUN";
const string WAYPOINT_PAUSE                         = "WAYPOINT_PAUSE";

// S.FLOAT
/******************************************************************************/
// Shout strings.
/******************************************************************************/
// 1 - I was attacked. :-P
const string I_WAS_ATTACKED                         = "I_WAS_ATTACKED";         // CONSTANT
// 2 is blocked NWN thingy
// 3 - Call to arms - Determines combat round
const string CALL_TO_ARMS                           = "CALL_TO_ARMS";           // CONSTANT
// 4 - Runner shout (shouts on heartbeat if running)
const string HELP_MY_FRIEND                         = "HELP_MY_FRIEND";         // CONSTANT
// 5 - Leader flee now
const string LEADER_FLEE_NOW                        = "LEADER_FLEE_NOW";        // CONSTANT
// 6 - Attack target X (specific target)
const string LEADER_ATTACK_TARGET                   = "LEADER_ATTACK_TARGET";   // CONSTANT
// 7 - I was killed - May flee if lots die!
const string I_WAS_KILLED                           = "I_WAS_KILLED";           // CONSTANT
// 8 - 1.3 - PLaceables/doors which shout this get responded to!
const string I_WAS_OPENED                           = "I_WAS_OPENED";           // CONSTANT

// Extra - runner location variable (local location)
const string AI_HELP_MY_FRIEND_LOCATION             = "AI_HELP_MY_FRIEND_LOCATION";// LOCATION
// Set on a placeable, by the placeable - thier last opener.
const string PLACEABLE_LAST_OPENED_BY               = "PLACEABLE_LAST_OPENED_BY";// Object

/******************************************************************************/
// All timers  (the end bits. Not the prefixes.)
/******************************************************************************/
const string AI_TIMER_TURN_OFF_HIDE                 = "AI_TURN_OFF_HIDE";       // S.INTEGER
const string AI_TIMER_JUST_CAST_INVISIBILITY        = "AI_TIMER_JUST_CAST_INVISIBILITY";//S.INTEGER
const string AI_TIMER_SHOUT_IGNORE_ANYTHING_SAID    = "AI_TIMER_SHOUT_IGNORE_ANYTHING_SAID";// S.INTEGER
// Heartbeat "move to PC" searching
const string AI_TIMER_SEARCHING                     = "AI_TIMER_SEARCHING";           // S.INTEGER
const string AI_TIMER_STILL_PICKING_UP_ITEMS        = "AI_TIMER_STILL_PICKING_UP_ITEMS";// S.INTEGER
const string AI_TIMER_AIMATIONS_PAUSE               = "AI_TIMER_AIMATIONS_PAUSE";     // S.INTEGER
const string AI_TIMER_ATTACKED_IN_HTH               = "AI_TIMER_ATTACKED_IN_HTH";        // S.INTEGER
const string AI_TIMER_TAUNT                         = "AI_TIMER_TAUNT";         // S.INTEGER
const string AI_TIMER_EMPATHY                       = "AI_TIMER_EMPATHY";       // S.INTEGER
// Special: Adds AOE spell which caused the event.
const string AI_TIMER_AOE_SPELL_EVENT               = "AI_TIMER_AOE_SPELL_EVENT";
const string AI_TIMER_FLEE                          = "AI_TIMER_FLEE";
const string AI_TIMER_LEADER_SENT_RUNNER            = "AI_TIMER_LEADER_SENT_RUNNER";

// Special search timer - stops calling Search()
const string AI_TIMER_SEARCH                        = "AI_TIMER_SEARCH_TIMER";        // S.INTEGER

// On phisical attacked - if knockdown adn they can hit us (and not doofing the AI)
// then we use healing sooner as, basically, we may be knockdowned too much!
const string AI_TIMER_KNOCKDOWN                     = "AI_TIMER_KNOCKDOWN_TIMER";


// Timer to stop cure condition in AI firing.
const string AI_TIMER_CURE_CONDITION                = "AI_TIMER_CURE_CONDITION";

/******************************************************************************/
// All speak talk arrays
/******************************************************************************/
const string AI_TALK_ON_PERCIEVE_ENEMY              = "AI_TALK_ON_PERCIEVE_ENEMY";// S.STRING
const string AI_TALK_ON_CONVERSATION                = "AI_TALK_ON_CONVERSATION";     // S.STRING
const string AI_TALK_ON_PHISICALLY_ATTACKED         = "AI_TALK_ON_PHISICALLY_ATTACKED";// S.STRING
const string AI_TALK_ON_DAMAGED                     = "AI_TALK_ON_DAMAGED";     // S.STRING
const string AI_TALK_ON_DEATH                       = "AI_TALK_ON_DEATH";       // S.STRING
const string AI_TALK_ON_HOSTILE_SPELL_CAST_AT       = "AI_TALK_ON_HOSTILE_SPELL_CAST_AT";// S.STRING
const string AI_TALK_ON_MORALE_BREAK                = "AI_TALK_ON_MORALE_BREAK";// S.STRING
const string AI_TALK_ON_COMBAT_ROUND                = "AI_TALK_ON_COMBAT_ROUND";// S.STRING
const string AI_TALK_WE_PASS_POTION                 = "AI_TALK_WE_PASS_POTION";
const string AI_TALK_WE_GOT_POTION                  = "AI_TALK_WE_GOT_POTION";
const string AI_TALK_ON_CANNOT_RUN                  = "AI_TALK_ON_CANNOT_RUN";
const string AI_TALK_ON_STUPID_RUN                  = "AI_TALK_ON_STUPID_RUN";
const string AI_TALK_ON_COMBAT_ROUND_EQUAL          = "AI_TALK_ON_COMBAT_ROUND_EQUAL";
const string AI_TALK_ON_COMBAT_ROUND_THEM_OVER_US   = "AI_TALK_ON_COMBAT_ROUND_THEM_OVER_US";
const string AI_TALK_ON_COMBAT_ROUND_US_OVER_THEM   = "AI_TALK_ON_COMBAT_ROUND_US_OVER_THEM";
const string AI_TALK_ON_TAUNT                       = "AI_TALK_ON_TAUNT";

const string AI_TALK_ON_LEADER_SEND_RUNNER          = "AI_TALK_ON_LEADER_SEND_RUNNER";
const string AI_TALK_ON_LEADER_ATTACK_TARGET        = "AI_TALK_ON_LEADER_ATTACK_TARGET";
// Constant for the Size of the a string array - the prefix.
const string ARRAY_SIZE                             = "ARRAY_SIZE_";            // S.STRING
const string ARRAY_PERCENT                          = "ARRAY_PER_";             // S.STRING

// Time stop stored array.
const string TIME_STOP_LAST_                        = "TIME_STOP_LAST_";
const string TIME_STOP_LAST_ARRAY_SIZE              = "TIME_STOP_LAST_ARRAY_SIZE";

/******************************************************************************/
// Objects
/******************************************************************************/
// THe leader shout sets an object for others to attack.
const string AI_ATTACK_SPECIFIC_OBJECT              = "AI_ATTACK_SPECIFIC_OBJECT";// S.OBJECT
// Our flee object string name
const string AI_FLEE_TO                             = "AI_FLEE_TO";             // S.OBJECT
// Object - The AOE we have been set to move from - special action
const string AI_AOE_FLEE_FROM                       = "AI_AOE_FLEE_FROM";       // S.OBJECT
// - RANGE to flee from the above object
// - Stored as a normal float value.
const string AI_AOE_FLEE_FROM_RANGE                 = "AI_AOE_FLEE_FROM_RANGE"; // S.FLOAT
// Set to whatever we attack, so others can find out.
const string AI_TO_ATTACK                           = "AI_TO_ATTACK";           // S.OBJECT
// The last phisical attacker set.
const string AI_STORED_LAST_ATTACKER                = "AI_STORED_LAST_ATTACKER";// S.OBJECT
// Highest damager
const string AI_HIGHEST_DAMAGER                     = "AI_HIGHEST_DAMAGER";     // S.OBJECT
// Last person (set on the perception of inaudible or invisible) to have
// invisibility. It is also a local location (no prefix) for where they were!
const string AI_LAST_TO_GO_INVISIBLE                = "AI_LAST_TO_GO_INVISIBLE";// S.OBJECT
// Stored under AI object as normal. If valid, we are meant to run to it.
const string AI_RUNNER_TARGET                       = "AI_RUNNER_TARGET";       // S.OBJECT
/******************************************************************************/
// Looting special
/******************************************************************************/
// Current object to take the thing
const string AI_CURRENT_TAKER                       = "AI_CURRENT_TAKER";       // S.OBJECT
// Exact tag of default body bags.
const string BODY_BAG                               = "BodyBag";

/******************************************************************************/
// Weapons.
/******************************************************************************/
// Arrays, so we have an array (best to worst value)
const string AI_WEAPON_PRIMARY                      = "AI_WEAPON_PRIMARY";      // S.OBJECT
const string AI_WEAPON_SECONDARY                    = "AI_WEAPON_SECONDARY";    // S.OBJECT
const string AI_WEAPON_TWO_HANDED                   = "AI_WEAPON_TWO_HANDED";   // S.OBJECT
const string AI_WEAPON_RANGED                       = "AI_WEAPON_RANGED";       // S.OBJECT
const string AI_WEAPON_RANGED_2                     = "AI_WEAPON_RANGED_2";     // S.OBJECT
const string AI_WEAPON_RANGED_SHIELD                = "AI_WEAPON_RANGED_SHIELD";// S.INTEGER
const string AI_WEAPON_RANGED_AMMOSLOT              = "AI_WEAPON_RANGED_AMMOSLOT";// S.INTEGER
const string AI_WEAPON_RANGED_IS_UNLIMITED          = "AI_WEAPON_RANGED_IS_UNLIMITED";// S.INTEGER
const string AI_WEAPON_SHIELD                       = "AI_WEAPON_SHIELD";       // S.OBJECT
const string AI_WEAPON_SHIELD_2                     = "AI_WEAPON_SHIELD_2";     // S.OBJECT
// End post-fixs as it were
const string WEAP_SIZE                              = "AI_WEAP_SIZE";           // CONSTANT
const string WEAP_DAMAGE                            = "AI_WEAP_DAMAGE";         // CONSTANT

/*******************************************************************************
    Constants for spawn options

    These are set via. SetSpawnInCondition. They have sName set to the right
    one else it is never picked up.

    Names:

    - Targeting & Fleeing                       (AI_TARGETING_FLEE_MASTER)
    - Fighting & Spells                         (AI_COMBAT_MASTER)
    - Other Combat - Healing, Skills & bosses   (AI_OTHER_COMBAT_MASTER)
    - Other - Death corpses, minor things       (AI_OTHER_MASTER)
    - User Defined                              (AI_UDE_MASTER)
    - Shouts                                     N/A
    - Default Bioware settings                  (NW_GENERIC_MASTER)
*******************************************************************************/

/******************************************************************************/
/******************************************************************************/
//Master Constants for UDEs
/******************************************************************************/
/******************************************************************************/
const string AI_UDE_MASTER      = "AI_UDE_MASTER";
const string EXIT_UDE_PREFIX_   = "EXIT_UDE_PREFIX_";// Exit string, like EXIT_UDE_PREFIX_1001 is the heartbeat exit
/******************************************************************************/
/******************************************************************************/

// Added pre- events. Starts them at 1021+, the originals (and some new) are 1001+
const int AI_FLAG_UDE_HEARTBEAT_EVENT               = 0x00000001;   // 1001
const int EVENT_HEARTBEAT_EVENT                     = 1001;
const int AI_FLAG_UDE_HEARTBEAT_PRE_EVENT           = 0x00000002;   // 1021
const int EVENT_HEARTBEAT_PRE_EVENT                 = 1021;

const int AI_FLAG_UDE_PERCIEVE_EVENT                = 0x00000004;   // 1002
const int EVENT_PERCIEVE_EVENT                      = 1002;
const int AI_FLAG_UDE_PERCIEVE_PRE_EVENT            = 0x00000008;   // 1022
const int EVENT_PERCIEVE_PRE_EVENT                  = 1022;

const int AI_FLAG_UDE_END_COMBAT_ROUND_EVENT        = 0x00000010;   // 1003
const int EVENT_END_COMBAT_ROUND_EVENT              = 1003;
const int AI_FLAG_UDE_END_COMBAT_ROUND_PRE_EVENT    = 0x00000020;   // 1023
const int EVENT_END_COMBAT_ROUND_PRE_EVENT          = 1023;

const int AI_FLAG_UDE_ON_DIALOGUE_EVENT             = 0x00000040;   // 1004
const int EVENT_ON_DIALOGUE_EVENT                   = 1004;
const int AI_FLAG_UDE_ON_DIALOGUE_PRE_EVENT         = 0x00000080;   // 1024
const int EVENT_ON_DIALOGUE_PRE_EVENT               = 1024;

const int AI_FLAG_UDE_ATTACK_EVENT                  = 0x00000010;   // 1005
const int EVENT_ATTACK_EVENT                        = 1005;
const int AI_FLAG_UDE_ATTACK_PRE_EVENT              = 0x00000020;   // 1025
const int EVENT_ATTACK_PRE_EVENT                    = 1025;

const int AI_FLAG_UDE_DAMAGED_EVENT                 = 0x00000040;   // 1006
const int EVENT_DAMAGED_EVENT                       = 1006;
const int AI_FLAG_UDE_DAMAGED_PRE_EVENT             = 0x00000080;   // 1026
const int EVENT_DAMAGED_PRE_EVENT                   = 1026;

const int AI_FLAG_UDE_DEATH_EVENT                   = 0x00000100;   // 1007
const int EVENT_DEATH_EVENT                         = 1007;
const int AI_FLAG_UDE_DEATH_PRE_EVENT               = 0x00000200;   // 1027
const int EVENT_DEATH_PRE_EVENT                     = 1027;

const int AI_FLAG_UDE_DISTURBED_EVENT               = 0x00000400;   // 1008
const int EVENT_DISTURBED_EVENT                     = 1008;
const int AI_FLAG_UDE_DISTURBED_PRE_EVENT           = 0x00000800;   // 1028
const int EVENT_DISTURBED_PRE_EVENT                 = 1028;

const int AI_FLAG_UDE_RESTED_EVENT                  = 0x00004000;   // 1009
const int EVENT_RESTED_EVENT                        = 1009;
const int AI_FLAG_UDE_RESTED_PRE_EVENT              = 0x00004000;   // 1029
const int EVENT_RESTED_PRE_EVENT                    = 1029;

const int AI_FLAG_UDE_SPELL_CAST_AT_EVENT           = 0x00001000;   // 1011
const int EVENT_SPELL_CAST_AT_EVENT                 = 1011;
const int AI_FLAG_UDE_SPELL_CAST_AT_PRE_EVENT       = 0x00002000;   // 1031
const int EVENT_SPELL_CAST_AT_PRE_EVENT             = 1031;

const int AI_FLAG_UDE_COMBAT_ACTION_EVENT           = 0x00004000;   // 1012
const int EVENT_COMBAT_ACTION_EVENT                 = 1012;
const int AI_FLAG_UDE_COMBAT_ACTION_PRE_EVENT       = 0x00004000;   // 1032
const int EVENT_COMBAT_ACTION_PRE_EVENT             = 1032;

const int AI_FLAG_UDE_DAMAGED_AT_1_HP               = 0x80000000;   // 1014
const int EVENT_DAMAGED_AT_1_HP                     = 1014;

const int AI_FLAG_UDE_ON_BLOCKED_EVENT              = 0x00008000;   // 1015
const int EVENT_ON_BLOCKED_EVENT                    = 1015;
const int AI_FLAG_UDE_ON_BLOCKED_PRE_EVENT          = 0x00010000;   // 1035
const int EVENT_ON_BLOCKED_PRE_EVENT                = 1035;


/******************************************************************************/
/******************************************************************************/
// Fleeing & Targeting settings, under AI_TARGETING_FLEE_MASTER
/******************************************************************************/
const string AI_TARGETING_FLEE_MASTER = "AI_TARGETING_FLEE_MASTER";
/******************************************************************************/
/******************************************************************************/

// Targeting settings
// We only attack the lowest current HP.
const int AI_FLAG_TARGETING_LIKE_LOWER_HP           = 0x00000001;
// We only attack the lowest AC (as in 1.2).
const int AI_FLAG_TARGETING_LIKE_LOWER_AC           = 0x00000002;
// We go straight for mages/sorcerors
const int AI_FLAG_TARGETING_LIKE_MAGE_CLASSES       = 0x00000004;
// We go for those who are using ranged weapons, especially against us!
// 1. Any ranged attackers attacking us. 2. Any ranged attackers.
const int AI_FLAG_TARGETING_LIKE_ARCHERS            = 0x00000008;
// Attack PC's we see
const int AI_FLAG_TARGETING_LIKE_PCS                = 0x00000010;
// Only attack PC targets if any in range
const int AI_FLAG_TARGETING_FILTER_FOR_PC_TARGETS   = 0x00000020;
// Got for lowest HD
const int AI_FLAG_TARGETING_LIKE_LOWER_HD           = 0x00000040;

// Morale settings

// This will flee to a waypoint set below.
// This is good for fleeing to a boss, fleeing to another area and so on.
const int AI_FLAG_FLEEING_FLEE_TO_WAYPOINT_IF_VALID = 0x00000080;
// This will make the creature never flee at all.
const int AI_FLAG_FLEEING_FEARLESS                  = 0x00000100;
// This will flee to an object, with the correct tag.
const int AI_FLAG_FLEEING_FLEE_TO_OBJECT            = 0x00000200;
// This will make the creature never flee at all.
const int AI_FLAG_FLEEING_FLEE_TO_NEAREST_NONE_SEEN = 0x00000400;
// This will make the creature never fight against impossible odds.
const int AI_FLAG_FLEEING_NEVER_FIGHT_IMPOSSIBLE_ODDS = 0x00000800;
// This turns OFF any sort of group morale bonuses.
const int AI_FLAG_FLEEING_TURN_OFF_GROUP_MORALE     = 0x00001000;
// Stops the overriding of HP% we'd need to test our morale.
const int AI_FLAG_FLEEING_NO_OVERRIDING_HP_AMOUNT   = 0x00002000;

// Stored integer, base morale save (Default 10)
const string BASE_MORALE_SAVE                       = "BASE_MORALE_SAVE";// S.INTEGER

// Penalites for large damage...
const string AI_DAMAGE_AT_ONCE_FOR_MORALE_PENALTY   = "AI_DAMAGE_AT_ONCE_FOR_MORALE_PENALTY";// S.INTEGER
const string AI_DAMAGE_AT_ONCE_PENALTY              = "AI_DAMAGE_AT_ONCE_PENALTY";// S.INTEGER

const string AMOUNT_OF_HD_DIFFERENCE_TO_CHECK       = "AMOUNT_OF_HD_DIFFERENCE_TO_CHECK";// S.INTEGER
const string HP_PERCENT_TO_CHECK_AT                 = "HP_PERCENT_TO_CHECK_AT"; // S.INTEGER
// This is DIFFERENT to the AI_FLEE_TO. This is a set object On Spawn
const string AI_FLEE_OBJECT                         = "AI_FLEE_OBJECT";         // S.OBJECT

const string AI_FAVOURED_ENEMY_RACE                 = "AI_FAVOURED_ENEMY_RACE"; // S.CONSTANT
const string AI_FAVOURED_ENEMY_CLASS                = "AI_FAVOURED_ENEMY_CLASS"; // S.CONSTANT

// How many rounds can we target 1 target?
const string AI_MAX_TURNS_TO_ATTACK_ONE_TARGET  = "AI_MAX_TURNS_TO_ATTACK_ONE_TARGET";

// Locals recording the progress of re-targetting each target, against the above
// limit, default of 6 rounds.
const string AI_MELEE_TURNS_ATTACKING   = "AI_MELEE_TURNS_ATTACKING";
const string AI_SPELL_TURNS_ATTACKING   = "AI_SPELL_TURNS_ATTACKING";
const string AI_RANGED_TURNS_ATTACKING  = "AI_RANGED_TURNS_ATTACKING";

// %'s. Chance to change targets in the next round.
const string AI_MELEE_LAST_TO_NEW_TARGET_CHANCE = "AI_MELEE_NT_CHANCE";
const string AI_RANGED_LAST_TO_NEW_TARGET_CHANCE = "AI_RANGE_NT_CHANCE";
const string AI_SPELL_LAST_TO_NEW_TARGET_CHANCE = "AI_SPELLS_NT_CHANCE";

// Internal AI use only!

// Targeting often-used constants.
const string MAXIMUM            = "MAXIMUM";
const string MINIMUM            = "MINIMUM";
const int TARGET_HIGHER         = 1;
const int TARGET_LOWER          = 0;

const string TARGETING_ISPC         = "TARGETING_ISPC";
const string TARGETING_MANTALS      = "TARGETING_MANTALS";
const string TARGETING_RANGE        = "TARGETING_RANGE";
const string TARGETING_AC           = "TARGETING_AC";
const string TARGETING_SAVES        = "TARGETING_SAVES";
const string TARGETING_PHISICALS    = "TARGETING_PHISICALS";
const string TARGETING_BAB          = "TARGETING_BAB";
const string TARGETING_HITDICE      = "TARGETING_HITDICE";
const string TARGETING_HP_PERCENT   = "TARGETING_HP_PERCENT";
const string TARGETING_HP_CURRENT   = "TARGETING_HP_CURRENT";
const string TARGETING_HP_MAXIMUM   = "TARGETING_HP_MAXIMUM";

// Generic Include constants for locals
const string AI_LAST_MELEE_TARGET   = "AI_LAST_MELEE_TARGET";
const string AI_LAST_SPELL_TARGET   = "AI_LAST_SPELL_TARGET";
const string AI_LAST_RANGED_TARGET  = "AI_LAST_RANGED_TARGET";
// This is how many turns we've been attacking target X
// Should be 0 to reset targets.
const string GLOBAL_TURNS_ATTACKING_MELEE_TARGET    = "GLOBAL_TURNS_ATTACKING_MELEE_TARGET";//S.INTEGER
const string GLOBAL_TURNS_ATTACKING_SPELL_TARGET    = "GLOBAL_TURNS_ATTACKING_SPELL_TARGET";//S.INTEGER
const string GLOBAL_TURNS_ATTACKING_RANGED_TARGET   = "GLOBAL_TURNS_ATTACKING_RANGED_TARGET";//S.INTEGER

/******************************************************************************/
/******************************************************************************/
// Fighting & Spells variables, set under AI_COMBAT_MASTER
/******************************************************************************/
const string AI_COMBAT_MASTER = "AI_COMBAT_MASTER";
// AI_FLAG_COMBAT_
/******************************************************************************/
/******************************************************************************/

/******************************************************************************/
// Mage settings
/******************************************************************************/
// This will make the creature counterspell mages specifically
const int AI_FLAG_COMBAT_COUNTER_SPELL_ARCANE           = 0x00000001;
// This will make the creature counterspell clerics specifically.
const int AI_FLAG_COMBAT_COUNTER_SPELL_DIVINE           = 0x00000002;
// This will make the creature only counterspell if it has a group to
// help it.
const int AI_FLAG_COMBAT_COUNTER_SPELL_ONLY_IN_GROUP    = 0x00000004;

// Makes sure that any targeting never hits allies.
const int AI_FLAG_COMBAT_NEVER_HIT_ALLIES               = 0x00000010;
// This ignores allies that would survive by being hit by the spell
const int AI_FLAG_COMBAT_AOE_DONT_MIND_IF_THEY_SURVIVE  = 0x00000020;
// Targets more with single target (rather than AOE) spells, trying
// to kill one target rather than many.
const int AI_FLAG_COMBAT_SINGLE_TARGETING               = 0x00000040;
// Likes AOE spells - more the merrier, for targeting.
const int AI_FLAG_COMBAT_MANY_TARGETING                 = 0x00000080;
// Improved ...
const int AI_FLAG_COMBAT_IMPROVED_INSTANT_DEATH_SPELLS  = 0x00002000;
const int AI_FLAG_COMBAT_IMPROVED_SUMMON_TARGETING      = 0x00004000;
const int AI_FLAG_COMBAT_IMPROVED_IMMUNITY_CHECKING     = 0x00008000;
const int AI_FLAG_COMBAT_IMPROVED_SPECIFIC_SPELL_IMMUNITY= 0x00010000;
// When set, this will force use all potions
const int AI_FLAG_COMBAT_USE_ALL_POTIONS                = 0x00020000;
// This will make the creature use ranged spells, before moving in bit by bit.
// Ranges of spells are 40, then 20, 8, 2.5 and then 0 (or self! hehe)
const int AI_FLAG_COMBAT_LONGER_RANGED_SPELLS_FIRST     = 0x00040000;
// Dispels highest level mage in range rather then spell target.
const int AI_FLAG_COMBAT_DISPEL_MAGES_MORE              = 0x00080000;
// Dispels in order of spell power on dispel target
const int AI_FLAG_COMBAT_DISPEL_IN_ORDER                = 0x00100000;
// Turn on more ally buffing
const int AI_FLAG_COMBAT_MORE_ALLY_BUFFING_SPELLS       = 0x00200000;

// This will make the creature summon thier respective familiars/animal companions.
const int AI_FLAG_COMBAT_SUMMON_FAMILIAR                = 0x00400000;
// Uses spells, to buff before an enemy comes near. (changed: not NW_prefix)
const int AI_FLAG_COMBAT_FLAG_FAST_BUFF_ENEMY           = 0x00800000;

// Set integers

const string AI_AOE_HD_DIFFERENCE   = "AI_AOE_HD_DIFFERENCE";
// Ignore AOE target if got this amount of allies in a blast area
const string AI_AOE_ALLIES_LOWEST_IN_AOE  = "AI_AOE_ALLIES_LOWEST_IN_AOE";

// Cheat cast spells set to this (SetAIConstant, with a + IntToString(1+) added)
const string AI_CHEAT_CAST_SPELL    = "AI_CHEAT_CAST_SPELL";

// the spell last valid random casting
const string GLOBAL_LAST_SPELL_INFORMATION  = "GLOBAL_LAST_SPELL_INFORMATION";

/******************************************************************************/
// Fighter settings
/******************************************************************************/
// This sets to pick up weapons which are disarmed.
const int AI_FLAG_COMBAT_PICK_UP_DISARMED_WEAPONS       = 0x01000000;
// IE TANK! Well, if we do have ranged weapons (EG giants with slings
// for "rocks"), but are bloody tougher in HTH.
const int AI_FLAG_COMBAT_BETTER_AT_HAND_TO_HAND         = 0x02000000;
// Moves back, uses more ranged weapons
const int AI_FLAG_COMBAT_ARCHER_ATTACKING               = 0x04000000;
// Forces move back if got ranged weapon
const int AI_FLAG_COMBAT_ARCHER_ALWAYS_MOVE_BACK        = 0x08000000;
// Forces using a bow (if got one)
const int AI_FLAG_COMBAT_ARCHER_ALWAYS_USE_BOW          = 0x10000000;
// No killing off low HP PC's
const int AI_FLAG_COMBAT_NO_GO_FOR_THE_KILL             = 0x20000000;

// What range to use missile weapons
const string AI_RANGED_WEAPON_RANGE = "AI_RANGED_WEAPON_RANGE";
/******************************************************************************/
// Dragon settings
/******************************************************************************/
// No wing buffet.
const int AI_FLAG_COMBAT_NO_WING_BUFFET                 = 0x40000000;
// (Dragon) flying on
const int AI_FLAG_COMBAT_FLYING                         = 0x80000000;

// String constants - integers
const string AI_DRAGON_FREQUENCY_OF_BUFFET = "AI_DRAGON_FREQUENCY_OF_BUFFET";
const string AI_DRAGON_FREQUENCY_OF_BREATH = "AI_DRAGON_FREQUENCY_OF_BREATH";
// Constants for counters
const string AI_DRAGONS_BREATH  = "AI_DRAGONS_BREATH";
const string AI_WING_BUFFET     = "AI_WING_BUFFET";

// Flying to target
const string AI_FLYING_TARGET = "AI_FLYING_TARGET";

/******************************************************************************/
/******************************************************************************/
// Other Combat - Healing, Skills & bosses - AI_OTHER_COMBAT_MASTER
/******************************************************************************/
const string AI_OTHER_COMBAT_MASTER = "AI_OTHER_COMBAT_MASTER";
//AI_FLAG_OTHER_COMBAT_
/******************************************************************************/
/******************************************************************************/

/******************************************************************************/
// Healing settings
// % to heal allies. Advanced healing search, and if they are a front liner or not.
/******************************************************************************/
const int AI_FLAG_OTHER_COMBAT_HEAL_AT_PERCENT_NOT_AMOUNT   = 0x00000001;
const int AI_FLAG_OTHER_COMBAT_WILL_RAISE_ALLIES_IN_BATTLE  = 0x00000002;
const int AI_FLAG_OTHER_COMBAT_NO_CURING                    = 0x00000004;
const int AI_FLAG_OTHER_COMBAT_ONLY_CURE_SELF               = 0x00000008;
const int AI_FLAG_OTHER_COMBAT_ONLY_RESTORE_SELF            = 0x00000010;
const int AI_FLAG_OTHER_COMBAT_GIVE_POTIONS_TO_HELP         = 0x00000020;
const int AI_FLAG_OTHER_COMBAT_USE_BAD_HEALING_SPELLS       = 0x00000040;

// Locals
const string AI_HEALING_US_PERCENT                  = "AI_HEALING_US_PERCENT";  // S.INTEGER
const string AI_HEALING_ALLIES_PERCENT              = "AI_HEALING_ALLIES_PERCENT";  // S.INTEGER
const string SECONDS_BETWEEN_STATUS_CHECKS          = "ROUNDS_BETWEEN_STATUS_CHECKS";// S.INTEGER

/******************************************************************************/
// Skill settings
// How the NPC uses skills (pickpocket, taunt, healing kits...) and disarming traps.
/******************************************************************************/
const int AI_FLAG_OTHER_COMBAT_NO_PICKPOCKETING             = 0x00000080;
const int AI_FLAG_OTHER_COMBAT_FORCE_PICKPOCKETING          = 0x00000100;
const int AI_FLAG_OTHER_COMBAT_NO_TAUNTING                  = 0x00000200;
const int AI_FLAG_OTHER_COMBAT_FORCE_TAUNTING               = 0x00000400;
const int AI_FLAG_OTHER_COMBAT_NO_EMPATHY                   = 0x00000800;
const int AI_FLAG_OTHER_COMBAT_FORCE_EMPATHY                = 0x00001000;
const int AI_FLAG_OTHER_COMBAT_NO_HIDING                    = 0x00002000;
const int AI_FLAG_OTHER_COMBAT_FORCE_HIDING                 = 0x00004000;
const int AI_FLAG_OTHER_COMBAT_NO_OPENING_LOCKED_DOORS      = 0x00008000;
const int AI_FLAG_OTHER_COMBAT_FORCE_OPENING_LOCKED_DOORS   = 0x00010000;
const int AI_FLAG_OTHER_COMBAT_NO_USING_HEALING_KITS        = 0x00020000;
const int AI_FLAG_OTHER_COMBAT_FORCE_USING_HEALING_KITS     = 0x00040000;
const int AI_FLAG_OTHER_COMBAT_NO_SEARCH                    = 0x00080000;
const int AI_FLAG_OTHER_COMBAT_FORCE_SEARCH                 = 0x00100000;
const int AI_FLAG_OTHER_COMBAT_NO_CONCENTRATION             = 0x00200000;
const int AI_FLAG_OTHER_COMBAT_FORCE_CONCENTRATION          = 0x00400000;
const int AI_FLAG_OTHER_COMBAT_NO_PARRYING                  = 0x00800000;
const int AI_FLAG_OTHER_COMBAT_FORCE_PARRYING               = 0x01000000;

// Counts up the concentration move counter, if over 5 we won't move back AGAIN
// but stand and fight a bit!
const string AI_CONCENTRATIONMOVE_COUNTER   = "AI_CONCENTRATIONMOVE_COUNTER";

/******************************************************************************/
// Boss settings, AI_BOSS_MASTER
// Leaders/Boss settings
/******************************************************************************/
// Boss shout. Brings creatures in a pre-set, or standard range to us.
const int AI_FLAG_OTHER_COMBAT_BOSS_MONSTER_SHOUT           = 0x02000000;
// Are we the group leader?
const int AI_FLAG_OTHER_COMBAT_GROUP_LEADER                 = 0x04000000;

// Range for the shout
const string AI_BOSS_MONSTER_SHOUT_RANGE            = "AI_BOSS_MONSTER_SHOUT_RANGE";
// counter - adds 1, when 4+, we may shout for people to attack our target.
const string AI_LEADER_SHOUT_COUNT                  = "AI_LEADER_SHOUT_COUNT";

/******************************************************************************/
/******************************************************************************/
// Bioware variables
// NW_GENERIC_MASTER. Mostly used for animations + stuff.
/******************************************************************************/
const string NW_GENERIC_MASTER = "NW_GENERIC_MASTER";
/******************************************************************************/
/******************************************************************************/

//const int NW_FLAG_SPECIAL_CONVERSATION        = 0x00000001;
//const int NW_FLAG_SHOUT_ATTACK_MY_TARGET      = 0x00000002;
//const int NW_FLAG_STEALTH                     = 0x00000004;
//const int NW_FLAG_SEARCH                      = 0x00000008;
//const int NW_FLAG_SET_WARNINGS                = 0x00000010;
//const int NW_FLAG_ESCAPE_RETURN               = 0x00000020; //Failed
//const int NW_FLAG_ESCAPE_LEAVE                = 0x00000040;
//const int NW_FLAG_TELEPORT_RETURN             = 0x00000080; //Failed
//const int NW_FLAG_TELEPORT_LEAVE              = 0x00000100;
//const int NW_FLAG_PERCIEVE_EVENT              = 0x00000200;
//const int NW_FLAG_ATTACK_EVENT                = 0x00000400;
//const int NW_FLAG_DAMAGED_EVENT               = 0x00000800;
//const int NW_FLAG_SPELL_CAST_AT_EVENT         = 0x00001000;
//const int NW_FLAG_DISTURBED_EVENT             = 0x00002000;
//const int NW_FLAG_END_COMBAT_ROUND_EVENT      = 0x00004000;
//const int NW_FLAG_ON_DIALOGUE_EVENT           = 0x00008000;
//const int NW_FLAG_RESTED_EVENT                = 0x00010000;
//const int NW_FLAG_DEATH_EVENT                 = 0x00020000;
//const int NW_FLAG_SPECIAL_COMBAT_CONVERSATION = 0x00040000;
//const int NW_FLAG_AMBIENT_ANIMATIONS          = 0x00080000;
//const int NW_FLAG_HEARTBEAT_EVENT             = 0x00100000;
const int NW_FLAG_IMMOBILE_AMBIENT_ANIMATIONS = 0x00200000;
const int NW_FLAG_DAY_NIGHT_POSTING           = 0x00400000;
const int NW_FLAG_AMBIENT_ANIMATIONS_AVIAN    = 0x00800000;
//const int NW_FLAG_APPEAR_SPAWN_IN_ANIMATION   = 0x01000000;
//const int NW_FLAG_SLEEPING_AT_NIGHT           = 0x02000000;
//const int NW_FLAG_FAST_BUFF_ENEMY             = 0x04000000;


/******************************************************************************/
// Other settings, AI_OTHER_MASTER
// Death, minor things.
/******************************************************************************/
const string AI_OTHER_MASTER = "AI_OTHER_MASTER";
//AI_FLAG_OTHER_
/******************************************************************************/

/******************************************************************************/
// Death
/******************************************************************************/
// This turns off corpses - they won't be set to destroyable, and will be
// destroyed on death, instantly.
const int AI_FLAG_OTHER_TURN_OFF_CORPSES                        = 0x00000001;
// This will turn on Bioware's SetLootable stuff. It is performed On Death (Using EffectRessurection)
const int AI_FLAG_OTHER_USE_BIOWARE_LOOTING                     = 0x00400000;

const string AI_WE_WILL_CREATE_ON_DEATH             = "AI_WE_WILL_CREATE_ON_DEATH";// S.STRING
const string AI_DEATH_VISUAL_EFFECT                 = "AI_DEATH_VISUAL_EFFECT"; // S.CONSTANT
const string AI_CORPSE_DESTROY_TIME                 = "AI_CORPSE_DESTROY_TIME"; // S.INTEGER

/******************************************************************************/
// Behaviour
/******************************************************************************/
// We search around going nearer enemies on heartbeat.
const int AI_FLAG_OTHER_SEARCH_IF_ENEMIES_NEAR                  = 0x00000002;
// We change to hostile when we are attacked.
const int AI_FLAG_OTHER_CHANGE_FACTIONS_TO_HOSTILE_ON_ATTACK    = 0x00000004;
// We don't attack when we see an enemy, they must attack us normally.
const int AI_FLAG_OTHER_ONLY_ATTACK_IF_ATTACKED                 = 0x00000008;
// We rest at the end of combat, after searching.
const int AI_FLAG_OTHER_REST_AFTER_COMBAT                       = 0x00000010;
// No voice chats.
const int AI_FLAG_OTHER_NO_PLAYING_VOICE_CHAT                   = 0x00000040;

const string AI_SEARCH_IF_ENEMIES_NEAR_RANGE        = "AI_SEARCH_IF_ENEMIES_NEAR_RANGE";// S.INTEGER
const string AI_DOOR_INTELLIGENCE                   = "AI_DOOR_INTELLIGENCE";   // S.INTEGER
// Items and loot picking extra bags.
const string AI_LOOT_BAG_OTHER_1                    = "AI_LOOT_BAG_OTHER_1";    // S.STRING
const string AI_LOOT_BAG_OTHER_2                    = "AI_LOOT_BAG_OTHER_2";    // S.STRING
const string AI_LOOT_BAG_OTHER_3                    = "AI_LOOT_BAG_OTHER_3";    // S.STRING

/******************************************************************************/
// Alignment - only 2 things
/******************************************************************************/
// Do we stop commoner default?
const int AI_FLAG_OTHER_NO_COMMONER_ALIGNMENT_CHANGE            = 0x00000080;
// Do we stop commoner default?
const int AI_FLAG_OTHER_FORCE_COMMONER_ALIGNMENT_CHANGE         = 0x00000100;

/******************************************************************************/
// Lag settings
/******************************************************************************/
// We do not use any items.
const int AI_FLAG_OTHER_LAG_NO_ITEMS                            = 0x00000200;
// No casting of spells!
const int AI_FLAG_OTHER_LAG_NO_SPELLS                           = 0x00000400;
// No listening, for anything.
const int AI_FLAG_OTHER_LAG_NO_LISTENING                        = 0x00000800;
// Use ActionEquipMostDamagingMelee/Ranged instead of my set weapons.
const int AI_FLAG_OTHER_LAG_EQUIP_MOST_DAMAGING                 = 0x00001000;
// We never cure allies - so less GetHasEffect checks.
const int AI_FLAG_OTHER_LAG_NO_CURING_ALLIES                    = 0x00002000;
// return; on heartbeat.
const int AI_FLAG_OTHER_LAG_IGNORE_HEARTBEAT                    = 0x00004000;
// Go for the nearest seen enemy always
const int AI_FLAG_OTHER_LAG_TARGET_NEAREST_ENEMY                = 0x00008000;

// SetAI level things.
const string LAG_AI_LEVEL_NO_PC_OR_ENEMY_50M        = "LAG_AI_LEVEL_NO_PC_OR_ENEMY_50M";
const string LAG_AI_LEVEL_YES_PC_OR_ENEMY_50M       = "LAG_AI_LEVEL_YES_PC_OR_ENEMY_50M";
const string LAG_AI_LEVEL_COMBAT                    = "LAG_AI_LEVEL_COMBAT";

/******************************************************************************/
// Other settings
/******************************************************************************/

// If they are damaged a lot, they may spawn a critical wounds potion and use it.
const int AI_FLAG_OTHER_CHEAT_MORE_POTIONS                      = 0x00010000;
// This will store thier starting location, and then move back there after combat
// Will turn off if there are waypoints.
const int AI_FLAG_OTHER_RETURN_TO_SPAWN_LOCATION                = 0x00020000;
// This will affect conversations - will they clear all actions before hand?
const int AI_FLAG_OTHER_NO_CLEAR_ACTIONS_BEFORE_CONVERSATION    = 0x00040000;
// Last one! This stops all polymorphing by spells/feats
const int AI_FLAG_OTHER_NO_POLYMORPHING                         = 0x00080000;
// Ignore emotes
const int AI_FLAG_OTHER_DONT_RESPOND_TO_EMOTES                  = 0x00100000;
// Don't ever shout
const int AI_FLAG_OTHER_DONT_SHOUT                              = 0x00200000;

const string EMOTE_STAR                             = "*";
// Locals
const string AI_POLYMORPH_INTO                      = "AI_POLYMORPH_INTO";      // S.CONSTANT
const string AI_RETURN_TO_POINT                     = "AI_RETURN_TO_POINT";     // S.INTEGER

/******************************************************************************/
// The spell validnessess:
/******************************************************************************/
const string AI_VALID_SPELLS = "AI_VALID_SPELLS";
/******************************************************************************/
// Max CR used OnSpawn or other GetCreatureTalentBest places
const int MAXCR                                                     = 20;

// Doesn't set what they are, only if they exsist.
const int AI_VALID_TALENT_HARMFUL_AREAEFFECT_DISCRIMINANT           = 0x00000001;// 1 - This is the constant number added to AI_VALID_SPELLS spawn settings.
const int AI_VALID_TALENT_HARMFUL_RANGED                            = 0x00000002;// 2
const int AI_VALID_TALENT_HARMFUL_TOUCH                             = 0x00000004;
const int AI_VALID_TALENT_BENEFICIAL_HEALING_AREAEFFECT             = 0x00000008;
const int AI_VALID_TALENT_BENEFICIAL_HEALING_TOUCH                  = 0x00000010;
const int AI_VALID_TALENT_BENEFICIAL_CONDITIONAL_AREAEFFECT         = 0x00000020;
const int AI_VALID_TALENT_BENEFICIAL_CONDITIONAL_SINGLE             = 0x00000040;
const int AI_VALID_TALENT_BENEFICIAL_ENHANCEMENT_AREAEFFECT         = 0x00000080;
const int AI_VALID_TALENT_BENEFICIAL_ENHANCEMENT_SINGLE             = 0x00000100;
const int AI_VALID_TALENT_BENEFICIAL_ENHANCEMENT_SELF               = 0x00000200;
const int AI_VALID_TALENT_HARMFUL_AREAEFFECT_INDISCRIMINANT         = 0x00000400;
const int AI_VALID_TALENT_BENEFICIAL_PROTECTION_SELF                = 0x00000800;
const int AI_VALID_TALENT_BENEFICIAL_PROTECTION_SINGLE              = 0x00001000;
const int AI_VALID_TALENT_BENEFICIAL_PROTECTION_AREAEFFECT          = 0x00002000;
const int AI_VALID_TALENT_BENEFICIAL_OBTAIN_ALLIES                  = 0x00004000;
const int AI_VALID_TALENT_PERSISTENT_AREA_OF_EFFECT                 = 0x00008000;
const int AI_VALID_TALENT_BENEFICIAL_HEALING_POTION                 = 0x00010000;
const int AI_VALID_TALENT_DRAGONS_BREATH                            = 0x00040000;
const int AI_VALID_TALENT_HARMFUL_MELEE                             = 0x00200000;
// Seperate GetHasSpell checks. Restoration ETC.
const int AI_VALID_CURE_CONDITION_SPELLS                            = 0x00400000;
// OTHER spells not from the aboves
const int AI_VALID_OTHER_SPELL                                      = 0x00800000;
// Any spell from the aboves
const int AI_VALID_ANY_SPELL                                        = 0x80000000;

// Unused. This is mearly to not use talents if we don't have any!
//const string AI_TALENT_HARMFUL_MELEE                                = "AI_TALENT_HM";

/******************************************************************************/
// Other file constants (default1, 2, 4-9, a, b, e
/******************************************************************************/
// Name of the tempoary target that we have seen/been damaged by/etc.
const string AI_TEMP_SET_TARGET                     = "AI_TEMP_SET_TARGET";

const string AI_TIMER                               = "AI_TIMER_";    // Prefix for timers
const string AI_CONSTANT                            = "AI_CONSTANT_"; // Prefix for constansts
const string AI_INTEGER                             = "AI_INTEGER_";  // Prefix for integers
const string AI_OBJECT                              = "AI_OBJECT_";   // Prefix for objects

// Array constants
const string MAXINT_                            = "MAXINT_";
const string s1                                 = "1";
const string s0                                 = "0";// Used mainly for spell triggers

const string ARRAY_TEMP_ENEMIES                 = "ARRAY_TEMP_ENEMIES";
const string ARRAY_TEMP_ALLIES                  = "ARRAY_TEMP_ALLIES";
const string ARRAY_TEMP_ARRAY                   = "ARRAY_TEMP_ARRAY";

const string ARRAY_MELEE_ENEMY                  = "ARRAY_MELEE_ENEMY";
const string ARRAY_RANGED_ENEMY                 = "ARRAY_RANGED_ENEMY";
const string ARRAY_SPELL_ENEMY                  = "ARRAY_SPELL_ENEMY";

// Some generic AI file constants
const string ARRAY_ENEMY_RANGE                  = "ARRAY_ENEMY_RANGE";
const string ARRAY_ENEMY_RANGE_SEEN             = "ARRAY_ENEMY_RANGE_SEEN";
const string ARRAY_ENEMY_RANGE_HEARD            = "ARRAY_ENEMY_RANGE_HEARD";

const string ARRAY_ALLIES_RANGE                 = "ARRAY_ALLIES_RANGE";
const string ARRAY_ALLIES_RANGE_SEEN            = "ARRAY_ALLIES_RANGE_SEEN";
const string ARRAY_ALLIES_RANGE_SEEN_BUFF       = "ARRAY_ALLIES_RANGE_SEEN_BUFF";

// RE-setting weapons uses this local integer identifier.
const string AI_WEAPONSETTING_SETWEAPONS            = "AI_WEAPONSETTING_SETWEAPONS";

/******************************************************************************/
// Functions in almost all scripts which include this :-P
/******************************************************************************/

// This reports the AI toggle of oTarget.
// * If the AI is OFF, it is TRUE.
// * Returns Dead + Commandable + AI Off integers
int GetAIOff(object oTarget = OBJECT_SELF);
// Sets the AI to NOT use any scripts (or run through them) EXCEPT death!
void SetAIOff(object oTarget = OBJECT_SELF);
// Resets the AI off integer, so the AI scripts run.
void SetAIOn(object oTarget = OBJECT_SELF);

// This sets a spawn in condition.
// * nCondition - the condition to check for (From the "j_inc_constants" file)
// * sName - The name its stored under
void SetSpawnInCondition(int nCondition, string sName);
// This removes a spawn in condition.
// * nCondition - the condition to check for (From the "j_inc_constants" file)
// * sName - The name its stored under
void DeleteSpawnInCondition(int nCondition, string sName);
// Gets a spawn in condition.
// * nCondition - the condition to check for (From the "j_inc_constants" file)
// * sName - The name its stored under
// * oTarget - The target to look at (Ususally ourselves)
int GetSpawnInCondition(int nCondition, string sName, object oTarget = OBJECT_SELF);

// We can only ever set ONE special action. These are special things, such as
// fleeing (that are a mixture of special things).
// * Use the AI_SPECIAL_ACTIONS_ constants in the constant file.
void SetCurrentAction(int nAction);
// Deletes the special action stored.
// * Use the AI_SPECIAL_ACTIONS_ constants in the constant file.
void ResetCurrentAction();
// Gets the current special action stored.
// * Use the AI_SPECIAL_ACTIONS_ constants in the constant file.
int GetCurrentSetAction();

// Sets a local constant to sName, adding one to set right (so values of 0 become 1).
// * Use GetLocalConstant to return original value set.
// (To stop local's going awary, we set them with pre-fixes.)
void SetAIConstant(string sName, int iConstant);
// Returns a constant set to sName (Takes one away).
// * Therefore, returns -1 on error.
// (To stop local's going awary, we set them with pre-fixes.)
int GetAIConstant(string sName);
// Deletes a constant set to sName.
// (To stop local's going awary, we set them with pre-fixes.)
int DeleteAIConstant(string sName);

// Sets a local AI integers to ourselves.
// (To stop local's going awary, we set them with pre-fixes.)
void SetAIInteger(string sName, int iValue);
// Gets a local AI integers from ourselves.
// (To stop local's going awary, we set them with pre-fixes.)
int GetAIInteger(string sName);
// Gets a local AI integers from ourselves.
// - We can define boundries for what it returns.
// (To stop local's going awary, we set them with pre-fixes.)
// If X is < iBottom or > iTop, return iDefault.
int GetBoundriedAIInteger(string sName, int iDefault = 10, int iTop = 10, int iBottom = 1);
// Deletes a local AI integers from ourselves.
// (To stop local's going awary, we set them with pre-fixes.)
int DeleteAIInteger(string sName);

// Sets a local AI object to ourselves.
// (To stop local's going awary, we set them with pre-fixes.)
void SetAIObject(string sName, object oObject);
// Gets a local AI object from ourselves.
// (To stop local's going awary, we set them with pre-fixes.)
object GetAIObject(string sName);
// Deletes a local AI object from ourselves.
// (To stop local's going awary, we set them with pre-fixes.)
void DeleteAIObject(string sName);

// Sets up a timer.
// * sName - the variable name (Adds a pre-fix).
// * fDuration - the time until it is removed.
void SetLocalTimer(string sName, float fDuration);
// TRUE if the timer set to sName is still running.
int GetLocalTimer(string sName);

// Arrays
// Sets a local INTEGER array on ourselves.
// * sArray - the array name.
// * oObjectArray - The object we will set.
// * iValue - The value to check. It is done HIGHEST to LOWEST.
void SetArrayIntegerValue(string sArray, object oObjectArray, int iValue);
// This will move all integer values from a point back a position
// * sArray - the array name.
// * iNumberStart - The value to start at.
// * iMax - The old-highest (or highest in the order) of the array (EG the 10th of 10)
void MoveArrayIntegerBackOne(string sArray, int iNumberStart, int iMax);

// Sets a local FLOAT array on ourselves.
// * sArray - the array name.
// * oObjectArray - The object we will set.
// * fValue - The value to check. It is done LOWEST (nearest) to HIGHEST (fathest).
void SetArrayFloatValue(string sArray, object oObjectArray, float fValue);
// This will move all float values from a point back a position
// * sArray - the array name.
// * iNumberStart - The value to start at.
// * iMax - The old-highest (or highest in the order) of the array (EG the 10th of 10)
void MoveArrayFloatBackOne(string sArray, int iNumberStart, int iMax);

// Deletes all the things in an array...set to sArray
void DeleteArray(string sArray);

// Set the oTarget to ignorable.
// * The AI ignores, and shouldn't intentioally target, the creature.
void SetIgnore(object oTarget);
// Gets if the oTarget is ignorable.
// * The AI ignores, and shouldn't intentioally target, the creature.
int GetIgnore(object oTarget);
// This gets if the oTarget can be targeted as an enemy.
// * Returns if a DM, is faction Equal, is dead or the ignore variable.
int GetIgnoreNoFriend(object oTarget);

// Fires a User Defined Event.
// * iSpawnValue - The spawn value (like NW_FLAG_PERCIEVE_PRE_EVENT)
// * iNumber - The number to fire (like EVENT_PERCIEVE_PRE_EVENT)
// Returns TRUE if the event fires.
int FireUserEvent(int iSpawnValue, int iNumber);
// This sets to exit the script. Use in the defaultd (On User Defined) file.
// For example: We want to not attack PC's with the item "ROCK" (Tag). We
// therefore use the event EVENT_PERCIEVE_PRE_EVENT to exit if they have that item
// because we go friendly to them.
// * iNumber - The user defined number to exit from.
void SetToExitFromUDE(int iNumber);
// This is used for Pre-events. If we exit from EVENT_PERCIEVE_PRE_EVENT, and
// use SetToExitFromUDE, this returns TRUE (ONCE!)
// * iNumber - The user defined number to exit from.
int ExitFromUDE(int iNumber);

// We check if we are attacking anything
// * Checks Attempted* Targets, Get the AttackTarget of us.
// * Checks GetIsInCombat at the end. If that is TRUE, we should be doing proper rounds anyway.
int GetIsFighting();
// We check if we can perform a combat action currently.
// * Checks our action list. Some things like skills, opening doors and so on
//   we don't want to interrupt before they are done.
// * Also used within DetermineCombatRound
int GetIsBusyWithAction();
// This checks GetIsFighting and GetIsBusyWithAction, returns FALSE if we can
// do a combat round (IE we don't have anything to interrupt and are not already
// in combat!)
// * IE it adds GetIsBusyWithAction with GetIsFighting to give 0, 1 or 2.
// * Checks if we are fleeing too
int CannotPerformCombatRound();
// This will SpeakString a value from sName's array. i1000 uses a d1000 for % chance
void SpeakArrayString(string sName, int i1000 = FALSE);
// This is used in combat (at the end thereof) and when something shouts, and is a placeable.
// * oTarget - The target which may have shouted, or similar. Moves to and closes normally.
// If no oTarget, it still searches
void Search(object oTarget = OBJECT_INVALID);
// Used in Search(). This apply Trueseeing, See invisibility, or Invisiblity purge
// if we have neither of the 3 on us.
void SearchSpells();

// Returns our custom AI file (if any)
// - Blank string if not set
string GetCustomAIFileName();
// Sets our custom AI file
// - Needs a 16 or less character string
// - Should execute actions
// - Can sort actions against a imputted target (EG: On Percieved enemy) by
//   "GetLocalObject(OBJECT_SELF, AI_TEMP_SET_TARGET)"
void SetCustomAIFileName(string sAIFileName);

// This is still used - we just set a local object and execute script.
// Set the script to use by COMBAT_FILE constant
void DetermineCombatRound(object oTarget = OBJECT_INVALID);

// This checks the current special action (fleeing, runner, door smashing)
// - Returns FALSE if none of them are performed
// Use this to make sure that an ActionMoveTo or DCR doesn't fire if we are fleeing.
// - This does not perform any actions.
int GetIsPerformingSpecialAction();

// This will, if we are set that we can, shout the string.
void AISpeakString(string sString);

/*::///////////////////////////////////////////////
//:: Name: AI ON, or OFF.
//::///////////////////////////////////////////////
  Scripted version of AI on/off toggle.

  It stops all AI scripts from running - using "if(GetAIStatus()) return;"

  Simple, but effective!
//::////////////////////////////////////////////*/
int GetAIOff(object oTarget)
{
    if(GetIsDead(oTarget) ||
      !GetCommandable(oTarget) ||
       GetLocalInt(oTarget, AI_TOGGLE))
    {
        return TRUE;
    }
    return FALSE;
}
void SetAIOff(object oTarget)
{
    SetLocalInt(oTarget, AI_TOGGLE, TRUE);
}
void SetAIOn(object oTarget)
{
    DeleteLocalInt(oTarget, AI_TOGGLE);
}
/*::///////////////////////////////////////////////
//:: Name: GetSpawnInCondition
//::///////////////////////////////////////////////
  This returns the condition of it (True or False)
  You can specify a name (as some use AI_SKILLS_MASTER for example.)
  1.3: Changed to a simpler thing, hopefully faster (taken from SoU AI).
//::////////////////////////////////////////////*/
int GetSpawnInCondition(int nCondition, string sName, object oTarget = OBJECT_SELF)
{
    return (GetLocalInt(oTarget, sName) & nCondition);
}
void SetSpawnInCondition(int nCondition, string sName)
{
    SetLocalInt(OBJECT_SELF, sName, (GetLocalInt(OBJECT_SELF, sName) | nCondition));
}
void DeleteSpawnInCondition(int nCondition, string sName)
{
    SetLocalInt(OBJECT_SELF, sName, (GetLocalInt(OBJECT_SELF, sName) & ~nCondition));
}
/*::///////////////////////////////////////////////
//:: Name: SetCurrentAction, ResetCurrentAction, GetCurrentSetAction.
//::///////////////////////////////////////////////
  We can only ever set ONE action. These are special things, such as
  fleeing.
  Use the AI_ACTION constants in the constant file.
//::////////////////////////////////////////////*/
void SetCurrentAction(int nAction)
{
    SetLocalInt(OBJECT_SELF, AI_CURRENT_ACTION, nAction);
}
void ResetCurrentAction()
{
    DeleteLocalInt(OBJECT_SELF, AI_CURRENT_ACTION);
}
int GetCurrentSetAction()
{
    return GetLocalInt(OBJECT_SELF, AI_CURRENT_ACTION);
}
/*::///////////////////////////////////////////////
//:: Name: SetLocalTimer, GetLocalTimer
//::///////////////////////////////////////////////
  Gets/Sets a local timer.
//::////////////////////////////////////////////*/
void SetLocalTimer(string sName, float fDuration)
{
    sName = AI_TIMER + sName;
    SetLocalInt(OBJECT_SELF, sName, TRUE);
    DelayCommand(fDuration, DeleteLocalInt(OBJECT_SELF, sName));
}
int GetLocalTimer(string sName)
{
    return GetLocalInt(OBJECT_SELF, AI_TIMER + sName);
}
/*::///////////////////////////////////////////////
//:: Name: Array functions.
//::///////////////////////////////////////////////
    Set array values to local integers/floats under the values stated.
//::////////////////////////////////////////////*/
// Sets a local INTEGER array on ourselves.
// * sArray - the array name.
// * oObjectArray - The object we will set.
// * iValue - The value to check. It is done HIGHEST to LOWEST.
void SetArrayIntegerValue(string sArray, object oObjectArray, int iValue)
{
    int iValueAtPosition, iMax, i;
    // Get the current size
    iMax = GetLocalInt(OBJECT_SELF, MAXINT_ + sArray);
    string sArrayStore = sArray;
    // Special -  IE no valid array values at the start.
    if(iMax < i1)
    {
        sArrayStore += s1;
        SetLocalInt(OBJECT_SELF, sArray + s1, iValue);
        SetLocalObject(OBJECT_SELF, sArray + s1, oObjectArray);
        SetLocalInt(OBJECT_SELF, MAXINT_ + sArray, i1);  // always the first.
    }
    // Else, we will set it in the array.
    else
    {
        // Loop through the items stored already.
        for(i = i1; i <= iMax; i++)
        {
            // Get the value of the item.
            iValueAtPosition = GetLocalInt(OBJECT_SELF, sArray + IntToString(i));
            // If imput is greater than stored...move all of them back one.
            if(iValue > iValueAtPosition)
            {
                // Move all values from this point onwards back one.
                MoveArrayIntegerBackOne(sArray, i, iMax);
                // Set the local object and the local integer.
                sArrayStore += IntToString(i);
                SetLocalInt(OBJECT_SELF, sArrayStore, iValue);
                SetLocalObject(OBJECT_SELF, sArrayStore, oObjectArray);
                // Set max values we have (IE add one!)    1.3beta - changed from iMax++
                SetLocalInt(OBJECT_SELF, MAXINT_ + sArray, ++iMax);
                break;
            }
            // If at end, just add at end.
            else if(i == iMax)
            {
                // Set the local object and the local integer.
                sArrayStore += IntToString(i + i1);
                SetLocalInt(OBJECT_SELF, sArrayStore, iValue);
                SetLocalObject(OBJECT_SELF, sArrayStore, oObjectArray);
                // Set max values we have (IE add one!)
                SetLocalInt(OBJECT_SELF, MAXINT_ + sArray, ++iMax);
                break;
            }
        }
    }
}
// This will move all integer values from a point back a position
// * sArray - the array name.
// * iNumberStart - The value to start at.
// * iMax - The old-highest (or highest in the order) of the array (EG the 10th of 10)
void MoveArrayIntegerBackOne(string sArray, int iNumberStart, int iMax)
{
    // Objects, the old name for that value and the new one.
    object oObjectAtNumber;
    string sCurrentName, sNewName;
    int iArrayAtNumberValue, i;
    // Move it from the back, back one, then then next...
    // Start at value 5 (Max) and move it to 6, then move to 4, move it
    // to 5 and so on down to iNumber Start, say, 3, so we get to 3, move it to 4,
    // and space 3 is free.
    for(i = iMax; i >= iNumberStart; i--)
    {
        // Sets the name up right.
        sCurrentName = sArray + IntToString(i);  // The current name to get values.
        sNewName = sArray + IntToString(i + i1); // Move back = Add one
        //  Set the things up in the right parts.
        oObjectAtNumber = GetLocalObject(OBJECT_SELF, sCurrentName);
        iArrayAtNumberValue = GetLocalInt(OBJECT_SELF, sCurrentName);
        // To the NEW name - we add one to the i value.
        SetLocalObject(OBJECT_SELF, sNewName, oObjectAtNumber);
        SetLocalInt(OBJECT_SELF, sNewName, iArrayAtNumberValue);
    }
}
// Sets a local FLOAT array on ourselves.
// * sArray - the array name.
// * oObjectArray - The object we will set.
// * fValue - The value to check. It is done LOWEST (nearest) to HIGHEST (fathest).
void SetArrayFloatValue(string sArray, object oObjectArray, float fValue)
{
    int iMax, i;
    iMax = GetLocalInt(OBJECT_SELF, MAXINT_ + sArray);
    string sArrayStore = sArray;
    float fValueAtPosition;
    // Special -  IE no valid array values at the start.
    if(iMax <= FALSE)
    {
        sArrayStore = sArray + s1;
        SetLocalFloat(OBJECT_SELF, sArrayStore, fValue);
        SetLocalObject(OBJECT_SELF, sArrayStore, oObjectArray);
        SetLocalInt(OBJECT_SELF, MAXINT_ + sArray, i1);  // always the first.
    }
    // Else, we will set it in the array.
    else
    {
        // Loop through the items stored already.
        for(i = i1; i <= iMax; i++)
        {
            // Get the value of the item.
            fValueAtPosition = GetLocalFloat(OBJECT_SELF, sArray + IntToString(i));
            // If imput is LESS (nearer) than stored...move all of them back one.
            if(fValue < fValueAtPosition)
            {
                // Move all values from this point onwards back one.
                MoveArrayFloatBackOne(sArray, i, iMax);
                // Set the local object and the local integer.
                sArrayStore = sArray + IntToString(i);
                SetLocalFloat(OBJECT_SELF, sArrayStore, fValue);
                SetLocalObject(OBJECT_SELF, sArrayStore, oObjectArray);
                // Set max values we have (IE add one!)  1.3 beta - it was iMax++
                SetLocalInt(OBJECT_SELF, MAXINT_ + sArray, ++iMax);
                break;
            }
            // Else, if it is the end value (iMax) we set it at the end
            else if(i == iMax)
            {
                // Set the local object and the local integer.
                sArrayStore = sArray + IntToString(i + i1);
                SetLocalFloat(OBJECT_SELF, sArrayStore, fValue);
                SetLocalObject(OBJECT_SELF, sArrayStore, oObjectArray);
                // Set max values we have (IE add one!)
                SetLocalInt(OBJECT_SELF, MAXINT_ + sArray, ++iMax);
                break;
            }
        }
    }
}
// This will move all float values from a point back a position
// * sArray - the array name.
// * iNumberStart - The value to start at.
// * iMax - The old-highest (or highest in the order) of the array (EG the 10th of 10)
void MoveArrayFloatBackOne(string sArray, int iNumberStart, int iMax)
{
    // Objects, the old name for that value and the new one.
    object oObjectAtNumber;
    string sCurrentName, sNewName;
    int i;
    float fArrayAtNumberValue;
    // Move it from the back, back one, then then next...
    for(i = iMax; i >= iNumberStart; i--)
    {
        // Sets the name up right.
        sCurrentName = sArray + IntToString(i);  // The current name to get values.
        sNewName = sArray + IntToString(i + i1); // Move back = Add one
        //  Set the things up in the right parts.
        oObjectAtNumber = GetLocalObject(OBJECT_SELF, sCurrentName);
        fArrayAtNumberValue = GetLocalFloat(OBJECT_SELF, sCurrentName);
        // To the NEW name - we add one to the i value.
        SetLocalObject(OBJECT_SELF, sNewName, oObjectAtNumber);
        SetLocalFloat(OBJECT_SELF, sNewName, fArrayAtNumberValue);
    }
}
// Deletes all the things in an array...set to sArray
void DeleteArray(string sArray)
{
    int i, iMax;
    string sNewName;
    // Max values, if any
    iMax = GetLocalInt(OBJECT_SELF, MAXINT_ + sArray);
    if(iMax)
    {
        for(i = i1; i <= iMax; i++)
        {
            sNewName = sArray + IntToString(i);
            DeleteLocalObject(OBJECT_SELF, sNewName);// Object
            DeleteLocalInt(OBJECT_SELF, sNewName);// Value
            DeleteLocalFloat(OBJECT_SELF, sNewName);// Value
        }
    }
    // Here, we do delete the max
    DeleteLocalInt(OBJECT_SELF, MAXINT_ + sArray);
}


/*::///////////////////////////////////////////////
//:: Name: SetLocalTimer, GetLocalTimer
//::///////////////////////////////////////////////
    Set/Get the oTarget to ignorable.
    * The AI ignores, and shouldn't intentioally target, the creature.
//::////////////////////////////////////////////*/
void SetIgnore(object oTarget)
{
    SetLocalInt(oTarget, AI_IGNORE_TOGGLE, TRUE);
}
int GetIgnore(object oTarget)
{
    return GetLocalInt(oTarget, AI_IGNORE_TOGGLE);
}
int GetIgnoreNoFriend(object oTarget)
{
    if(GetLocalInt(oTarget, AI_IGNORE_TOGGLE) || GetFactionEqual(oTarget) ||
       GetIsDM(oTarget) || GetIsDead(oTarget))
    {
        return TRUE;
    }
    return FALSE;
}
/*::///////////////////////////////////////////////
//:: Name: SetLocalConstant, GetLocalConstant
//::///////////////////////////////////////////////
  Sets a constant (from nwscript.nss)
//::////////////////////////////////////////////*/
void SetAIConstant(string sName, int iConstant)
{
    SetLocalInt(OBJECT_SELF, AI_CONSTANT + sName, iConstant + i1);
}
int GetAIConstant(string sName)
{
    return GetLocalInt(OBJECT_SELF, AI_CONSTANT + sName) - i1;
}
void DeleteAIConstant(string sName)
{
    DeleteLocalInt(OBJECT_SELF, AI_CONSTANT + sName);
}
/*::///////////////////////////////////////////////
//:: Name: SetAIInteger, GetAIInteger
//::///////////////////////////////////////////////
    To stop local's going awary, we set them with pre-fixes.
//::////////////////////////////////////////////*/
void SetAIInteger(string sName, int iValue)
{
    SetLocalInt(OBJECT_SELF, AI_INTEGER + sName, iValue);
}
int GetAIInteger(string sName)
{
    return GetLocalInt(OBJECT_SELF, AI_INTEGER + sName);
}
int GetBoundriedAIInteger(string sName, int iDefault, int iTop, int iBottom)
{
    int iReturn = GetAIInteger(sName);
    // Boundries
    if(iReturn < iBottom || iReturn > iTop)
    {
        iReturn = iDefault;
    }
    return iReturn;
}
void DeleteAIInteger(string sName)
{
    DeleteLocalInt(OBJECT_SELF, AI_INTEGER + sName);
}
/*::///////////////////////////////////////////////
//:: Name: SetAIObject, GetAIObject
//::///////////////////////////////////////////////
    To stop local's going awary, we set them with pre-fixes.
//::////////////////////////////////////////////*/
void SetAIObject(string sName, object oObject)
{
    SetLocalObject(OBJECT_SELF, AI_OBJECT + sName, oObject);
}
object GetAIObject(string sName)
{
    return GetLocalObject(OBJECT_SELF, AI_OBJECT + sName);
}
void DeleteAIObject(string sName)
{
    DeleteLocalObject(OBJECT_SELF, AI_OBJECT + sName);
}

/*::///////////////////////////////////////////////
//:: Name: FireUserEvent
//::///////////////////////////////////////////////
// Fires a User Defined Event.
// * iSpawnValue - The spawn value (like NW_FLAG_PERCIEVE_PRE_EVENT)
// * iNumber - The number to fire (like EVENT_PERCIEVE_PRE_EVENT)
// Returns TRUE if the event fires.
//::////////////////////////////////////////////*/
int FireUserEvent(int iSpawnValue, int iNumber)
{
    // Check spawn in condition
    if(GetSpawnInCondition(iSpawnValue, AI_UDE_MASTER))
    {
        // Signal event (and return TRUE)
        SignalEvent(OBJECT_SELF, EventUserDefined(iNumber));
        return TRUE;
    }
    return FALSE;
}
/*::///////////////////////////////////////////////
//:: Name: SetToExitFromUDE
//::///////////////////////////////////////////////
// This sets to exit the script. Use in the defaultd (On User Defined) file.
// For example: We want to not attack PC's with the item "ROCK" (Tag). We
// therefore use the event EVENT_PERCIEVE_PRE_EVENT to exit if they have that item
// because we go friendly to them.
// * iNumber - The user defined number to exit from.
//::////////////////////////////////////////////*/
void SetToExitFromUDE(int iNumber)
{
    SetLocalInt(OBJECT_SELF, EXIT_UDE_PREFIX_ + IntToString(iNumber), TRUE);
}
/*::///////////////////////////////////////////////
//:: Name: ExitFromUDE
//::///////////////////////////////////////////////
// This is used for Pre-events. If we exit from EVENT_PERCIEVE_PRE_EVENT, and
// use SetToExitFromUDE, this returns TRUE (ONCE!)
// * iNumber - The user defined number to exit from.
//::////////////////////////////////////////////*/
int ExitFromUDE(int iNumber)
{
    // Set up string to delete/check
    string sCheck = EXIT_UDE_PREFIX_ + IntToString(iNumber);
    // Check local value
    if(GetLocalInt(OBJECT_SELF, sCheck))
    {
        // Delete if valid (not equal to one) and return TRUE to exit
        DeleteLocalInt(OBJECT_SELF, sCheck);
        return TRUE;
    }
    return FALSE;
}

/*::///////////////////////////////////////////////
//:: Name: GetIsFighting, GetIsBusyWithAction, CanPerformCombatRound
//::///////////////////////////////////////////////
// Busy things - are we doing an action we don't want to override with ClearAllActions?
// Checks them here.
//::////////////////////////////////////////////*/

// We check if we are attacking anything
// * Checks Attempted* Targets, Get the AttackTarget of us.
// * Checks GetIsInCombat at the end. If that is TRUE, we should be doing proper rounds anyway.
int GetIsFighting()
{
    // Do we already have a target?
    if(GetIsObjectValid(GetAttackTarget()) ||
       GetIsObjectValid(GetAttemptedAttackTarget()) ||
       GetIsObjectValid(GetAttemptedSpellTarget()))
    {
        return TRUE;
    }
    // Final check. Are we in combat?
    return GetIsInCombat();
}
// We check if we can perform a combat action currently.
// * Checks our action list. Some things like skills, opening doors and so on
//   we don't want to interrupt before they are done.
// * Also used within DetermineCombatRound
int GetIsBusyWithAction()
{
    // Set up actions.
    int iAction = GetCurrentAction();
    // Common dropout ones to speed it up.
    if(iAction == ACTION_INVALID ||
       iAction == ACTION_WAIT ||
       iAction == ACTION_FOLLOW ||
       iAction == ACTION_MOVETOPOINT ||
       iAction == ACTION_DIALOGOBJECT ||
       iAction == ACTION_REST ||
       iAction == ACTION_USEOBJECT ||
       iAction == ACTION_COUNTERSPELL ||
       iAction == ACTION_DISABLETRAP ||
       iAction == ACTION_EXAMINETRAP ||
       iAction == ACTION_FLAGTRAP ||
       iAction == ACTION_RECOVERTRAP)
    {
        return FALSE;
    }
    else
    if(iAction == ACTION_ATTACKOBJECT)// Very common. Could be a door as well as a creature!
    {
        // This is a special thing...if we are attacking a non-creature, we
        // return FALSE anyway, to attack the creature.

        // Therefore, if we are attacking a creature though, we return TRUE as
        // we do not want to change objects. :-P
        int iAttackObjectType = GetObjectType(GetAttackTarget());
        // Note: as this returns -1 on error, its easier to just use an if/else
        //       checking the integers, with a -1 dropout.
        if(iAttackObjectType != -1)
        {
            // We never stop attacking one creature
            if(iAttackObjectType == OBJECT_TYPE_CREATURE)
            {
                return TRUE;
            }
            // we may stop attacking a door if we are not fleeing though
            // But if we are attacking a door and fleeing, don't react.
            else if(iAttackObjectType == OBJECT_TYPE_DOOR &&
                   !GetIsObjectValid(GetAIObject(AI_FLEE_TO)))
            {
                return TRUE;
            }
        }
    }
    // We are opening a door... (or unlocking one)
    else
    if(iAction == ACTION_OPENDOOR || // Opening a door!
       iAction == ACTION_OPENLOCK)   // The AI only unlocks doors
    {
        // It may be that we want to always unlock doors and open them as we
        // are fleeing.
        if(!GetIsObjectValid(GetAIObject(AI_FLEE_TO)))
        {
            return TRUE;
        }
    }
    // If we are using a cirtain skill or similar, don't try and attack.
    else
    if(iAction == ACTION_ANIMALEMPATHY || // An "attack" skill we use
       iAction == ACTION_CASTSPELL ||     // Casting a spell shouldn't be interrupted.
       iAction == ACTION_HEAL ||          // Heal skill. A very important way to heal and not to override
       iAction == ACTION_ITEMCASTSPELL || // Scrolls, potions ETC.
       iAction == ACTION_LOCK ||          // Won't be used. Added for completeness.
       iAction == ACTION_PICKPOCKET ||    // Sometimes used in combat. Nifty!
       iAction == ACTION_PICKUPITEM ||    // We may be picking up lost weapons (disarmed ones)
       iAction == ACTION_SETTRAP ||       // Can't seem to work it :-/ Well, here for completeness
       iAction == ACTION_TAUNT)           // Taunt shouldn't be interrupted.
    {
        return TRUE;
    }
    return FALSE;
}
// This checks GetIsFighting and GetIsBusyWithAction, returns FALSE if we can
// do a combat round (IE we don't have anything to interrupt and are not already
// in combat!)
// * IE it adds GetIsBusyWithAction with GetIsFighting to give 0, 1 or 2.
// * Checks if we are fleeing too
int CannotPerformCombatRound()
{
    return GetIsPerformingSpecialAction() + GetIsBusyWithAction() + GetIsFighting();
}

// This will SpeakString a value from sName's array. i1000 uses a d1000 for % chance
void SpeakArrayString(string sName, int i1000 = FALSE)
{
    // Need a valid array (arrays of 1 are just that - 1 value to choose from.)
    int iSize = GetLocalInt(OBJECT_SELF, ARRAY_SIZE + sName);
    if(iSize > i0)
    {
        // Make sure we are not dead (unless we should be)
        if(sName != AI_TALK_ON_DEATH)
        {
            if(GetIsDead(OBJECT_SELF)) return;
        }
        // Do we carry on?
        int iCarryOn = FALSE;
        if(i1000 == TRUE)
        {
            // Do the % check now. Values 1-1000 randomised.
            if((Random(1000) + i1) <= GetLocalInt(OBJECT_SELF, ARRAY_PERCENT + sName)) iCarryOn = TRUE;
        }
        else
        {
            // 100 normal one.
            if(d100() <= GetLocalInt(OBJECT_SELF, ARRAY_PERCENT + sName)) iCarryOn = TRUE;
        }
        if(iCarryOn)
        {
            int iRandomOne = i1;
            if(iSize > i1)
            {
                // Randomise - we add one, so instead of 0-2 (for 3 values) it goes 1-3.
                iRandomOne = Random(iSize) + i1;
            }
            // Now, to choose one...
            string sSpeak = GetLocalString(OBJECT_SELF, sName + IntToString(iRandomOne));
            // And speak!
            // - Added random delay for 0.1 to 1.2 seconds to add some variety,
            //   if it is used for n1000
            if(sSpeak != "")
            {
                // Code sorta taken from NW_I0_Spells, the random stuff.
                // FloatToInt(15);/FloatToInt(fRandom * 10.0);
                if(i1000 == TRUE)
                {
                    float fDelay = IntToFloat(Random(15) + 1) / 10.0;
                    DelayCommand(fDelay, SpeakString(sSpeak));
                }
                else
                {
                    // Speak instantly.
                    SpeakString(sSpeak);
                }
            }
        }
    }
}
// Used in Search(). This apply Trueseeing, See invisibility, or Invisiblity purge
// if we have neither of the 3 on us.
void SearchSpells()
{
    effect eCheck = GetFirstEffect(OBJECT_SELF);
    int iEffectType, iBreak;
    while(GetIsEffectValid(eCheck) && iBreak == FALSE)
    {
        iEffectType = GetEffectType(eCheck);
        if(iEffectType == EFFECT_TYPE_TRUESEEING ||
           iEffectType == EFFECT_TYPE_SEEINVISIBLE)
        {
            iBreak = TRUE;
        }
        eCheck = GetNextEffect(OBJECT_SELF);
    }
    // We have effects, stop.
    if(iBreak == TRUE && !GetHasSpellEffect(SPELL_INVISIBILITY_PURGE))
    {
        return;
    }
    // Else we apply the best spell we have.
    if(GetHasSpell(SPELL_TRUE_SEEING))
    {
        ActionCastSpellAtObject(SPELL_TRUE_SEEING, OBJECT_SELF);
        return;
    }
    if(GetHasSpell(SPELL_SEE_INVISIBILITY))
    {
        ActionCastSpellAtObject(SPELL_SEE_INVISIBILITY, OBJECT_SELF);
        return;
    }
    if(GetHasSpell(SPELL_INVISIBILITY_PURGE))
    {
        ActionCastSpellAtObject(SPELL_INVISIBILITY_PURGE, OBJECT_SELF);
        return;
    }
}
// This is used in combat (at the end thereof) and when something shouts, and is a placeable.
// * oTarget - The target which may have shouted, or similar. Moves to and closes normally.
// If no oTarget, it still searches
void Search(object oTarget = OBJECT_INVALID)
{
    if(GetIsObjectValid(GetAttemptedSpellTarget()) ||
       GetIsObjectValid(GetAttemptedAttackTarget()) ||
       GetIsObjectValid(GetAttackTarget()) ||
       GetLocalTimer(AI_TIMER_SEARCH))
    {
        return;
    }
    else
    {
        // Stop now
        ClearAllActions();
        // Rest after combat?
        if(GetSpawnInCondition(AI_FLAG_OTHER_REST_AFTER_COMBAT, AI_OTHER_MASTER))
        {
            // 71: "[Search] Resting"
            DebugActionSpeakByInt(71);
            ForceRest(OBJECT_SELF);
            ActionWait(f1);
        }
        // Determine the amount of time to search if there is antone else around.
        int iIntelligence = GetBoundriedAIInteger(AI_INTELLIGENCE, i10, i10, i1);
        float fTime = IntToFloat(iIntelligence * i3);
        // Set local timer for a minimum of 4 seconds
        SetLocalTimer(AI_TIMER_SEARCH, f4);
        // Check some spells. Cast one if we have no true seeing ETC.
        SearchSpells();
        // Stealth/search.
        int iStealth = GetStealthMode(OBJECT_SELF);
        int iSearch = GetDetectMode(OBJECT_SELF);
        // We perfere to hide again if we search if set to...sneaky!
        if(GetSpawnInCondition(AI_FLAG_OTHER_COMBAT_FORCE_HIDING, AI_OTHER_COMBAT_MASTER))
        {
            if(iStealth != STEALTH_MODE_ACTIVATED)
            {
                SetActionMode(OBJECT_SELF, ACTION_MODE_STEALTH, TRUE);
            }
        }
        else
        {
            // If we are hiding, stop to search (we shouldn't be - who knows?)
            if(iStealth == STEALTH_MODE_ACTIVATED)
            {
                SetActionMode(OBJECT_SELF, ACTION_MODE_STEALTH, FALSE);
            }
            // And search!
            if(iSearch != DETECT_MODE_ACTIVE && !GetHasFeat(FEAT_KEEN_SENSE))
            {
                SetActionMode(OBJECT_SELF, ACTION_MODE_DETECT, TRUE);
            }
        }
        // We check around the target, if there is one.
        if(GetIsObjectValid(oTarget))
        {
            ActionMoveToLocation(GetLocation(oTarget));
            // If it is a chest ETC. We close it.
            if(GetIsOpen(oTarget))
            {
                if(GetObjectType(oTarget) == OBJECT_TYPE_DOOR)
                {
                    ActionCloseDoor(oTarget);
                }
                else
                {
                    // Close it
                    ActionDoCommand(DoPlaceableObjectAction(oTarget, PLACEABLE_ACTION_USE));
                }
            }
        }
        // We will get nearest enemy at the very least
        else
        {
            // Use nearest heard
            object oEnemy = GetNearestCreature(CREATURE_TYPE_REPUTATION, REPUTATION_TYPE_ENEMY,
                               OBJECT_SELF, i1, CREATURE_TYPE_PERCEPTION, PERCEPTION_HEARD);
            if(GetIsObjectValid(oEnemy))
            {
                // Move to location
                ActionMoveToLocation(GetLocation(oEnemy));
            }
        }
        // Note: Here, we will return to spawn location after moving to the
        // object, if it is a valid setting, else we do the normal randomwalk
        if(GetSpawnInCondition(AI_FLAG_OTHER_RETURN_TO_SPAWN_LOCATION, AI_OTHER_MASTER))
        {
            ActionMoveToLocation(GetLocalLocation(OBJECT_SELF, AI_RETURN_TO_POINT));
        }
        else
        {
            // 72: "[Search] Searching, No one to attack. [Time] " + FloatToString(fTime, i3, i2)
            DebugActionSpeakByInt(72, OBJECT_INVALID, FALSE, FloatToString(fTime, i3, i2));
            // Randomly walk.
            ActionRandomWalk();
            // Clear all actions stops Random Walk
            DelayCommand((fTime - f1), ClearAllActions());
            // Delay a 30 second walk waypoints (which stops ActionRandomWalk).
            DelayCommand(fTime, ExecuteScript(FILE_WALK_WAYPOINTS, OBJECT_SELF));
        }
    }
}

// Returns our custom AI file (if any)
// - Blank string if not set
string GetCustomAIFileName()
{
    return GetLocalString(OBJECT_SELF, AI_CUSTOM_AI_SCRIPT);
}
// Sets our custom AI file
// - Needs a 16 or less character string
// - Should execute actions
// - Can sort actions against a imputted target (EG: On Percieved enemy) by
//   "GetLocalObject(OBJECT_SELF, AI_TEMP_SET_TARGET)"
void SetCustomAIFileName(string sAIFileName)
{
    SetLocalString(OBJECT_SELF, AI_CUSTOM_AI_SCRIPT, sAIFileName);
}

/*::///////////////////////////////////////////////
//:: Name: DetermineCombatRound
//::///////////////////////////////////////////////
    This is still used - we just set a local object and execute script.
    Argument - iCustom = Custom Files, so we determine not with default3
//:://///////////////////////////////////////////*/
void DetermineCombatRound(object oTarget = OBJECT_INVALID)
{
    // Check for custom AI script, else fire default.
    string sAI = GetCustomAIFileName();
    // Fire default AI script
    if(sAI == "")
    {
        // Sanity check - to not fire this off multiple times, we make sure temp
        //      object is not the same as oTarget (and valid)
        if(!GetIsObjectValid(oTarget) || (GetIsObjectValid(oTarget) &&
           !GetLocalTimer(AI_DEFAULT_AI_COOLDOWN)))
        {
            // 73: "[Call for DCR] Default AI [Pre-Set Target]" + GetName(oTarget)
            DebugActionSpeakByInt(73, oTarget);
            SetLocalObject(OBJECT_SELF, AI_TEMP_SET_TARGET, oTarget);
            ExecuteScript(COMBAT_FILE, OBJECT_SELF);
            SetLocalTimer(AI_DEFAULT_AI_COOLDOWN, 0.1);
        }
    }
    // Fire custom AI script
    else
    {
        SetLocalObject(OBJECT_SELF, AI_TEMP_SET_TARGET, oTarget);
        // 74: "[Call for DCR] Custom AI [" + sAI + "] [Pre-Set Target]" + GetName(oTarget)
        DebugActionSpeakByInt(74, oTarget, FALSE, sAI);
        // Execute it
        ExecuteScript(sAI, OBJECT_SELF);
    }
}


// This checks the current special action (fleeing, runner, door smashing)
// - Returns FALSE if none of them are performed
// Use this to make sure that an ActionMoveTo or DCR doesn't fire if we are fleeing.
int GetIsPerformingSpecialAction()
{
    int iAction = GetCurrentSetAction();
    object oTarget = GetAttackTarget();
    object oRunTarget;
    switch(iAction)
    {
        case AI_SPECIAL_ACTIONS_ME_RUNNER:
        {
            oRunTarget = GetAIObject(AI_RUNNER_TARGET);
            if(GetIsObjectValid(oRunTarget))
            {
                if(GetObjectSeen(oRunTarget))
                {
                    // Stop thinking we are a runner if we can see the run target
                    ResetCurrentAction();
                }
                else
                {
                    // Else we are running to the
                    return TRUE;
                }
            }
        }
        break;
        case AI_SPECIAL_ACTIONS_FLEE:
        {
            oRunTarget = GetAIObject(AI_FLEE_TO);
            if(GetIsObjectValid(oRunTarget))
            {
                if(GetObjectSeen(oRunTarget))
                {
                    // If we see the flee target, reset targets
                    ResetCurrentAction();
                }
                else
                {
                    // Else flee!
                    return TRUE;
                }
            }
            else
            {
                // Check if we have bad intellgence, and we will run away
                // from the nearest enemy if heard.
                if(GetAIInteger(AI_INTELLIGENCE) <= i3)
                {
                    oRunTarget = GetNearestCreature(CREATURE_TYPE_REPUTATION, REPUTATION_TYPE_ENEMY, OBJECT_SELF, i1, CREATURE_TYPE_PERCEPTION, PERCEPTION_SEEN, CREATURE_TYPE_IS_ALIVE, TRUE);
                    if(!GetIsObjectValid(oRunTarget))
                    {
                        oRunTarget = GetNearestCreature(CREATURE_TYPE_REPUTATION, REPUTATION_TYPE_ENEMY, OBJECT_SELF, i1, CREATURE_TYPE_PERCEPTION, PERCEPTION_HEARD, CREATURE_TYPE_IS_ALIVE, TRUE);
                        if(!GetIsObjectValid(oRunTarget))
                        {
                            oRunTarget = GetLastHostileActor();
                            if(!GetIsObjectValid(oRunTarget) || GetIsDead(oRunTarget))
                            {
                                ResetCurrentAction();
                                return FALSE;
                            }
                        }
                    }
                    // Running from enemy
                    return TRUE;
                }
                ResetCurrentAction();
            }
        }
        break;
        case AI_SPECIAL_ACTIONS_MOVE_OUT_OF_AOE:
        {
            // We must be X distance away from a cirtain AOE, if we are not, we
            // move.
            oRunTarget = GetAIObject(AI_AOE_FLEE_FROM);

            // If not valid, or already far enough away, delete special action
            // and return false.
            if(!GetIsObjectValid(oRunTarget) ||
                GetLocalFloat(OBJECT_SELF, AI_AOE_FLEE_FROM_RANGE) < GetDistanceToObject(oRunTarget))
            {
                ResetCurrentAction();
            }
            else
            {
                // Valid and still in range
                return TRUE;
            }
        }
        break;
    }
    // Return false to carry on a normal DCR or move to enemy.
    return FALSE;
}

// This will, if we are set that we can, shout the string.
void AISpeakString(string sString)
{
    // Spawn condition to turn it off.
    if(!GetSpawnInCondition(AI_FLAG_OTHER_DONT_SHOUT, AI_OTHER_MASTER))
    {
        // Silent talk = "DebugMode 1" only can see, is the "talk" version of the DM
        // channel.
        SpeakString(sString, TALKVOLUME_SILENT_TALK);
    }
}
// Debug: To compile this script full, uncomment all of the below.
/* - Add two "/"'s at the start of this line
void main()
{
    return;
}
//*/
