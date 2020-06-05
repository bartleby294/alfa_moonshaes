// Player Handbook Movement Skills 1.02
// by OldManWhistler

/*
I've done a lot of other packages to help bring NWN more of a PnP feel, check out my portfolio:
http://nwvault.ign.com/portfolios/data/1054937958.shtml


DESCRIPTION

This is a simple system that implements several of the 3E PHB skills that were left out of NWN. This script adds checks for Balance, Climb, Jump, Swim and Tight Space (based on Escape Artist). The implementation follows the 3E rules for the skills and the documentation includes a print out of guidelines for how to determine the Difficulty Check when adding the skill check to your module. The intent of this package is to add some additional player versus environment situations to the game.

It doesn't *really* add any new skills to the game (no hak pak), what it does is provide the builder a means to use placeables or triggers to create a transition between any two points. Whether or not a player can use the transition is based on the 3E rules governing the five movement skills. The player uses the object and if they pass a successful skill check then they can go to the destination.

This script is loosely based off of a custom script by Demetrious and a similar package by Dlaun (http://nwvault.ign.com/Files/scripts/data/1052921930670.shtml). I was not 100% happy with either system because I felt it was possible to fully implement the 3E rules, it could all be done with one generic script, and there was no need for conversations. Having the object use a conversation to control the skill would mean the transitions couldn't be used in combat.

If someone wants to come up with some better animation sequences and sound effects that don't require a hak pak, feel free to send them to me and I'll include them. That kind of stuff really isn't my forté.

INSTALLATION

Import phb_ms_X_XX.erf into the module. This will give you the script, a base placeable and a base trigger.

If you want to have a set of pre-built placeable and triggers to work from, then also import phb_ms_X_XX_dm.erf

THE SKILLS

Balance - uses DEX, affected by Armor Check Penalty and Encumbrance Penalty, +2 synergy with 5 ranks of Tumble skill.
Climb - uses STR, affected by Armor Check Penalty and Encumbrance Penalty
Jump - uses STR, affected by Armor Check Penalty and Encumbrance Penalty, +2 synergy with 5 ranks of Tumble skill, +1 skill point for every +10% movement speed from class, affected by creature size modifier.
Long Jump (3.5E) - uses STR, affected by Armor Check Penalty and Encumbrance Penalty, +2 synergy with 5 ranks of Tumble skill, +1 skill point for every +10% movement speed from class
High Jump (3.5E) - uses STR, affected by Armor Check Penalty and Encumbrance Penalty, +2 synergy with 5 ranks of Tumble skill, +1 skill point for every +10% movement speed from class, affected by creature size modifier.
Swim - uses STR, -1 skill for every 5lb of weight character has.
Tight Space - uses DEX, affected by creature size modifier, Armor Check Penalty and Encumbrance Penalty. (NOTE: this skill diverges from the PHB)

Failing a Balance, Climb, or Jump check by more than 5 means you take falling damage. Succeeding against a DC15 Tumble check reduces the damage. The falling damage can kill you.
Failing a Swim check by more than 5 means you take drowning damage. Drowning damage cannot kill you.
Failing a Tight Space check by more than 5 means that you damage yourself on the attempt. This damage cannot kill you.

Thanks to Mogney and Lazybones for some help with the design. Who needs WOTC when those two are around?

For the 3.5 jump skills (Long Jump and High Jump) there are the following modifications compared to 3E jump:
- If you succeed by less than 5 then you land prone.
- If you fail by less than 5 then you can still succeed if you pass a DC15 reflex save.
- Halflings get +2 to jump skill.
- High jump is affected by creature size. I assume that the DCs are all based off of medium sized creatures.
- tiny creatures get a 24 point penalty to their rolls
- small creatures get a 16 point penalty to their rolls
- large creatures get a 32 point bonus to their rolls
- huge creatures get a 128 point bonus to their rolls.

FEATURES

- Includes an extensive example module and two erfs.
- 1 script, 1 trigger, 1 placeable. Does not override any NWN content or require hak paks.
- Placeable and trigger are in Custom 5 and have built-in documentation under the comment field.
- The player's ranks in the "new" skills are calculated based on if the character had put the maximum possible number of skill points into it.
- You can globally reconfigure how much of their maximum possible movement skill a player should get. Default is 75%.
- Trigger/placeable tag specifies the type of skill check, DC, destination waypoint tag and the maximum damage from Critical Failure (failure by more than 5).
- Trigger/placeable name is displayed as the description of the action.
- Automatically displays the direction between the source and the destination and makes the player face the destination.
- Displays a different animation and sound for each different skill.
- Displays a difficulty appraisal (certain, easy, average, hard, impossible) based on the roll needed to succeed so that players can decide whether or not they want to try the action.
- Damage can be specified for Critical Failure. It will apply a random value between 0 to the maximum damage specified.
- You can configure how much falling damage is reduced by a Tumble save. Default is the tumble save reduces damage to 75%.
- If a waypoint exists with the name of the destination followed by "F" then that is where the player will go when they fail.
- If no destination waypoint exists then it will search for the nearest object with the same tag within 3 tiles. This is so that skill placeables can be placed live by a DM.
DM SUPPORT

We *ALL* know that players never do what you expect them to, so this system is built in such a way that the placeables can be placed live without the need for destination waypoints so long as the destination is the nearest object with the same Tag. This is considerably easier to do live compared to rolling skill checks for each player and jumping them individually.

There is a second erf inside for DMs who want to be able to place down skills live (ie: in a soundstage module). It can also be used by builders who just want to place down checks in their modules without having to think to hard about which DC to use.

The sample erf contains placeables and triggers, but only use the PLACEABLES live. Any triggers that are placed live instantly become traps because of a bug in NWN. Also, having a large number of clickable triggers close together causes a huge amount of graphics lag (same thing happens with area transitions).

The sample erf contains 27 placeables and 27 triggers.

Balance (looks like a Scorch Mark)
(B05) The floor looks slippery.
(B10) The floor looks slippery and inclined or uneven.
(B15) The floor looks uneven and slippery.
(B20) The floor looks uneven, slippery and inclined.

Climb (looks like a Boulder)
(C05) A knotted rope. (looks like a Pull Chain)
(C10) A surface with ledges to hold on to and stand on.
(C15) A surface with adequate handholds and foot holds.
(C20) An uneven surface with some narrow handholds and footholds.
(C25) A rough surface or an overhang/ceiling with handholds but no footholds.
(C30) A slippery rough surface.

Jump (looks like Butterflies)
(LJ05) Long jump of 5 feet.
(LJ10) Long jump of 10 feet.
(LJ15) Long jump of 15 feet.
(LJ20) Long jump of 20 feet.
(LJ25) Long jump of 25 feet.
(LJ30) Long jump of 30 feet.
(HJ04) High jump of 9 feet.
(HJ08) High jump of 10 feet.
(HJ12) High jump of 11 feet.
(HJ16) High jump of 12 feet.
(HJ20) High jump of 13 feet.
(HJ24) High jump of 14 feet.
(HJ28) High jump of 15 feet.
(HJ32) High jump of 16 feet.


Swim (looks like a Water Drip)
(S10) Calm water.
(S15) Rough water.
(S20) Stormy water.

Tight Space (looks like Stones)
(TS00) An opening.
(TS10) A small space.
(TS20) A narrow space with a chance of getting stuck.
(TS30) A tight space where your head fits but your shoulders don't.



IMPLEMENTATION NOTES

Any of the skill rules that required removing heavy armor (running jumps) or removing shields (climbing) were removed since it only serves as an annoyance to the players. If they can pass the DC with the armor check penalty from their equipment then so be it.

Since the skills aren't actually available in the NWN game engine, the player's skill ranked is faked by determining their class levels and whether or not each class would have had that skill as a class based skill. This means that players will always have the maximum possible rank in the skill. This isn't true to PnP, and it might make the DCs easier than they are intended to be. There is a scaling factor in the script that can determine what percentage of the maximum possible skill a player should have. Default is 75%.

If their first class had the skill as a class based skill then they get 4 points as base, otherwise they get 2 points. After that they get 1 point for every level as a class-skill class and 1 point for every two levels in a non-class-skill class.

// What percentage of their maximum possible Movement skill should players be given?
// Value from 0 to 100.
const int MS_MOVEMENT_SKILL_PERCENTAGE = 75;

The PHB also specifies that if a player fails a balance, climb or jump check by more then five then they take damage based on how much they fall. A successful Tumble check reduces the falling damage by 10 ft. Since the Z-axis of the game is likely different then what the Builder intends it to be, I decided that how much a Tumble check reduces the balance should be globally configurable by the builder rather than an automatic distance check that is most likely inaccurate.

// What percentage should a successful Tumble check reduce Balance/Climb/Jump damage?
// Value from 0 to 100.
const int MS_TUMBLE_SAVE_REDUCTION_PERCENTAGE = 75;


CLASS SKILLS

Each class gets the following as a class skill:

Barbarian: Climb (Str), Jump (Str), Swim (Str)
Bard: Balance (Dex), Climb (Str), Escape Artist (Dex), Jump (Str), Swim (Str)
Cleric: None
Druid: Swim (Str)
Fighter: Climb (Str), Jump (Str), Swim (Str)
Monk: Balance (Dex), Climb (Str), Escape Artist (Dex), Jump (Str), Swim (Str)
Paladin: None
Ranger: Climb (Str), Jump (Str), Swim (Str)
Rogue: Balance (Dex), Climb (Str), Escape Artist (Dex), Jump (Str), Swim (Str)
Sorcerer: None
Wizard: None

Arcane Archer: None
Assassin: Balance (Dex), Climb (Str), Escape Artist (Dex), Jump (Str), Swim (Str)
Blackguard: None
HarperScout: Climb (Str), Escape Artist (Dex), Jump (Str), Swim (Str)
Shadowdancer: Balance (Dex), Jump (Str)


*/

