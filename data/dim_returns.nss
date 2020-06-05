//
//  dim_returns
//
//  Provide diminishing returns experience factor
//
//  (c) Cereborn, 2002
//
//
// Modifications and additions to the ALFA XP system which provides diminishing
// returnson XP awarded to characters who kill creatures from spawns/encounters
// that they have killedp reviously.
//
// History:
//   12/01/02 Cereborn       created (in sei_xp)
//   12/03/02 Cereborn       bug fix; strip loot from creature when no XP awarded
//                           changed touse fSpawnNumberMax instead of
//                           fSpawnNumber, to eliminate kill allowance
//                           fluctuation with NESS
//   01/01/03 Cereborn       added suppression flag; moved to this file
//   01/10/03 Cereborn       added XP_GetDimReturnsQuestXPFactor()
//   08/20/03 Cereborn       merged Albereth's mods for persistence
//
//

#include "alfa_persist"

// Constants from sei_xp
// General experience scale slider (also includes monster xp scale).
float ADVANCE_XP_SCALE= 0.2;

// Monster experience scale slider.
float MONSTER_XP_SCALE = 0.2;

// Forward declarations

// When nDebug is true, creature speaks this
void speakDebug(string sOut);

// When nDebug is true, this is logged
void logDebug(string sOut);

// Gets and increments the Killer's kill count
int XP_GetAndUpdateKillCount(object oRecordKeeper, object oAwardee);

// Gets and increments the Quest Awardee's award count
int XP_GetAndUpdateQuestAwardCount(object oRecordKeeper, object oAwardee,
    string sAwardType, int nParty, int nAwardId=0);

// Ripped from ALFA boards.  Posted by Modal.  If killer gets no XP, these
// are used to also strip all loot
void DestroyInventory(object oTarget);
void DestroyEquipped(object oTarget, int nDestroyCItems=TRUE);

// Set this to TRUE to get debug speakStrings and log entries
int nDebug = FALSE;

// Spawns and encounters are tagged with a variable for each character
// that indicates how many kills that character has made at that spawn.
// The variable for a character is made from 'sAwardVarPrefix' + either
// XP_KILLS_TYPE or XP_QUEST_TYPE + the award id (or '0' if none) + the
// character's name and CD Key
string sAwardVarPrefix = "DimRet";
const string XP_KILLS_TYPE = "Kills";
const string XP_QUEST_TYPE = "Quests";

// ** ** **
// These are the names of variables used in NESS!  They must match for this
// to work.  The same names are used by the onEnter/onHeartbeat scripts for
// BW encounters to keep everything consistent.  If the names used by NESS
// change, then the rest must be modified as well.
// If it's decided that diminishing returns XP is the way we're going to go,
// we can get at least get these into alfa_include so they're not in 3
// places.

// This is the name of the variable used to save the spawn object onto the
// spawned creature
string sParentSpawnVarName = "ParentSpawn";

// This is the name of the variable used to save the number of creatures
// created by the sapwn/encounter.  For now, it is being used as the 'kill
// allowance' for the spawn
string sSpawnCountVarName = "f_SpawnNumberMax";

// This is the name of the variable set by NESS when the SX flag is used. It
// suppresses diminishing returns if set to non-zero
string sSuppressFlagName = "f_SuppressDimReturns";

