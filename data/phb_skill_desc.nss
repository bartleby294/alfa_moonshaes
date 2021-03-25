#include "ms_xp_util"

/*
Descriptive Skill Triggers 1.00
Descriptions/Flavor Text, Skill Checks, Ability Checks
by OldManWhistler

Check out my other scripts at:
http://nwvault.ign.com/portfolios/data/1054937958.shtml

If you are interested in this, I highly recommend the following:
- PHB Movement Skills (adds Balance, Climb, Jump, Swim, TightSpace/EscapeArtist to the game)
- NWN Skill DC Compilation for DMs and Builders (PDF Reference)
- PDF Reference of all the creature/item/placeable/sound ResRefs (in progress)
FEATURES
- Two installs, minimal install is one script and one trigger (all you need).
- Generic script that uses tags on the trigger for configuration.
- Can roll any skill check, any ability check, or a description.
- Implements tracking feat (as a Search skill check where only rangers can succeed against DCs greater than 10 and passive detect mode gives a -5 penalty)
- No heartbeat, only CPU cycles used are when the triggers are activated by players.
- Rolls checks without "Take 20" and checks are rolled blind so player does not know the DC. (If you fail a check, you do not even know that a check occurred)
- Supports critical failure on 1 and critical success on 20. (configurable)
- Uses colored text for the skill names. (optional)
- Waits until players are out of combat before it displays the text (so that text isn't lost in the combat messages)
- 64 possible configuration option combinations of: showing to player/party, check until success, check  until failure, destroy trigger on success, destroy trigger on failure, send results to DM channel on success.
- Can give XP on success.
- Can create an object (creature, item, placeable) on success and control the orientation of the object.
- Can play a sound on success (only if not creating an object)
- Triggers are visible in the toolset and the DM client.
- Triggers can be removed from within the DM client by using the Chooser menu and killing them.
- DM notification can be turned on/off per trigger instance or globally turned on/off.
- Triggers can be set up to work persistently for PWs.
- Library skill functions can be used to replace existing skill systems in other scripts you may be using.
- Includes several prefab triggers to ease the learning curve.

INSTALLATION

// Required
// #1: Import the tsd_basic_X_XX.erf  into your module. It contains a script called trig_skill_desc and a
// generic trigger.

// #2: There is a placeable in Miscellaneous called the Color Tag Generator that must be placed somewhere
// in your module for colored text to work.

// Now you can place down instances of the generic trigger in your module and change the name and tag to
// configure that instance. Documentation is included further down and in the trigger's comments field.

// Optional
// #3: Import the tsd_extra_X_XX.erf  into your module. It has several "pre-configured" triggers under
// Custom1.

// Optional
// #4: Import the tsd_lib_X_XX.erf  into your module. It contains the inc_skill_desc library script so the
// base skill functions can be used from within any script.

CONFIGURABLE OPTIONS

These options are found in either the inc_skill_desc or trig_skill_desc scripts.

// Should DM notification be forced?
// 0 - always force DM notification off regardless of trigger tag.
// 1 - always force DM notification on regardless of trigger tag.
// 2 - use the DM notication setting in the trigger tag.
const int DST_DM_NOTIFY_FORCE = 2;

// Set this to FALSE to disable critical success on 20s and critical failure on 1s.
const int DST_ALLOW_CRITICAL = TRUE;

// Set this to a value other than 0.0 so that triggers aren't really destroyed, instead they are just prevented from being used for a period of time.
const float DST_FAKE_DESTROY_TIMER = 0.0;

// For debugging purposes only. Useful for module development.
const int DST_DEBUG = FALSE;

If you want the trigger state for a specific player to be persistent over module restarts, then you should modify the DSTSetPersistent and DSTGetPersistent functions to tie into your persistent database system. How to do so is beyond the scope of this script.
CREDITS
- The method of doing color text using a placeable tag was taken from a post by Richterm on the bioboards.
- The original idea for this came from playing Adam Miller's Shadowlords and seeing the flavor text room descriptions. I thought that having that information be available only on specific skill checks would be really cool.
- A lot of the ideas for the features of this script were taken from Mishenka's Placeable skill
  check markers http://nwvault.ign.com/Files/scripts/data/1050871157361.shtml
  It is a very good package, I just didn't like the following limitations:
    - uses a heartbeat that looks for the nearest PC every 6 seconds.
      (although Mish coded it very efficiently)
    - static invisible placeables are hard to see in the toolset (easily) and can't
      be seen in the DM client at all (although they can be placed live, unlike triggers).
    - hard to remove static placeables with the DM client (need a scripted tool).
    - only supported a limited number of skills.
    - can only create placeables.
    - no DM notification.
  That being said, it's still a great package and definitely try it out and then decide what you would like to use.
- Little known fact: this package was my first attempt at writing NWSCRIPT way back in 2003/02.
Glad I never released the original version. :)

KNOWN ISSUES
- Triggers seem to cause huge amounts of graphics lag when you put down a whole bunch close together. Use one per tile, and draw them so that they remain two-dimensional.
- Triggers can not be placed down live in the DM client because they are set up as traps. (Bioware bug)
- Objects are always created at the STARTING POINT of the trigger. Draw your trigger so that the starting point is where you want the object created. You can use the handy "redraw trigger polygon" feature in the toolset (right click on the trigger).
- It is does not seem possible to create the following object types with CreateObject:
    - OBJECT_TYPE_DOOR
    - OBJECT_TYPE_ENCOUNTER
    - OBJECT_TYPE_TRIGGER
    - OBJECT_TYPE_WAYPOINT (Created, but does not show on map)
- The CreateObject function seems to only work well with creatures, items, and placeables.

*/

