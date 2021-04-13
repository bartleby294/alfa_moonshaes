////////////////////////////////////////////////////////////
//
//  Scrtipt Name : ap_stats
//       version : 1.1
//       Purpose : Include file for stats package
//                 and then some
//          Date : 06 March 2002
//        Author : Ranoulf, ag107093@hotmail.com
//
/////////////////////////////////////////////////////////////

int StartingConditional() {  return 0; }

/* turn on and off here */
int     MONITOR         = TRUE; // This is the master on/off switch
int     MONITOR_BASIC   = TRUE; // Traks change in exp, networth and provides a general description.
int     MONITOR_ITEM    = TRUE; // Shows you any vauleable or magic items that the Char has, and what they gained while on your server.
int     MONITOR_STAT    = TRUE; // Reports any unusual (over 3) stat bonuses
int     MONITOR_AREA    = TRUE; // Tells you the order and tag of the areas the PC traveled.
int     MONITOR_NPC     = TRUE; // Lists the NPC the PC talked to
int     MONITOR_TIME    = TRUE; // Measures the amount of time the PC spend on your server in game time and real time
int     MONITOR_COMBAT  = TRUE; // Summarizes the PC's fights as to Who, Where, When, and What they got in items/cash and Exp.

float   GENERAL_ACCURACY= 2.0;  // This setting does little to affect CPU
                                // time. 5.0 is an OK value, 2.0 is better
                                // However, times too much outside of these
                                // lessen accuracy.

float   COMBAT_ACCURACY = 0.5;  // The closer to zero it is, the more accurate
                                // it becomes, but the more resources it consumes.
                                // I wouldn't go much lower than 0.5, but you can.
                                // Values above 2.0 significantly reduce accuracy.
                                // Settings above 5.0 are fairly meaningless.

int ITEM_VALUE_THRESHOLD = 100; // Anything worth this much or more is reported
                                // on by the MONITOR_ITEM module at entry/exit
                                // and checked for magic. 100 cathes most
                                // potions and magical items. Higher values such
                                // as 500 will put less info in your logs if
                                // you desire. Note: magic items worth less than
                                // this are not detected because it is too CPU
                                // intensive to check every item.



/* prototypes */

// master controll functions
void    AP_MonitorPC        (object oPC, int iEvent);
void    AP_BeginReport      (object oPC, int iEvent);
void    AP_EndReport        (object oPC, int iEvent);

// Bulletins
void    AP_MonitorBulletins     (object oPC, int iEvent);
void    AP_DumpBulletins        (object oPC);
void    AP_DeleteBulletinsStore (object oPC);


// Basic details on the PC
void    AP_MonitorBasics    (object oPC, int iEvent);
void    AP_StoreBasics      (object oPC);
string  AP_GetDescription   (object oPC);
string  AP_GetIPnCDKey      (object oPC);
string  AP_GetAlignments    (object oPC);
string  AP_GetClasses       (object oPC);
int     AP_GetNetWorth      (object oPC);
void    AP_DumpLogOnBasics  (object oPC);
void    AP_CompareBasics    (object oPC);
void    AP_DumpLogOffBasics (object oPC);
void    AP_DeleteBasicsStore(object oPC);

// find any notable items equiped or carried
void    AP_MonitorItems         (object oPC, int iEvent);
void    AP_StoreItemsEquiped    (object oPC);
void    AP_StoreItemsInPack     (object oPC);
int     AP_GetIsMagical         (object oItem);
void    AP_SetHadAtEntry        (object oItem);
int     AP_GetHadAtEntry        (object oItem);
void    AP_DeleteHadAtEntry     (object oItem);
void    AP_DumpLogOnItems       (object oPC);
void    AP_CompareItemsEquiped  (object oPC);
void    AP_CompareItemsInPack   (object oPC);
void    AP_DumpLogOffItems      (object oPC);
void    AP_DeleteItemStores     (object oPC);

// finding any notable Ability modifiers
void    AP_StoreStatMods        (object oPC);
void    AP_PrintStatModsToLog   (object oPC);
void    AP_DeleteStatModsStore  (object oPC);

// dealing with tracking areas
void    AP_MonitorArea          (object oPC, int iEvent);
void    AP_MonitorPCsArea       (object oPC);
void    AP_PrintAreasToLog      (object oPC);
void    AP_DeleteAreas          (object oPC);

// dealing with talking to NPCs
void    AP_MonitorDialog    (object oPC, int iEvent);
void    AP_MonitorPCsDialog (object oPC);
object  AP_GetConversingNPC (object oPC);
void    AP_PrintNPCsToLog   (object oPC);
void    AP_DeleteDialogs    (object oPC);

// High level functions to deal with login and out time
void    AP_MonitorTime      (object oPC, int iEvent);
void    AP_StoreLogonTime   (object oPC);
void    AP_StoreLogOffTime  (object oPC);
string  AP_GetPlayTime      (object oPC);
void    AP_PrintTimesToLog  (object oPC);
void    AP_DeleteStoredTimes(object oPC);

// dealing with combats area and combatants
void    AP_MonitorCombat    (object oPC, int iEvnet);
void    AP_MonitorPCsCombat (object oPC);
void    AP_CheckCombatLogout(object oPC);
int     AP_GetWasInCombat   (object oPC);
void    AP_SetWasInCombat   (object oPC, int iCondition);
void    AP_ProcessCombat    (object oPC);
void    AP_StartNewCombat   (object oPC);
void     AP_SetCombatFlag    (object oPC, int iCondition);
void     AP_SetCombatStartTime(object oPC);
void     AP_SetCombatLocation(object oPC);
void     AP_FlagInventory   (object oPC, string sRegarding);
void     AP_SetGoldAndExp   (object oPC);
void     AP_StoreCombatStart(object oPC);
void     AP_StoreCombatSides(object oPC);
void     AP_AddTimeToCombat (object oPC);
void    AP_ContinueCombat   (object oPC);
void    AP_CheckEnemies     (object oPC);
object   AP_GetCurrentEnemy (object oPC);
object   AP_GetLastEnemy    (object oPC);
int      AP_GetHadFought    (object oEnemy);
void     AP_StoreEnemy      (object oPC, object oEnemy);
void     AP_SetHadFought    (object oEnemy);

void     AP_MarkPCFight     (object oPC, object oCurrentEnemy);
int      AP_GetIsNPC        (object oCurrentEnemy);
void     AP_MarkNPCFight    (object oPC, object oCurrentEnemy);

void    AP_ProcessNonCombat  (object oPC);
int      AP_GetIsCombatOver  (object oPC);
int      AP_GetTimeHasPassed (object oPC);
int      AP_GetHasMovedOn    (object oPC);
location AP_GetLastLocation  (object oPC);
void    AP_EndNewCombat      (object oPC);
void     AP_StoreCombatEnd   (object oPC);
void     AP_StoreNewItems    (object oPC);
void     AP_StoreGoldAndExp  (object oPC);
void     AP_DeleteTempMarkers(object oPC);
int      AP_GetWasLooted     (object oPC);
void     AP_SetWasLooted     (object oPC);
void    AP_PrintCombatsToLog (object oPC);
void    AP_PrintEnemiesToLog (object oPC);
void    AP_DeleteStoredCombats(object oPC);
void    AP_DeleteStoredEnemies (object oPC);
void    AP_DeleteLootedItemMarkers(object oPC);




// debugging
int     DEBUG_BASICS= FALSE;
int     DEBUG_ITEM  = FALSE;
int     DEBUG_STAT  = FALSE;
int     DEBUG_AREA  = FALSE;
int     DEBUG_NPC   = FALSE;
int     DEBUG_TIME  = FALSE;
int     DEBUG_COMBAT= FALSE;
int     DEBUG_STORE = FALSE;

int     LOW,MED,HI,MAX;
void    AP_DeBug   (int iDebugLevel, string sCallingFunction, string sMessage);



//-------------------Low Level Function Prototypes-------------------------//


// flag functions
void    AP_SetFlag    (object oSubject, string sRegarding, int iCondition);
int     AP_GetFlag    (object oSubject, string sRegarding);
void    AP_DelFlag    (object oSubject, string sRegarding);

// storage functions
void    AP_StoreInfo    (object oPC, string sRegarding, string sInfo);
int     AP_GetStoreSize (object oPC, string sRegarding);
string  AP_GetInfo      (object oPC, string sRegarding, int iNth);
string  AP_GetLastInfo  (object oPC, string sRegarding);
void    AP_DumpInfoToLog(object oPC, string sRegarding);
void    AP_DeleteStore  (object oPC, string sRegarding);


// time functions
string      AP_GetNow           ();
string      AP_GetWhen          (object oSubject, string sEvent);
int         AP_GetMinInHour     ();
void        AP_SetTime          (object oSubject, string sEvent, struct time strTime);
struct time AP_GetTime          (object oSubject, string sEvent);
void        AP_DelTime          (object oSubject, string sEvent);
struct time AP_GetElapsedTime   (object oSubject1, string sEvent, object oSubject2, string sEvent2);
int         AP_GetElapsedMin    (object oSubject1, string sEvent, object oSubject2, string sEvent2);
struct time AP_GetCurrentTime   ();
struct time AP_GameToRealTime   (struct time strTime);
string      AP_TimeToString     (struct time strTime);


// end prototypes












/*-------------------------------------------------------*/
                /* Master function */










int     START = 1;
int     STOP = 0;
//::///////////////////////////////////////////////
//:: AP_MonitorPC
//::
//:://////////////////////////////////////////////
/*
This is the master function that co-ordinates the
start and stop of the various monitoring scripts
that run while the PC is logged in, based on what's
turned on and off at the top.

It is called by the '1984_enter' and and '1984_exit'
scripts which supply it a START or STOP iEvent
depending on if the PC is joining or leaving. It
passes the event down to the individual sub parts


*/
//:://////////////////////////////////////////////
//:: Created By: Ranoulf, ag107093@hotmail.com
//:: Created On:
//:://////////////////////////////////////////////
void    AP_MonitorPC        (object oPC, int iEvent)    {

    if ( MONITOR && ! GetIsDM(oPC) ) {  // GetIsPC doesn't work here

        AP_BeginReport(oPC,iEvent);

        if  (MONITOR)           AP_MonitorBulletins (oPC,iEvent);
        if  (MONITOR_BASIC)     AP_MonitorBasics    (oPC,iEvent);
        if  (MONITOR_ITEM)      AP_MonitorItems     (oPC,iEvent);
        if  (MONITOR_STAT)      AP_StoreStatMods    (oPC);
        if  (MONITOR_AREA)      AP_MonitorArea      (oPC,iEvent);
        if  (MONITOR_NPC)       AP_MonitorDialog    (oPC,iEvent);
        if  (MONITOR_TIME)      AP_MonitorTime      (oPC,iEvent);
        if  (MONITOR_COMBAT)    AP_MonitorCombat    (oPC,iEvent);

        AP_EndReport(oPC,iEvent);
    }

}


//::///////////////////////////////////////////////
//:: AP_BeginReport
//::
//:://////////////////////////////////////////////
/*
GetPCPlayerName (as opposed to GetName) does not
work at on exit. So had to use AP_GetInfo to get
the first element of the basic description.
*/
//:://////////////////////////////////////////////
//:: Created By: Ranoulf, ag107093@hotmail.com
//:: Created On:
//:://////////////////////////////////////////////
void    AP_BeginReport(object oPC, int  iEvent) {

    if (iEvent == START) {
        PrintString("");
        PrintString("# Entry Report for " + GetPCPlayerName(oPC));
        return;
    }
    if (iEvent == STOP) {
        PrintString("");
        PrintString("# Exit Report for " + AP_GetInfo(oPC,DESCRIPT,1) );
        return;
    }
}

//::///////////////////////////////////////////////
//:: AP_EndReport
//::
//:://////////////////////////////////////////////
/*
GetPCPlayerName (as opposed to GetName) does not
work at on exit. So had to use AP_GetInfo to get
the first element of the basic description.
*/
//:://////////////////////////////////////////////
//:: Created By: Ranoulf, ag107093@hotmail.com
//:: Created On:
//:://////////////////////////////////////////////
void    AP_EndReport(object oPC, int  iEvent) {

    if (iEvent == START) {
        PrintString("");
        PrintString("# End Entry Report.");
        PrintString("");
        return;
    }
    if (iEvent == STOP) {
        PrintString("");
        PrintString("# End Exit Report.");
        PrintString("");
        return;
    }
}











/*-------------------------------------------------------*/
                /* Bulletins functions */










string  BULLETIN = "Bulletins";

//::///////////////////////////////////////////////
//:: AP_MonitorBulletins
//::
//:://////////////////////////////////////////////
/*
Designed to put the things the DM should know about
first at the top of the list
*/
//:://////////////////////////////////////////////
//:: Created By: Ranoulf, ag107093@hotmail.com
//:: Created On:
//:://////////////////////////////////////////////
void    AP_MonitorBulletins (object oPC, int iEvent){

    if (iEvent == STOP) {
        AP_DumpBulletins(oPC);
        AP_DeleteBulletinsStore(oPC);
    }
}


//::///////////////////////////////////////////////
//:: AP_DumpBulletins
//::
//:://////////////////////////////////////////////
/*
Prints to the log anything that deserves priority

*/
//:://////////////////////////////////////////////
//:: Created By: Ranoulf, ag107093@hotmail.com
//:: Created On:
//:://////////////////////////////////////////////
void    AP_DumpBulletins (object oPC)    {


    PrintString("");
    PrintString("______Bulletins______");

    AP_DumpInfoToLog( oPC, BULLETIN);
}



//::///////////////////////////////////////////////
//:: AP_DeleteBulletinsStore
//::
//:://////////////////////////////////////////////
/*
This function returns the space used up by all the
variables employed by the BULLETIN functions.
*/
//:://////////////////////////////////////////////
//:: Created By: Ranoulf, ag107093@hotmail.com
//:: Created On:
//:://////////////////////////////////////////////
void    AP_DeleteBulletinsStore(object oPC)    {

    AP_DeleteStore( oPC, BULLETIN   );
}











/*-------------------------------------------------------*/
                /* Basic info functions */












/* Constants used by the basic functions */