// ****************************************************************************
// CONFIGURATION - MODIFY
// ****************************************************************************

// What percentage of their maximum possible Movement skill should players be given?
// Value from 0 to 100.
const int MS_MOVEMENT_SKILL_PERCENTAGE = 75;
// What percentage should a successful Tumble check reduce Balance/Climb/Jump damage?
// Value from 0 to 100.
const int MS_TUMBLE_SAVE_REDUCTION_PERCENTAGE = 75;
// How much distance to search for possible destination when waypoint isn't specified?
// Value 0.0 to infinity. The max distance only exists to prevent false
const float MS_MAX_NO_WP_SEARCH_DISTANCE = 30.0;
// How much time does the player have to choose to click the object after
// getting the description message?
// Value greater than 0.0.
const float MS_CLICK_TIMEOUT_SEC = 30.0;


// ****************************************************************************
// GLOBALS - DO NOT MODIFY
// ****************************************************************************

// Turn on debugging information for development.
const int MS_DEBUG = FALSE;

// The skill types.
const int MS_SKILL_BALANCE = 1;
const int MS_SKILL_CLIMB = 2;
const int MS_SKILL_JUMP = 3;
const int MS_SKILL_SWIM = 4;
const int MS_SKILL_TIGHT_SPACE = 5;
const int MS_SKILL_LONG_JUMP = 6;
const int MS_SKILL_HIGH_JUMP = 7;

// The position of certain elements in the tag.
const int MS_POSITION_SKILL_TYPE = 1;
const int MS_POSITION_DC = 2;
const int MS_POSITION_DEST_TAG = 3;
const int MS_POSITION_MAX_DMG = 4;

// ****************************************************************************
// FUNCTIONS
// ****************************************************************************

// MSStrTok
// Returns the ith element in a / separated string. If the element
// does not exist it returns an empty string.
//   sStr - the string.
//   i - the ith element.
string MSStrTok(string sStr, int i);
string MSStrTok(string sStr, int i)
{
    int iIndex = 1;
    int iPos = GetStringLength(sStr);
    int iDelimiter = FindSubString(sStr, "_");
    string sMatch = "";
    while (iDelimiter != -1)
    {
        if (iIndex == i)
        {
            sMatch = GetStringLeft(GetStringRight(sStr, iPos), iDelimiter);
            break;
        }
        iIndex++;
        iPos = iPos - iDelimiter - 1;
        iDelimiter = FindSubString(GetStringRight(sStr, iPos), "_");
        if (iDelimiter == -1) sMatch = GetStringRight(sStr, iPos);
    }
    return sMatch;
}