// ****************************************************************************
// ** CONFIGURATION - MODIFY THIS SECTION
// ****************************************************************************

// Set this to FALSE to disable critical success on 20s and critical failure on 1s.
const int DST_ALLOW_CRITICAL = FALSE;

// Should DM notification be forced?
// 0 - always force DM notification off regardless of trigger tag.
// 1 - always force DM notification on regardless of trigger tag.
// 2 - use the DM notication setting in the trigger tag.
const int DST_DM_NOTIFY_FORCE = 2;

// Should triggers be permanent?
// Set this to a value other than 0.0 so that triggers aren't really destroyed,
// instead they are just prevented from being used for a period of time.
const float DST_FAKE_DESTROY_TIMER = 0.0;

// For debugging purposes only. Useful for module development.
const int DST_DEBUG = FALSE;

// ****************************************************************************
// ** CONSTANTS
// ****************************************************************************

// Constants for setting the configuration of the trigger.
const int DST_SET_PARTY = 0x01; // 0 display to PC on success, 1 display to party on success.
const int DST_SET_STATE_SUCCESS = 0x02; // 0 do nothing, 1 store persistent state on success.
const int DST_SET_STATE_FAILURE = 0x04; // 0 do nothing, 1 store persistent state on failure.
const int DST_SET_DESTROY_SUCCESS = 0x08; // 0 do nothing, 1 destroy on success. Also see DST_FAKE_DESTROY_TIMER.
const int DST_SET_DESTROY_FAILURE = 0x10; // 0 do nothing, 1 destroy on failure. Also see DST_FAKE_DESTROY_TIMER.
const int DST_SET_DM_NOTIFY = 0x20; // 0 do nothing, 1 copy text on DM channel. Overridden by DM_NOTIFY_FORCE

// Constants for the different kinds of checks.
const int DST_SKILL_ANIMAL_EMPATHY   = 0;
const int DST_SKILL_CONCENTRATION    = 1;
const int DST_SKILL_DISABLE_TRAP     = 2;
const int DST_SKILL_DISCIPLINE       = 3;
const int DST_SKILL_HEAL             = 4;
const int DST_SKILL_HIDE             = 5;
const int DST_SKILL_LISTEN           = 6;
const int DST_SKILL_LORE             = 7;
const int DST_SKILL_MOVE_SILENTLY    = 8;
const int DST_SKILL_OPEN_LOCK        = 9;
const int DST_SKILL_PARRY            = 10;
const int DST_SKILL_PERFORM          = 11;
const int DST_SKILL_PERSUADE         = 12;
const int DST_SKILL_PICK_POCKET      = 13;
const int DST_SKILL_SEARCH           = 14;
const int DST_SKILL_SET_TRAP         = 15;
const int DST_SKILL_SPELLCRAFT       = 16;
const int DST_SKILL_SPOT             = 17;
const int DST_SKILL_TAUNT            = 18;
const int DST_SKILL_USE_MAGIC_DEVICE = 19;
const int DST_SKILL_APPRAISE         = 20;
const int DST_SKILL_TUMBLE           = 21;
const int DST_SKILL_CRAFT_TRAP       = 22;
const int DST_ABILITY_STRENGTH       = 50;
const int DST_ABILITY_DEXTERITY      = 51;
const int DST_ABILITY_CONSTITUTION   = 52;
const int DST_ABILITY_INTELLIGENCE   = 53;
const int DST_ABILITY_WISDOM         = 54;
const int DST_ABILITY_CHARISMA       = 55;
const int DST_DESCRIPTION            = 56;
const int DST_TRACKING               = 57;

// Used to simplify the code.
const int DST_ABILITY_MIN = DST_ABILITY_STRENGTH;
const int DST_ABILITY_MAX = DST_ABILITY_CHARISMA;
const int DST_SKILL_MIN = DST_SKILL_ANIMAL_EMPATHY;
const int DST_SKILL_MAX = DST_SKILL_CRAFT_TRAP;

const int DST_OBJECT_TYPE_SOUND = 512;

// This is the string used to store state information on the triggers.
const string DST_STATE = "DSTFired";
const string DST_DM_STATE = "DSTDMFired";
const string DST_LOCKED_STATE = "DSTLocked";

// ****************************************************************************
// ** GLOBAL VARIABLES
// ****************************************************************************

