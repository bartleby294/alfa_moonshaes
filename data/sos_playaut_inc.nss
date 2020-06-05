// Name             :   System of the Sages (SOS) - Include Script
// System           :   Player Authentication System
// Description      :   This include implements the scripts that make up the core
//                          functionality of the SOS system.
// Authors          :   Stephen "Trismuss" Clayburn
//                      T Guiles
//                      Silmar Trekfollower

// This file is licensed under the terms of the
// GNU GENERAL PUBLIC LICENSE (GPL) Version 2

#include "alfa_persist"
#include "alfa_options"
// Forward Reference:
void SOS_SendMessageNumeric( object oPC, int iMessage, int iSendToPlayer = TRUE,
     int iSendToDM = TRUE, int iWriteLogEntry = TRUE );

/******************************************************************************/
/* Constants                                                                  */
/******************************************************************************/


/******************************************************************************/
/* Function definitions                                                       */
/******************************************************************************/

int SOS_PlayerLogin(object poPC);
/******************************************************************************/
/*  SOS_PlayerLogin

    Parameters:

    [in] object poPC
        Pass this parameter a valid PC object

    Return Values:

        WK_SUCCESS - If the value was successfully retrieved from the database
            this is the return value

        WK_ERROR - If there was a problem executing the database statement, this
            will be the return value

    Description: This will validate incoming PC's against the database to determine
                    if they have valid accounts, and what the status of their
                    character(s) is.

/******************************************************************************/

void SOS_BootPC(object poPC);
/******************************************************************************/
/*  SOS_BootPC

    Parameters:

    [in] object poPC
        Pass this parameter a valid PC object

    Return Values:

    None

    Description: This will Boot the poPC, based upon the way that BOOT switched
                    are set in the sos_switches file.

/******************************************************************************/

int SOS_GetPlayerRank(object poPC);
/******************************************************************************/
/*  SOS_GetPlayerRank

    Parameters:

    [in] object poPC
        Pass this parameter a valid PC object

    Return Values:

        The Players Rank

    Description: This function looks up the Player Rank that is stored in the
                    database and returns it to the caller.

/******************************************************************************/

int SOS_GetIsNewCharacterAllowed(object poPC);
/******************************************************************************/
/*  SOS_GetIsNewCharacterAllowed

    Parameters:

    [in] object poPC
        Pass this parameter a valid PC object

    Return Values:

        The Players Rank

    Description: This function will check and see if a Player can have multiple
                    characters, regardless of the way that the ALLOWMULTICHARS
                    switch is set.

/******************************************************************************/

int SOS_GetCharacterStatus(object poPC);
/******************************************************************************/
/*  SOS_GetCharacterStatus

    Parameters:

    [in] object poPC
        Pass this parameter a valid PC object

    Return Values:

        The Players Rank

    Description: This function looks up the Character Status that is stored in the
                    database and returns it to the caller.

/******************************************************************************/

string SOS_GetCharacterID(object poPC);
/******************************************************************************/
/*  SOS_GetCharacterID

    Parameters:

    [in] object poPC
        Pass this parameter a valid PC object

    Return Values:

        The Character ID

    Description: The will take the PC object and look up in the database
                    it's unique identifier that is stored in the database.

/******************************************************************************/

string SOS_GetPlayerID(object poPC);
/******************************************************************************/
/*  SOS_GetPlayerID

    Parameters:

    [in] object poPC
        Pass this parameter a valid PC object

    Return Values:

        The Players ID

    Description: The will take the PC object and look up in the database
                    it's unique identifier that is stored in the database.

/******************************************************************************/

string SOS_GetModuleID();
/******************************************************************************/
/*  SOS_GetModuleID

    Parameters:

    None

    Return Values:

        Module ID

    Description: This function gets the ServerID of the current module based
                    the module tag.  It then stores that the ServerID in a local
                    variable in the Module object

/******************************************************************************/

int SOS_SetPersistentString(object poObject, string psVarName, string psValue);
/******************************************************************************/
/*  SOS_SetPersistentString

    Parameters:

    [in] object poObject
        The object that you want to assign this variable to

    [in] string psVarName
        The name that you want to give the variable

    [in] string psValue
        The value that you would like to store in the variable

    Return Values:

        WK_SUCCESS - If the value was successfully stored in the database
            this is the return value

        WK_ERROR - If there was a problem executing the SQL statement, this
            will be the return value

    Description:  This function will store the object, the variable name,
        and the variable value in the LocalVars table.

/******************************************************************************/