string  DESCRIPT= "description";
string  LEVEL   = "level";
string  EXP     = "experience points";
string  GOLD    = "gold carried";
string  NET     = "total net worth";
//::///////////////////////////////////////////////
//:: AP_MonitorBasics
//::
//:://////////////////////////////////////////////
/*
This function controls when the various functions
get run that have to do with 'the basics'.
*/
//:://////////////////////////////////////////////
//:: Created By: Ranoulf, ag107093@hotmail.com
//:: Created On:
//:://////////////////////////////////////////////
void    AP_MonitorBasics    (object oPC, int iEvent) {

    if (iEvent == START) {
        AP_StoreBasics(oPC);
        AP_DumpLogOnBasics(oPC);
        return;
    }

    if (iEvent == STOP) {
        AP_CompareBasics(oPC);
        AP_DumpLogOffBasics(oPC);
        AP_DeleteBasicsStore(oPC);
        return;
    }

}

//::///////////////////////////////////////////////
//:: AP_StoreBasics
//::
//:://////////////////////////////////////////////
/*
This function takes a picture of the PC and tosses
the info into the variable names mentioned below.
(The variable names are defined as constats at the
top of this section)

The function AP_StoreInfo is one of several
general purpose storage functions used throughout
*/
//:://////////////////////////////////////////////
//:: Created By: Ranoulf, ag107093@hotmail.com
//:: Created On:
//:://////////////////////////////////////////////
void    AP_StoreBasics  (object oPC)    {

    AP_StoreInfo( oPC, DESCRIPT, GetPCPlayerName(oPC) ); // added to help with the logoff report
    AP_StoreInfo( oPC, DESCRIPT, AP_GetDescription(oPC) );
    AP_StoreInfo( oPC, DESCRIPT, AP_GetIPnCDKey(oPC)  );
    AP_StoreInfo( oPC, LEVEL,    IntToString(GetHitDice(oPC)) );
    AP_StoreInfo( oPC, EXP,      IntToString(GetXP(oPC)) );
    AP_StoreInfo( oPC, GOLD,     IntToString(GetGold(oPC)) );
    AP_StoreInfo( oPC, NET,      IntToString(AP_GetNetWorth(oPC)) );

}

//::///////////////////////////////////////////////
//:: AP_GetDescription
//::
//:://////////////////////////////////////////////
/*
Here we just build one long string to descripe the
Player/Characer at a glance.
*/
//:://////////////////////////////////////////////
//:: Created By: Ranoulf, ag107093@hotmail.com
//:: Created On:
//:://////////////////////////////////////////////
string      AP_GetDescription    (object oPC) {

    string sPlayer      = GetPCPlayerName(oPC);
    string sCharacter   = GetName(oPC);
    string sLevel       = IntToString( GetHitDice(oPC) );
    string sAlign       = AP_GetAlignments(oPC);
    string sClass       = AP_GetClasses(oPC);
    string sHitPoints   = IntToString( GetMaxHitPoints(oPC) );
    string sAC          = IntToString( GetAC(oPC) );

    return
    sPlayer + " is playing " + sCharacter + ", a " + sLevel + " Hitdice " +
    sAlign + " " + sClass + " with " + sHitPoints + " hitpoints and an AC of " + sAC;

}

//::///////////////////////////////////////////////
//:: AP_GetIP&CDKey
//::
//:://////////////////////////////////////////////
/*
This gets exactly what you'd think from the title
*/
//:://////////////////////////////////////////////
//:: Created By: Ranoulf, ag107093@hotmail.com
//:: Created On:
//:://////////////////////////////////////////////
string  AP_GetIPnCDKey      (object oPC)    {

    return
    "From address " + GetPCIPAddress(oPC) + " With CD Key " + GetPCPublicCDKey(oPC);
}

//::///////////////////////////////////////////////
//:: AP_GetAlignments
//::
//:://////////////////////////////////////////////
/*
Since bioware has no good way to return a character's
allignment as a string, we need to build a function
that does for the 'at a glance' description.
*/
//:://////////////////////////////////////////////
//:: Created By: Ranoulf, ag107093@hotmail.com
//:: Created On:
//:://////////////////////////////////////////////
string  AP_GetAlignments    (object oPC)  {

    int iAlignmentLawChaos = GetAlignmentLawChaos(oPC);
    int iAlignmentGoodEvil = GetAlignmentGoodEvil(oPC);

    string sLawChaos;
    string sGoodEvil;

    switch (iAlignmentLawChaos) {
        case ALIGNMENT_LAWFUL:
            sLawChaos = "Lawful";
            break;
        case ALIGNMENT_NEUTRAL:
           sLawChaos = "Neutral";
           break;
        case ALIGNMENT_CHAOTIC:
           sLawChaos = "Chaotic";
           break;
   }

   switch (iAlignmentGoodEvil) {
        case ALIGNMENT_GOOD:
            sGoodEvil += "Good";
            break;
        case ALIGNMENT_NEUTRAL:
           sGoodEvil += "Neutral";
           break;
        case ALIGNMENT_EVIL:
           sGoodEvil += "Evil";
           break;
   }

   return sLawChaos + " " + sGoodEvil;

}

//::///////////////////////////////////////////////
//:: AP_GetClasses
//::
//:://////////////////////////////////////////////
/*
Once again, there's no good way to get the character's
class as a sting since it's defined by integers.
*/
//:://////////////////////////////////////////////
//:: Created By: Ranoulf, ag107093@hotmail.com
//:: Created On:
//:://////////////////////////////////////////////
string  AP_GetClasses    (object oPC) {

    string sClassList = "";
    int iNthClass = 1;
    int iClass = GetClassByPosition(iNthClass, oPC);

    while (iClass != CLASS_TYPE_INVALID) {

        // if we've already been through the loop,
        // lets seperate this iteration from the last with a slash
        if (sClassList != "") sClassList += " / ";

        // let's start with the PC's level in this class
        sClassList += "Level " + IntToString( GetLevelByPosition(iNthClass,oPC)) + " ";

        // now lets figure out what the class interger matches up with
        switch (iClass) {
            case CLASS_TYPE_BARBARIAN:
                sClassList += "Barbarian";
                break;
            case CLASS_TYPE_BARD:
                sClassList += "Bard";
                break;
            case CLASS_TYPE_CLERIC:
                sClassList += "Cleric";
                break;
            case CLASS_TYPE_DRUID:
                sClassList += "Druid";
                break;
            case CLASS_TYPE_FIGHTER:
                sClassList += "Fighter";
                break;
            case CLASS_TYPE_MONK:
                sClassList += "Monk";
                break;
            case CLASS_TYPE_PALADIN:
               sClassList += "Paladin";
               break;
            case CLASS_TYPE_RANGER:
               sClassList += "Ranger";
               break;
            case CLASS_TYPE_ROGUE:
               sClassList += "Rogue";
               break;
            case CLASS_TYPE_SORCERER:
               sClassList += "Sorcerer";
               break;
            case CLASS_TYPE_WIZARD:
               sClassList += "Wizard";
               break;
        }   //end switch

        // now let's increment and see if there is a next class
        iNthClass++;
        iClass = GetClassByPosition(iNthClass, oPC);

    } // end while

    return sClassList;
}

//::///////////////////////////////////////////////
//:: AP_GetNetWorth
//::
//:://////////////////////////////////////////////
/*
This function loops through the character's inventory
and sums up the GP vaule of all thier equipment,
adding it to the coin they carry.
*/
//:://////////////////////////////////////////////
//:: Created By: Ranoulf, ag107093@hotmail.com
//:: Created On:
//:://////////////////////////////////////////////

int         AP_GetNetWorth      (object oPC) {

    // lets start out with what gold they are carrying
    int iNetWorth = GetGold(oPC);

    // now lets take a look at thier inventory
    object oItem = GetFirstItemInInventory(oPC);

    while ( GetIsObjectValid(oItem) ) {
        iNetWorth += GetGoldPieceValue(oItem);
        oItem = GetNextItemInInventory(oPC);
    }

    // and the items they have equiped too.
    int     nSlot = INVENTORY_SLOT_HEAD;  // this is the first slot
            oItem = GetItemInSlot( nSlot, oPC);

    while (nSlot <= INVENTORY_SLOT_CARMOUR)     {    // the last slot
        iNetWorth += GetGoldPieceValue(oItem);
        nSlot ++;
        oItem = GetItemInSlot( nSlot, oPC);
    }

    return iNetWorth;
}

//::///////////////////////////////////////////////
//:: AP_DumpLogOnBasics
//::
//:://////////////////////////////////////////////
/*
This function displays the info we just gathered
(most of it anyway) by calling a function from
the storage group of functions
*/
//:://////////////////////////////////////////////
//:: Created By: Ranoulf, ag107093@hotmail.com
//:: Created On:
//:://////////////////////////////////////////////
void    AP_DumpLogOnBasics  (object oPC)    {

    PrintString("");
    PrintString("______Basics______");

    AP_DumpInfoToLog( oPC, DESCRIPT);
    AP_DumpInfoToLog( oPC, EXP);
    AP_DumpInfoToLog( oPC, GOLD);
    AP_DumpInfoToLog( oPC, NET);

}

//::///////////////////////////////////////////////
//:: AP_CompareBasics
//::
//:://////////////////////////////////////////////
/*
Here we get the entry vaules out of storage, see what's
changed, and store the difference for later use
*/
//:://////////////////////////////////////////////
//:: Created By: Ranoulf, ag107093@hotmail.com
//:: Created On:
//:://////////////////////////////////////////////
void    AP_CompareBasics  (object oPC)    {

    int iLevelChange = GetHitDice(oPC)     - StringToInt( AP_GetLastInfo(oPC, LEVEL) );
    int iExpChange   = GetXP(oPC)          - StringToInt( AP_GetLastInfo(oPC, EXP)   );
    int iGoldChange  = GetGold(oPC)        - StringToInt( AP_GetLastInfo(oPC, GOLD)  );
    int iNetChange   = AP_GetNetWorth(oPC) - StringToInt( AP_GetLastInfo(oPC, NET)   );

    AP_StoreInfo( oPC, LEVEL,   IntToString(iLevelChange)   );
    AP_StoreInfo( oPC, EXP,     IntToString(iExpChange)     );
    AP_StoreInfo( oPC, GOLD,    IntToString(iGoldChange)    );
    AP_StoreInfo( oPC, NET,     IntToString(iNetChange)     );

}

//::///////////////////////////////////////////////
//:: AP_DumpLogOffBasics
//::
//:://////////////////////////////////////////////
/*
This function is called at log off and uses the
GetLastInfo to pull off the
*/
//:://////////////////////////////////////////////
//:: Created By: Ranoulf, ag107093@hotmail.com
//:: Created On:
//:://////////////////////////////////////////////
void    AP_DumpLogOffBasics  (object oPC)    {

    PrintString(" ");
    PrintString("______Basics______");
    AP_DumpInfoToLog( oPC, DESCRIPT);
    PrintString("Gained while on your server");
    PrintString("    Level Increase: " +  AP_GetLastInfo( oPC, LEVEL) );
    PrintString("      Exp Increase: " +  AP_GetLastInfo( oPC, EXP) );
    PrintString("     Gold Increase: " +  AP_GetLastInfo( oPC, GOLD) );
    PrintString("Net Worth Increase: " +  AP_GetLastInfo( oPC, NET) );

}

//::///////////////////////////////////////////////
//:: AP_DeleteBasicsStore
//::
//:://////////////////////////////////////////////
/*
This function returns the space used up by all the
variables employed by the basics functions.
*/
//:://////////////////////////////////////////////
//:: Created By: Ranoulf, ag107093@hotmail.com
//:: Created On:
//:://////////////////////////////////////////////
void    AP_DeleteBasicsStore(object oPC)    {

    AP_DeleteStore( oPC, DESCRIPT   );
    AP_DeleteStore( oPC, LEVEL      );
    AP_DeleteStore( oPC, EXP        );
    AP_DeleteStore( oPC, GOLD       );
    AP_DeleteStore( oPC, NET        );

}












/*-------------------------------------------------------*/
                    /* Item functions */













/* Constants used by the item functions */

string  EQUIP_ITEM = "equiped items";
string  PACK_ITEM  = "carried items";
string  NEW_ITEMS  = "new items";
string  HAD_AT_ENTRY = "had at entry";

//::///////////////////////////////////////////////
//:: AP_MonitorItems
//::
//:://////////////////////////////////////////////
/*
This function simply controls when the others get run.
*/
//:://////////////////////////////////////////////
//:: Created By: Ranoulf, ag107093@hotmail.com
//:: Created On:
//:://////////////////////////////////////////////
void AP_MonitorItems(object oPC, int iEvent)  {

    if (iEvent == START) {
        AP_StoreItemsEquiped(oPC);
        AP_StoreItemsInPack(oPC);
        AP_DumpLogOnItems(oPC);
        return;
    }

    if (iEvent == STOP) {
        AP_CompareItemsEquiped(oPC);
        AP_CompareItemsInPack(oPC);
        AP_DumpLogOffItems(oPC);
        AP_DeleteItemStores(oPC);
        return;
    }
}

//::///////////////////////////////////////////////
//:: AP_StoreItemsEquiped
//::
//:://////////////////////////////////////////////
/*
Note: Because screening every item for magic is
rather intensive, we screen them for value first.
This means a magic item worth little will slip
through, but it's an acceptable tradeoff.

Every noteworthy item is 'tagged' by the SetHadAtEntry
function so we can figure out which items are new
later.

*/
//:://////////////////////////////////////////////
//:: Created By: Ranoulf, ag107093@hotmail.com
//:: Created On:
//:://////////////////////////////////////////////
void    AP_StoreItemsEquiped    (object oPC)    {

    string  sItemData;
    int     nSlot = INVENTORY_SLOT_HEAD;  // this is the first slot
    object  oItem = GetItemInSlot( nSlot, oPC);

    while (nSlot <= INVENTORY_SLOT_CARMOUR)     {    // the last slot

        if ( GetGoldPieceValue(oItem) >= ITEM_VALUE_THRESHOLD )   {

            if ( AP_GetIsMagical(oItem) )
                sItemData = IntToString(GetNumStackedItems(oItem)) + " Magical " + GetName(oItem) + " (" + GetTag(oItem) + ")";
            else
                sItemData = IntToString(GetNumStackedItems(oItem)) + " Valueable " + GetName(oItem) + " (" + GetTag(oItem) + ")";

            AP_StoreInfo( oPC, EQUIP_ITEM, sItemData );
            AP_SetHadAtEntry(oItem); // so later we know what they had with them originally
        }

        nSlot ++;
        oItem = GetItemInSlot( nSlot, oPC);

    } // end while

}

