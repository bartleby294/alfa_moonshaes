/******************************************************************
 * Name: alfa_charloc
 * Type: ACR Include File
 * ---
 * Authors: Cereborn
 * Date: 0/24/03
 *
 * ---
 * This was created from the original sos_loc_inc script.  Character
 * location saving is now a local DB function of the ACR (SOS routines
 * are used for the central DB)
 *
 * Credits:
 *   The original authors are -
 *      Stephen "Trismuss" Clayburn
 *      T Guiles
 *      Silmar Trekfollower
 *
 * IMPORTANT: THIS FILE IS A CORE ALFA SCRIPT AND MUST NOT BE
 * MODIFIED EXCEPT THROUGH OFFICIAL ALFA PATCHES!
 ******************************************************************/

#include "alfa_options"
#include "alfa_persist"

// Forward Reference:
void ALFA_SendCharLocationMessage( object oPC, int iMessage, int iSendToPlayer = TRUE,
     int iSendToDM = TRUE, int iWriteLogEntry = TRUE );

void ALFA_SaveCharacterLocationOnTimer( object poPC );
/******************************************************************************/
/*  ALFA_SaveCharacterLocationOnTimer

    Parameters:

    [in] object poPC
        Pass this parameter a valid PC object to save the current location of.

    Description: This function is attached to each PC in the Module's OnClientEnter
                    event, and fires once every ALFA_LOCATION_SAVE_INTERVAL seconds
                    to save that characters location.

/******************************************************************************/


int ALFA_SaveCharacterLocation( object poPC );
/******************************************************************************/
/*  ALFA_SaveCharacterLocation

    Parameters:

    [in] object poPC
        Pass this parameter a valid PC object to save the current location of.

    Description: This function will save the location of a PC.  This function will
                    return success without doing anything if the PC is currently
                    in the Start Area.

/******************************************************************************/

void ALFA_LoadCharacterLocation( object poPC );
/******************************************************************************/
/*  ALFA_LoadCharacterLocation

    Parameters:

    [in] object poPC
        Pass this parameter a valid PC object to retrieve the saved location of.

    Description: This function will retrieve the saved location of the PC.  It will
                    then jump the PC to that location.

/******************************************************************************/

void ALFA_SaveCharacterLocationOnTimer( object poPC )
{
  if ( GetIsObjectValid( poPC ) )
  {
      ALFA_SaveCharacterLocation( poPC );
  }

  DelayCommand( gALFA_LOCATION_SAVE_INTERVAL,
     ALFA_SaveCharacterLocationOnTimer( poPC ) );
}

void ALFA_SaveCharacterLocation( object poPC )
{

  if (GetIsDM( poPC ) && ! gALFA_SAVE_DM_LOC )
  {
    return;
  }

  // Don't save char location when possessing familiar
  object oFamiliar = GetAssociate( ASSOCIATE_TYPE_FAMILIAR, poPC );
  if ( GetIsObjectValid( oFamiliar ) )
  {
    if (GetIsPossessedFamiliar( oFamiliar ) )
    {
      return;
    }

  }

  location lLocation = GetLocation( poPC );

  if ( GetIsObjectValid( GetArea( poPC ) ) == FALSE)
  {
    return;
  }

  if ( GetLocalInt( poPC, "ALFA_LoadingLocation" ) == TRUE )
  {
    return;
  }

  if ( GetLocalInt( poPC, "ALFA_PC_DoNotLoadLocation" ) )
  {
    return;
  }

  if (lLocation == GetLocalLocation(poPC, "ALFA_CurrentLocation"))
  {
    return;
  }

  SetLocalLocation(poPC, "ALFA_CurrentLocation", lLocation);

  ALFA_SetPersistentLocation(WK_LOCATION_TABLE, "CurrentLocation", lLocation, poPC);

  // CHARACTER LOCATION SAVED CORRECTLY
  if ( gALFA_LOCATION_SAVE_DISPLAYTEXT )
  {
    ALFA_SendCharLocationMessage( poPC, 202, TRUE, FALSE, FALSE );
  }

}

void ALFA_LoadCharacterLocation( object poPC )
{
  location    oLocation;
  location    oCurLocation;

  SetLocalInt(poPC, "ALFA_LoadingLocation", TRUE);

  if (GetIsObjectValid( GetAreaFromLocation( GetLocation( poPC ) ) ) == FALSE)
  {
      DelayCommand( 1.0f, ALFA_LoadCharacterLocation( poPC ) );
      return;
  }

  else
  {
    SetLocalInt(poPC, "ALFA_LoadingLocation", FALSE);

    //Check to see if it is ok that we run the location code.
    if ( GetLocalInt( poPC, "ALFA_PC_DoNotLoadLocation" ) == TRUE )
    {
        return;
    }

    else if ( GetLocalInt( poPC, "ALFA_PC_AlreadyLoggedIn" ) == TRUE )
    {
        return;
    }

//    else if ( GetLocalInt( poPC, "AP_WK_MOVE_FLAG" ) == FALSE )
//    {
//      return;
//    }

    else if ( GetItemPossessedBy( poPC, "ALFADeathToken" ) != OBJECT_INVALID )
    {
        return;
    }

    oLocation = ALFA_GetPersistentLocation(WK_LOCATION_TABLE, "CurrentLocation", poPC);

    if ( GetAreaFromLocation( oLocation ) == OBJECT_INVALID )
    {
        return;
    }

    ALFA_SendCharLocationMessage( poPC, 204, TRUE, FALSE, FALSE );
    DelayCommand( 10.0f, AssignCommand( poPC, ActionJumpToLocation( oLocation ) ) );
    SetLocalInt( poPC, "ALFA_PC_AlreadyLoggedIn", TRUE );
  }

  SetLocalInt(poPC, "ALFA_LoadingLocation", FALSE);
}

void ALFA_SendCharLocationMessage( object oPC, int iMessage, int iSendToPlayer = TRUE,
     int iSendToDM = TRUE, int iWriteLogEntry = TRUE )
{
  string sPlayerMessage;
  string sDMMessage;
  string sLogMessage;

  switch ( iMessage )
  {
    case 201:
      sPlayerMessage = "Your location cannot be saved in the module's start area.";
      break;
    case 202:
      sPlayerMessage = "Your location was saved successfully.";
      break;
    case 203:
      sPlayerMessage = "Your location was not saved. Please contact a DM.";
      break;
    case 204:
      sPlayerMessage = "You will be moved to your last known location in a few seconds.";
      break;

  }

  if ( iSendToPlayer )
  {
    SendMessageToPC( oPC, sPlayerMessage );
  }

  if ( iSendToDM )
  {
    SendMessageToAllDMs( sDMMessage );
  }

  if ( iWriteLogEntry )
  {
    WriteTimestampedLogEntry( sLogMessage );
  }

}