int SOS_SetPersistentInt(object poObject, string psVarName, int pnValue);
/******************************************************************************/
/*  SOS_SetPersistentInt

    Parameters:

    [in] object poObject
        The object that you want to assign this variable to

    [in] string psVarName
        The name that you want to give the variable

    [in] int pnValue
        The value that you would like to store in the variable

    Return Values:

        WK_SUCCESS - If the value was successfully stored in the database
            this is the return value

        WK_ERROR - If there was a problem executing the SQL statement, this
            will be the return value

    Description:  This function will store the object, the variable name,
        and the variable value in the LocalVars table.

/******************************************************************************/

int SOS_SetPersistentFloat(object poObject, string psVarName, float pfValue);
/******************************************************************************/
/*  SOS_SetPersistentFloat

    Parameters:

    [in] object poObject
        The object that you want to assign this variable to

    [in] string psVarName
        The name that you want to give the variable

    [in] float pfValue
        The value that you would like to store in the variable

    Return Values:

        WK_SUCCESS - If the value was successfully stored in the database
            this is the return value

        WK_ERROR - If there was a problem executing the SQL statement, this
            will be the return value

    Description:  This function will store the object, the variable name,
        and the variable value in the LocalVars table.

/******************************************************************************/

int SOS_SetPersistentLocation(object poObject, string psVarName, location plValue);
/******************************************************************************/
/*  SOS_SetPersistentLocation

    Parameters:

    [in] object poObject
        The object that you want to assign this variable to

    [in] string psVarName
        The name that you want to give the variable

    [in] location plValue
        The value that you would like to store in the variable

    Return Values:

        WK_SUCCESS - If the value was successfully stored in the database
            this is the return value

        WK_ERROR - If there was a problem executing the SQL statement, this
            will be the return value

    Description:  This function will store the object, the variable name,
        and the variable value in the LocalVars table.

/******************************************************************************/

int SOS_SetPersistentVector(object poObject, string psVarName, vector pvValue);
/******************************************************************************/
/*  SOS_SetPersistentVector

    Parameters:

    [in] object poObject
        The object that you want to assign this variable to

    [in] string psVarName
        The name that you want to give the variable

    [in] vector pvValue
        The value that you would like to store in the variable

    Return Values:

        WK_SUCCESS - If the value was successfully stored in the database
            this is the return value

        WK_ERROR - If there was a problem executing the SQL statement, this
            will be the return value

    Description:  This function will store the object, the variable name,
        and the variable value in the LocalVars table.

/******************************************************************************/

string SOS_GetPersistentString(object poObject, string psVarName);
/******************************************************************************/
/*  SOS_GetPersistentString

    Parameters:

    [in] object poObject
        The object that you want to get this variable for

    [in] string psVarName
        The name of the variable you wish to get

    Return Values:

        The string value that is stored in the database for this object

    Description:  This function will retrieve the variable value from the
        database for the given object and VarName.

/******************************************************************************/

int SOS_GetPersistentInt(object poObject, string psVarName);
/******************************************************************************/
/*  SOS_GetPersistentInt

    Parameters:

    [in] object poObject
        The object that you want to get this variable for

    [in] string psVarName
        The name of the variable you wish to get

    Return Values:

        The integer value that is stored in the database for this object

    Description:  This function will retrieve the variable value from the
        database for the given object and VarName.

/******************************************************************************/

float SOS_GetPersistentFloat(object poObject, string psVarName);
/******************************************************************************/
/*  SOS_GetPersistentFloat

    Parameters:

    [in] object poObject
        The object that you want to get this variable for

    [in] string psVarName
        The name of the variable you wish to get

    Return Values:

        The float value that is stored in the database for this object

    Description:  This function will retrieve the variable value from the
        database for the given object and VarName.

/******************************************************************************/

location SOS_GetPersistentLocation(object poObject, string psVarName);
/******************************************************************************/
/*  SOS_GetPersistentLocation

    Parameters:

    [in] object poObject
        The object that you want to get this variable for

    [in] string psVarName
        The name of the variable you wish to get

    Return Values:

        The location value that is stored in the database for this object

    Description:  This function will retrieve the variable value from the
        database for the given object and VarName.

/******************************************************************************/

vector SOS_GetPersistentVector(object poObject, string psVarName);
/******************************************************************************/
/*  SOS_GetPersistentVector

    Parameters:

    [in] object poObject
        The object that you want to get this variable for

    [in] string psVarName
        The name of the variable you wish to get

    Return Values:

        The vector value that is stored in the database for this object

    Description:  This function will retrieve the variable value from the
        database for the given object and VarName.

/******************************************************************************/