//::///////////////////////////////////////////////
//:: AP_StoreItemsInPack
//::
//:://////////////////////////////////////////////
/*
This function looks at what the PC is carrying and
stores the name+tag of anything valuable or magical.

Note: Because screening every item for magic is
rather intensive, we screen them for value first.
This means a magic item that was worth nothing will
slip through, but it's an acceptable tradeoff.

Every noteworthy item is 'tagged' by the SetHadAtEntry
function so we can figure out which items are new
later.
*/
//:://////////////////////////////////////////////
//:: Created By: Ranoulf, ag107093@hotmail.com
//:: Created On:
//:://////////////////////////////////////////////
void    AP_StoreItemsInPack     (object oPC)     {

    string sItemData;
    object oItem = GetFirstItemInInventory(oPC);

    while ( GetIsObjectValid(oItem) )   {

        if ( GetGoldPieceValue(oItem) >= ITEM_VALUE_THRESHOLD )   {

            if ( AP_GetIsMagical(oItem) )
                sItemData = IntToString(GetNumStackedItems(oItem)) + " Magical " + GetName(oItem) + " (" + GetTag(oItem) + ")";
            else
                sItemData = IntToString(GetNumStackedItems(oItem)) + " Valuable " + GetName(oItem) + " (" + GetTag(oItem) + ")";

            AP_StoreInfo( oPC, PACK_ITEM, sItemData );
            AP_SetHadAtEntry(oItem); // so later we know what they had with them originally
        }

        oItem = GetNextItemInInventory(oPC);

    } // end while
}


//::///////////////////////////////////////////////
//:: AP_GetIsMagical
//::
//:://////////////////////////////////////////////
/*
    Returns True if item has 'magical' properties

    The loop is around 75 iterations for all the
    effects so be carefull how many items you
    send through it.

*/
//:://////////////////////////////////////////////
//:: Created By:
//:: Created On:
//:://////////////////////////////////////////////
int AP_GetIsMagical(object oItem) {

    int iProperty;

    for ( iProperty = ITEM_PROPERTY_ABILITY_BONUS; iProperty <= ITEM_PROPERTY_IMMUNITY_SPELLS_BY_LEVEL; iProperty ++ ) {
        if ( GetItemHasItemProperty(oItem,iProperty) ) return TRUE;
    }

    return FALSE;
}

//::///////////////////////////////////////////////
//:: AP_GetIsBanned
//::
//:://////////////////////////////////////////////
/*
    -- not used yet
*/
//:://////////////////////////////////////////////
//:: Created By: Ranoulf, ag107093@hotmail.com
//:: Created On:
//:://////////////////////////////////////////////
int     AP_GetIsBanned      (object oItem) {

    return (

        GetItemHasItemProperty(oItem, ITEM_PROPERTY_DAMAGE_REDUCTION)
        ||
        GetItemHasItemProperty(oItem, ITEM_PROPERTY_DAMAGE_RESISTANCE)
        ||
        GetItemHasItemProperty(oItem, ITEM_PROPERTY_IMMUNITY_DAMAGE_TYPE)
        ||
        GetItemHasItemProperty(oItem, ITEM_PROPERTY_IMMUNITY_MISCELLANEOUS)
        ||
        GetItemHasItemProperty(oItem, ITEM_PROPERTY_IMMUNITY_SPECIFIC_SPELL)
        ||
        GetItemHasItemProperty(oItem, ITEM_PROPERTY_IMMUNITY_SPELL_SCHOOL)
        ||
        GetItemHasItemProperty(oItem, ITEM_PROPERTY_IMMUNITY_SPELLS_BY_LEVEL)
        ||
        GetItemHasItemProperty(oItem, ITEM_PROPERTY_HASTE)
        ||
        GetItemHasItemProperty(oItem, ITEM_PROPERTY_LIGHT)
    );

}

//::///////////////////////////////////////////////
//:: AP_SetHadAtEntry
//::
//:://////////////////////////////////////////////
/*
Tags the item with a variable so we can tell later
if it was present at logon
*/
//:://////////////////////////////////////////////
//:: Created By: Ranoulf, ag107093@hotmail.com
//:: Created On:
//:://////////////////////////////////////////////
void    AP_SetHadAtEntry     (object oItem)    {

    SetLocalInt(oItem,HAD_AT_ENTRY,1);

    return;
}

//::///////////////////////////////////////////////
//:: AP_GetHadAtEntry
//::
//:://////////////////////////////////////////////
/*
Returns the vaule of the variable named HAD_AT_ENTRY.
If the variable isn't present, 0 is returned.
*/
//:://////////////////////////////////////////////
//:: Created By: Ranoulf, ag107093@hotmail.com
//:: Created On:
//:://////////////////////////////////////////////
int     AP_GetHadAtEntry    (object oItem)  {

    return GetLocalInt(oItem,HAD_AT_ENTRY);
}

//::///////////////////////////////////////////////
//:: AP_DeleteHadAtEntry
//::
//:://////////////////////////////////////////////
/*
This cleans up the variable we set eariler
*/
//:://////////////////////////////////////////////
//:: Created By: Ranoulf, ag107093@hotmail.com
//:: Created On:
//:://////////////////////////////////////////////
void     AP_DeleteHadAtEntry    (object oItem)  {

    DeleteLocalInt(oItem,HAD_AT_ENTRY);
}



//::///////////////////////////////////////////////
//:: AP_DumpLogOnItems
//::
//:://////////////////////////////////////////////
/*
This function generates the report for the log of
any interesting things the PC had in inventory
*/
//:://////////////////////////////////////////////
//:: Created By: Ranoulf, ag107093@hotmail.com
//:: Created On:
//:://////////////////////////////////////////////
void    AP_DumpLogOnItems   (object oPC) {

    PrintString("");
    PrintString("______Items______");

    AP_DumpInfoToLog(oPC,EQUIP_ITEM);
    if ( AP_GetStoreSize(oPC,EQUIP_ITEM) == 0)
        PrintString("      " + "nothing interesting equiped");

    AP_DumpInfoToLog(oPC,PACK_ITEM);
    if ( AP_GetStoreSize(oPC,PACK_ITEM) == 0)
        PrintString("      " + "not carrying anything of note");


}

//::///////////////////////////////////////////////
//:: AP_CompareItemsEquiped
//::
//:://////////////////////////////////////////////
/*
This function looks at what the PC has equiped
and puts any 'new' items of note in the NEW_ITEM
store. By 'new' we mean anthing that wasn't tagged
by the AP_SetHadAtEntry function when they logged on.

If an item is moved from Equiped to Pack, it will
still have the same HAD_AT_ENTRY variable and so will
not show up as a false postive.

Note: deletes the HAD_AT_ENTRY variable
*/
//:://////////////////////////////////////////////
//:: Created By: Ranoulf, ag107093@hotmail.com
//:: Created On:
//:://////////////////////////////////////////////
void    AP_CompareItemsEquiped     (object oPC)    {

    string  sItemData;
    int     nSlot = INVENTORY_SLOT_HEAD;
    object  oItem = GetItemInSlot( nSlot, oPC);

    while (nSlot <= INVENTORY_SLOT_CARMOUR)     {

        if ( GetGoldPieceValue(oItem) >= ITEM_VALUE_THRESHOLD )   {

            if ( AP_GetIsMagical(oItem) )
                sItemData = IntToString(GetNumStackedItems(oItem)) + " Magical " + GetName(oItem) + " (" + GetTag(oItem) + ")";
            else
                sItemData = IntToString(GetNumStackedItems(oItem)) + " Valueable " + GetName(oItem) + " (" + GetTag(oItem) + ")";

            if ( ! AP_GetHadAtEntry(oItem) )
                AP_StoreInfo( oPC, NEW_ITEMS, sItemData );
            else
                AP_DeleteHadAtEntry(oItem);
        }

        nSlot ++;
        oItem = GetItemInSlot( nSlot, oPC);

    } // end while



}

//::///////////////////////////////////////////////
//:: AP_CompareItemsInPack
//::
//:://////////////////////////////////////////////
/*
This function looks at what the PC is carrying
and puts any 'new' items of note in the NEW_ITEM
store. By 'new' we meand anthing that wasn't tagged
by the AP_SetHadAtEntry function when they logged on.

Note: deletes the HAD_AT_ENTRY variable
*/
//:://////////////////////////////////////////////
//:: Created By: Ranoulf, ag107093@hotmail.com
//:: Created On:
//:://////////////////////////////////////////////
void    AP_CompareItemsInPack    (object oPC)    {

    string sItemData;
    object oItem = GetFirstItemInInventory(oPC);

    while ( GetIsObjectValid(oItem) )   {

        if ( GetGoldPieceValue(oItem) >= ITEM_VALUE_THRESHOLD )   {

            if ( AP_GetIsMagical(oItem) )
                sItemData = IntToString(GetNumStackedItems(oItem)) + " Magical " + GetName(oItem) + " (" + GetTag(oItem) + ")";
            else
                sItemData = IntToString(GetNumStackedItems(oItem)) + " Valuable " + GetName(oItem) + " (" + GetTag(oItem) + ")";

            if ( ! AP_GetHadAtEntry(oItem) )
                AP_StoreInfo( oPC, NEW_ITEMS, sItemData );
            else
                AP_DeleteHadAtEntry(oItem);
        }

        oItem = GetNextItemInInventory(oPC);

    } // end while

}

//::///////////////////////////////////////////////
//:: AP_DumpLogOffItems
//::
//:://////////////////////////////////////////////
/*
This function generates the log off report for the
PC.
*/
//:://////////////////////////////////////////////
//:: Created By: Ranoulf, ag107093@hotmail.com
//:: Created On:
//:://////////////////////////////////////////////
void    AP_DumpLogOffItems  (object oPC)    {

    PrintString(" ");
    PrintString("____Items gained____");
    AP_DumpInfoToLog( oPC, NEW_ITEMS);

    if ( AP_GetStoreSize(oPC,NEW_ITEMS) == 0)
        PrintString("      " + "nothing out of the ordinary gained");



}

//::///////////////////////////////////////////////
//:: AP_DeleteItemStore
//::
//:://////////////////////////////////////////////
/*
This function returns the space used up by all the
variables employed by the basics functions.

The HAD_AT_ENTRY variable is cleaned up by the
CompareItems set of functions
*/
//:://////////////////////////////////////////////
//:: Created By: Ranoulf, ag107093@hotmail.com
//:: Created On:
//:://////////////////////////////////////////////
void    AP_DeleteItemStores(object oPC)    {

    AP_DeleteStore( oPC, EQUIP_ITEM);
    AP_DeleteStore( oPC, PACK_ITEM);
    AP_DeleteStore( oPC, NEW_ITEMS);
}

















/*-------------------------------------------------------*/


                /* Stat functions */
















/* constants used in the stat functions */
string  STAT = "stat modifier";
int     STAT_VALUE_THRESHOLD = 3;

//::///////////////////////////////////////////////
//:: AP_StoreStatMods
//::
//:://////////////////////////////////////////////
/*

*/
//:://////////////////////////////////////////////
//:: Created By: Ranoulf, ag107093@hotmail.com
//:: Created On:
//:://////////////////////////////////////////////
void    AP_StoreStatMods       (object oPC) {

    // dicover any abnormal ability mods  - couldn't do this in a for loop
    // as we want something other than the number in an output
    int iStat;

    if ( (iStat = GetAbilityModifier(ABILITY_STRENGTH,oPC)) > STAT_VALUE_THRESHOLD )
        AP_StoreInfo( oPC, STAT,"Strength bonus is: " + IntToString(iStat) );
    if ( (iStat = GetAbilityModifier(ABILITY_DEXTERITY,oPC)) > STAT_VALUE_THRESHOLD )
        AP_StoreInfo( oPC, STAT,"Dex bonus is: " + IntToString(iStat) );
    if ( (iStat = GetAbilityModifier(ABILITY_CONSTITUTION,oPC)) > STAT_VALUE_THRESHOLD )
        AP_StoreInfo( oPC, STAT,"Con bonus is: " + IntToString(iStat) );
    if ( (iStat = GetAbilityModifier(ABILITY_INTELLIGENCE,oPC)) > STAT_VALUE_THRESHOLD )
        AP_StoreInfo( oPC, STAT,"Int bonus is: " + IntToString(iStat) );
    if ( (iStat = GetAbilityModifier(ABILITY_WISDOM,oPC)) > STAT_VALUE_THRESHOLD )
        AP_StoreInfo( oPC, STAT,"Wisdom bonus is: " + IntToString(iStat) );
    if ( (iStat = GetAbilityModifier(ABILITY_CHARISMA,oPC)) > STAT_VALUE_THRESHOLD )
        AP_StoreInfo( oPC, STAT,"Charisma bonus is: " + IntToString(iStat) );

    return;
}

//::///////////////////////////////////////////////
//:: AP_PrintStatModsToLog
//::
//:://////////////////////////////////////////////
/*

*/
//:://////////////////////////////////////////////
//:: Created By: Ranoulf, ag107093@hotmail.com
//:: Created On:
//:://////////////////////////////////////////////
void    AP_PrintStatModsToLog  (object oPC) {

    PrintString("");
    PrintString("___Stat Bonuses___");

    AP_DumpInfoToLog(oPC,STAT);

    return;

}

//::///////////////////////////////////////////////
//:: AP_DeleteStatModsStore
//::
//:://////////////////////////////////////////////
/*

*/
//:://////////////////////////////////////////////
//:: Created By: Ranoulf, ag107093@hotmail.com
//:: Created On:
//:://////////////////////////////////////////////
void    AP_DeleteStatModsStore (object oPC) {

    AP_DeleteStore( oPC, STAT);

    return;
}















/*-------------------------------------------------------*/


                /* Area functions */













/* constants used in the area functions */
string  AREA = "Areas";

//::///////////////////////////////////////////////
//:: AP_MonitorArea
//::
//:://////////////////////////////////////////////
/*
This function simply controls what gets run at
START and STOP events.

 - to do

 add function to find out what the first area
 will be and put it at the beginning of the
 AREA store so we can report it as the starting
 area
*/
//:://////////////////////////////////////////////
//:: Created By: Ranoulf, ag107093@hotmail.com
//:: Created On:
//:://////////////////////////////////////////////
void AP_MonitorArea    (object oPC, int iEvent) {

    if (iEvent == START) {
        AP_MonitorPCsArea(oPC);
        return;
    }

    if (iEvent == STOP) {
        AP_PrintAreasToLog(oPC);
        AP_DeleteAreas(oPC);
        return;
    }
}

