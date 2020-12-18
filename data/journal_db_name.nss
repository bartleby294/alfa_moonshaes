//::///////////////////////////////////////////////
//:: Journal Database Naming
//:: journal_db_name
//:://////////////////////////////////////////////
/*

*/
//:://////////////////////////////////////////////
//::  Constants
//:://////////////////////////////////////////////

// the variable strJournalDatabaseName indicates the campaign
// database to which the journal information will be written
// set this value to the name that you wish to use.
const string strJournalDatabaseName = "JournalDatabase";

//:://////////////////////////////////////////////
//::     Method:    dhGetJournalDatabaseName
//:: Created By:    Dauvis
//:: Created On:    7/13/03
//::
//:: This function will return the campaign name for the
//:: the journal.  To control to where the player's journal
//:: information will be stored, change this function.
//:://////////////////////////////////////////////
string dhGetJournalDatabaseName(object oPlayer)
{
    return strJournalDatabaseName;
}