int SOS_DeletePersistentVariable(object poObject, string psVarName);
/******************************************************************************/
/*  SOS_DeletePersistentString

    Parameters:

    [in] object poObject
        The object that you want to delet this variable from

    [in] string psVarName
        The name of the variable you wish to delete

    Return Values:

        WK_SUCCESS - If the value was successfully deleted from the database
            this is the return value

        WK_ERROR - If there was a problem executing the SQL statement, this
            will be the return value

    Description:  This function will delete the specified variable from the
        database.

/******************************************************************************/

int SOS_SetPersistentString(object poObject, string psVarName, string psValue)
{

  //SetCampaignString( WK_LOCALVARS_TABLE, psVarName, psValue, poObject );
  ALFA_SetPersistentString( WK_LOCALVARS_TABLE, psVarName, psValue, poObject );

  return WK_SUCCESS;

}

int SOS_SetPersistentInt(object poObject, string psVarName, int pnValue)
{
  //SetCampaignInt( WK_LOCALVARS_TABLE, psVarName, pnValue, poObject );
  ALFA_SetPersistentInt( WK_LOCALVARS_TABLE, psVarName, pnValue, poObject );

  return WK_SUCCESS;
}

int SOS_SetPersistentFloat(object poObject, string psVarName, float pfValue)
{
  //SetCampaignFloat( WK_LOCALVARS_TABLE, psVarName, pfValue, poObject );
  ALFA_SetPersistentFloat( WK_LOCALVARS_TABLE, psVarName, pfValue, poObject );

  return WK_SUCCESS;
}

int SOS_SetPersistentLocation(object poObject, string psVarName, location plValue)
{
  //SetCampaignLocation( WK_LOCALVARS_TABLE, psVarName, plValue, poObject );
  ALFA_SetPersistentLocation( WK_LOCALVARS_TABLE, psVarName, plValue, 
    poObject );

  return WK_SUCCESS;
}

int SOS_SetPersistentVector(object poObject, string psVarName, vector pvValue)
{
  //SetCampaignVector( WK_LOCALVARS_TABLE, psVarName, pvValue, poObject );
  ALFA_SetPersistentVector( WK_LOCALVARS_TABLE, psVarName, pvValue, poObject );

  return WK_SUCCESS;
}

string SOS_GetPersistentString(object poObject, string psVarName)
{
  //return GetCampaignString( WK_LOCALVARS_TABLE, psVarName, poObject );
  return ALFA_GetPersistentString( WK_LOCALVARS_TABLE, psVarName, poObject );
}

int SOS_GetPersistentInt(object poObject, string psVarName)
{
  //return GetCampaignInt( WK_LOCALVARS_TABLE, psVarName, poObject );
  return ALFA_GetPersistentInt( WK_LOCALVARS_TABLE, psVarName, poObject );
}

float SOS_GetPersistentFloat(object poObject, string psVarName)
{
  // return GetCampaignFloat( WK_LOCALVARS_TABLE, psVarName, poObject );
  return ALFA_GetPersistentFloat( WK_LOCALVARS_TABLE, psVarName, poObject );
}

location SOS_GetPersistentLocation(object poObject, string psVarName)
{
  //return GetCampaignLocation( WK_LOCALVARS_TABLE, psVarName, poObject );
  return ALFA_GetPersistentLocation( WK_LOCALVARS_TABLE, psVarName, poObject );
}

vector SOS_GetPersistentVector(object poObject, string psVarName)
{
  //return GetCampaignVector( WK_LOCALVARS_TABLE, psVarName, poObject );
  return ALFA_GetPersistentVector( WK_LOCALVARS_TABLE, psVarName, poObject );
}

int SOS_DeletePersistentVariable(object poObject, string psVarName)
{
  //DeleteCampaignVariable( WK_LOCALVARS_TABLE, psVarName, poObject );
  ALFA_DeletePersistentVariable( WK_LOCALVARS_TABLE, psVarName, poObject );
  return WK_SUCCESS;
}

string SOS_GetModuleID()
{
    return GetTag( GetModule() );
}