// ****************************************************************************

// MSErrorMsg
// Displays error messages in the code.
//  oPC - the player who triggered the error.
//  sMsg - the error message.
void MSErrorMsg (object oPC, string sMsg);
void MSErrorMsg (object oPC, string sMsg)
{
    string sErrorMsg = "MoveSkillError: "+sMsg+" on obj:"+GetResRef(OBJECT_SELF)+" tag:"+GetTag(OBJECT_SELF)+" area:"+GetName(GetArea(OBJECT_SELF));
    SendMessageToAllDMs(sErrorMsg);
    // Players are given a water-downed error message.
    SendMessageToPC(oPC, sMsg);
    WriteTimestampedLogEntry(sErrorMsg);
}

// ****************************************************************************

// MSGetSkillName
// Get the skill name from the number.
//  oPC - used for displaying error messages only.
//  iSkill - a MS_SKILL_* constant.
string MSGetSkillName(object oPC, int iSkill);
string MSGetSkillName(object oPC, int iSkill)
{
    switch (iSkill)
    {
        case MS_SKILL_BALANCE: return "balance";
        case MS_SKILL_CLIMB: return "climb";
        case MS_SKILL_JUMP: return "jump";
        case MS_SKILL_SWIM: return "swim";
        case MS_SKILL_TIGHT_SPACE: return "tight space";
        case MS_SKILL_LONG_JUMP: return "long jump";
        case MS_SKILL_HIGH_JUMP: return "high jump";
    }
    MSErrorMsg (oPC, "Skill "+IntToString(iSkill)+" was not recognized.");
    return "Unknown Skill";
}

// ****************************************************************************

// MSGetDestination
// Get the destination waypoint matching sDestTag. If waypoint not found, it
// looks for another object with the same tag within MS_MAX_NO_WP_SEARCH_DISTANCE.
//  sDestTag - the tag of the destination waypoint.
//  bKeepLooking - should we look for an object with the same tag if we can't
//                 find the waypoint?
object MSGetDestination(string sDestTag, int bKeepLooking = TRUE);
object MSGetDestination(string sDestTag, int bKeepLooking = TRUE)
{
    object oDest = GetWaypointByTag(sDestTag);
    if ((GetIsObjectValid(oDest)) || (!bKeepLooking))
    {
        return (oDest);
    }
    // Try to find nearest object with the same tag.
    // sDestTag is the tag of the waypoint, so don't use it.
    oDest = GetNearestObjectByTag(GetTag(OBJECT_SELF));
    if (!GetIsObjectValid(oDest))
    {
        // Destination was not found.
        return (OBJECT_INVALID);
    }
    float fDistance = GetDistanceBetween(OBJECT_SELF, oDest);
    if ((fDistance > 0.0) && (fDistance <= MS_MAX_NO_WP_SEARCH_DISTANCE))
    {
        return (oDest);
    }
    // Destination was not found.
    return (OBJECT_INVALID);
}

// ****************************************************************************

// MSGetIsClassSkill
// Returns TRUE if skill nSkill is supposed to be a class skill for class nClass.
//  nSkill - a MS_SKILL_* constant.
//  nClass - a CLASS_TYPE_* constant.
int MSGetIsClassSkill(int nSkill, int nClass);
int MSGetIsClassSkill(int nSkill, int nClass)
{
    switch(nSkill)
    {
        case MS_SKILL_BALANCE:
            switch(nClass)
            {
                case CLASS_TYPE_BARD:
                case CLASS_TYPE_MONK:
                case CLASS_TYPE_ROGUE:
                case CLASS_TYPE_ASSASSIN:
                case CLASS_TYPE_SHADOWDANCER:
                    return TRUE;
            }
            break;
        case MS_SKILL_CLIMB:
            switch(nClass)
            {
                case CLASS_TYPE_BARBARIAN:
                case CLASS_TYPE_BARD:
                case CLASS_TYPE_FIGHTER:
                case CLASS_TYPE_MONK:
                case CLASS_TYPE_RANGER:
                case CLASS_TYPE_ROGUE:
                case CLASS_TYPE_ASSASSIN:
                case CLASS_TYPE_HARPER:
                    return TRUE;
            }
            break;
        case MS_SKILL_JUMP:
        case MS_SKILL_HIGH_JUMP:
        case MS_SKILL_LONG_JUMP:
            switch(nClass)
            {
                case CLASS_TYPE_BARBARIAN:
                case CLASS_TYPE_BARD:
                case CLASS_TYPE_FIGHTER:
                case CLASS_TYPE_MONK:
                case CLASS_TYPE_RANGER:
                case CLASS_TYPE_ROGUE:
                case CLASS_TYPE_ASSASSIN:
                case CLASS_TYPE_HARPER:
                case CLASS_TYPE_SHADOWDANCER:
                    return TRUE;
            }
            break;
        case MS_SKILL_SWIM:
            switch(nClass)
            {
                case CLASS_TYPE_BARBARIAN:
                case CLASS_TYPE_BARD:
                case CLASS_TYPE_DRUID:
                case CLASS_TYPE_FIGHTER:
                case CLASS_TYPE_MONK:
                case CLASS_TYPE_RANGER:
                case CLASS_TYPE_ROGUE:
                case CLASS_TYPE_ASSASSIN:
                case CLASS_TYPE_HARPER:
                    return TRUE;
            }
            break;
        case MS_SKILL_TIGHT_SPACE:
            switch(nClass)
            {
                case CLASS_TYPE_BARD:
                case CLASS_TYPE_MONK:
                case CLASS_TYPE_ROGUE:
                case CLASS_TYPE_ASSASSIN:
                case CLASS_TYPE_HARPER:
                    return TRUE;
            }
            break;
    }
    return FALSE;
}