// NOTE: OMW_COLORS is an invisible object that must be present in your module.
// It has high ascii characters in the name and is used to get the color codes.
// This was ripped wholeheartedly by an example posted by Richterm on the bioboards.

string DST_COLOR_TAGS = GetName(GetObjectByTag("OMW_COLORS"));
string DST_COLOR_WHITE = GetSubString(DST_COLOR_TAGS, 0, 6);
string DST_COLOR_YELLOW = GetSubString(DST_COLOR_TAGS, 6, 6);
string DST_COLOR_MAGENTA = GetSubString(DST_COLOR_TAGS, 12, 6);
string DST_COLOR_CYAN = GetSubString(DST_COLOR_TAGS, 18, 6);
string DST_COLOR_RED = GetSubString(DST_COLOR_TAGS, 24, 6);
string DST_COLOR_GREEN = GetSubString(DST_COLOR_TAGS, 30, 6);
string DST_COLOR_BLUE = GetSubString(DST_COLOR_TAGS, 36, 6);

// Colors for each ability type. Change the colors if you like.
string DST_COLOR_STR = DST_COLOR_BLUE;
string DST_COLOR_DEX = DST_COLOR_GREEN;
string DST_COLOR_CON = DST_COLOR_RED;
string DST_COLOR_WIS = DST_COLOR_CYAN;
string DST_COLOR_INT = DST_COLOR_YELLOW;
string DST_COLOR_CHA = DST_COLOR_MAGENTA;
string DST_COLOR_NORMAL = DST_COLOR_WHITE;

// ****************************************************************************
// ** FUNCTION DECLARATIONS
// ****************************************************************************

// DSTGetCheckName
//  nCheck - ability/skill check or description (DST_* constant)
// Get the name for a skill/ability check with colored text.
string DSTGetCheckName (int nCheck);

// DSTGetIsSkillNeedsTraining
//  nCheck - ability/skill check or description (DST_* constant)
// Returns TRUE if nCheck is a skill that needs training.
int DSTGetIsSkillNeedsTraining (int nCheck);

// DSTGiveXPToParty
// Gives experience to a party.
//  oPC - one of the players in the party.
//  iAmount - the amount of XP to give to each player.
//  bAllParty - if FALSE then only give XP to oPC, if TRUE then give to entire party.
void DSTGiveXPToParty(object oPC, int iAmount, int bAllParty=TRUE);

// DSTGetModForCheck
// Returns the modifier for a specific check.
//  oPC - player who is performing the check
//  nCheck - ability/skill check or description (DST_* constant)
int DSTGetModForCheck (object oPC, int nCheck);

// DSTGetIsCheckSuccessful
// Returns TRUE if the roll was successful, FALSE if it wasn't.
//  oPC - player who is performing the check
//  nCheck - ability/skill check or description (DST_* constant)
//  iDC - the DC to beat
int DSTGetIsCheckSuccessful (object oPC, int nCheck, int iDC);

// DSTSendText
// Send descriptive flavor text to a player or party.
//  oPC - A member of the party.
//  sFloat - This is the text that will float over the player's head.
//  sDesc - The text description to send.
//  bAllParty - If TRUE, send text to entire party. If FALSE, only send it to oPC.
//  bState - If TRUE, it will only send once per player. If FALSE, it will send every time.
//  iDMNotify - If TRUE, the text will be copied to the DM channel the FIRST time it is triggered.
void DSTSendText(object oPC, string sFloat, string sDesc, int bAllParty = FALSE, int bState = TRUE, int iDMNotify = FALSE);

// DSTDestroyTrigger
// Wrapper for destroying a trigger. The setting of DST_FAKE_DESTROY_TIMER will
// change how this function works. If DST_FAKE_DESTROY_TIMER == 0.0 then this
// function will simple destroy the trigger that called it. If there is some other
// setting, then the function will lock the trigger for a period of time and destroy
// oCreated when that period of time is over.
void DSTDestroyTrigger (object oCreated = OBJECT_INVALID);

// DSTCheck
// Returns TRUE if the roll was successful, FALSE if it wasn't.
//  oPC - player who is performing the check
//  nCheck - ability/skill check or description (DST_* constant)
//  iDC - the DC to beat
//  sDesc - the descriptive text to send.
//  iXP - the amount of XP to give out on success.
//  iSetting - A bitwise OR of DST_SET_* constant to determine how the check will be run. (ie: DST_SET_PARTY | DST_SET_DM_NOTIFY)
//  iDM - If TRUE, then the text will be copied on to the DM channel the first time it is run.
//  iObjectType - the OBJECT_TYPE_* of the object to be created on success. Use 512 if you want to specify a sound to be played.
//   NOTE: the only types that seem to work cleanly are CREATURE, ITEM and PLACEABLE.
//  iFacing - the facing for the created object (DIRECTION_*, E=0, NE=45, N=90, NW=135, W=180, SW=225, S=270, SE=315)
//  sResRef - the ResRef of the object to be created on success, or the name of the sound to be played if iObjectType == OBJECT_TYPE_INVALID.
int DSTCheck (object oPC, int nCheck, int iDC, string sDesc = "", int iSetting = DST_SET_STATE_SUCCESS, int iXP = 0, int iObjectType = 0, int iFacing = 0, string sResRef = "");