string SOS_GetPlayerID(object poPC)
{
    string  sResult;
    int     nRank = 0;

    if (GetIsObjectValid(poPC))
    {
        // if the local variable already exists then dont bother with the rest
        if ( GetLocalInt( poPC, "SOS_InitialLoginCharID" ) )
        {
            DeleteLocalInt( poPC, "SOS_InitialLoginCharID" );

            sResult = GetCampaignString( WK_PLAYER_TABLE, "PlayerID", poPC );
            if ( sResult == "" )
            {
                if (GetIsDM( poPC ) == TRUE)
                    nRank = PLAYER_RANK_DM;
                else
                    nRank = PLAYER_RANK_PC;

                if ( GetLocalInt( GetModule(), "SOS_PLAYER_AUTOCREATE" ) || gALFA_TEST_MODE )
                {
                    SetCampaignString( WK_PLAYER_TABLE, "PlayerName", GetPCPlayerName( poPC ), poPC );
                    SetCampaignString( WK_PLAYER_TABLE, "PublicCDKey", GetPCPublicCDKey( poPC ), poPC );
                    SetCampaignInt( WK_PLAYER_TABLE, "PlayerStatus", 4, poPC );
                    SetCampaignInt( WK_PLAYER_TABLE, "AllowMultiChars", 0, poPC );
                    SetCampaignInt( WK_PLAYER_TABLE, "Rank", nRank, poPC );
                }
                else
                {
                    return "ERROR";
                }
            }
            else
            {
                return sResult;
            }
        }
        else
        {
            return GetPCPlayerName( poPC ) + "|" + GetPCPublicCDKey( poPC );
        }
    }

    return sResult;

}

int SOS_GetPlayerRank(object poPC)
{
    int nResult;

    if (GetIsObjectValid(poPC))
    {
        nResult = GetCampaignInt( WK_PLAYER_TABLE, "Rank", poPC );
        if ( nResult == 0 )
        {
            return -1;
        }
        else
        {
            return nResult;
        }
}

    return WK_SUCCESS;
}

string SOS_GetCharacterID(object poPC)
{
    string sResult;

    if (GetIsObjectValid(poPC))
    {
        // if the local variable already exists then dont bother with the rest
        if ( GetLocalInt( poPC, "SOS_InitialLoginCharID" ) )
        {
            DeleteLocalInt( poPC, "SOS_InitialLoginCharID" );

            sResult = GetCampaignString( WK_CHARACTER_TABLE, "CharacterID", poPC );
            if ( sResult == "" )
            {
                if ( GetLocalInt( poPC, "WK_CreateCharID" ) || gALFA_TEST_MODE )
                {
                    SetCampaignString( WK_CHARACTER_TABLE, "PlayerID", SOS_GetPlayerID( poPC ), poPC );
                    SetCampaignString( WK_CHARACTER_TABLE, "CurrentServerID", GetTag( GetModule() ), poPC );
                    SetCampaignString( WK_CHARACTER_TABLE, "CharacterName", GetName( poPC ), poPC );
                    SetCampaignInt( WK_CHARACTER_TABLE, "CharacterStatus", 4, poPC );
                }
            }
            else
            {
                return sResult;
            }

        }
        else
        {
            return GetPCPlayerName( poPC ) + "|" + GetName( poPC );
        }
    }
    return sResult;
}

int SOS_GetCharacterStatus(object poPC)
{
    int nResult;

    if (GetIsObjectValid(poPC))
    {
        nResult = GetCampaignInt( WK_CHARACTER_TABLE, "CharacterStatus", poPC );
        if ( nResult == 0 )
        {
            return -1;
        }
        else
        {
            return nResult;
        }
    }

    return WK_SUCCESS;
}

int SOS_GetIsNewCharacterAllowed(object poPC)
{
    int nResult;

    if (GetIsObjectValid(poPC))
    {
        nResult = GetCampaignInt( WK_PLAYER_TABLE, "IsNewCharacterAllowed", poPC );
        if ( nResult == 0 )
        {
            return FALSE;
        }
        else
        {
            return nResult;
        }
    }

    return FALSE;
}