// ****************************************************************************

// MSGetCreatureSizeModifier
// Returns the creature size modifier based on the size of oPC. NOTE: Bioware
// hasn't fully implemented the CREATURE_SIZE_* constants so this is a reduced
// list.
//  oPC - the player to get the penalty for.
int MSGetCreatureSizeModifier(object oPC);
int MSGetCreatureSizeModifier(object oPC)
{
    switch(GetCreatureSize(oPC))
    {
        case CREATURE_SIZE_TINY: return(2);
        case CREATURE_SIZE_SMALL: return(1);
        case CREATURE_SIZE_MEDIUM: return(0);
        case CREATURE_SIZE_LARGE: return(-1);
        case CREATURE_SIZE_HUGE: return(-2);
    }
    return(0);
}

// ****************************************************************************

// MSGetCreatureSizeVerticalModifier
// Returns the creature size veritical modifier for high jump based on the size
// of oPC. NOTE: Bioware hasn't fully implemented the CREATURE_SIZE_* constants
// so this is a reduced list.
//  oPC - the player to get the penalty for.
int MSGetCreatureSizeVerticalModifier(object oPC);
int MSGetCreatureSizeVerticalModifier(object oPC)
{
    switch(GetCreatureSize(oPC))
    {
        case CREATURE_SIZE_TINY: return(-24);
        case CREATURE_SIZE_SMALL: return(-16);
        case CREATURE_SIZE_MEDIUM: return(0);
        case CREATURE_SIZE_LARGE: return(32);
        case CREATURE_SIZE_HUGE: return(128);
    }
    return(0);
}

// ****************************************************************************

// MSGetBonusRank
// Returns the number the bonus modifier to oPC's skill rank.
//  nSkill - MS_SKILL_* constant.
//  oPC - the PC to get the modifier for.
int MSGetBonusRank(int nSkill, object oPC);
int MSGetBonusRank(int nSkill, object oPC)
{
    int iBonus = 0;
    int iMonkLevel = 0;
    switch(nSkill)
    {
        case MS_SKILL_BALANCE:
            // Ability modifier.
            iBonus = iBonus + GetAbilityModifier(ABILITY_DEXTERITY, oPC);
            // Tumble skill synergy.
            if (GetSkillRank(SKILL_TUMBLE, oPC) >= 5) iBonus = iBonus + 2;
            break;
        case MS_SKILL_CLIMB:
            // Ability modifier.
            iBonus = iBonus + GetAbilityModifier(ABILITY_STRENGTH, oPC);
            break;
        case MS_SKILL_HIGH_JUMP:
            // Height modifier.
            iBonus = iBonus + MSGetCreatureSizeVerticalModifier(oPC);
            // Drop through.
        case MS_SKILL_LONG_JUMP:
            // Racial modifier.
            if (GetRacialType(oPC) == RACIAL_TYPE_HALFLING) iBonus = iBonus + 2;
            // Ability modifier.
            iBonus = iBonus + GetAbilityModifier(ABILITY_STRENGTH, oPC);
            // Tumble skill synergy.
            if (GetSkillRank(SKILL_TUMBLE, oPC) >= 5) iBonus = iBonus + 2;
            // Fast Movement bonus.
            if (GetHasFeat(FEAT_BARBARIAN_ENDURANCE, oPC)) iBonus = iBonus + 1;
            if (GetHasFeat(FEAT_MONK_ENDURANCE, oPC))
            {
                iMonkLevel = GetLevelByClass(CLASS_TYPE_MONK, oPC);
                if ((iMonkLevel >= 3) && (iMonkLevel <= 5)) iBonus = iBonus + 1;
                if ((iMonkLevel >= 6) && (iMonkLevel <= 8)) iBonus = iBonus + 2;
                if ((iMonkLevel >= 9) && (iMonkLevel <= 11)) iBonus = iBonus + 3;
                if ((iMonkLevel >= 12) && (iMonkLevel <= 17)) iBonus = iBonus + 4;
                if (iMonkLevel >= 18) iBonus = iBonus + 5;
            }
            break;
        case MS_SKILL_JUMP:
            // Ability modifier.
            iBonus = iBonus + GetAbilityModifier(ABILITY_STRENGTH, oPC);
            // Tumble skill synergy.
            if (GetSkillRank(SKILL_TUMBLE, oPC) >= 5) iBonus = iBonus + 2;
            // Fast Movement bonus.
            if (GetHasFeat(FEAT_BARBARIAN_ENDURANCE, oPC)) iBonus = iBonus + 1;
            if (GetHasFeat(FEAT_MONK_ENDURANCE, oPC))
            {
                iMonkLevel = GetLevelByClass(CLASS_TYPE_MONK, oPC);
                if ((iMonkLevel >= 3) && (iMonkLevel <= 5)) iBonus = iBonus + 1;
                if ((iMonkLevel >= 6) && (iMonkLevel <= 8)) iBonus = iBonus + 2;
                if ((iMonkLevel >= 9) && (iMonkLevel <= 11)) iBonus = iBonus + 3;
                if ((iMonkLevel >= 12) && (iMonkLevel <= 17)) iBonus = iBonus + 4;
                if (iMonkLevel >= 18) iBonus = iBonus + 5;
            }
            break;
        case MS_SKILL_SWIM:
            // Ability modifier.
            iBonus = iBonus + GetAbilityModifier(ABILITY_STRENGTH, oPC);
            break;
        case MS_SKILL_TIGHT_SPACE:
            // Ability modifier.
            iBonus = iBonus + GetAbilityModifier(ABILITY_DEXTERITY, oPC);
            break;
    }
    return iBonus;
}

// ****************************************************************************