// XP values are currently multiplied by this number before being returned.
// Use this to adjust the overall XP given out by the system.
float XP_TUNING_SCALE = 1.0;
float QUEST_XP_TUNING_SCALE = 1.0;
//
// Function:
//   XP_GetDimReturnsXPFactor(object oKiller)
//
//  XP_GetDimReturnsXPFactor() returns an XP scale factor based on the
//  largest number of kills by any member of oKiller's party, and a 'kill
//  allowance' which is tagged to the spawn or encounter itself.  The current
//  implementation does not specify this kill allowance explicitly - it is
//  assumed to be the number of creatures in the spawn.  Current XP scale
//  factor is determined as follows:
//
// 1 to                      kill allowance           5%
// kill allowance + 1 to 3 * kill allowance           4%
// 3  * kill allowance + 1 to  6 * kill allowance     3%
// 7  * kill allowance + 1 to 10 * kill allowance     2%
// 11 * kill allowance + 1 and up                     1%
//
// For example, a spawn or encounter spawns 4 creatures.  Then a player (or
// party) will get 5% of standard XP for the first 4 kills, then 4% for the
// next 8, 3% for the next 12, 2% for the next 16, and 1% from then on
//
// Note that these values are then multiplied by XP_TUNING_SCALE (which is
// currently 1.0) before being returned.  Therefore the overall XP profile
// can easily be adjusted.
//
// Subsequent versions may allow the 'kill allowance' to be set explicitly
// via a NESS spawn flag or encounter name.
//
float XP_GetDimReturnsXPFactor(object oPartyMember)
{
    float fFactor;

    // idiot check
    if (GetIsDM(oPartyMember))
    {
        // Return old ALFA xp scale factor
        return MONSTER_XP_SCALE * XP_TUNING_SCALE;
    }

    // Find the PC killer to whom this kill is credited, whether PC,
    // familiar, summonned, or trap

    // None of this should be needed anymore.  We call this with each faction member
    // of the 'killer', which does the right thing even if killer is a trap, familiar.
    // etc.

/*
    object oKiller = XP_FindTrueKiller( oLastDamager );

    if (!GetIsObjectValid(oKiller))
    {
        logDebug("killed by NPC");
        return 0.0;
    }
*/


    // If we get here, oKiller should be a player... 

    // Get spawn object - placed on the creature by NESS on creation or by
    // the onEnter or heartbeat event of a BW encounter.  The object therefore
    // may be a waypoint or an encounter, but we don't care which.  It's a place
    // to hang data
    object oSpawn = GetLocalObject(OBJECT_SELF, sParentSpawnVarName);

    if(oSpawn == OBJECT_INVALID)
    {
        // log this for testing, but this is the normal behavior for an object
        // that was created statically instead of spawned
        logDebug("No spawn object for creature " + GetName(OBJECT_SELF));

        // You're getting the old 4%, it would appear
        return MONSTER_XP_SCALE * XP_TUNING_SCALE;
    }

    // Look for Diminishing Returns suppression flag.  Only NESS is currently
    // capable of setting this flag
    int nSuppress = GetLocalInt(oSpawn, sSuppressFlagName);
    if (nSuppress)
    {
        //  for testing
        speakDebug("Dim returns suppressed for " + GetName(oSpawn));

        // You're getting the old 4%
        return MONSTER_XP_SCALE * XP_TUNING_SCALE;
    }

    // Get largest number of times any party member has killed at this spawn,
    // and update the number of kills for all party members
    int nNumKills = XP_GetAndUpdateKillCount(oSpawn, oPartyMember);

    // Get the number of kills allowed before XP starts to diminish - in a later
    // version, this can be a flag added to NESS, or picked up from a BW
    // encounter name (a la NESS) - For now, it the number of creatures spawned
    // for NESS, and whatever the BW onEnter script sets for BW encounters
    int nNumKillsAllowed = GetLocalInt(oSpawn, sSpawnCountVarName);

    if (nNumKillsAllowed == 0)
    {
        logDebug("No SpawnCount on spawn " + GetName(oSpawn));

        // Provide a reasonable default if tagging fails for some reason
        // (like killing a creature before a BW encounter can get around
        // to tagging it - this shouldn't ever happen for NESS spawns, and should
        // be at least very infrequent for BW encounters).
        nNumKillsAllowed = 5;
    }

    speakDebug("Kills = " + IntToString(nNumKills) + " Allowed = " +
       IntToString(nNumKillsAllowed));

    // int nDropLoot = TRUE;

    // calculate the XP factor...
    int nKillNum =((nNumKills-1) / nNumKillsAllowed);
    switch (nKillNum)
    {
    case 0:
        // .25
        logDebug("Case 0: " + IntToString(nKillNum));
        fFactor = 0.05 / ADVANCE_XP_SCALE;
        break;
    case 1:
    case 2:
        // .20
        logDebug("Case 1-2: " + IntToString(nKillNum));
        fFactor = 0.04 / ADVANCE_XP_SCALE;
        break;
    case 3:
    case 4:
    case 5:
        // .15
        logDebug("Case 3-5: " + IntToString(nKillNum));
        fFactor = 0.03 / ADVANCE_XP_SCALE;
        break;
    case 6:
    case 7:
    case 8:
    case 9:
        // .10
        logDebug("Case 6-9: " + IntToString(nKillNum));
        fFactor = 0.02 / ADVANCE_XP_SCALE;
        break;
    case 10:
    case 11:
    case 12:
    case 13:
    case 14:
        // .05
        logDebug("Case 10-14: " + IntToString(nKillNum));
        fFactor = 0.01 / ADVANCE_XP_SCALE;
        break;
    default:
        // .00
        logDebug("Default: " + IntToString(nKillNum));
        fFactor = 0.00;
        // nDropLoot = FALSE;
        break;
    }

    speakDebug(" XP factor = " + FloatToString(fFactor * ADVANCE_XP_SCALE));

/* This is now handled in sei_xp, and only happens if no one in the group gets XP
    if (! nDropLoot)
    {
        // strip all loot from the creature
        DestroyInventory(OBJECT_SELF);
        DestroyEquipped(OBJECT_SELF);
    }
*/

    return fFactor * XP_TUNING_SCALE;
}