// DSTSetPersistent
// Wrapper for setting persistent data. By default, is just uses local variables
// on the object. You can re-write this function to use whatever persistent
// database you are using.
void DSTSetPersistent (object oPC);

// DSTGetPersistent
// Wrapper for getting persistent data. By default, is just uses local variables
// on the object. You can re-write this function to use whatever persistent
// database you are using.
int DSTGetPersistent (object oPC);

// ****************************************************************************
// ** FUNCTION DEFINITIONS
// ****************************************************************************

int DSTGetPersistent (object oPC)
{
    // For true persistence over module restarts, re-write this function to use
    // a persistent database system.
    // // edited by El Grillo 23/3/2021 to introduce persistence via GetCampaignInt/SetCampaignInt
    // // campaign database is "LoreTriggers"
    // // variables are made unique by including the value of the variable named 'UID'
    // // a UNIQUE value for the UID variable must be manually added to each trigger when placed by builders; anything will do e.g. 'caercorwellgates' or similar
    // // the UID variable string is combined with the DST_STATE and added as a campaign variable to the PC themselves (not to the trigger)
    return     (GetCampaignInt("LoreTriggers", DST_STATE + GetLocalString(OBJECT_SELF, "UID"), oPC));
}

// ****************************************************************************

void DSTSetPersistent (object oPC)
{
    // For true persistence over module restarts, re-write this function to use
    // a persistent database system.
    SetCampaignInt("LoreTriggers", DST_STATE + GetLocalString(OBJECT_SELF, "UID"), 1, oPC);
}

// ****************************************************************************

string DSTGetCheckName (int nCheck)
{
    int bFound = TRUE;
    string sRetVal = "Bug Found: unknown ability/skill/save";
    // The NWN compiler isn't smart enough to build jump tables, etc.
    // So break the abilities into sub-groups to increase the execution speed.
    if ((nCheck >= DST_ABILITY_STRENGTH) && (nCheck <= DST_TRACKING))
    {
        if (nCheck == DST_DESCRIPTION) sRetVal = DST_COLOR_INT+"*Description*"+DST_COLOR_NORMAL;
        else if (nCheck == DST_TRACKING) sRetVal = DST_COLOR_INT+"*Tracks*"+DST_COLOR_NORMAL;
        else if (nCheck == DST_ABILITY_CHARISMA) sRetVal = DST_COLOR_CHA+"*Charisma*"+DST_COLOR_NORMAL;
        else if (nCheck == DST_ABILITY_CONSTITUTION) sRetVal = DST_COLOR_CON+"*Constitution*"+DST_COLOR_NORMAL;
        else if (nCheck == DST_ABILITY_DEXTERITY) sRetVal = DST_COLOR_DEX+"*Dexterity*"+DST_COLOR_NORMAL;
        else if (nCheck == DST_ABILITY_INTELLIGENCE) sRetVal = DST_COLOR_INT+"*Intelligence*"+DST_COLOR_NORMAL;
        else if (nCheck == DST_ABILITY_STRENGTH) sRetVal = DST_COLOR_STR+"*Strength*"+DST_COLOR_NORMAL;
        else if (nCheck == DST_ABILITY_WISDOM) sRetVal = DST_COLOR_WIS+"*Wisdom*"+DST_COLOR_NORMAL;
    }
    else if ((nCheck >= DST_SKILL_ANIMAL_EMPATHY) && (nCheck <= DST_SKILL_LISTEN))
    {
        if (nCheck == DST_SKILL_LISTEN) sRetVal = DST_COLOR_WIS+"*Listen*"+DST_COLOR_NORMAL;
        else if (nCheck == DST_SKILL_ANIMAL_EMPATHY) sRetVal = DST_COLOR_CHA+"*AnimalEmpathy*"+DST_COLOR_NORMAL;
        else if (nCheck == DST_SKILL_CONCENTRATION) sRetVal = DST_COLOR_CON+"*Concentration*"+DST_COLOR_NORMAL;
        else if (nCheck == DST_SKILL_DISABLE_TRAP) sRetVal = DST_COLOR_INT+"*DisableTrap*"+DST_COLOR_NORMAL;
        else if (nCheck == DST_SKILL_DISCIPLINE) sRetVal = DST_COLOR_STR+"*Discipline*"+DST_COLOR_NORMAL;
        else if (nCheck == DST_SKILL_HEAL) sRetVal = DST_COLOR_WIS+"*Heal*"+DST_COLOR_NORMAL;
        else if (nCheck == DST_SKILL_HIDE) sRetVal = DST_COLOR_DEX+"*Hide*"+DST_COLOR_NORMAL;
    }
    else if ((nCheck >= DST_SKILL_LORE) && (nCheck <= DST_SKILL_SEARCH))
    {
        if (nCheck == DST_SKILL_LORE) sRetVal = DST_COLOR_INT+"*Lore*"+DST_COLOR_NORMAL;
        else if (nCheck == DST_SKILL_SEARCH) sRetVal = DST_COLOR_INT+"*Search*"+DST_COLOR_NORMAL;
        else if (nCheck == DST_SKILL_PERFORM) sRetVal = DST_COLOR_CHA+"*Perform*"+DST_COLOR_NORMAL;
        else if (nCheck == DST_SKILL_PERSUADE) sRetVal = DST_COLOR_CHA+"*Persuade*"+DST_COLOR_NORMAL;
        else if (nCheck == DST_SKILL_MOVE_SILENTLY) sRetVal = DST_COLOR_DEX+"*MoveSilently*"+DST_COLOR_NORMAL;
        else if (nCheck == DST_SKILL_OPEN_LOCK) sRetVal = DST_COLOR_DEX+"*OpenLock*"+DST_COLOR_NORMAL;
        else if (nCheck == DST_SKILL_PARRY) sRetVal = DST_COLOR_DEX+"*Parry*"+DST_COLOR_NORMAL;
        else if (nCheck == DST_SKILL_PICK_POCKET) sRetVal = DST_COLOR_DEX+"*PickPocket*"+DST_COLOR_NORMAL;
    }
    else if ((nCheck >= DST_SKILL_SET_TRAP) && (nCheck <= DST_SKILL_CRAFT_TRAP))
    {
        if (nCheck == DST_SKILL_SET_TRAP) sRetVal = DST_COLOR_DEX+"*SetTrap*"+DST_COLOR_NORMAL;
        else if (nCheck == DST_SKILL_SPELLCRAFT) sRetVal = DST_COLOR_INT+"*Spellcraft*"+DST_COLOR_NORMAL;
        else if (nCheck == DST_SKILL_SPOT) sRetVal = DST_COLOR_WIS+"*Spot*"+DST_COLOR_NORMAL;
        else if (nCheck == DST_SKILL_TAUNT) sRetVal = DST_COLOR_CHA+"*Taunt*"+DST_COLOR_NORMAL;
        else if (nCheck == DST_SKILL_USE_MAGIC_DEVICE) sRetVal = DST_COLOR_CHA+"*UseMagicDevice*"+DST_COLOR_NORMAL;
        else if (nCheck == DST_SKILL_APPRAISE) sRetVal = DST_COLOR_INT+"*Appraise*"+DST_COLOR_NORMAL;
        else if (nCheck == DST_SKILL_TUMBLE) sRetVal = DST_COLOR_DEX+"*Tumble*"+DST_COLOR_NORMAL;
        else if (nCheck == DST_SKILL_CRAFT_TRAP) sRetVal = DST_COLOR_INT+"*CraftTrap*"+DST_COLOR_NORMAL;
    }
    else bFound = FALSE;

    // Error Handling.
    if (bFound == FALSE)
    {
        SpeakString("ERROR DSTGetCheckName: Unknown ability/skill/save nCheck: "+IntToString(nCheck)+" Area:"+GetName(GetArea(OBJECT_SELF))+" Tag:"+GetTag(OBJECT_SELF), TALKVOLUME_SHOUT);
    }
    return sRetVal;
}