// MSGetArmorCheckPenalty
// Returns a negative penalty based on the players equipped shield and armor.
// Armor check penalty is done by armor weight, as it should be.
//  oPC - the player to get the penalty for.
int MSGetArmorCheckPenalty(object oPC);
int MSGetArmorCheckPenalty(object oPC)
{
    int iPenalty = 0;
    // Check for shield.
    object oItem = GetItemInSlot(INVENTORY_SLOT_LEFTHAND, oPC);
    switch (GetBaseItemType(oItem))
    {
        case BASE_ITEM_SMALLSHIELD:
            iPenalty = iPenalty - 1;
            break;
        case BASE_ITEM_LARGESHIELD:
            iPenalty = iPenalty - 2;
            break;
        case BASE_ITEM_TOWERSHIELD:
            iPenalty = iPenalty - 3;
            break;
    }

    // Check for Armor. Since we can't find the base armor type then calculate the
    // penalty based off of the weight. Kind of cool because this will make
    // weight reduced armor have a lower armor check penalty like it should.
    oItem = GetItemInSlot(INVENTORY_SLOT_CHEST, oPC);
    // GetWeight returns the weight in lb * 10 (to handle fractional weights with an int).
    int iWeight = GetWeight(oItem)/10;
    if ((iWeight >= 15) && (iWeight < 30)) iPenalty = iPenalty - 1;
    if ((iWeight >= 30) && (iWeight < 40)) iPenalty = iPenalty - 2;
    if ((iWeight >= 40) && (iWeight < 45)) iPenalty = iPenalty - 3;
    if ((iWeight >= 45) && (iWeight < 50)) iPenalty = iPenalty - 4;
    if (iWeight >= 50) iPenalty = iPenalty - 5;
    return (iPenalty);
}

// ****************************************************************************

// MSGetEncumbrancePenalty
// Returns a negative penalty based on how encumbered the player is compared
// to their strength.
//  oPC - the player to get the penalty for.
int MSGetEncumbrancePenalty(object oPC);
int MSGetEncumbrancePenalty(object oPC)
{
    int iLight = 0;
    int iMed = 0;
    int iHigh = 0;
    int iStr = GetAbilityScore(oPC, ABILITY_STRENGTH);
    // Get the encumbrance ranges from the SRD Equipment Basics.
    switch(iStr)
    {
        case 0: iLight = 0; iMed = 0; iHigh = 0; break;
        case 1: iLight = 3; iMed = 6; iHigh = 10; break;
        case 2: iLight = 6; iMed = 13; iHigh = 20; break;
        case 3: iLight = 10; iMed = 20; iHigh = 30; break;
        case 4: iLight = 13; iMed = 26; iHigh = 40; break;
        case 5: iLight = 16; iMed = 33; iHigh = 50; break;
        case 6: iLight = 20; iMed = 40; iHigh = 60; break;
        case 7: iLight = 23; iMed = 46; iHigh = 70; break;
        case 8: iLight = 26; iMed = 53; iHigh = 80; break;
        case 9: iLight = 30; iMed = 60; iHigh = 90; break;
        case 10: iLight = 33; iMed = 66; iHigh = 100; break;
        case 11: iLight = 38; iMed = 76; iHigh = 115; break;
        case 12: iLight = 43; iMed = 86; iHigh = 130; break;
        case 13: iLight = 50; iMed = 10; iHigh = 150; break;
        case 14: iLight = 58; iMed = 116; iHigh = 175; break;
        case 15: iLight = 66; iMed = 133; iHigh = 200; break;
        case 16: iLight = 76; iMed = 153; iHigh = 230; break;
        case 17: iLight = 86; iMed = 173; iHigh = 260; break;
        case 18: iLight = 100; iMed = 200; iHigh = 300; break;
        case 19: iLight = 116; iMed = 233; iHigh = 350; break;
        case 20: iLight = 133; iMed = 266; iHigh = 400; break;
        case 21: iLight = 153; iMed = 306; iHigh = 460; break;
        case 22: iLight = 173; iMed = 346; iHigh = 520; break;
        case 23: iLight = 200; iMed = 400; iHigh = 600; break;
        case 24: iLight = 233; iMed = 466; iHigh = 700; break;
        case 25: iLight = 266; iMed = 533; iHigh = 800; break;
        case 26: iLight = 306; iMed = 613; iHigh = 920; break;
        case 27: iLight = 346; iMed = 693; iHigh = 1040; break;
        case 28: iLight = 400; iMed = 800; iHigh = 1200; break;
        case 29: iLight = 466; iMed = 933; iHigh = 1400; break;
        default:
            // Crap you must be giving your character too much wheaties.
            iLight = (iStr-28)*4*466/10;
            iMed = (iStr-28)*4*933/10;
            iHigh = (iStr-28)*4*1400/10;
            break;
   }
   // GetWeight returns the weight in lb * 10 (to handle fractional weights with an int).
   int iEncumbrance = GetWeight(oPC)/10;
   if (iEncumbrance <= iLight) return (0);
   if ((iEncumbrance > iLight) && (iEncumbrance <= iMed)) return (-1);
   if ((iEncumbrance > iMed) && (iEncumbrance <= iHigh)) return (-2);
   // Character is immobolized.
   return (-100);
}

// ****************************************************************************

// MSGetPenalty
// Get all of the appropriate penalties based on the skill being checked.
//  nSkill - a MS_SKILL_* constant.
//  oPC - the player to get the penalty for.
int MSGetPenalty(int nSkill, object oPC);
int MSGetPenalty(int nSkill, object oPC)
{
    int iPenalty = 0;
    switch(nSkill)
    {
        case MS_SKILL_TIGHT_SPACE:
            // Times by 10 since creature size makes such a huge difference.
            // Smaller is better.
            iPenalty = iPenalty + 10*MSGetCreatureSizeModifier(oPC);
            iPenalty = iPenalty + MSGetArmorCheckPenalty(oPC);
            iPenalty = iPenalty + MSGetEncumbrancePenalty(oPC);
            break;
        case MS_SKILL_BALANCE:
        case MS_SKILL_CLIMB:
            iPenalty = iPenalty + MSGetArmorCheckPenalty(oPC);
            iPenalty = iPenalty + MSGetEncumbrancePenalty(oPC);
            break;
        case MS_SKILL_JUMP:
            // Times by 10 since creature size makes such a huge difference.
            // Bigger is better.
            iPenalty = iPenalty - 10*MSGetCreatureSizeModifier(oPC);
            iPenalty = iPenalty + MSGetArmorCheckPenalty(oPC);
            iPenalty = iPenalty + MSGetEncumbrancePenalty(oPC);
            break;
        case MS_SKILL_SWIM:
            // -1 penalty for every 5 lb
            // GetWeight returns the weight in lb * 10 (to handle fractional weights with an int).
            iPenalty = iPenalty - (GetWeight(oPC)/(80));
            break;
    }
    return iPenalty;
}

