////////////////////////////////////////////////////////////////////////////////
/*
    SYSTEM OF THE SAGES                                             WORLD KEEPER

    Message System
*/
////////////////////////////////////////////////////////////////////////////////

// Sends the error message based upon the user defined value
//
void SOS_SendMessageNumeric( object oPC, int iMessage, int iSendToPlayer = TRUE, int iSendToDM = TRUE, int iWriteLogEntry = TRUE );

// Sends the error message based upon the string sent
//
void SOS_SendMessageString( object oPC, string iMessage, int iSendToPlayer = TRUE, int iSendToDM = TRUE, int iWriteLogEntry = TRUE );

void SOS_SendMessageNumeric( object oPC, int iMessage, int iSendToPlayer = TRUE,
     int iSendToDM = TRUE, int iWriteLogEntry = TRUE )
{
  if( SOS_MESSAGE_SYSTEM_ON )
  {
    string sPlayerMessage;
    string sDMMessage;
    string sLogMessage;

    switch ( iMessage )
    {
      case 100:
        sPlayerMessage = "PLAYER AUTH: Please double check your account setting on the website.  Your Gamespy Player Name is: " + GetPCPlayerName( oPC ) + " ; PublicCDKey: " + GetPCPublicCDKey( oPC );
        sDMMessage = GetName( oPC ) + " was denied access. Account does not exist.";
        sLogMessage = sDMMessage;
        break;
      case 101:
        sPlayerMessage = "You are not allowed to log in with a retired character.";
        sDMMessage = GetPCPlayerName( oPC ) + " was denied access. " + GetName( oPC ) + " has been retired.";
        sLogMessage = sDMMessage;
        break;
      case 102:
        sPlayerMessage = "You are not allowed to log in with a buried character.";
        sDMMessage = GetPCPlayerName( oPC ) + " was denied access. " + GetName( oPC ) + " has been buried.";
        sLogMessage = sDMMessage;
        break;
      case 103:
        sPlayerMessage = "You already have an active character in this world.";
        sDMMessage = GetPCPlayerName( oPC ) + " was denied access. Active character already exists.";
        sLogMessage = sDMMessage;
        break;

      // ERROR MESSAGES FOR DATABASE LOCATION STORAGE
      // sos_loc_inc, sos_loc_core
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
      SendMessageToPC( oPC, sPlayerMessage );
    if ( iSendToDM )
      SendMessageToAllDMs( sDMMessage );
    if ( iWriteLogEntry )
      WriteTimestampedLogEntry( sLogMessage );
  }
}

void SOS_SendMessageString( object oPC, string sErrorMessage, int iSendToPlayer = TRUE,
     int iSendToDM = TRUE, int iWriteLogEntry = TRUE )
{
  if( SOS_MESSAGE_SYSTEM_ON )
  {
    if ( iSendToPlayer )
      SendMessageToPC( oPC, sErrorMessage );
    if ( iSendToDM )
      SendMessageToAllDMs( sErrorMessage );
    if ( iWriteLogEntry )
      WriteTimestampedLogEntry( sErrorMessage );
  }
}