// ****************************************************************************

int DSTGetIsSkillNeedsTraining (int nCheck)
{
    // these are the subset of skills that need training to be used
    if (nCheck == DST_SKILL_ANIMAL_EMPATHY) return TRUE;
    else if (nCheck == DST_SKILL_SPELLCRAFT) return TRUE;
    else if (nCheck == DST_SKILL_USE_MAGIC_DEVICE) return TRUE;
    else if (nCheck == DST_SKILL_DISABLE_TRAP) return TRUE;
    else if (nCheck == DST_SKILL_OPEN_LOCK) return TRUE;
    else if (nCheck == DST_SKILL_PICK_POCKET) return TRUE;
    else if (nCheck == DST_SKILL_SET_TRAP) return TRUE;
    else if (nCheck == DST_SKILL_APPRAISE) return TRUE;
    else if (nCheck == DST_SKILL_TUMBLE) return TRUE;
    else
    {
        return FALSE;
    }
}

// ****************************************************************************

void DSTGiveXPToParty(object oPC, int iAmount, int bAllParty=TRUE)
{
    // Give XP to party
    // iAmount - amount of XP
    // bAllParty - give to one player or all players
    if (bAllParty == TRUE)
    {
        object oPartyMember = GetFirstFactionMember(oPC);
        while (GetIsObjectValid(oPartyMember))
        {
            GiveAndLogXP(oPartyMember, iAmount, "PHB SKILL",
                         "for phb_skill_desc.");
            oPartyMember = GetNextFactionMember(oPC);
        }
    }
    else {
    GiveAndLogXP(oPC, iAmount, "PHB SKILL",
                         "for phb_skill_desc.");
    }
}

// ****************************************************************************