int SOS_PlayerLogin( object poPC )
{
    int iProceed = TRUE;
    int iBoot = FALSE;

    SetLocalInt( poPC, "SOS_InitialLoginPlayerID", TRUE );
    SetLocalInt( poPC, "SOS_InitialLoginCharID", TRUE );

    // Step 1 - Validate the Player
    string sPlayerID = SOS_GetPlayerID( poPC );

    if ( sPlayerID == "ERROR" )
    {
        SOS_SendMessageNumeric( poPC, 100 );
        SOS_BootPC( poPC );
        return WK_SUCCESS;
    }

    // Step 2 - Procss The Character
    int iPlayerRank = SOS_GetPlayerRank( poPC );

    // If this is a player account and not a DM
    if ( iPlayerRank == PLAYER_RANK_PC && GetIsDM( poPC ) == FALSE)
    {

        string sCharacterID = SOS_GetCharacterID( poPC );

        if ( sCharacterID != "ERROR" )
        {
            int iCharacterStatus = SOS_GetCharacterStatus( poPC );

            if ( iCharacterStatus == CHARACTER_STATUS_RETIRED )
            {
                // If the PC has retired this character, then they are not allowed
                //  to login with it, until the character is reinstated to ALIVE status.
                SOS_SendMessageNumeric( poPC, 101 );
                SOS_BootPC( poPC );
                return WK_SUCCESS;
            }

            if ( iCharacterStatus == CHARACTER_STATUS_BURIED )
            {
                //If the PC has died, and decided to bury the body and start another
                //  character, they cannot play the dead and buried character.
                SOS_SendMessageNumeric( poPC, 102 );
                SOS_BootPC( poPC );
                return WK_SUCCESS;
            }

            if ( iCharacterStatus == CHARACTER_STATUS_DEAD )
            {
                // IF THE PC IS CURRENTLY DEAD, SHIP HIM TO THE MORGUE
                //This is still a problem, but we will work it out soon.
            }

            if ( iCharacterStatus == CHARACTER_STATUS_ALIVE )
            {
                return WK_SUCCESS;
            }
        }
        else
        {
            if ( iPlayerRank == PLAYER_RANK_PC && !( GetLocalInt( GetModule(), "SOS_ALLOW_MULTIPLE_CHARACTERS" ) ) )
            {
                // If the player is a PC and the server only allows one character per
                //  Player, check and see if this player record is set to override the
                //  server default.
                if ( SOS_GetIsNewCharacterAllowed( poPC ) == 1)
                {
                    //Tell the GetCharacterID function to go ahead and create
                    //  the a new character ID if one of this character doesn't
                    //  already exist.
                    SetLocalInt( poPC, "WK_CreateCharID", TRUE );
                    SOS_GetCharacterID( poPC );
                    return WK_SUCCESS;
                }
                else
                {
                    SOS_SendMessageNumeric( poPC, 103 );
                    SOS_BootPC( poPC );
                    return WK_SUCCESS;
                }
            }
        }
    }

    // Step 3 - Create Character ID
    SetLocalInt( poPC, "WK_CreateCharID", TRUE );
    string sCharacterID = SOS_GetCharacterID( poPC );



    return WK_SUCCESS;

}

void SOS_BootPC( object poPC )

{
        //Set a variable on the PC that tells the Location code not to load the chars
        //  previous location.
        SetLocalInt( poPC, "SOS_PC_DoNotLoadLocation", TRUE);

        if ( BOOT_METHOD_BOOT )
        {
            effect eParalyze = EffectImmunity( IMMUNITY_TYPE_PARALYSIS );
            RemoveEffect( poPC, eParalyze );
            eParalyze = EffectParalyze( );
            ApplyEffectToObject( DURATION_TYPE_PERMANENT, eParalyze, poPC );
            DelayCommand( 10.0, BootPC( poPC ) );
            DelayCommand( 10.0f, SOS_BootPC( poPC ) );
        }
        else if ( BOOT_METHOD_PARALYZE )
        {
            effect eParalyze = EffectImmunity( IMMUNITY_TYPE_PARALYSIS );
            RemoveEffect( poPC, eParalyze );
            eParalyze = EffectParalyze( );
            ApplyEffectToObject( DURATION_TYPE_PERMANENT, eParalyze, poPC );
        }
        else if ( BOOT_METHOD_QUARANTINE )
        {
            WriteTimestampedLogEntry("WK: Quarantining");
            if ( poPC == OBJECT_INVALID)
                return;

            if ( GetWaypointByTag( "WP_QUARANTINE" ) == OBJECT_INVALID)
            {
                effect eParalyze = EffectImmunity( IMMUNITY_TYPE_PARALYSIS );
                RemoveEffect( poPC, eParalyze );
                eParalyze = EffectParalyze( );
                ApplyEffectToObject( DURATION_TYPE_PERMANENT, eParalyze, poPC );
                DelayCommand( 10.0, BootPC( poPC ) );
                DelayCommand( 10.0f, SOS_BootPC( poPC ) );
            }
            location lQuarantine = GetLocation( GetWaypointByTag( "WP_QUARANTINE" ) );
            if ( GetArea( poPC ) != GetArea( GetWaypointByTag( "WP_QUARANTINE" ) ) )
            {
                DelayCommand( 5.0f, AssignCommand( poPC, ActionJumpToLocation( lQuarantine ) ) );
                DelayCommand( 10.0f, SOS_BootPC( poPC ) );
                return;
            }
        }

        return;

}