//::///////////////////////////////////////////////
//:: MonitorPCsArea
//::
//:://////////////////////////////////////////////
/*
This function checks the PC's area is in every
so often. (defined in GENERAL_ACCURACY at the top) If
it's a different area than the last one, it adds it
to the AREA store.

This means that it captures areas as the PC travels
through them in order, even if the PC has already
been there. In this fashion you can chart the PC's
path.

Once started this function continues to run until
the PC leaves
*/
//:://////////////////////////////////////////////
//:: Created By: Ranoulf, ag107093@hotmail.com
//:: Created On:
//:://////////////////////////////////////////////
void AP_MonitorPCsArea    (object oPC) {

    // bail if the oPC no longer exists
    if (! GetIsObjectValid(oPC) )   return;

    // You can only GetTag areas, GetName doesn't work
    string sThisAreaName = GetTag(GetArea(oPC));
    string sLastAreaName = AP_GetLastInfo(oPC,AREA);

    // if the area hasn't loaded yet, the above returns  ""
    if ( (sThisAreaName != "") && (sThisAreaName != sLastAreaName) ) {
        AP_StoreInfo(oPC,AREA,sThisAreaName);
    }

    DelayCommand(GENERAL_ACCURACY,AP_MonitorPCsArea(oPC));

    return;

}


//::///////////////////////////////////////////////
//:: AP_PrintAreasToLog
//::
//:://////////////////////////////////////////////
/*

*/
//:://////////////////////////////////////////////
//:: Created By:
//:: Created On:
//:://////////////////////////////////////////////
void    AP_PrintAreasToLog  (object oPC){

    PrintString("");
    PrintString("___Areas Traveled___");

    AP_DumpInfoToLog(oPC,AREA);

    return;
}

//::///////////////////////////////////////////////
//:: AP_DeleteAreas
//::
//:://////////////////////////////////////////////
/*

*/
//:://////////////////////////////////////////////
//:: Created By: Ranoulf, ag107093@hotmail.com
//:: Created On:
//:://////////////////////////////////////////////
void    AP_DeleteAreas  (object oPC)    {

    AP_DeleteStore(oPC,AREA);

    return;
}


















/*-----------------------------------------------------------------*/

               /* Conversation Tracking Functions */

















/* Constats used by the Monitor Dialog functions */
string  NPC = "NPCs";

//::///////////////////////////////////////////////
//:: AP_MonitorDialog
//::
//:://////////////////////////////////////////////
/*
This function simply controls what gets run when
START or STOP events happen.
*/
//:://////////////////////////////////////////////
//:: Created By: Ranoulf, ag107093@hotmail.com
//:: Created On:
//:://////////////////////////////////////////////
void AP_MonitorDialog    (object oPC, int iEvent) {

    if (iEvent == START) {
        AP_MonitorPCsDialog(oPC);
        return;
    }

    if (iEvent == STOP) {
        AP_PrintNPCsToLog(oPC);
        AP_DeleteDialogs(oPC);
        return;
    }
}

//::///////////////////////////////////////////////
//:: AP_MonitorPCsDialog
//::
//:://////////////////////////////////////////////
/*
This function works similarly to the area function
in that it checks every so often to see if the PC
is in a conversation with a NPC. If so, it gets
the NPC's name and put it in the NPC Store.

The function ends when the PC exits
*/
//:://////////////////////////////////////////////
//:: Created By: Ranoulf, ag107093@hotmail.com
//:: Created On:
//:://////////////////////////////////////////////
void AP_MonitorPCsDialog (object oPC) {

//  exit if the oPC no longer exists
    if (! GetIsObjectValid(oPC) )  return;

//  otherwise, lets see if he is talking to anyone.
    if ( IsInConversation(oPC) )    {

        object oNPC = AP_GetConversingNPC(oPC);

        if ( GetIsObjectValid(oNPC) )   {
            // get thier name/tag and compare it to the last person we spoke to
            string sThisNPC = GetName(oNPC) + " (" + GetTag(oNPC) + ")";
            string sLastNPC = AP_GetLastInfo(oPC,NPC); // one of the storage functions

            if (sThisNPC != sLastNPC ) AP_StoreInfo(oPC,NPC,sThisNPC);    // one of the storage functions
        }
    }  // end if IsInConersation

    // and lets reschedule ourselves
    DelayCommand(GENERAL_ACCURACY,AP_MonitorPCsDialog(oPC));

}

//::///////////////////////////////////////////////
//:: AP_GetConversingNPC
//::
//:://////////////////////////////////////////////
/*
As GetLastSpeaker() only works with perception heard events, we have to get
the nearest object to the PC and see if its also in a converstation
(Sometimes the closest NPC isn't who we're talking to)
*/
//:://////////////////////////////////////////////
//:: Created By: Ranoulf, ag107093@hotmail.com
//:: Created On:
//:://////////////////////////////////////////////
object AP_GetConversingNPC(object oPC)  {

//  lets find the NPC closest to us
    int     iNthObject = 1;
    object  oNPC = GetNearestObject(OBJECT_TYPE_CREATURE,oPC,iNthObject);

//  but if they aren't in a conversation, we need to keep looking
    while ( ! IsInConversation(oNPC) && GetIsObjectValid(oNPC) ) {
        iNthObject ++;
        oNPC = GetNearestObject(OBJECT_TYPE_CREATURE,oPC,iNthObject);
        if (iNthObject > 10) return OBJECT_INVALID; // an excape condition
    }

    return oNPC; // if we ran out of NPCs, this will be OBJECT_INVALID
}



//::///////////////////////////////////////////////
//:: AP_PrintNPCsToLog
//::
//:://////////////////////////////////////////////
/*

*/
//:://////////////////////////////////////////////
//:: Created By: Ranoulf, ag107093@hotmail.com
//:: Created On:
//:://////////////////////////////////////////////
void    AP_PrintNPCsToLog       (object oPC)    {


    PrintString("");
    PrintString("____Talked To____");

    AP_DumpInfoToLog(oPC,NPC);
}

//::///////////////////////////////////////////////
//:: AP_DeleteDialogs
//::
//:://////////////////////////////////////////////
/*

*/
//:://////////////////////////////////////////////
//:: Created By: Ranoulf, ag107093@hotmail.com
//:: Created On:
//:://////////////////////////////////////////////
void    AP_DeleteDialogs    (object oPC)    {

    AP_DeleteStore(oPC,NPC);

    return;
}










/*-----------------------------------------------------------------*/

                   /* Time Tracking Functions */












/* constants used by the time functions */
string  LOGON =  "logon time";
string  LOGOFF = "logoff time";


//::///////////////////////////////////////////////
//:: AP_MonitorTime
//::
//:://////////////////////////////////////////////
/*
These functions track when the PC loged in and out
in game time and tell you how long they were on in
real time.

Dealing with time in NWN is actually quite complex
and reqired a seperate set of storage and conversion
functions.

The 'upper level' functions found here hide much of
that detail making time easier to handle.
*/
//:://////////////////////////////////////////////
//:: Created By: Ranoulf, ag107093@hotmail.com
//:: Created On:
//:://////////////////////////////////////////////
void    AP_MonitorTime      (object oPC, int iEvent)    {

    if (iEvent == START) {
        if (DEBUG_TIME) AP_DeBug(LOW,"AP_MonitorTime","Setting the logon time for the PC");
        AP_StoreLogonTime(oPC);
        return;
    }

    if (iEvent == STOP) {
        if (DEBUG_TIME) AP_DeBug(LOW,"AP_MonitorTime","Setting the logoff time for the PC");
        AP_StoreLogOffTime(oPC);
        AP_PrintTimesToLog(oPC);
        AP_DeleteStoredTimes(oPC);
    }
}

//::///////////////////////////////////////////////
//:: AP_StoreLogonTime
//::
//:://////////////////////////////////////////////
/*
This function simple sets the event names "LOGON"
about the oPC to the current time
*/
//:://////////////////////////////////////////////
//:: Created By: Ranoulf, ag107093@hotmail.com
//:: Created On:
//:://////////////////////////////////////////////
void AP_StoreLogonTime(object oPC) {

    if (DEBUG_TIME) AP_DeBug(LOW,"AP_StoreLogonTime","Setting logon time");

    AP_SetTime( oPC,LOGON,AP_GetCurrentTime() );
}

//::///////////////////////////////////////////////
//:: AP_StoreLogOffTime
//::
//:://////////////////////////////////////////////
/*
This function simple sets the event names "LOGOFF"
about the oPC to the current time
*/
//:://////////////////////////////////////////////
//:: Created By: Ranoulf, ag107093@hotmail.com
//:: Created On:
//:://////////////////////////////////////////////
void AP_StoreLogOffTime(object oPC) {

    if (DEBUG_TIME) AP_DeBug(LOW,"AP_StoreLogOffTime","Setting logoff time");

    AP_SetTime( oPC,LOGOFF,AP_GetCurrentTime() );
}

//::///////////////////////////////////////////////
//:: AP_DeleteStoredTimes
//::
//:://////////////////////////////////////////////
/*

*/
//:://////////////////////////////////////////////
//:: Created By: Ranoulf, ag107093@hotmail.com
//:: Created On:
//:://////////////////////////////////////////////
void    AP_DeleteStoredTimes(object oPC)    {

    AP_DelTime( oPC,LOGON );
    AP_DelTime( oPC,LOGOFF );

    return;
}



//::///////////////////////////////////////////////
//:: AP_GetPlayTime
//::
//:://////////////////////////////////////////////
/*

*/
//:://////////////////////////////////////////////
//:: Created By: Ranoulf, ag107093@hotmail.com
//:: Created On:
//:://////////////////////////////////////////////
string  AP_GetPlayTime      (object oPC) {

    if (DEBUG_TIME) AP_DeBug(LOW,"AP_GetPlayTime","Getting Play Time");

    struct time strPlayTime = AP_GetElapsedTime(oPC,LOGON,oPC,LOGOFF);

    struct time strRealTime = AP_GameToRealTime(strPlayTime);

    return AP_TimeToString(strRealTime);

}

//::///////////////////////////////////////////////
//:: AP_GetRatioTime
//::
//:://////////////////////////////////////////////
/*

*/
//:://////////////////////////////////////////////
//:: Created By: Ranoulf, ag107093@hotmail.com
//:: Created On:
//:://////////////////////////////////////////////
string  AP_GetRatioTime() {

    int iMinInHour = AP_GetMinInHour();
    int iRatio =  60 / iMinInHour;

    return IntToString(iRatio) + ":1 compression (" + IntToString(iMinInHour) + " min per game hour)";
}


//::///////////////////////////////////////////////
//:: AP_PrintTimesToLog
//::
//:://////////////////////////////////////////////
/*

*/
//:://////////////////////////////////////////////
//:: Created By: Ranoulf, ag107093@hotmail.com
//:: Created On:
//:://////////////////////////////////////////////
void    AP_PrintTimesToLog(object oPC)   {

    if (DEBUG_TIME) AP_DeBug(LOW,"AP_PrintTimesToLog","Printing Play Time to log");

    PrintString("");
    PrintString("______Times______");
    PrintString("  log in");
    PrintString("    " + AP_GetWhen(oPC,LOGON) );
    PrintString("  log off");
    PrintString("    " + AP_GetWhen(oPC,LOGOFF) );
    PrintString("  ratio");
    PrintString("    " + AP_GetRatioTime() );
    PrintString("  real time spent playing:");
    PrintString("    " + AP_GetPlayTime(oPC));

    return;
}






















//---------------------------------------------------------//

                     /* Combat functions */























/* constants used by the combat functions */

// Tuneable Constants
int     MINUTES_BETWEEN_COMBATS = 2;
float   YARDS_BETWEEN_COMBATS = 15.0;

              /* named variables */

//  local variables that are reused from fight to fight
string  IN_COMBAT_FLAG = "AP combat flag ";
string  COMBAT_START_TIME = "AP combat start time ";
string  COMBAT_LOCATION = "AP combat location ";
string  STARTING_EXP = "starting EXP";
string  STARTING_GOLD = "starting gold";
string  LAST_ENEMY = "last enemy";

// AP Storage Libs variables that are reused from fight to fight
string  LAST_FIGHT = "last fight";
string  RIGHT_NOW = "right now";

// Perm storage names using the AP Storage Libs
string  COMBAT_NUMBER = "combat number";
string  ENEMY = "enemy";
string  COMBAT = "combat";

// tag to put on items
string  LOOTED = "looted";

// tag to put on creatures
string  HAD_FOUGHT = "had fought";

//::///////////////////////////////////////////////
//:: AP_MonitorCombat
//::
//:://////////////////////////////////////////////
/*
We want to do more than one thing here. We want to
know who we fought, where we fought at, how much
exp and how much treasure.
*/
//:://////////////////////////////////////////////
//:: Created By: Ranoulf, ag107093@hotmail.com
//:: Created On:
//:://////////////////////////////////////////////
void AP_MonitorCombat(object oPC, int iEvent) {

    if (iEvent == START) {
        AP_MonitorPCsCombat(oPC);
        return;
    }

    if (iEvent == STOP) {
        AP_CheckCombatLogout(oPC);
        AP_PrintCombatsToLog(oPC);
        AP_PrintEnemiesToLog(oPC);
        AP_DeleteStoredCombats(oPC);
        AP_DeleteStoredEnemies(oPC);
        AP_DeleteLootedItemMarkers(oPC);
        return;
    }
}

//::///////////////////////////////////////////////
//:: AP_CheckCombatLogout
//::
//:://////////////////////////////////////////////
/*
This function notifies us if the PC logs out in
the midst of combat, and/or when low on HP.

The second conditional is needed because some times
they player will think they are out of a fight
but our timeouts have not yet expired, so we need
to close up the last combat they were in.
*/
//:://////////////////////////////////////////////
//:: Created By: Ranoulf, ag107093@hotmail.com
//:: Created On:
//:://////////////////////////////////////////////
void    AP_CheckCombatLogout(object oPC)    {

    if ( GetIsInCombat(oPC) )   {
        PrintString("");
        PrintString("|--------------------------------------------|");
        PrintString("|  The PC Logged off in the middle of combat |");
        PrintString("|--------------------------------------------|");
        AP_StoreInfo( oPC,COMBAT,"    ---> The PC logged out during combat at this point");
        AP_EndNewCombat(oPC); // we need to close up the open combat so we can report on it later
        return;
    }

//  The PC may not be in combat for some reason, but be about to die
    if ( GetCurrentHitPoints(oPC) <= 0 )    {
        PrintString("");
        PrintString("|-----------------------------------------------------|");
        PrintString("|    The PC Logged off with less than 0 HitPoints     |");
        PrintString("|-----------------------------------------------------|");
        AP_StoreInfo( oPC,COMBAT,"    ---> The PC logged out when below zero HP, prehapse to prevent death at this point");
    }

    if ( AP_GetWasInCombat(oPC) )
        AP_EndNewCombat(oPC);
}