// ****************************************************************************

// MSGetSkillRank
// Get the complete skill rank (innate, bonuses and penalties) for a player.
//  nSkill - a MS_SKILL_* constant.
//  oPC - the player to get the skill rank for.
int MSGetSkillRank(int nSkill, object oPC);
int MSGetSkillRank(int nSkill, object oPC)
{
    int iRank1 = 0;
    int iRank2 = 0;
    int iRank3 = 0;
    int iBonus = MSGetBonusRank(nSkill, oPC);
    int iPenalty = MSGetPenalty(nSkill, oPC);
    // Did their first class have the skill as a class skill?
    if (MSGetIsClassSkill(nSkill, GetClassByPosition(1, oPC))) iRank1 = 4 + GetLevelByPosition(1, oPC);
    else iRank1 = 2 + (GetLevelByPosition(1, oPC)/2);
    if (MSGetIsClassSkill(nSkill, GetClassByPosition(2, oPC))) iRank2 = GetLevelByPosition(2, oPC);
    else iRank2 = (GetLevelByPosition(2, oPC)/2);
    if (MSGetIsClassSkill(nSkill, GetClassByPosition(3, oPC))) iRank3 = GetLevelByPosition(3, oPC);
    else iRank3 = (GetLevelByPosition(3, oPC)/2);
    string sMsg = GetName(oPC)+" "+MSGetSkillName(oPC, nSkill)+" modifier for "+MSGetSkillName(oPC, nSkill)+" is "+IntToString(iRank1)+"+"+IntToString(iRank2)+"+"+IntToString(iRank3)+"+Modifier("+IntToString(iBonus)+")+Penalty("+IntToString(iPenalty)+")";
    if (MS_MOVEMENT_SKILL_PERCENTAGE != 100) sMsg = sMsg + " Free class ranks are modified by "+IntToString(MS_MOVEMENT_SKILL_PERCENTAGE)+"%";
    if (MS_DEBUG) AssignCommand(oPC, ActionSpeakString(sMsg));
    return ((MS_MOVEMENT_SKILL_PERCENTAGE * (iRank1+iRank2+iRank3)/100)+iBonus+iPenalty);
}

// ****************************************************************************

// MSGetDifficultyLevel
// Returns a string representing the challenge of the DC based on how high a PC
// needs to roll to succeed the check.
//  iRank - the player's total rank.
//  iDC - the DC of the check.
string MSGetDifficultyLevel(int iRank, int iDC);
string MSGetDifficultyLevel(int iRank, int iDC)
{
    if (iRank >= iDC) return "a certain";
    if (iRank+6 >= iDC) return "an easy";
    if (iRank+13 >= iDC) return "an average";
    if (iRank+20 >= iDC) return "a hard";
    return "an impossible";
}

// ****************************************************************************

// MSGetAngleBetween
// Returns a string representing the cardinal direction between the player
// and a destination in the distance.
//  oDestination - destination in the distance.
//  oPC - source object.
string MSGetAngleBetween(object oDestination, object oPC);
string MSGetAngleBetween(object oDestination, object oPC)
{
    float fAngle = VectorToAngle(GetPosition(oDestination) - GetPosition(oPC));
    AssignCommand(oPC, SetFacing(fAngle));
    switch (FloatToInt(fAngle / 45))
    {
        // 0 degrees
        case 0: return "west";
        // 45 degrees
        case 1: return "north west";
        // 90 degrees
        case 2: return "north";
        // 135 degrees
        case 3: return "north east";
        // 180 degrees
        case 4: return "east";
        // 225 degrees
        case 5: return "south east";
        // 270 degrees
        case 6: return "south";
        // 315 degrees
        case 7: return "south west";
        // 360 degrees
        case 8: return "west";
    }
    return "";
}

// ****************************************************************************

// MSGetDamage
// Calculate how much damage should be applied for a critical failure (fail by
// more than 5). This function handles the Tumble skill save and subdual damage.
//  iSkill - a MS_SKILL_* constant.
//  iMaxDmg - damage rolled will be between 0 and this value.
//  oPC - player to roll the damage for.
int MSGetDamage(int iSkill, int iMaxDmg, object oPC);
int MSGetDamage(int iSkill, int iMaxDmg, object oPC)
{
    int iDmg = Random(iMaxDmg+1);
    if (MS_DEBUG) SendMessageToPC(oPC, "Rolled "+IntToString(iDmg)+" for damage.");
    // Did they luck out?
    if (iDmg == 0) return 0;
    switch (iSkill)
    {
        // Tumble check for reduced damage
        case MS_SKILL_BALANCE:
        case MS_SKILL_CLIMB:
        case MS_SKILL_JUMP:
            if ((MS_TUMBLE_SAVE_REDUCTION_PERCENTAGE > 0) &&
            (GetIsSkillSuccessful(oPC, SKILL_TUMBLE, 15))) iDmg = MS_TUMBLE_SAVE_REDUCTION_PERCENTAGE * iDmg / 100;
            break;
        // Damage cannot kill
        case MS_SKILL_SWIM:
        case MS_SKILL_TIGHT_SPACE:
            int iHP = GetCurrentHitPoints(oPC);
            if (iDmg >= iHP) iDmg = iHP - 1;
            break;
    }
    if (MS_DEBUG) SendMessageToPC(oPC, "Taking "+IntToString(iDmg)+" damage.");
    return iDmg;
}

// ****************************************************************************