//
// Function:
//   XP_GetDimReturnsXPFactor(object oKiller)
//
//  XP_GetDimReturnsQuestXPFactor() returns an XP scale factor based on the
//  largest number of times the quest has been completed by either the quester
//  or by any member of quester's party (controlled by the nParty flag).  A
//  factor of 1. is returned if the number of quest completions is <= the number
//  of times specified by the nFullXPAllowed parameter, otherwise a number
//  between 0. and 1. based on the number of times the quest may be completed
//  for diminished XP (indicated by the nDimXPAllowed parameter).  An optional
//  ID may be specified to allow a single record keeper to maintain info about
//  multiple quests.
//
float XP_GetDimReturnsQuestXPFactor(object oQuester, object oRecordKeeper,
   int nFullXPAllowed, int nDimXPAllowed, int nParty, int nAwardID=0)
{
    float fFactor;

    if (oRecordKeeper == OBJECT_INVALID)
    {
        return QUEST_XP_TUNING_SCALE;
    }

    int nNumQuests = XP_GetAndUpdateQuestAwardCount(oRecordKeeper, oQuester,
       XP_QUEST_TYPE, nParty, nAwardID);

    if (nNumQuests <= nFullXPAllowed)
    {
        return QUEST_XP_TUNING_SCALE;
    }

    nNumQuests -= nFullXPAllowed;

    // calculate the XP factor...
    if (nNumQuests > nDimXPAllowed)
    {
        fFactor = 0.0;
    }

    else
    {
        fFactor = 1. - (IntToFloat(nNumQuests) / IntToFloat(nDimXPAllowed+1));
    }
    speakDebug("Quest XP factor = " + FloatToString(fFactor));

    return fFactor * QUEST_XP_TUNING_SCALE;
}


int XP_GetAndUpdateKillCount(object oRecordKeeper, object oAwardee)
{
    string sCharName;
    string sCharCDKey;
    string sCharID;
    string sSpawnID;
    string sAwardVarName;
    int nResultNumAwards = 0;


    // Create a character id
    //sCharName = GetName(oAwardee);
    //sCharCDKey = GetPCPublicCDKey(oAwardee);
    //sCharID = sCharName + sCharCDKey;
    sSpawnID = "SID" + IntToString(GetLocalInt(oRecordKeeper, "SpawnID"));
    sAwardVarName = sAwardVarPrefix + XP_KILLS_TYPE + IntToString(0) + 
       sSpawnID; //sCharID;

    //int nNumAwards = GetLocalInt(oRecordKeeper, sAwardVarName);
    int nNumAwards = ALFA_GetPersistentInt("WK_DIMRET_VARS", sAwardVarName, 
       oAwardee);

    //SetLocalInt(oRecordKeeper, sAwardVarName, ++nNumAwards);
    ALFA_SetPersistentInt("WK_DIMRET_VARS", sAwardVarName, ++nNumAwards, oAwardee);
    nResultNumAwards = nNumAwards;

    speakDebug("Award count is " + IntToString(nResultNumAwards));
    return nResultNumAwards;
}

//
// Function:
//  XP_GetAndUpdateQuestAwardCount(object oRecordKeeper, object oAwardee,
//    string sAwardType, int nParty)
//