//::///////////////////////////////////////////////
//:: AP_MonitorPCsCombat
//::
//:://////////////////////////////////////////////
/*
 Here we do a few things. Set a combat flag, take
the time, and location.

We do this because Bioware will tell you you're
out of combat the instant you're not attacking
someone. We want a little more delay than that.

We turn the flag on when we get in a combat, but
don't turn it off untill we've been through 2 min
without attacking someone, or we've traveled 50 feet

we also record the last attack in another place so we
get a feel for how long the combat lasted.
*/
//:://////////////////////////////////////////////
//:: Created By: Ranoulf, ag107093@hotmail.com
//:: Created On:
//:://////////////////////////////////////////////
void    AP_MonitorPCsCombat (object oPC) {

//  lets bail if the oPC no longer exists
    if (! GetIsObjectValid(oPC) )  return;

//  If we are just hanging out,(which is most of the time)
    if ( ! GetIsInCombat(oPC) ) {

        AP_ProcessNonCombat(oPC);

//      and reschedule on a slow beat
        DelayCommand( GENERAL_ACCURACY, AP_MonitorPCsCombat(oPC) );

    }

    else {  // we must be in a fight !

        AP_ProcessCombat(oPC);

//      and reschedule ourselves at a faster pace
        DelayCommand( COMBAT_ACCURACY, AP_MonitorPCsCombat(oPC) );

    }

}

//::///////////////////////////////////////////////
//:: AP_ProcessCombat
//::
//:://////////////////////////////////////////////
/*

*/
//:://////////////////////////////////////////////
//:: Created By: Ranoulf, ag107093@hotmail.com
//:: Created On:
//:://////////////////////////////////////////////
void    AP_ProcessCombat(object oPC)    {

    if ( ! AP_GetWasInCombat(oPC) ) {

        if (DEBUG_COMBAT) PrintString("");
        if (DEBUG_COMBAT) AP_DeBug(LOW,"AP_MonitorCombat","This is a new combat");

        AP_StartNewCombat(oPC);

    }

    else {

        if (DEBUG_COMBAT) PrintString("");
        if (DEBUG_COMBAT) AP_DeBug(LOW,"AP_MonitorCombat","We are still in the same fight");

        AP_ContinueCombat(oPC);

    }

    return;
}

//::///////////////////////////////////////////////
//:: AP_GetWasInCombat
//::
//:://////////////////////////////////////////////
/*

*/
//:://////////////////////////////////////////////
//:: Created By: Ranoulf, ag107093@hotmail.com
//:: Created On:
//:://////////////////////////////////////////////
int     AP_GetWasInCombat   (object oPC)    {

    return AP_GetFlag(oPC,IN_COMBAT_FLAG);
}

//::///////////////////////////////////////////////
//:: AP_StartNewCombat
//::
//:://////////////////////////////////////////////
/*

*/
//:://////////////////////////////////////////////
//:: Created By: Ranoulf, ag107093@hotmail.com
//:: Created On:
//:://////////////////////////////////////////////
void    AP_StartNewCombat   (object oPC)    {

//  Set the flag that AP_GetWasInCombat watches for
    AP_SetWasInCombat(oPC,TRUE);

//  Set the start of combat so later we know how long it lasted
    AP_SetCombatStartTime(oPC);

//  Lets mark the location we started at so we know when we've moved away
    AP_SetCombatLocation(oPC);

//  Bring the oPC's equipment up to date so we know what we had before we started fighting
    AP_FlagInventory(oPC,LOOTED);

//  See how much EXP we are starting with so we can compare later
    AP_SetGoldAndExp(oPC);

//  Store this inital combat descrition
    AP_StoreCombatStart(oPC);

//  Describe the group they are fighting, thier allies, and the Challange Ratings
    AP_StoreCombatSides(oPC);

//  And continue with normal round to round combat things
    AP_ContinueCombat(oPC);

    return ;

}

//::///////////////////////////////////////////////
//:: AP_SetWasInCombat
//::
//:://////////////////////////////////////////////
/*
The function could be called GetCombatFlag as
it that's what it does and it matches SetCombatFlag,
but this name is more readable in the higerlevel
functions
*/
//:://////////////////////////////////////////////
//:: Created By: Ranoulf, ag107093@hotmail.com
//:: Created On:
//:://////////////////////////////////////////////
void     AP_SetWasInCombat   (object oPC, int iCondition)    {

    AP_SetFlag(oPC,IN_COMBAT_FLAG,iCondition);
}

//::///////////////////////////////////////////////
//:: AP_SetCombatStartTime
//::
//:://////////////////////////////////////////////
/*

*/
//:://////////////////////////////////////////////
//:: Created By: Ranoulf, ag107093@hotmail.com
//:: Created On:
//:://////////////////////////////////////////////
void    AP_SetCombatStartTime   (object oPC)    {

    AP_SetTime( oPC,COMBAT_START_TIME,AP_GetCurrentTime() );

}

//::///////////////////////////////////////////////
//:: AP_SetCombatLocation
//::
//:://////////////////////////////////////////////
/*
This function is used to store the location of where
a fight took place at
*/
//:://////////////////////////////////////////////
//:: Created By: Ranoulf, ag107093@hotmail.com
//:: Created On:
//:://////////////////////////////////////////////
void    AP_SetCombatLocation (object oPC)   {

    SetLocalLocation( GetModule(), COMBAT_LOCATION + GetName(oPC), GetLocation(oPC) );

}



//::///////////////////////////////////////////////
//:: AP_FlagInventory
//::
//:://////////////////////////////////////////////
/*
This is actually more of a general purpose function
for flagging inventory.

It used here to mark all the stuff the PC already has
so we can compare later and see what they looted.
*/
//:://////////////////////////////////////////////
//:: Created By: Ranoulf, ag107093@hotmail.com
//:: Created On:
//:://////////////////////////////////////////////
void    AP_FlagInventory    (object oPC, string sRegarding)    {

//  start with what's equiped
    string  sItemData;
    int     nSlot = INVENTORY_SLOT_HEAD;  // this is the first slot
    object  oItem = GetItemInSlot( nSlot, oPC);

    while (nSlot <= INVENTORY_SLOT_CARMOUR)     {    // the last slot

        if ( GetGoldPieceValue(oItem) >= ITEM_VALUE_THRESHOLD )
            SetLocalInt(oItem,sRegarding,TRUE);

        nSlot ++;
        oItem = GetItemInSlot( nSlot, oPC);

    } // end while

//  next, with what's being carried
    oItem = GetFirstItemInInventory(oPC);

    while ( GetIsObjectValid(oItem) )   {

        if ( GetGoldPieceValue(oItem) >= ITEM_VALUE_THRESHOLD )
            SetLocalInt(oItem,sRegarding,TRUE);

        oItem = GetNextItemInInventory(oPC);

    } // end while

}

//::///////////////////////////////////////////////
//:: AP_SetGoldAndExp
//::
//:://////////////////////////////////////////////
/*
Here we Get thier Gold and EXP before the fight to
compare afterwards
*/
//:://////////////////////////////////////////////
//:: Created By: Ranoulf, ag107093@hotmail.com
//:: Created On:
//:://////////////////////////////////////////////
void     AP_SetGoldAndExp   (object oPC)    {

    SetLocalInt( GetModule(), STARTING_GOLD + GetName(oPC), GetGold(oPC) );

    SetLocalInt( GetModule(), STARTING_EXP  + GetName(oPC), GetXP(oPC) );

}


//::///////////////////////////////////////////////
//:: AP_StoreCombatStart
//::
//:://////////////////////////////////////////////
/*
Here we prime the DataStore as we'll be pushing the
names of monters as we fight them onto it.
*/
//:://////////////////////////////////////////////
//:: Created By: Ranoulf, ag107093@hotmail.com
//:: Created On:
//:://////////////////////////////////////////////
void     AP_StoreCombatStart     (object oPC)    {

//  The 'COMBAT_NUMBER' data store just keeps track of how many
//  combats we've fought. We store "Combat #" just to have something in it.
    int    iNumberOfCombats = AP_GetStoreSize(oPC,COMBAT_NUMBER);
    string sNewCombatHeader = "Combat # " + IntToString(iNumberOfCombats + 1);
    AP_StoreInfo( oPC,COMBAT_NUMBER, sNewCombatHeader );

//  The 'COMBAT' data store is a specific description of the
//  combat that is about to happen
    AP_StoreInfo( oPC,COMBAT, sNewCombatHeader );
    AP_StoreInfo( oPC,COMBAT,"    started at " + AP_GetNow() );
    AP_StoreInfo( oPC,COMBAT,"    in area " + GetTag(GetArea(oPC)) );
}

//::///////////////////////////////////////////////
//:: AP_StoreCombatSides
//::
//:://////////////////////////////////////////////
/*
This function sums up the opposition and the PC's
allies.

We should consider using a sphere to limit the number
of creatures that could be involved
*/
//:://////////////////////////////////////////////
//:: Created By: Ranoulf, ag107093@hotmail.com
//:: Created On:
//:://////////////////////////////////////////////
void AP_StoreCombatSides(object oPC)  {

    string sEnemies, sAllies;
    float fEnemiesCR, fAlliesCR;

//  lets find the Creature closest to us
    int     iNthCreature = 1;
    object  oCreature = GetNearestObject(OBJECT_TYPE_CREATURE,oPC,iNthCreature);

//  Now cycle though the creatures adding names and CRs
    while ( GetIsObjectValid(oCreature) ) {

        if ( GetIsEnemy(oPC,oCreature) ) {
            if (DEBUG_COMBAT) AP_DeBug(LOW,"AP_StoreCombatSides","Found an enemy");
            sEnemies += GetName(oCreature) + ", ";
            fEnemiesCR += GetChallengeRating(oCreature);
        }

        if ( GetIsFriend(oPC,oCreature) ) {
            if (DEBUG_COMBAT) AP_DeBug(LOW,"AP_StoreCombatSides","Ally Found");
            sAllies += GetName(oCreature) + ", ";
            fAlliesCR += GetChallengeRating(oCreature);
        }

        iNthCreature ++;
        oCreature = GetNearestObject(OBJECT_TYPE_CREATURE,oPC,iNthCreature);
                    //GetNextObjectInShape(SHAPE_SPHERE,YARDS_BETWEEN_COMBATS,GetLocation(OBJECT_SELF));

        if (iNthCreature > 20) {
            if (DEBUG_COMBAT) AP_DeBug(HI,"AP_StoreCombatSides","20 creature limit reached");
            break ; // an excape condition
        }
    } // end while

    fAlliesCR += GetHitDice(oPC); // don't forget about ourselves! (GetChallangeRathing returns error condition when used here for some reason)

//  Now lets sum up what we found
    AP_StoreInfo( oPC,COMBAT,"  The PC picked a fight with:");
    if (sEnemies == "") AP_StoreInfo( oPC,COMBAT,"    No enemy creatures nearby (usually means a sneak attack)");
    else AP_StoreInfo( oPC,COMBAT,"    " + sEnemies);
    AP_StoreInfo( oPC,COMBAT,"    Challange Rating: " + IntToString(FloatToInt(fEnemiesCR)) );

    AP_StoreInfo( oPC,COMBAT,"  The PC's allies were:");
    if (sAllies == "") AP_StoreInfo( oPC,COMBAT,"    No allies present");
    else AP_StoreInfo( oPC,COMBAT,"    " + sAllies);
    AP_StoreInfo( oPC,COMBAT,"    Challange Rating: " + IntToString(FloatToInt(fAlliesCR)) );

//  And leave a intro for the Check Enemies
    AP_StoreInfo( oPC,COMBAT,"  They fought:");
}

//::///////////////////////////////////////////////
//:: AP_ContinueCombat
//::
//:://////////////////////////////////////////////
/*
This is the part of combat that we need to do every
round
*/
//:://////////////////////////////////////////////
//:: Created By: Ranoulf, ag107093@hotmail.com
//:: Created On:
//:://////////////////////////////////////////////
void    AP_ContinueCombat(object oPC)   {

//  Lets see who we are fighting
    AP_CheckEnemies(oPC);

//  Later this will let us see if its been X time since we fought last
    AP_SetTime( oPC,LAST_FIGHT,AP_GetCurrentTime() );

    return;

}

//::///////////////////////////////////////////////
//:: AP_CheckEnemies
//::
//:://////////////////////////////////////////////
/*

*/
//:://////////////////////////////////////////////
//:: Created By: Ranoulf, ag107093@hotmail.com
//:: Created On:
//:://////////////////////////////////////////////
void    AP_CheckEnemies     (object oPC)    {

    object oCurrentEnemy = AP_GetCurrentEnemy(oPC);

    if ( GetIsObjectValid(oCurrentEnemy) ) {

        object oLastEnemy = AP_GetLastEnemy(oPC);

//      if this is a new enemy
        if ( oCurrentEnemy != oLastEnemy &&  ! AP_GetHadFought(oCurrentEnemy) )    {

            if (DEBUG_COMBAT ) AP_DeBug(LOW,"AP_CheckEnemies","This as a new enemy");

            AP_SetHadFought(oCurrentEnemy);
            AP_StoreEnemy(oPC,oCurrentEnemy );

//          if we are fighting another PC, lets take special note
            if ( GetIsPC(oCurrentEnemy) ) AP_MarkPCFight(oPC,oCurrentEnemy);

//          if we are attacking a commoner or a merchant?
            if ( AP_GetIsNPC(oCurrentEnemy) ) AP_MarkNPCFight(oPC,oCurrentEnemy);
        }
    }

    else {

        if (DEBUG_COMBAT ) AP_DeBug(MED,"AP_CheckEnemies","Unable to find attacker with the default bioware function");
    }
}

/*  Some old debug code I saved just in case...

if ( oCurrentEnemy == oLastEnemy )
    if (DEBUG_COMBAT) AP_DeBug(LOW,"AP_CheckEnemies","This is the same enemy");
else
    if (DEBUG_COMBAT) AP_DeBug(LOW,"AP_CheckEnemies","Hey, We've fought this guy before");

else // if no current enemy
    if ( DEBUG_COMBAT ) AP_DeBug(LOW,"AP_CheckEnemies","We don't have an enemy right this second");
    return;
*/