// MSDoFalldown
// This animation and sound sequence is played when a character fails a check.
void MSDoFalldown();
void MSDoFalldown()
{
    int iVoice = VOICE_CHAT_CANTDO;
    switch (Random(8))
    {
        case 0: iVoice = VOICE_CHAT_BADIDEA; break;
        case 1: iVoice = VOICE_CHAT_CANTDO; break;
        case 2: iVoice = VOICE_CHAT_CUSS; break;
        case 3: iVoice = VOICE_CHAT_LAUGH; break;
        case 4: iVoice = VOICE_CHAT_NO; break;
        case 5: iVoice = VOICE_CHAT_PAIN1; break;
        case 6: iVoice = VOICE_CHAT_PAIN2; break;
        case 7: iVoice = VOICE_CHAT_PAIN3; break;
    }
    PlayVoiceChat(iVoice);
    if (Random(2)) PlayAnimation(ANIMATION_LOOPING_DEAD_BACK, 1.0, 5.0);
    else PlayAnimation(ANIMATION_LOOPING_DEAD_FRONT, 1.0, 5.0);
}

// ****************************************************************************

// MSDoMovementAction
// These are the separate animation and sound sequences that are played when
// a player performs a movement skill.
//  iSkill - a MS_SKILL_* constant.
//  oDest - the destination object to move to.
//  bFall - if true, then it will also play the MSDoFalldown() sequence.
void MSDoMovementAction(int iSkill, object oDest, int bFall);
void MSDoMovementAction(int iSkill, object oDest, int bFall)
{
    SetFacing(VectorToAngle(GetPosition(oDest) - GetPosition(OBJECT_SELF)));
    switch (iSkill)
    {
        case MS_SKILL_BALANCE:
            DelayCommand(1.0, ActionJumpToObject(oDest, TRUE));
            if (bFall) DelayCommand(1.1, MSDoFalldown());
            DelayCommand(0.1, PlaySound("fs_dirt_soft1"));
            DelayCommand(0.5, PlaySound("fs_dirt_soft2"));
            DelayCommand(1.0, PlaySound("fs_dirt_soft3"));
            PlayAnimation(ANIMATION_FIREFORGET_DODGE_SIDE);
            break;
        case MS_SKILL_CLIMB:
            DelayCommand(1.0, ActionJumpToObject(oDest, TRUE));
            if (bFall) DelayCommand(1.1, MSDoFalldown());
            DelayCommand(0.1, PlaySound("fs_dirt_hard1"));
            DelayCommand(0.5, PlaySound("fs_dirt_hard2"));
            DelayCommand(1.0, PlaySound("fs_dirt_hard3"));
            PlayAnimation(ANIMATION_LOOPING_TALK_FORCEFUL);
            break;
        case MS_SKILL_JUMP:
            DelayCommand(0.3, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectDisappearAppear(GetLocation(oDest)), OBJECT_SELF, 3.0));
            if (bFall) DelayCommand(6.0, MSDoFalldown());
            PlaySound("as_cv_florcreak3");
            break;
        case MS_SKILL_LONG_JUMP:
        case MS_SKILL_HIGH_JUMP:
            DelayCommand(0.3, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectDisappearAppear(GetLocation(oDest)), OBJECT_SELF, 3.0));
            if (bFall) DelayCommand(6.0, MSDoFalldown());
            PlaySound("as_cv_florcreak3");
            break;
        case MS_SKILL_SWIM:
            DelayCommand(0.3, PlaySound("as_na_surf2"));
            DelayCommand(0.3, PlayAnimation(ANIMATION_LOOPING_WORSHIP));
            DelayCommand(1.3, ActionJumpToObject(oDest, TRUE));
            if (bFall) DelayCommand(1.4, MSDoFalldown());



            break;
        case MS_SKILL_TIGHT_SPACE:
            DelayCommand(1.0, ActionJumpToObject(oDest, TRUE));
            if (bFall) DelayCommand(1.1, MSDoFalldown());
            PlaySound("as_cv_brickscrp1");
            PlayAnimation(ANIMATION_LOOPING_GET_LOW);
            break;
    }
}

// ****************************************************************************
// MAIN
// ****************************************************************************

// Main program.