int DSTGetModForCheck (object oPC, int nCheck)
{
    int iMod = 0;
    if ((nCheck >= DST_SKILL_MIN) && (nCheck <= DST_SKILL_MAX)) iMod = GetSkillRank(nCheck, oPC);
    if ((nCheck >= DST_ABILITY_MIN) && (nCheck <= DST_ABILITY_MAX)) iMod = GetAbilityModifier(nCheck - DST_ABILITY_MIN, oPC);
    if (nCheck == DST_TRACKING) iMod = GetSkillRank(SKILL_SEARCH, oPC) - 5*(GetDetectMode(oPC) == DETECT_MODE_PASSIVE); // passive = 0, active = 1
    return (iMod);
}

// ****************************************************************************

int DSTGetIsCheckSuccessful (object oPC, int nCheck, int iDC)
{
    // Descriptions are always successful.
    if (nCheck == DST_DESCRIPTION) return TRUE;

    // Tracking DCs over 10 always fail unless the character has ranger levels.
    if (nCheck == DST_TRACKING)
    {
        if ((iDC > 10) && (GetLevelByClass(CLASS_TYPE_RANGER, oPC) == 0))
        {
        if (DST_DEBUG) FloatingTextStringOnCreature("debug: non-ranger can't track DC over 10. DC is " +IntToString(iDC)+" "+ DSTGetCheckName(nCheck) + " has skill: " + IntToString(GetHasSkill(nCheck,oPC)) + " has rank:" + IntToString(GetSkillRank(nCheck, oPC)), oPC);
            return FALSE;
        }
    }

    // Check to see if it is a skill that requires training, if so don't check.
    if (DSTGetIsSkillNeedsTraining(nCheck))
    {
        if (DST_DEBUG) FloatingTextStringOnCreature("debug: needs training " + DSTGetCheckName(nCheck) + " has skill: " + IntToString(GetHasSkill(nCheck,oPC)) + " has rank:" + IntToString(GetSkillRank(nCheck, oPC)), oPC);
        if (GetHasSkill(nCheck, oPC))
        {
            // Player does not have skill if skill rank is 0 or -1.
            if (GetSkillRank(nCheck, oPC) < 1) return FALSE;
        } else return FALSE;
    }

    // Roll the dice and check for critical failure / automatic success
    int iRoll = d20();
    int iMod = DSTGetModForCheck (oPC, nCheck);
    if (DST_DEBUG) FloatingTextStringOnCreature("debug: Check " + DSTGetCheckName(nCheck) + " rolled " + IntToString(iRoll) + " + " + IntToString(iMod) + " vs DC "+IntToString(iDC), oPC);
    if ((DST_ALLOW_CRITICAL) && (iRoll == 1))
    {
        // Critical Failure on natural 1, do not get a chance to reroll
        DSTSetPersistent(oPC);
        return FALSE;
    }
    if ((DST_ALLOW_CRITICAL) && (iRoll == 20)) return TRUE; // Automatic Success on natural 20
    else
    {
        // Calculate the Check
        if ((iRoll + iMod) >= iDC) return TRUE;
        else return FALSE; // They can try the check again
    }
}

// ****************************************************************************

void DSTSendText(object oPC, string sFloat, string sDesc, int bAllParty = FALSE, int bState = TRUE, int iDMNotify = FALSE)
{
    // check that no one is in combat
    if (GetIsInCombat(oPC)) // The combat flag is set whenever anyone in the party has recently been in combat
    {
        // someone in the party is in combat
        DelayCommand(6.0, DSTSendText(oPC, sFloat, sDesc, bAllParty, iDMNotify));
        return;
    }
    // no one is in combat, so send the message

    // DM Notification
    if (iDMNotify && (GetLocalInt(OBJECT_SELF, DST_DM_STATE) == 0))
    {
        SetLocalInt(OBJECT_SELF, DST_DM_STATE, 1);
        SendMessageToAllDMs(GetName(oPC)+" triggered: "+sFloat+" "+sDesc);
    }
    sDesc = DST_COLOR_NORMAL + sDesc;
    if (bAllParty)
    {
        // Send to everyone in the party.
        object oParty = GetFirstFactionMember (oPC); // loop through the players
        while (GetIsObjectValid(oParty))
        {
            if (DSTGetPersistent(oParty) == 0)
            {
                if (bState) DSTSetPersistent(oParty);
                FloatingTextStringOnCreature(sFloat, oParty, FALSE); // Alert the player that they have a description coming in
                SendMessageToPC(oParty, sDesc); // Send the description to the player
            }
            // Get the next party member
            oParty = GetNextFactionMember(oPC);
        }
    } else {
        // Send to one player.
        if (DSTGetPersistent(oPC) == 0)
        {
            if (bState) DSTSetPersistent(oPC);
            FloatingTextStringOnCreature(sFloat, oPC, FALSE); // Alert the player that they have a description coming in
            SendMessageToPC(oPC, sDesc); // Send the description to the player
        }
    }
}

// ****************************************************************************