//::///////////////////////////////////////////////
//:: AP_GetCurrentEnemy
//::
//:://////////////////////////////////////////////
/*

*/
//:://////////////////////////////////////////////
//:: Created By: Ranoulf, ag107093@hotmail.com
//:: Created On:
//:://////////////////////////////////////////////
object  AP_GetCurrentEnemy(object oPC) {

    object oTarget = GetAttackTarget(oPC);

    if (DEBUG_COMBAT) AP_DeBug(LOW,"AP_GetCurrentEnemy","Current enemy is " + GetName( oTarget )  );

    return oTarget;
}

//::///////////////////////////////////////////////
//:: AP_GetLastEnemy
//::
//:://////////////////////////////////////////////
/*

*/
//:://////////////////////////////////////////////
//:: Created By: Ranoulf, ag107093@hotmail.com
//:: Created On:
//:://////////////////////////////////////////////
object  AP_GetLastEnemy (object oPC)    {

    return GetLocalObject( GetModule(),LAST_ENEMY + GetName(oPC) );


}

//::///////////////////////////////////////////////
//:: AP_GetHadFought
//::
//:://////////////////////////////////////////////
/*

*/
//:://////////////////////////////////////////////
//:: Created By: Ranoulf, ag107093@hotmail.com
//:: Created On:
//:://////////////////////////////////////////////
int      AP_GetHadFought     (object oEnemy)    {

    return GetLocalInt(oEnemy, HAD_FOUGHT);

}

//::///////////////////////////////////////////////
//:: AP_SetHadFought
//::
//:://////////////////////////////////////////////
/*

*/
//:://////////////////////////////////////////////
//:: Created By: Ranoulf, ag107093@hotmail.com
//:: Created On:
//:://////////////////////////////////////////////
void      AP_SetHadFought     (object oEnemy)    {

    SetLocalInt(oEnemy, HAD_FOUGHT, TRUE);

}

//::///////////////////////////////////////////////
//:: AP_StoreEnemy
//::
//:://////////////////////////////////////////////
/*
This finction stores the enemy three times

First, as a local object on the module so we can
later see if this is still the same guy we've been
fighting (a pack of goblins all have the same name,
tag, and resref, so we can't do it by tag)

Second, it adds to the combat store as a text
description, so we can describe the combat later

Last, it adds him to the running list of enemys
we've fought in the ENEMY data store.
*/
//:://////////////////////////////////////////////
//:: Created By: Ranoulf, ag107093@hotmail.com
//:: Created On:
//:://////////////////////////////////////////////
void    AP_StoreEnemy       (object oPC, object oEnemy) {

    if (DEBUG_COMBAT) AP_DeBug(LOW,"AP_StoreEnemy","Adding an Enemy");

    string sEnemy = GetName(oEnemy) + " (" + GetTag(oEnemy) + ")";

    if ( GetIsPC(oEnemy) )  sEnemy += " (this is another PC!)";

//  First
    SetLocalObject( GetModule(),LAST_ENEMY + GetName(oPC), oEnemy );

//  Second
    AP_StoreInfo( oPC,COMBAT,"    " + sEnemy );

//  Third
    AP_StoreInfo(oPC,ENEMY,sEnemy);

}


//::///////////////////////////////////////////////
//:: AP_MarkPCFight
//::
//:://////////////////////////////////////////////
/*
    If we are fighting another PC, we want to take
    special note of it. We'll print it to the log
    now, and store it as a bulletin for logoff

    PC1 is the PC we are monitoring
*/
//:://////////////////////////////////////////////
//:: Created By: Ranoulf, ag107093@hotmail.com
//:: Created On:
//:://////////////////////////////////////////////
void     AP_MarkPCFight     (object oPC1, object oPC2) {

    string sChar1 = GetName(oPC1);
    string sChar2 = GetName(oPC2);
    string sPlayer1 = GetPCPlayerName(oPC1);
    string sPlayer2 = GetPCPlayerName(oPC2);

    string sWarning =
        sChar1 + " played by " + sPlayer1 +
        " is fighting "  +
        sChar2 + " played by " + sPlayer2;

    PrintString("");
    WriteTimestampedLogEntry("");
    PrintString("---> PvP Conflict <---");
    PrintString(sWarning);

    AP_StoreInfo( oPC1, BULLETIN,sWarning);

}

//::///////////////////////////////////////////////
//:: AP_GetIsNPC
//::
//:://////////////////////////////////////////////
/*
    This function attempts to discover if the person
    we are fighting is a merchant or commoner

    since we can't refer directly to the factions,
    all we can do is try and see how this creature
    feels about commoners and merchants and hostiles

*/
//:://////////////////////////////////////////////
//:: Created By: Ranoulf, ag107093@hotmail.com
//:: Created On:
//:://////////////////////////////////////////////
int      AP_GetIsNPC        (object oCurrentEnemy)  {

    if ( GetObjectType(oCurrentEnemy) != OBJECT_TYPE_CREATURE ) {

        if (DEBUG_COMBAT) AP_DeBug(LOW,"AP_GetIsNPC","Enemy is not a creature");

        return FALSE;
    }

    else {

        int iCommoner = GetStandardFactionReputation(STANDARD_FACTION_COMMONER, oCurrentEnemy);
        int iMerchant = GetStandardFactionReputation(STANDARD_FACTION_MERCHANT, oCurrentEnemy);
        int iDefender = GetStandardFactionReputation(STANDARD_FACTION_DEFENDER, oCurrentEnemy);

        if ( iCommoner == 100 || iMerchant == 100 || iDefender == 100 ) {

            if (DEBUG_COMBAT) AP_DeBug(LOW,"AP_GetIsNPC","Enemy was a NPC");

            return TRUE;
        }

        else {

            if (DEBUG_COMBAT) AP_DeBug(LOW,"AP_GetIsNPC","Enemy wasn't a NPC");

            return FALSE;
        }
    }
}

//::///////////////////////////////////////////////
//:: AP_MarkNPCFight
//::
//:://////////////////////////////////////////////
/*
If the player is attacking a Commoner, Guard or
Merchant, we want to draw the DMs attention to it
by storing the event in the 'bulletins' store

*/
//:://////////////////////////////////////////////
//:: Created By: Ranoulf, ag107093@hotmail.com
//:: Created On:
//:://////////////////////////////////////////////
void     AP_MarkNPCFight    (object oPC, object oCurrentEnemy){

    AP_StoreInfo( oPC, BULLETIN,"Player attacked NPC " + GetName(oCurrentEnemy) + "("+ GetTag(oCurrentEnemy) + ")");

}



//::///////////////////////////////////////////////
//:: AP_ProcessNonCombat
//::
//:://////////////////////////////////////////////
/*
Here we check to see if its been more than 2 min
or we moved 50 feet since the last combat
*/
//:://////////////////////////////////////////////
//:: Created By: Ranoulf, ag107093@hotmail.com
//:: Created On:
//:://////////////////////////////////////////////
void    AP_ProcessNonCombat(object oPC)    {

//  If we didn't just get out of a fight, just return
    if (! AP_GetWasInCombat(oPC) )  return;

//  Otherwise, a fight just ended according to bioware, but we need to check
    else {

        if ( ! AP_GetIsCombatOver(oPC) ) // if it's not really over, just return for now and we'll check again later

            return;

        else {

            if (DEBUG_COMBAT) AP_DeBug(LOW,"AP_ProcessNonCombat","the fight is over");

            AP_EndNewCombat(oPC);

            return;
        }
    }
}



//::///////////////////////////////////////////////
//:: AP_GetIsCombatOver
//::
//:://////////////////////////////////////////////
/*
Bioware says we are not in combat. Is combat really over?

It is if the oPC has moved more than 50 feet
or more than 2 min has gone by while bioware's been
telling us we aren't.
*/
//:://////////////////////////////////////////////
//:: Created By: Ranoulf, ag107093@hotmail.com
//:: Created On:
//:://////////////////////////////////////////////
int     AP_GetIsCombatOver  (object oPC)    {

    if ( AP_GetTimeHasPassed(oPC) || AP_GetHasMovedOn(oPC) )    {
        if (DEBUG_COMBAT) AP_DeBug(LOW,"AP_GetIsCombatOver","Combat is over");
        return TRUE;
    }

    else {
        if (DEBUG_COMBAT) AP_DeBug(LOW,"AP_GetIsCombatOver","We are still waiting for the PC to move on, or time to expire");
        return FALSE;
    }
}


//::///////////////////////////////////////////////
//:: AP_GetTimeHasPassed
//::
//:://////////////////////////////////////////////
/*

*/
//:://////////////////////////////////////////////
//:: Created By: Ranoulf, ag107093@hotmail.com
//:: Created On:
//:://////////////////////////////////////////////
int     AP_GetTimeHasPassed (object oPC)    {

    AP_SetTime( oPC,RIGHT_NOW,AP_GetCurrentTime() );

    int iMinPassed = AP_GetElapsedMin(oPC, LAST_FIGHT, oPC, RIGHT_NOW);

    if (iMinPassed > MINUTES_BETWEEN_COMBATS)  {
        if (DEBUG_COMBAT) AP_DeBug(LOW,"AP_GetTimeHasPassed","enough time has passed");
        return TRUE;
    }
    else
        return FALSE;
}




//::///////////////////////////////////////////////
//:: AP_GetHasMovedOn
//::
//:://////////////////////////////////////////////
/*

*/
//:://////////////////////////////////////////////
//:: Created By: Ranoulf, ag107093@hotmail.com
//:: Created On:
//:://////////////////////////////////////////////
int     AP_GetHasMovedOn    (object oPC)    {

    location lRightHere = GetLocation(oPC);
    location lLastCombatSpot = AP_GetLastLocation(oPC);

    float fDistance = GetDistanceBetweenLocations(lRightHere,lLastCombatSpot);

    if (fDistance > YARDS_BETWEEN_COMBATS)   {
        if (DEBUG_COMBAT) AP_DeBug(LOW,"AP_GetHasMovedOn","we've traveled on");
        return TRUE;
    }

    else
        return FALSE;
    // return (fDistance > YARDS_BETWEEN_COMBATS) ;

}

//::///////////////////////////////////////////////
//:: AP_GetLastLocation
//::
//:://////////////////////////////////////////////
/*

*/
//:://////////////////////////////////////////////
//:: Created By: Ranoulf, ag107093@hotmail.com
//:: Created On:
//:://////////////////////////////////////////////
location    AP_GetLastLocation  (object oPC) {

    return GetLocalLocation( GetModule(), COMBAT_LOCATION + GetName(oPC) );

}

//::///////////////////////////////////////////////
//:: AP_EndNewCombat
//::
//:://////////////////////////////////////////////
/*

*/
//:://////////////////////////////////////////////
//:: Created By: Ranoulf, ag107093@hotmail.com
//:: Created On:
//:://////////////////////////////////////////////
void AP_EndNewCombat    (object oPC) {

        AP_SetWasInCombat(oPC,FALSE);

        AP_StoreCombatEnd(oPC);

        AP_StoreNewItems(oPC);

        AP_StoreGoldAndExp(oPC);

        AP_DeleteTempMarkers(oPC);

}


//::///////////////////////////////////////////////
//:: AP_StoreCombatEnd
//::
//:://////////////////////////////////////////////
/*

*/
//:://////////////////////////////////////////////
//:: Created By: Ranoulf, ag107093@hotmail.com
//:: Created On:
//:://////////////////////////////////////////////
void     AP_StoreCombatEnd     (object oPC)    {


    AP_StoreInfo( oPC,COMBAT,"  Combat lasted:");

    int iMinPassed = AP_GetElapsedMin(oPC, COMBAT_START_TIME, oPC, LAST_FIGHT);

    if (iMinPassed < 1)
        AP_StoreInfo( oPC,COMBAT,"    Less than 1 minute" );
    else
        AP_StoreInfo( oPC,COMBAT,"    " + IntToString(iMinPassed) + " Minute(s)" );


}


//::///////////////////////////////////////////////
//:: AP_StoreNewItems
//::
//:://////////////////////////////////////////////
/*
    Cribed from the item section
*/
//:://////////////////////////////////////////////
//:: Created By:
//:: Created On:
//:://////////////////////////////////////////////
void     AP_StoreNewItems   (object oPC)    {

    AP_StoreInfo( oPC,COMBAT,"  They looted in items:");

    string  sItemData;
    int     nSlot = INVENTORY_SLOT_HEAD;  // this is the first slot
    object  oItem = GetItemInSlot( nSlot, oPC);

    while (nSlot <= INVENTORY_SLOT_CARMOUR)     {    // the last slot

        if ( GetGoldPieceValue(oItem) >= ITEM_VALUE_THRESHOLD )   {

            sItemData = IntToString(GetNumStackedItems(oItem)) + " " + GetName(oItem) + " (" + GetTag(oItem) + ")";

            if ( ! AP_GetWasLooted(oItem) ) {
                AP_StoreInfo( oPC,COMBAT,"    " + sItemData );
                AP_SetWasLooted(oItem); // so later we know what they gained
            }
        }

        nSlot ++;
        oItem = GetItemInSlot( nSlot, oPC);

    } // end while

    oItem = GetFirstItemInInventory(oPC);

    while ( GetIsObjectValid(oItem) )   {

        if ( GetGoldPieceValue(oItem) >= ITEM_VALUE_THRESHOLD )   {

            sItemData = IntToString(GetNumStackedItems(oItem)) + " " + GetName(oItem) + " (" + GetTag(oItem) + ")";

            if ( ! AP_GetWasLooted(oItem) ) {
                AP_StoreInfo( oPC,COMBAT,"    " + sItemData );
                AP_SetWasLooted(oItem); // so later we know what they gained
            }
        }

        oItem = GetNextItemInInventory(oPC);

    } // end while

}

//::///////////////////////////////////////////////
//:: AP_StoreGoldAndExp
//::
//:://////////////////////////////////////////////
/*

*/
//:://////////////////////////////////////////////
//:: Created By: Ranoulf, ag107093@hotmail.com
//:: Created On:
//:://////////////////////////////////////////////
void     AP_StoreGoldAndExp (object oPC)    {

//  Lets start with the change in gold
    int iOriginalGold = GetLocalInt( GetModule(), STARTING_GOLD + GetName(oPC) );
    int iCurrentGold = GetGold(oPC);
    string sGold = IntToString(iCurrentGold - iOriginalGold);

    AP_StoreInfo( oPC,COMBAT,"  They looted in gold:");
    AP_StoreInfo( oPC,COMBAT,"    " + sGold);

//  Now the change in EXP
    int iOriginalEXP = GetLocalInt( GetModule(), STARTING_EXP + GetName(oPC) );
    int iCurrentEXP = GetXP(oPC);
    string sEXP = IntToString(iCurrentEXP - iOriginalEXP);

    AP_StoreInfo( oPC,COMBAT,"  They gained in EXP:");
    AP_StoreInfo( oPC,COMBAT,"    " + sEXP);

}