void main()
{
    // Get the person who activated the object.
    object oPC = GetLastUsedBy();
    if (GetObjectType(OBJECT_SELF) == OBJECT_TYPE_TRIGGER)
    {
        // Different function to run if this is on a trigger.
        oPC = GetClickingObject();
    }
    // Sanity check.
    if (!GetIsObjectValid(oPC)) return;

    // Keep players from spamming the object. The object can only be used once
    // a turn (6 seconds)
    if(GetLocalInt(OBJECT_SELF, GetPCPlayerName(oPC)+"USING") > 0)
    {
        FloatingTextStringOnCreature("Can only make one attempt per round (6 seconds).", oPC, FALSE);
        return;
    }
    if(GetLocalInt(OBJECT_SELF, GetPCPlayerName(oPC)) > 0)
    {
        // Set up the spam protection.
        DelayCommand(6.0, DeleteLocalInt(OBJECT_SELF, GetPCPlayerName(oPC)+"USING"));
        SetLocalInt(OBJECT_SELF, GetPCPlayerName(oPC)+"USING", 1);
    }

    // Read the data from the tag.
    string sTag = GetTag(OBJECT_SELF);
    int iSkill = StringToInt(MSStrTok(sTag, MS_POSITION_SKILL_TYPE));
    int iDC = StringToInt(MSStrTok(sTag, MS_POSITION_DC));
    string sDestTag =  MSStrTok(sTag, MS_POSITION_DEST_TAG);
    int iMaxDmg = StringToInt(MSStrTok(sTag, MS_POSITION_MAX_DMG));

    // See if the destination exists.
    object oDest = MSGetDestination(sDestTag);
    if (!GetIsObjectValid(oDest))
    {
        MSErrorMsg (oPC, "Destination could not be found.");
        return;
    }

    // Get some more data.
    string sSkillName = MSGetSkillName(oPC, iSkill);
    int iRank = MSGetSkillRank(iSkill, oPC);
    string sDifficulty = MSGetDifficultyLevel(iRank, iDC);

    // Has the PC clicked the trigger recently?
    if (GetLocalInt(OBJECT_SELF, GetPCPlayerName(oPC)) == 0)
    {
        // Next time they click the movement will be activate.
        DelayCommand(MS_CLICK_TIMEOUT_SEC, DeleteLocalInt(OBJECT_SELF, GetPCPlayerName(oPC)));
        SetLocalInt(OBJECT_SELF, GetPCPlayerName(oPC), 1);
        // Has not been used recently, so give player info.
        // OBJECT_SELF's name is the description to show the player.
        FloatingTextStringOnCreature(GetName(OBJECT_SELF)+"\nIt looks like "+sDifficulty+" "+sSkillName+" heading "+MSGetAngleBetween(oDest, oPC)+". *CLICK AGAIN TO MOVE*", oPC, FALSE);
        return;
    }

    // Keep track of how many times they have clicked. This is used for "take 20" rules.
    // 1st try: iClick = 0. 2nd try: iClick = 1. 3rd try: iClick = 2.
    int iClick = GetLocalInt(OBJECT_SELF, GetPCPlayerName(oPC)+"CLICK");
    SetLocalInt(OBJECT_SELF, GetPCPlayerName(oPC)+"CLICK", iClick+1);
    if (iClick == 0) DelayCommand(MS_CLICK_TIMEOUT_SEC, DeleteLocalInt(OBJECT_SELF, GetPCPlayerName(oPC)+"CLICK"));

    // The PC has clicked the trigger recently so perform the skill check since they obviously want to perform the action.
    int iRoll = d20();
    if (GetIsDM(oPC)) iRoll = 127; // DMs always move for free.

    // Only allow players to take 20 if they are out of combat and they could
    // not be damaged by the task.
    if ((iMaxDmg == 0) && (iClick > 0) && (!GetIsInCombat(oPC)))
    {
        // Take 10.
        if ((iClick == 1) && (iRoll < 10)) iRoll = 10;
        // Take 20.
        if (iClick > 1) iRoll = 20;
    }

    string sRoll = IntToString(iRoll)+"+"+IntToString(iRank)+"="+IntToString(iRank+iRoll)+" vs DC="+IntToString(iDC);

    // Special handling of the 3.5 jump skill.
    if ((iSkill == MS_SKILL_LONG_JUMP) || (iSkill == MS_SKILL_HIGH_JUMP))
    {
        if (
            ((iRank + iRoll) < iDC) &&
            ((iRank + iRoll + 5) >= iDC)
        )
        {
            if (ReflexSave(oPC, 15) == 1)
            {
                AssignCommand(oPC, ActionSpeakString("*MANAGED TO GRAB THE EDGE*"));
                iRoll = iRoll + 5;
            }
        }
        // Should the player fall prone?
        if (
            ((iRank + iRoll) >= iDC) &&
            ((iRank + iRoll) < (iDC + 5))
            )
        {
            // Success, but fall prone.
            // Perform animations.
            AssignCommand(oPC, MSDoMovementAction(iSkill, oDest, TRUE));
            // Let the player know what they rolled.
            FloatingTextStringOnCreature("*"+GetStringUpperCase(sSkillName)+" BARELY SUCCEEDED* "+sRoll, oPC, FALSE);
            // Make the nearby people aware of the result. In playtesting the players liked this feature.
            if(!GetIsDM(oPC)) AssignCommand(oPC, ActionSpeakString("*BARELY SUCCEEDED* on "+sDifficulty+" "+sSkillName));
            return;
        }
    }

    // SUCCESS
    if ((iRank + iRoll) >= iDC)
    {
        // Perform animations.
        AssignCommand(oPC, MSDoMovementAction(iSkill, oDest, FALSE));
        // Let the player know what they rolled.
        FloatingTextStringOnCreature("*"+GetStringUpperCase(sSkillName)+" SUCCESS* "+sRoll, oPC, FALSE);
        // Make the nearby people aware of the result. In playtesting the players liked this feature.
        if(!GetIsDM(oPC)) AssignCommand(oPC, ActionSpeakString("*SUCCESS* on "+sDifficulty+" "+sSkillName));
        return;
    }
    // FAILURE
    if ((iRank + iRoll + 5) >= iDC)
    {
        // Perform animations and look for a destination.
        object oFailDest = MSGetDestination(sDestTag+"F", FALSE);
        if (GetIsObjectValid(oFailDest)) AssignCommand(oPC, MSDoMovementAction(iSkill, oFailDest, TRUE));
        else AssignCommand(oPC, MSDoFalldown());
        // Let the player know what they rolled.
        FloatingTextStringOnCreature("*"+GetStringUpperCase(sSkillName)+" FAILURE* "+sRoll, oPC, FALSE);
        // Make the nearby people aware of the result. In playtesting the players liked this feature.
        AssignCommand(oPC, ActionSpeakString("*FAILURE* on "+sDifficulty+" "+sSkillName));
        return;
    }
    // CRITICAL FAILURE

    // Perform animations and look for a destination.
    object oFailDest = MSGetDestination(sDestTag+"F", FALSE);
    if (GetIsObjectValid(oFailDest)) AssignCommand(oPC, MSDoMovementAction(iSkill, oFailDest, TRUE));
    else AssignCommand(oPC, MSDoFalldown());
    // This is a critical failure so the player will take damage.
    int iDmg = MSGetDamage(iSkill, iMaxDmg, oPC);
    if (iDmg > 0) AssignCommand(oPC, ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectDamage(iDmg, DAMAGE_TYPE_MAGICAL, DAMAGE_POWER_PLUS_FIVE), oPC));
    // Let the player know what they rolled.
    FloatingTextStringOnCreature("*"+GetStringUpperCase(sSkillName)+" CRITICAL FAILURE* "+sRoll+". Took "+IntToString(iDmg)+" damage.", oPC, FALSE);
        // Make the nearby people aware of the result. In playtesting the players liked this feature.
    AssignCommand(oPC, ActionSpeakString("*CRITICAL FAILURE* on "+sDifficulty+" "+sSkillName));
    return;
}