int XP_GetAndUpdateQuestAwardCount(object oRecordKeeper, object oAwardee,
    string sAwardType, int nParty, int nAwardID=0)
{
    string sCharName;
    string sCharCDKey;
    string sCharID;
    string sAwardVarName;
    int nResultNumAwards = 0;

    if (nParty)
    {
        object oAwardArea = GetArea(oAwardee);
        object oPC = GetFirstFactionMember(oAwardee);

        // Loop through members of the party that are in the same area as the
        // awardee
        while(GetIsObjectValid(oPC))
        {
            if(!GetIsDM(oPC) && (oAwardArea == GetArea(oPC)))
            {
                // Create a character id
                sCharName = GetName(oPC);
                sCharCDKey = GetPCPublicCDKey(oPC);
                sCharID = sCharName + sCharCDKey;
                sAwardVarName = sAwardVarPrefix + sAwardType +
                   IntToString(nAwardID) + sCharID;

                int nNumAwards = GetLocalInt(oRecordKeeper, sAwardVarName);

                // update character's award count
                SetLocalInt(oRecordKeeper, sAwardVarName, ++nNumAwards);

                // Poor-man's max() function. nResultNumAwards holds the largest
                // award count by any party member
                if (nNumAwards > nResultNumAwards)
                {
                    nResultNumAwards = nNumAwards;
                }
            }

            oPC = GetNextFactionMember(oAwardee, TRUE);
        } // End while
    }

    else
    {
        // Create a character id
        sCharName = GetName(oAwardee);
        sCharCDKey = GetPCPublicCDKey(oAwardee);
        sCharID = sCharName + sCharCDKey;
        sAwardVarName = sAwardVarPrefix + sAwardType + IntToString(nAwardID)
           + sCharID;

        int nNumAwards = GetLocalInt(oRecordKeeper, sAwardVarName);
        SetLocalInt(oRecordKeeper, sAwardVarName, ++nNumAwards);
        nResultNumAwards = nNumAwards;
    }
    speakDebug("Award count is " + IntToString(nResultNumAwards));
    return nResultNumAwards;
}

// Debug utility functions
//
void speakDebug(string sOut)
{
    if (nDebug) SpeakString(sOut);
}

void logDebug(string sOut)
{
    if (nDebug) WriteTimestampedLogEntry(sOut);
}

// Inventory-clearing functions posted on boards by Modal :)
/*
 * void DestroyInventory()
 * ---
 * Nuke a creature's inventory.
 */
void DestroyInventory( object oTarget )
{
    object oItem;

    oItem = GetFirstItemInInventory( oTarget );

    while ( oItem != OBJECT_INVALID )
    {
        DestroyObject( oItem );
        oItem = GetNextItemInInventory( oTarget );
    }
}
/*
 * void DestroyEquipped()
 * ---
 * Destroy ALL equipped items on a creature,
 * with the option of not including Creature Hide/Attack
 * slots.
 */
void DestroyEquipped( object oTarget, int nDestroyCItems=TRUE )
{
    object oItem;
    int nSlot;

    for ( nSlot = 0; nSlot <= INVENTORY_SLOT_CARMOUR; nSlot++ )
    {
        if ( nSlot == INVENTORY_SLOT_CARMOUR   ||
             nSlot == INVENTORY_SLOT_CWEAPON_B ||
             nSlot == INVENTORY_SLOT_CWEAPON_L ||
             nSlot == INVENTORY_SLOT_CWEAPON_R )
        {
            if ( nDestroyCItems == TRUE
                && (oItem = GetItemInSlot( nSlot, oTarget )) != OBJECT_INVALID )
            {
                DestroyObject( oItem );
            }
        }
        else if ( (oItem = GetItemInSlot( nSlot, oTarget )) != OBJECT_INVALID )
        {
            DestroyObject( oItem );
        }
    }
}


//
// Deprecated code.  Kept around until we're sure we won't go back to it...
//
//
//


// This form looks at the killer's party and uses the party member with the
// most kills.  This form is no longer used.
int XP_GetAndUpdatePartyKillCount(object oRecordKeeper, object oAwardee,
    string sAwardType, int nParty, int nAwardId=0);

// Given the last damager, find the killer (deals with traps, familiars, summoned, 
// etc.)
object XP_FindTrueKiller(object oLastDamager);