void DSTDestroyTrigger (object oCreated = OBJECT_INVALID)
{
    if (DST_DEBUG) SpeakString("DST debug: destroying self");
    if (DST_FAKE_DESTROY_TIMER > 0.0)
    {
        SetLocalInt(OBJECT_SELF, DST_LOCKED_STATE, 1);
        DelayCommand(DST_FAKE_DESTROY_TIMER, DeleteLocalInt(OBJECT_SELF, DST_LOCKED_STATE));
        if (GetIsObjectValid(oCreated)) DestroyObject(oCreated, DST_FAKE_DESTROY_TIMER);
    } else {
        DestroyObject(OBJECT_SELF, 1.0);
    }
}

// ****************************************************************************

int DSTCheck (object oPC, int nCheck, int iDC, string sDesc = "", int iSetting = DST_SET_STATE_SUCCESS, int iXP = 0, int iObjectType = 0, int iFacing = 0, string sResRef = "")
{

    // Should we run the check?
    if(
        (GetLocalInt(OBJECT_SELF, DST_LOCKED_STATE) == 1) ||
        (DSTGetPersistent(oPC) == 1)
        ) return FALSE;
    // See if they pass the check.
    if (DSTGetIsCheckSuccessful (oPC, nCheck, iDC) == FALSE)
    { // Did not pass the check.
        // Trigger runs once per player.
        if (iSetting & DST_SET_STATE_FAILURE) DSTSetPersistent(oPC);
        // Trigger runs once only.
        if (iSetting & DST_SET_DESTROY_FAILURE) DSTDestroyTrigger();
        return FALSE;
    }
    // Passed the check.
    // Send the text.
    DSTSendText(oPC, DSTGetCheckName(nCheck), sDesc, iSetting & DST_SET_PARTY, iSetting & DST_SET_STATE_SUCCESS, iSetting & DST_SET_DM_NOTIFY);
    // Award XP if specified.
    if (iXP > 0) DSTGiveXPToParty(oPC, iXP, iSetting & DST_SET_PARTY);
    // Create the specified object.
    object oCreated = OBJECT_INVALID;
    if (iObjectType > 0)
    {
        if(iObjectType == DST_OBJECT_TYPE_SOUND) AssignCommand(oPC, PlaySound(sResRef));
        else {
            oCreated = CreateObject(iObjectType, sResRef, GetLocation(OBJECT_SELF), TRUE);
            if (!GetIsObjectValid(oCreated)) SpeakString("DSTCheck ERROR: could not create object with ResRef "+sResRef+" Area:"+GetName(GetArea(OBJECT_SELF))+" Tag:"+GetTag(OBJECT_SELF), TALKVOLUME_SHOUT);
            else AssignCommand(oCreated, SetFacing(IntToFloat(iFacing)));
        }
    }
    if (iSetting & DST_SET_DESTROY_SUCCESS) DSTDestroyTrigger(oCreated);
    return TRUE;
}

// ****************************************************************************
// ** CONSTANTS (Do not modify)
// ****************************************************************************

// Positions of the data in the tag.
const int DST_POS_CHECK = 1;
const int DST_POS_DC = 2;
const int DST_POS_SETTING = 3;
const int DST_POS_XP = 4;
const int DST_POS_OBJECT = 5;
const int DST_POS_FACING = 6;
const int DST_POS_RESREF = 7;

// State machine.
const string DST_STATE_INIT = "DSTSInit";
const string DST_STATE_CHECK = "DSTSCh";
const string DST_STATE_DC = "DSTSDC";
const string DST_STATE_SETTING = "DSTSSet";
const string DST_STATE_XP = "DSTSXP";
const string DST_STATE_OBJECT = "DSTSObj";
const string DST_STATE_FACING = "DSTSFac";
const string DST_STATE_RESREF = "DSTSRes";

// ****************************************************************************
// ** FUNCTION DECLARATIONS
// ****************************************************************************

// DSTStrTok
// Returns the ith element in a / separated string. If the element
// does not exist it returns an empty string.
//   sStr - the string.
//   i - the ith element.
//   bGetRest - get everything after this element.
string DSTStrTok(string sStr, int i, int bGetRest = FALSE);

// ****************************************************************************
// ** FUNCTION DEFINITIONS
// ****************************************************************************

string DSTStrTok(string sStr, int i, int bGetRest = FALSE)
{
    int iIndex = 1;
    int iPos = GetStringLength(sStr);
    int iDelimiter = FindSubString(sStr, "_");
    string sMatch = "";
    while (iDelimiter != -1)
    {
        if (iIndex == i)
        {
            if (bGetRest) sMatch = GetStringRight(sStr, iPos);
            else sMatch = GetStringLeft(GetStringRight(sStr, iPos), iDelimiter);
            break;
        }
        iIndex++;
        iPos = iPos - iDelimiter - 1;
        iDelimiter = FindSubString(GetStringRight(sStr, iPos), "_");
        if (iDelimiter == -1) sMatch = GetStringRight(sStr, iPos);
    }
    if (iIndex == i) return sMatch;
    else return "";
}

// ****************************************************************************
// ** MAIN
// ****************************************************************************

