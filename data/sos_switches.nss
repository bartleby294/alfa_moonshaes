// Name             :   System of the Sages (SOS) - Constant Definition Script
// Description      :   This include file defines constants that will effect the
//                          execution of the SOS scripts that utilize them.
// Authors          :   Stephen "Trismuss" Clayburn
//                      T Guiles
//                      Silmar Trekfollower

// This file is licensed under the terms of the
// GNU GENERAL PUBLIC LICENSE (GPL) Version 2

// SWITCHES
//

//  Definitions of the database names for the different systems
    string WK_LOCATION_TABLE = "WK_Location";
    string WK_MODULE_TABLE = "WK_Module";
    string WK_PLAYER_TABLE = "WK_Player";
    string WK_CHARACTER_TABLE = "WK_Character";
    string WK_LOCALVARS_TABLE = "WK_LocalVars";

    int WK_SUCCESS = -10;

// This defines whether or not we should use the morgue when a character dies.
//
   int SOS_MORGUE_ENABLED               = TRUE;


// SOS MESSAGE SYSTEM
//
    int     SOS_MESSAGE_SYSTEM_ON       = TRUE;


// Defines the different methods that an illegal Player can be handled
//
   int BOOT_METHOD_BOOT                 = 0;
   int BOOT_METHOD_PARALYZE             = 0;
   int BOOT_METHOD_QUARANTINE           = 1;


// CONSTANTS
//

// CHARACTER RANK CONSTANTS
//
   int PLAYER_RANK_INVALID              = 0;
   int PLAYER_RANK_DM                   = 1;
   int PLAYER_RANK_CPC                  = 2;
   int PLAYER_RANK_PC                   = 3;

// CHARACTER STATUS CONSTANTS
//
   int CHARACTER_STATUS_INVALID         = 0;
   int CHARACTER_STATUS_RETIRED         = 1;
   int CHARACTER_STATUS_BURIED          = 2;
   int CHARACTER_STATUS_DEAD            = 3;
   int CHARACTER_STATUS_ALIVE           = 4;

void SetSwitches()
{
    // These two switches deal with the Remote or Central Authorization/User Login
    //      capabilities of the system.

        SetLocalInt( GetModule(), "SOS_PLAYER_REMOTEAUTH", FALSE );
        SetLocalInt( GetModule(), "SOS_REMOTE_TIME_SYNC", FALSE );

    // Member Autocreate tells the SOS whether to create a record in the database
    //     for a Player that is joining for the first time.  If this is set to false
    //     and the joining player does not have a database record, then will be booted.
    //
        SetLocalInt( GetModule(), "SOS_PLAYER_AUTOCREATE", FALSE );


    // This defines whether Players are allowed to create one or more characters if
    //     they already have one character in the CHARACTER_STATUS_ALIVE, or
    //     CHARACTER_STATUS_DEAD states.  If set to TRUE, this will override the
    //     individual settings in each Player record.
    //
       SetLocalInt( GetModule(), "SOS_ALLOW_MULTIPLE_CHARACTERS", FALSE );

    //This controls Ulias's Vegetation system.  If you would like to disable the vegetation
    //  change this to FALSE.
       SetLocalInt( GetModule(), "SOS_VEGETATION_ENABLED", TRUE);


}