//
// Function:
//  XP_GetAndUpdatePartyKillCount(object oRecordKeeper, object oAwardee,
//    string sAwardType, int nParty)
//
// XP_GetAndUpdatePartyKillCount() returns the largest number of kills at the
// specified spawn made by any party member of oKiller that is in the area
// of the killed object.  It also increments the kill count at this spawn for
// each party member in the area.
//
//
//  Note: This is no longer used.  Each party member is treated seperately for 
//  dim_returns, so this function has been replaced by XP_GetAndUpdateKillCount()
int XP_GetAndUpdatePartyKillCount(object oRecordKeeper, object oAwardee,
    string sAwardType, int nParty, int nAwardID=0)
{
    string sCharName;
    string sCharCDKey;
    string sCharID;
    string sSpawnID;
    string sAwardVarName;
    int nResultNumAwards = 0;

    if (nParty)
    {
        object oAwardArea = GetArea(oAwardee);
        object oPC = GetFirstFactionMember(oAwardee);

        // Loop through members of the party that are in the same area as the
        // awardee
        while(GetIsObjectValid(oPC))
        {
            if(!GetIsDM(oPC) && (oAwardArea == GetArea(oPC)))
            {
                // Create a character id
                //sCharName = GetName(oPC);
                //sCharCDKey = GetPCPublicCDKey(oPC);
                //sCharID = sCharName + sCharCDKey;
                sSpawnID = "SID" + IntToString(GetLocalInt(oRecordKeeper, "SpawnID"));
                sAwardVarName = sAwardVarPrefix + sAwardType + IntToString(nAwardID) + sSpawnID; //sCharID;

                //int nNumAwards = GetLocalInt(oRecordKeeper, sAwardVarName);
                int nNumAwards = ALFA_GetPersistentInt("WK_DIMRET_VARS", sAwardVarName,
                   oPC);

                // update character's award count
                //SetLocalInt(oRecordKeeper, sAwardVarName, ++nNumAwards);
                ALFA_SetPersistentInt("WK_DIMRET_VARS", sAwardVarName, ++nNumAwards, 
                   oPC);

                // Poor-man's max() function. nResultNumAwards holds the largest
                // award count by any party member
                if (nNumAwards > nResultNumAwards)
                {
                    nResultNumAwards = nNumAwards;
                }
            }

            oPC = GetNextFactionMember(oAwardee, TRUE);
        } // End while
    }

    else
    {
        // Create a character id
        //sCharName = GetName(oAwardee);
        //sCharCDKey = GetPCPublicCDKey(oAwardee);
        //sCharID = sCharName + sCharCDKey;
        sSpawnID = "SID" + IntToString(GetLocalInt(oRecordKeeper, "SpawnID"));
        sAwardVarName = sAwardVarPrefix + sAwardType + IntToString(nAwardID) + sSpawnID; //sCharID;

        //int nNumAwards = GetLocalInt(oRecordKeeper, sAwardVarName);
        int nNumAwards = ALFA_GetPersistentInt("WK_DIMRET_VARS", sAwardVarName, 
           oAwardee);

        //SetLocalInt(oRecordKeeper, sAwardVarName, ++nNumAwards);
        ALFA_SetPersistentInt("WK_DIMRET_VARS", sAwardVarName, ++nNumAwards, oAwardee);
        nResultNumAwards = nNumAwards;
    }
    speakDebug("Award count is " + IntToString(nResultNumAwards));
    return nResultNumAwards;
}


// Still need to check for AreaOfEffect
//
// Note: No longer used...
//
object XP_FindTrueKiller( object oLastDamager )
{
    object oKiller = OBJECT_INVALID;
    object oMaster;
    object oTrapSetter;
    
    if (GetIsPC(oLastDamager))
    {
        oKiller = oLastDamager;
    }

    else
    {
        oMaster = GetMaster(oLastDamager);
        if (GetIsObjectValid(oMaster))
        {
            if (GetIsPC(oMaster))
            {
                oKiller = oMaster;
                logDebug("killed by summoned or familiar.  Player is " +
                    GetName(oKiller));
            }
        }

        else
        {
          // maybe a trap?
          oTrapSetter = GetTrapCreator( oLastDamager );
          if (GetIsObjectValid(oTrapSetter))
          {
            oKiller = oTrapSetter;
            logDebug("killed by trap.  Player setting trap is " +
                    GetName(oKiller));
          }
       }
    }
    return oKiller;
}