//::///////////////////////////////////////////////
//:: AP_DeleteTempMarkers
//::
//:://////////////////////////////////////////////
/*
This function deletes all the temporary variables
we employed during this fight
*/
//:://////////////////////////////////////////////
//:: Created By: Ranoulf, ag107093@hotmail.com
//:: Created On:
//:://////////////////////////////////////////////
void     AP_DeleteTempMarkers   (object oPC)    {

    AP_DelTime( oPC,COMBAT_START_TIME );

    DeleteLocalLocation( GetModule(), COMBAT_LOCATION + GetName(oPC) );

    DeleteLocalInt( GetModule(), STARTING_GOLD + GetName(oPC) );

    DeleteLocalInt( GetModule(), STARTING_EXP  + GetName(oPC) );

    AP_DelTime( oPC,LAST_FIGHT );

    AP_DelFlag( oPC,IN_COMBAT_FLAG);

    AP_DelTime( oPC,RIGHT_NOW);

    DeleteLocalObject( GetModule(), LAST_ENEMY  + GetName(oPC) );
}





//::///////////////////////////////////////////////
//:: AP_SetWasLooted
//::
//:://////////////////////////////////////////////
/*
Tags the item with a variable so we can tell later
if it was present at logon
*/
//:://////////////////////////////////////////////
//:: Created By: Ranoulf, ag107093@hotmail.com
//:: Created On:
//:://////////////////////////////////////////////
void    AP_SetWasLooted     (object oItem)    {

    SetLocalInt(oItem,LOOTED,TRUE);

    return;
}

//::///////////////////////////////////////////////
//:: AP_GetWasLooted
//::
//:://////////////////////////////////////////////
/*
Returns the vaule of the variable named HAD_AT_ENTRY.
If the variable isn't present, 0 is returned.
*/
//:://////////////////////////////////////////////
//:: Created By: Ranoulf, ag107093@hotmail.com
//:: Created On:
//:://////////////////////////////////////////////
int     AP_GetWasLooted    (object oItem)  {

    return GetLocalInt(oItem,LOOTED);
}

//::///////////////////////////////////////////////
//:: AP_PrintCombatsToLog
//::
//:://////////////////////////////////////////////
/*

*/
//:://////////////////////////////////////////////
//:: Created By:
//:: Created On:
//:://////////////////////////////////////////////
void    AP_PrintCombatsToLog(object oPC)    {

    PrintString( " " );
    PrintString( "______Combats______" );

    AP_DumpInfoToLog(oPC,COMBAT);

    return;

}

//::///////////////////////////////////////////////
//:: AP_PrintEnemiesToLog
//::
//:://////////////////////////////////////////////
/*

*/
//:://////////////////////////////////////////////
//:: Created By:
//:: Created On:
//:://////////////////////////////////////////////
void    AP_PrintEnemiesToLog(object oPC)    {

    PrintString( " " );
    PrintString( "______Enemies______" );

    AP_DumpInfoToLog(oPC,ENEMY);

    int iTotalInfo = AP_GetStoreSize(oPC,ENEMY);
    PrintString("  Total Fought:");
    PrintString("    " + IntToString(iTotalInfo) );
}

//::///////////////////////////////////////////////
//:: AP_DeleteStoredCombats
//::
//:://////////////////////////////////////////////
/*

*/
//:://////////////////////////////////////////////
//:: Created By: Ranoulf, ag107093@hotmail.com
//:: Created On:
//:://////////////////////////////////////////////
void    AP_DeleteStoredCombats(object oPC)  {

    AP_DeleteStore( oPC,COMBAT_NUMBER );
    AP_DeleteStore( oPC,COMBAT );

}

//::///////////////////////////////////////////////
//:: AP_DeleteStoredCombats
//::
//:://////////////////////////////////////////////
/*

*/
//:://////////////////////////////////////////////
//:: Created By: Ranoulf, ag107093@hotmail.com
//:: Created On:
//:://////////////////////////////////////////////
void    AP_DeleteStoredEnemies   (object oPC)  {

    AP_DeleteStore( oPC,ENEMY);

}

//::///////////////////////////////////////////////
//:: AP_DeleteLootedItemMarkers
//::
//:://////////////////////////////////////////////
/*
    During the course of their adventures, the PC's
    items are marked up with local vars so we know
    what they looted from fight to fight.

    In use, only valuable items are flagged, but it
    is faster for us just to issue a delete on every
    item than to check every item to see if the flag
    is present and then delte only thouse with flags.

    There is a potential bioware bug with deleting
    these flags at OnExit, in that some vars cannot be
    deleted as the PC exits that relate to the oPC.

    Future attemps may be to set and delete before
    and after every fight.

*/
//:://////////////////////////////////////////////
//:: Created By: Ranoulf, ag107093@hotmail.com
//:: Created On:
//:://////////////////////////////////////////////
void    AP_DeleteLootedItemMarkers(object oPC) {

     // now lets take a look at thier inventory
    object oItem = GetFirstItemInInventory(oPC);

    while ( GetIsObjectValid(oItem) ) {

        DeleteLocalInt(oItem,LOOTED);

        oItem = GetNextItemInInventory(oPC);
    }

    // and the items they have equiped too.
    int     nSlot = INVENTORY_SLOT_HEAD;  // this is the first slot
            oItem = GetItemInSlot( nSlot, oPC);

    while (nSlot <= INVENTORY_SLOT_CARMOUR)     {    // the last slot
        DeleteLocalInt(oItem,LOOTED);
        nSlot ++;
        oItem = GetItemInSlot( nSlot, oPC);
    }
}
















//---------------------Global Flag Functions-------------------------//


















//::///////////////////////////////////////////////
//:: AP_SetFlag
//::
//:://////////////////////////////////////////////
/*

*/
//:://////////////////////////////////////////////
//:: Created By: Ranoulf, ag107093@hotmail.com
//:: Created On:
//:://////////////////////////////////////////////
void    AP_SetFlag    (object oSubject, string sRegarding, int iCondition) {

    // now let's build the unique name of the variable we are actually going to use
    string  VAR_NAME  = "AP Flag _" + GetName(oSubject) + sRegarding;

    if (iCondition == TRUE)    {
        SetLocalInt(GetModule(),VAR_NAME,TRUE);
        if (DEBUG_COMBAT) AP_DeBug(LOW,"AP_SetCombatStart", sRegarding + " flag has been set TRUE");
        return;
    }

    if (iCondition == FALSE)    {
        SetLocalInt(GetModule(),VAR_NAME,FALSE);
        if (DEBUG_COMBAT) AP_DeBug(LOW,"AP_SetCombatStart", sRegarding + " flag has been set FALSE");
        return;
    }
}

//::///////////////////////////////////////////////
//:: AP_GetFlag
//::
//:://////////////////////////////////////////////
/*

*/
//:://////////////////////////////////////////////
//:: Created By: Ranoulf, ag107093@hotmail.com
//:: Created On:
//:://////////////////////////////////////////////
int    AP_GetFlag    (object oSubject, string sRegarding) {

    // now let's build the unique name of the variable we are actually going to use
    string  VAR_NAME  = "AP Flag _" + GetName(oSubject) + sRegarding;

    return GetLocalInt(GetModule(),VAR_NAME);
}

//::///////////////////////////////////////////////
//:: AP_DelFlag
//::
//:://////////////////////////////////////////////
/*

*/
//:://////////////////////////////////////////////
//:: Created By: Ranoulf, ag107093@hotmail.com
//:: Created On:
//:://////////////////////////////////////////////
void    AP_DelFlag    (object oSubject, string sRegarding) {

    // now let's build the unique name of the variable we are actually going to use
    string  VAR_NAME  = "AP Flag _" + GetName(oSubject) + sRegarding;

    DeleteLocalInt(GetModule(),VAR_NAME);
}












//----------------------======+++++++=======-------------------//

                       // Storage functions //











/* constants used by the storager functions */

object STOREAGE_CONTAINER = GetModule();

//::///////////////////////////////////////////////
//:: AP_StoreInfo
//::
//:://////////////////////////////////////////////
/*
Parameters:

  oSubject : The object you store the data about
sRegarding : The varibale name used to referance the data
     sInfo : The data payload

Description:

This function serves as a generic storage device
for all the other functions. It pretends to be a
referenced stack, allowing the other funtions to
'push' multiple data onto the same varibale name
but still refrence individual elements for retrieval

It's key feature is allowing us to store multiple
data 'sRegarding' the same thing without having to
generate and refer to an individual local variable
for everyting we want to store or print.

How it works:

It works by creating a local variable for each
string you pass in. The names of these local
variables are based on the name you give it,
with a number appended saying this is the Nth
item you've passed in.

It generates the number by keeping track of how
many things you've given it and incrementing by
one each time.


*/
//:://////////////////////////////////////////////
//:: Created By: Ranoulf, ag107093@hotmail.com
//:: Created On:
//:://////////////////////////////////////////////
void    AP_StoreInfo    (object oSubject, string sRegarding, string sInfo) {

    // lets see how many things we've already stored and increment one for the new element
    int iNewSize = AP_GetStoreSize(oSubject,sRegarding) + 1;

    // now let's build the unique name of the variable we are actually going to use
    string  sElementNumber = IntToString(iNewSize);
    string  sName     = GetName(oSubject);   // put the name is so we know who it goes with in a save-game editor
    string  VAR_NAME  = "AP_DATA_" + sName + sRegarding + sElementNumber;

    SetLocalString(STOREAGE_CONTAINER,VAR_NAME,sInfo);

    // increment our total variable
    VAR_NAME = "AP_DATA_" + sName + sRegarding + "_INFO_COUNT";

    SetLocalInt(STOREAGE_CONTAINER,VAR_NAME,iNewSize);

}







//::///////////////////////////////////////////////
//:: AP_GetInfoCount
//::
//:://////////////////////////////////////////////
/*

*/
//:://////////////////////////////////////////////
//:: Created By: Ranoulf, ag107093@hotmail.com
//:: Created On:
//:://////////////////////////////////////////////
int AP_GetStoreSize(object oSubject, string sRegarding) {

    string sName = GetName(oSubject);
    string VAR_NAME = "AP_DATA_" + sName + sRegarding + "_INFO_COUNT";

    return GetLocalInt(STOREAGE_CONTAINER,VAR_NAME);

}

//::///////////////////////////////////////////////
//:: AP_GetInfo
//::
//:://////////////////////////////////////////////
/*

*/
//:://////////////////////////////////////////////
//:: Created By: Ranoulf, ag107093@hotmail.com
//:: Created On:
//:://////////////////////////////////////////////
string  AP_GetInfo      (object oSubject, string sRegarding, int iNth) {

    string  sNth      = IntToString(iNth);
    string  sName     = GetName(oSubject);
    string  VAR_NAME  = "AP_DATA_" + sName + sRegarding + sNth;

    return GetLocalString(STOREAGE_CONTAINER,VAR_NAME);
}

//::///////////////////////////////////////////////
//:: AP_GetLastInfo
//::
//:://////////////////////////////////////////////
/*

*/
//:://////////////////////////////////////////////
//:: Created By: Ranoulf, ag107093@hotmail.com
//:: Created On:
//:://////////////////////////////////////////////
string  AP_GetLastInfo  (object oSubject, string sRegarding) {

    int iLast = AP_GetStoreSize(oSubject,sRegarding);

    return AP_GetInfo(oSubject,sRegarding,iLast);
}

//::///////////////////////////////////////////////
//:: AP_DumpInfoToLog
//::
//:://////////////////////////////////////////////
/*

*/
//:://////////////////////////////////////////////
//:: Created By: Ranoulf, ag107093@hotmail.com
//:: Created On:
//:://////////////////////////////////////////////
void    AP_DumpInfoToLog       (object oSubject, string sRegarding)    {

    int iCurrentElement = 1;
    int iLastElement = AP_GetStoreSize(oSubject,sRegarding);

    PrintString(sRegarding);
    while (iCurrentElement <= iLastElement) {
        PrintString("    " + AP_GetInfo(oSubject,sRegarding,iCurrentElement) );
        iCurrentElement ++;
    }

}

//::///////////////////////////////////////////////
//:: AP_DestroyInfo
//::
//:://////////////////////////////////////////////
/*
This function is works backwards through the variables
and deletes them, finishing with the size couter as well
*/
//:://////////////////////////////////////////////
//:: Created By: Ranoulf, ag107093@hotmail.com
//:: Created On:
//:://////////////////////////////////////////////
void    AP_DeleteStore  (object oSubject, string sRegarding) {

    string  sElementNumber;
    string  sName;
    string  VAR_NAME;

    // lets see how big the stack is
    int iStoreSize = AP_GetStoreSize(oSubject,sRegarding);

    while (iStoreSize > 0) {

        // now let's build the name of the variable we are actually going to get rid of
        sElementNumber = IntToString(iStoreSize);
        sName     = GetName(oSubject);
        VAR_NAME  = "AP_DATA_" + sName + sRegarding + sElementNumber;

        DeleteLocalString(STOREAGE_CONTAINER,VAR_NAME);

        // decrement our total
        iStoreSize --;

    }

    // once we've deleted all the varibales associated with it, get rid of our size varibale too
    VAR_NAME = "AP_DATA_" + sName + sRegarding + "_INFO_COUNT";

    DeleteLocalInt(STOREAGE_CONTAINER,VAR_NAME);

    return;

}














//----------------------======+++++++=======----------------------//

                 // lower level time functions //













/* storage object used by the time functions */
object TIME_VESSEL = GetModule();

/* Time Constants */

//  MIN_TO_HOUR is special because it is a setting in the module properties. We
//  find out what it is by using the HoursToSeconds function and getting the
//  result back to minutes.
    int MIN_TO_HOUR = FloatToInt(HoursToSeconds(1) / 60 );
    int REAL_MIN_TO_HOUR = 60;
// the rest are hard coded in the module
    int HOUR_TO_DAY = 24;
    int DAY_TO_MON = 28;
    int MON_TO_YR = 12;



/* Time Data type */

//  This is a special strut the functions use to be able to handle a single
//  point in time in a more elegant fashion.
struct time   {
    int iMin;
    int iHour;
    int iDay;
    int iMonth;
    int iYear;
    };



