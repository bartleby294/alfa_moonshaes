#include "alfa_options"
#include "sos_switches"
#include "sos_messages"

#include "sos_playaut_inc"
#include "sos_time_inc"

// Originally "wk_mod_onload"

void SOS_Initialize()
{
    string          sSOSVersion = "0.2.7";

    //This sets the Module level switches.
    SetSwitches();

    //Write to the log what mode we are currently in.
    if (gALFA_TEST_MODE == TRUE)
    {
        SetLocalInt( GetModule(), "SOS_PLAYER_AUTOCREATE", TRUE );
        SetLocalInt( GetModule(), "SOS_ALLOW_MULTIPLE_CHARACTERS", TRUE );

        WriteTimestampedLogEntry("WK: SOS Scripts Operating in: TEST MODE");
    }
    else
        WriteTimestampedLogEntry("WK: SOS Scripts Operating in: PRODUCTION MODE");

    //Store the current version to a module wide string
    SetLocalString( GetModule(), "SOS_Version", sSOSVersion );

    if (GetLocalInt( GetModule(), "SOS_VEGETATION_ENABLED" ) == TRUE)
    {
        //Restore all previously existing vegetation objects on a
        //  restarted module session when WK/SOS has completed its part
        //SOS_LoadVegetation(SOS_GetLifeSpanDuration());
    }

    //Log that we are finished initializing
    WriteTimestampedLogEntry("WK: SOS Scripts - Version " + sSOSVersion);
    WriteTimestampedLogEntry("WK: Init finished.");

    //Query the database to set the time correctly
    if (GetLocalInt( GetModule(), "SOS_REMOTE_TIME_SYNC" ) == TRUE)
    {
        SOS_TimeSync();
    }
}