void main()
{
            // Got to love the fact that GetEnteringObject and GetClickingObject are
    // the same function.
    object oPC = GetEnteringObject();
    if (GetObjectType(OBJECT_SELF) == OBJECT_TYPE_PLACEABLE) oPC = GetLastUsedBy();
    int nCheck;
    int iDC;
    int iSetting;
    int iXP;
    int iObjectType;
    int iFacing;
    string sResRef;
    if (GetLocalInt(OBJECT_SELF, DST_STATE_INIT) == 0)
    {
        // Has not been initialized, parse the tag so that future executions
        // of the trigger will be faster.
        string sTag = GetTag(OBJECT_SELF);
        nCheck = StringToInt(DSTStrTok(sTag, DST_POS_CHECK));
        SetLocalInt(OBJECT_SELF, DST_STATE_CHECK, nCheck);

        iDC = StringToInt(DSTStrTok(sTag, DST_POS_DC));
        SetLocalInt(OBJECT_SELF, DST_STATE_DC, iDC);

        iSetting = StringToInt(DSTStrTok(sTag, DST_POS_SETTING));
        // DM notification can be globally force on or off with a constant.
        if (DST_DM_NOTIFY_FORCE != 2)
        {
            if (DST_DM_NOTIFY_FORCE == 1) iSetting = iSetting | DST_SET_DM_NOTIFY;
            else iSetting = iSetting & (~DST_SET_DM_NOTIFY);
        }
        SetLocalInt(OBJECT_SELF, DST_STATE_SETTING, iSetting);

        iXP = StringToInt(DSTStrTok(sTag, DST_POS_XP));
        SetLocalInt(OBJECT_SELF, DST_STATE_XP, iXP);

        iObjectType = StringToInt(DSTStrTok(sTag, DST_POS_OBJECT));
        // In order to save/simplify the tags, I use 3 & 4 to represent different
        // constants.
        if (iObjectType == 3) iObjectType = OBJECT_TYPE_PLACEABLE;
        else if (iObjectType == 4) iObjectType = DST_OBJECT_TYPE_SOUND;
        SetLocalInt(OBJECT_SELF, DST_STATE_OBJECT, iObjectType);

        // In order to save/simplify the tags, I only allow the cardinal directions.
        iFacing = StringToInt(DSTStrTok(sTag, DST_POS_FACING)) * 45;
        SetLocalInt(OBJECT_SELF, DST_STATE_FACING, iFacing);

        // ResRefs can contain underscores so get everything else left in the
        // string at this point.
        sResRef = DSTStrTok(sTag, DST_POS_RESREF, TRUE);
        SetLocalString(OBJECT_SELF, DST_STATE_RESREF, sResRef);

        // Complete initialization.
        SetLocalInt(OBJECT_SELF, DST_STATE_INIT, 1);
    } else {
        // Already initialized, just read in the local variables.
        nCheck = GetLocalInt(OBJECT_SELF, DST_STATE_CHECK);
        iDC = GetLocalInt(OBJECT_SELF, DST_STATE_DC);
        iSetting = GetLocalInt(OBJECT_SELF, DST_STATE_SETTING);
        iXP = GetLocalInt(OBJECT_SELF, DST_STATE_XP);
        iObjectType = GetLocalInt(OBJECT_SELF, DST_STATE_OBJECT);
        iFacing = GetLocalInt(OBJECT_SELF, DST_STATE_FACING);
        sResRef = GetLocalString(OBJECT_SELF, DST_STATE_RESREF);
    }
    if (DST_DEBUG)
    {
        string sSetting = "";
        if (iSetting & DST_SET_PARTY) sSetting = "party/";
        else sSetting = "player/";
        if (iSetting & DST_SET_STATE_FAILURE) sSetting += "check until failure/";
        else sSetting += "keep checking after failure/";
        if (iSetting & DST_SET_STATE_SUCCESS) sSetting += "check until success/";
        else sSetting += "keep checking after success/";
        if (iSetting & DST_SET_DESTROY_FAILURE) sSetting += "destroy on failure/";
        else sSetting += "no destroy on failure/";
        if (iSetting & DST_SET_DESTROY_SUCCESS) sSetting += "destroy on success/";
        else sSetting += "no destroy on success/";

        SendMessageToPC(oPC, "DST debug: SAD_DC_SET_DM_XP_OBJ_FC_RESREF, Tag: "+GetTag(OBJECT_SELF)+
        ", gives check: "+DSTGetCheckName(nCheck)+
        ", gives DC: "+IntToString(iDC)+
        ", gives Setting: "+IntToString(iSetting)+" ["+sSetting+"]"+
        ", gives XP Award: "+IntToString(iXP)+
        ", gives Object Type: "+IntToString(iObjectType)+
        ", gives Facing: "+IntToString(iFacing)+
        ", gives ResRef: "+sResRef);
    }
    // Run the check.
    DSTCheck(oPC, nCheck, iDC, GetName(OBJECT_SELF), iSetting, iXP, iObjectType, iFacing, sResRef);
}