//::///////////////////////////////////////////////
//:: AP_GetNow
//::
//:://////////////////////////////////////////////
/*

*/
//:://////////////////////////////////////////////
//:: Created By: Ranoulf, ag107093@hotmail.com
//:: Created On:
//:://////////////////////////////////////////////
string AP_GetNow() {

    return  AP_TimeToString( AP_GetCurrentTime() );
}

//::///////////////////////////////////////////////
//:: AP_GetWhen
//::
//:://////////////////////////////////////////////
/*

*/
//:://////////////////////////////////////////////
//:: Created By: Ranoulf, ag107093@hotmail.com
//:: Created On:
//:://////////////////////////////////////////////
string AP_GetWhen(object oPC, string sEvent) {

    return AP_TimeToString( AP_GetTime(oPC,sEvent) );

}

//::///////////////////////////////////////////////
//:: AP_GetMinInHour
//::
//:://////////////////////////////////////////////
/*

*/
//:://////////////////////////////////////////////
//:: Created By: Ranoulf, ag107093@hotmail.com
//:: Created On:
//:://////////////////////////////////////////////
int AP_GetMinInHour() {

    return FloatToInt(HoursToSeconds(1) / 60 );
}

//::///////////////////////////////////////////////
//:: AP_SetTime
//::
//:://////////////////////////////////////////////
/*
This function creates a series of local Ints keyed
to the oSubjects name and stored on the TIME_VESSEL
object defined above and hold the year, month, day,
hour, and min the Subject (a PC) logged in.

It is stored on the module rather than the PC because
of the inability to delete any variables at OnExit
time that are stored on the oPC
*/
//:://////////////////////////////////////////////
//:: Created By: Ranoulf, ag107093@hotmail.com
//:: Created On:
//:://////////////////////////////////////////////
void AP_SetTime(object oSubject, string sEvent, struct time strTime) {

//  Here are the names of the variables we are going to store
//  data in. We only use them in SetTime and GetTime
    string sName = GetName(oSubject);
    string MIN   = "AP_DATA_" + sName + sEvent + "_MIN";
    string HOUR  = "AP_DATA_" + sName + sEvent + "_HOUR";
    string DAY   = "AP_DATA_" + sName + sEvent + "_DAY";
    string MONTH = "AP_DATA_" + sName + sEvent + "_MONTH";
    string YEAR  = "AP_DATA_" + sName + sEvent + "_YEAR";

//  Now lets set some data on the object
    SetLocalInt( TIME_VESSEL,MIN  ,strTime.iMin );
    SetLocalInt( TIME_VESSEL,HOUR ,strTime.iHour );
    SetLocalInt( TIME_VESSEL,DAY  ,strTime.iDay );
    SetLocalInt( TIME_VESSEL,MONTH,strTime.iMonth );
    SetLocalInt( TIME_VESSEL,YEAR ,strTime.iYear );

} // end SetLogonTime

//::///////////////////////////////////////////////
//:: AP_GetTime
//::
//:://////////////////////////////////////////////
/*
This function returns a time struct with the PC's
logon time.
*/
//:://////////////////////////////////////////////
//:: Created By: Ranoulf, ag107093@hotmail.com
//:: Created On:
//:://////////////////////////////////////////////
struct time AP_GetTime(object oSubject, string sEvent) {

//  Here are the names of the variables we are going to store
//  data in. We only use them in SetTime and GetTime
    string sName = GetName(oSubject);
    string MIN   = "AP_DATA_" + sName + sEvent + "_MIN";
    string HOUR  = "AP_DATA_" + sName + sEvent + "_HOUR";
    string DAY   = "AP_DATA_" + sName + sEvent + "_DAY";
    string MONTH = "AP_DATA_" + sName + sEvent + "_MONTH";
    string YEAR  = "AP_DATA_" + sName + sEvent + "_YEAR";


    struct time strEventTime;

    strEventTime.iMin  = GetLocalInt(TIME_VESSEL,MIN  );
    strEventTime.iHour = GetLocalInt(TIME_VESSEL,HOUR );
    strEventTime.iDay  = GetLocalInt(TIME_VESSEL,DAY  );
    strEventTime.iMonth= GetLocalInt(TIME_VESSEL,MONTH);
    strEventTime.iYear = GetLocalInt(TIME_VESSEL,YEAR );

    return strEventTime;

} // end AP_GetTime

//::///////////////////////////////////////////////
//:: AP_DelTime
//::
//:://////////////////////////////////////////////
/*

*/
//:://////////////////////////////////////////////
//:: Created By: Ranoulf, ag107093@hotmail.com
//:: Created On:
//:://////////////////////////////////////////////
void    AP_DelTime  (object oSubject, string sEvent)    {

//  Here are the names of the variables we used to store data in
    string sName = GetName(oSubject);
    string MIN   = "AP_DATA_" + sName + sEvent + "_MIN";
    string HOUR  = "AP_DATA_" + sName + sEvent + "_HOUR";
    string DAY   = "AP_DATA_" + sName + sEvent + "_DAY";
    string MONTH = "AP_DATA_" + sName + sEvent + "_MONTH";
    string YEAR  = "AP_DATA_" + sName + sEvent + "_YEAR";

//  Now lets delete the variables
    DeleteLocalInt( TIME_VESSEL,MIN);
    DeleteLocalInt( TIME_VESSEL,HOUR);
    DeleteLocalInt( TIME_VESSEL,DAY);
    DeleteLocalInt( TIME_VESSEL,MONTH);
    DeleteLocalInt( TIME_VESSEL,YEAR);

}



//::///////////////////////////////////////////////
//:: AP_GetCurrentTime
//::
//:://////////////////////////////////////////////
/*
This function returns a logon struct with the
current time.
*/
//:://////////////////////////////////////////////
//:: Created By: Ranoulf, ag107093@hotmail.com
//:: Created On:
//:://////////////////////////////////////////////
struct time AP_GetCurrentTime() {

    struct time strCurrentTime;

    strCurrentTime.iMin  = GetTimeMinute();
    strCurrentTime.iHour = GetTimeHour();
    strCurrentTime.iMonth= GetCalendarMonth();
    strCurrentTime.iDay  = GetCalendarDay();
    strCurrentTime.iYear = GetCalendarYear();

    return strCurrentTime;

} // end AP_GetCurrentTime

//::///////////////////////////////////////////////
//:: AP_GetElapsedTime
//::
//:://////////////////////////////////////////////
/*
Note: expects the second event to come AFTER the
first event.

This function essentually does longhand subtraction.
It looks funny, but works better than the old
DIV MOD trick.
*/
//:://////////////////////////////////////////////
//:: Created By: Ranoulf, ag107093@hotmail.com
//:: Created On:
//:://////////////////////////////////////////////
struct time AP_GetElapsedTime(object oSubject1, string sEvent1, object oSubject2, string sEvent2) {

    struct time strFormer = AP_GetTime(oSubject1,sEvent1);
    struct time strLatter = AP_GetTime(oSubject2,sEvent2);
    struct time strSpentTime;

//  this subtraction can leave us with negative numbers
    strSpentTime.iMin   = strLatter.iMin - strFormer.iMin;
    strSpentTime.iHour  = strLatter.iHour - strFormer.iHour;
    strSpentTime.iDay   = strLatter.iDay - strFormer.iDay;
    strSpentTime.iMonth = strLatter.iMonth - strFormer.iMonth;
    strSpentTime.iYear  = strLatter.iYear - strFormer.iYear;

//  but we fix it here, by 'carrying' after the fact.
    if (strSpentTime.iMin < 0) {
        strSpentTime.iMin += MIN_TO_HOUR;
        strSpentTime.iHour -- ;
    }
    if (strSpentTime.iHour < 0)  {
        strSpentTime.iHour += HOUR_TO_DAY;
        strSpentTime.iDay -- ;
    }
    if (strSpentTime.iDay < 0) {
        strSpentTime.iDay += DAY_TO_MON;
        strSpentTime.iMonth -- ;
    }
    if (strSpentTime.iMonth < 0) {
        strSpentTime.iMonth += MON_TO_YR;
        strSpentTime.iYear -- ;
    }

    return strSpentTime;

}

//::///////////////////////////////////////////////
//:: AP_GetMinBetween
//::
//:://////////////////////////////////////////////
/*
This is the more traditional method of setting
minute marks and comparing the difference.
*/
//:://////////////////////////////////////////////
//:: Created By: Ranoulf, ag107093@hotmail.com
//:: Created On:
//:://////////////////////////////////////////////
int AP_GetElapsedMin(object oSubject1, string sEvent1, object oSubject2, string sEvent2) {

    struct time strFormer = AP_GetTime(oSubject1,sEvent1);
    struct time strLatter = AP_GetTime(oSubject2,sEvent2);

    int iFormerMin = (strFormer.iMin) +
                     (strFormer.iHour  *  MIN_TO_HOUR) +
                     (strFormer.iDay   *  HOUR_TO_DAY * MIN_TO_HOUR) +
                     (strFormer.iMonth *  DAY_TO_MON  * HOUR_TO_DAY * MIN_TO_HOUR) +
                     (strFormer.iYear  *  MON_TO_YR   * DAY_TO_MON  *  HOUR_TO_DAY * MIN_TO_HOUR);



     int iLatterMin =(strLatter.iMin) +
                     (strLatter.iHour  *  MIN_TO_HOUR) +
                     (strLatter.iDay   *  HOUR_TO_DAY * MIN_TO_HOUR) +
                     (strLatter.iMonth *  DAY_TO_MON  * HOUR_TO_DAY * MIN_TO_HOUR) +
                     (strLatter.iYear  *  MON_TO_YR   * DAY_TO_MON  *  HOUR_TO_DAY * MIN_TO_HOUR);

    return iLatterMin - iFormerMin;

}

//::///////////////////////////////////////////////
//:: AP_GameToRealTime
//::
//:://////////////////////////////////////////////
/*
This function takes an amount of elapsed time in the
time struct format,(like 2 days, 5 hours, and 12 minitues)
and converts it to an amount of real time based on
the module's time compression ratio.
*/
//:://////////////////////////////////////////////
//:: Created By: Ranoulf, ag107093@hotmail.com
//:: Created On:
//:://////////////////////////////////////////////
struct time AP_GameToRealTime(struct time strTime) {

//  lets get the total minutes out of the time struct. Note that the
//  MIN_TO_HOUR constant gets set at the top based on the module's setting
//  and represents the number of 'real' min in an hour of game time. By
//  using it here we get a total of 'real' minites without any messy conversions
    struct time strRealTime;
    strRealTime.iMin =
        (strTime.iMin) +
        (strTime.iHour  *  MIN_TO_HOUR) +
        (strTime.iDay   *  HOUR_TO_DAY * MIN_TO_HOUR) +
        (strTime.iMonth *  DAY_TO_MON  * HOUR_TO_DAY * MIN_TO_HOUR) +
        (strTime.iYear  *  MON_TO_YR   * DAY_TO_MON  *  HOUR_TO_DAY * MIN_TO_HOUR);

    // Now the old DIV MOD trick to break the total minitues back into hours and days
    strRealTime.iHour = strRealTime.iMin / 60;
    strRealTime.iMin %= 60;

    strRealTime.iDay = strRealTime.iHour / 24;
    strRealTime.iHour %= 24;

    strRealTime.iMonth = strRealTime.iDay / 30; // not exactly accurate
    strRealTime.iDay %= 30;

    strRealTime.iYear = strRealTime.iMonth / 12;
    strRealTime.iMonth %= 12;

    // Now let's return the time struct we just filled
    return strRealTime;

} // end AP_GameToRealTime


//::///////////////////////////////////////////////
//:: AP_TimeToString
//::
//:://////////////////////////////////////////////
/*
Converts a struct time into a printable string
*/
//:://////////////////////////////////////////////
//:: Created By: Ranoulf, ag107093@hotmail.com
//:: Created On:
//:://////////////////////////////////////////////
string      AP_TimeToString(struct time sTime) {

    string sMin = IntToString(sTime.iMin);
    string sHour = IntToString(sTime.iHour);
    string sDay = IntToString(sTime.iDay);
    string sMonth = IntToString(sTime.iMonth);
    string sYear = IntToString(sTime.iYear);

    // and spit it out
    return   sMin + " Minutes, "
           + sHour   + " Hours, "
           + sDay    + " Days, "
           + sMonth  + " Months, "
           + sYear   + " Years." ;
}

//::///////////////////////////////////////////////
//:: AP_DeBug
//::
//:://////////////////////////////////////////////
/*

*/
//:://////////////////////////////////////////////
//:: Created By: Ranoulf, ag107093@hotmail.com
//:: Created On:
//:://////////////////////////////////////////////
void AP_DeBug   (int iDebugLevel, string sCallingFunction, string sMessage) {

    PrintString(sCallingFunction + " : " + sMessage);
    SpeakString(sCallingFunction + " : " + sMessage,TALKVOLUME_SHOUT);

    return;
}

/*  old code */


//::///////////////////////////////////////////////
//:: AP_GetRealTimeOn
//::
//:://////////////////////////////////////////////
/*
What we do here is the old DIV and MOD trick
If you got 1000 min, DIV by 60 to get the hours, and
the MOD is whats left over for minutes
//:://////////////////////////////////////////////
//:: Created By: Ranoulf, ag107093@hotmail.com
//:: Created On:
//:://////////////////////////////////////////////
string      AP_GetRealTimeOn (object oPC) {

    int iMinutes = AP_GetRealMinutesOn(oPC);

    int iHours = iMinutes / 60;
    iMinutes %= 60;

    int iDays = iHours / 24;
    iHours %= 24;

    int iMonths = iDays / 30;
    iDays %= 30;

    int iYears = iMonths / 12;
    iMonths %= 12;

    string sMinutes = IntToString(iMinutes);
    string sHours = IntToString(iHours);
    string sDays = IntToString(iDays);
    string sMonths = IntToString(iMonths);
    string sYears = IntToString(iYears);

    return sMinutes + " Minutes, " +
           sHours + " Hours, " +
           sDays + " Days, " +
           sMonths + " Months, " +
           sYears + " Years";
}

// to do

Test GetIsBanned.

In Combat, instead of putting HAD_FOUGHT on enemys, use a table
instead so the memory can be reclaimed instead of possibly lost
when the mob dies.

// fixes and changes

version 1.1.1
added logic to GetIsNPC so as not to check factions on
non-creature type objects. It was causeing a stack overflow
in the nwscript engine.

version 1.1
expempted DMs
changed net worth to also sum up what PCs have equiped
lowered the item vaule threshold to 100gp from 500gp
*/
