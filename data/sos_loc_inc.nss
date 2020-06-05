// Name             :   System of the Sages (SOS) - Include Scripts
// System           :   Location Management System
// Description      :   This include file contains the functions that make up the
//                          Location Management System.  It handles saving the location
//                          of PC's in the module.
// Authors          :   Stephen "Trismuss" Clayburn
//                      T Guiles
//                      Silmar Trekfollower

// This file is licensed under the terms of the
// GNU GENERAL PUBLIC LICENSE (GPL) Version 2

void SOS_SaveCharacterLocationOnTimer( object poPC );
/******************************************************************************/
/*  SOS_SaveCharacterLocationOnTimer

    Parameters:

    [in] object poPC
        Pass this parameter a valid PC object to save the current location of.

    Return Values:

        None

    Description: This function is attached to each PC in the Module's OnClientEnter
                    event, and fires once every SOS_LOCATION_SAVE_INTERVAL seconds
                    to save that characters location.

/******************************************************************************/


int SOS_SaveCharacterLocation( object poPC );
/******************************************************************************/
/*  SOS_SaveCharacterLocation

    Parameters:

    [in] object poPC
        Pass this parameter a valid PC object to save the current location of.

    Return Values:

        WK_SUCCESS - If the value was successfully retrieved from the database
            this is the return value

        WK_ERROR - If there was a problem executing the database statement, this
            will be the return value

    Description: This function will save the location of a PC.  This function will
                    return success without doing anything if the PC is currently
                    in the Start Area.

/******************************************************************************/

void SOS_LoadCharacterLocation( object poPC );
/******************************************************************************/
/*  SOS_LoadCharacterLocation

    Parameters:

    [in] object poPC
        Pass this parameter a valid PC object to retrieve the saved location of.

    Return Values:

        WK_SUCCESS - If the value was successfully retrieved from the database
            this is the return value

        WK_ERROR - If there was a problem executing the database statement, this
            will be the return value

    Description: This function will retrieve the saved location of the PC.  It will
                    then jump the PC to that location.

/******************************************************************************/

void SOS_SaveCharacterLocationOnTimer( object poPC )
{
    if ( GetIsObjectValid( poPC ) )
    {
        SOS_SaveCharacterLocation( poPC );
    }

    DelayCommand( SOS_LOCATION_SAVE_INTERVAL, SOS_SaveCharacterLocationOnTimer( poPC ) );

    return;

}

int SOS_SaveCharacterLocation( object poPC )
{
    location            lLocation = GetLocation( poPC );

    if ( GetIsObjectValid( GetArea( poPC ) ) == FALSE)
        return WK_SUCCESS;
    if ( GetLocalInt( poPC, "SOS_LoadingLocation" ) == TRUE )
        return WK_SUCCESS;
    if ( GetLocalInt( poPC, "SOS_PC_DoNotLoadLocation" ) )
        return WK_SUCCESS;

    if (lLocation == GetLocalLocation(poPC, "SOS_CurrentLocation"))
        return TRUE;
    else
        SetLocalLocation(poPC, "SOS_CurrentLocation", lLocation);

    SetCampaignLocation(WK_LOCATION_TABLE, "CurrentLocation", lLocation, poPC);

    // CHARACTER LOCATION SAVED CORRECTLY
    if ( SOS_LOCATION_SAVE_DISPLAYTEXT )
//        SOS_SendMessageNumeric( poPC, 202,TRUE,FALSE,FALSE );

    return WK_SUCCESS;
}

void SOS_LoadCharacterLocation( object poPC )
{

    location    oLocation;
    location    oCurLocation;

    SetLocalInt(poPC, "SOS_LoadingLocation", TRUE);

    if (GetIsObjectValid( GetAreaFromLocation( GetLocation( poPC ) ) ) == FALSE)
    {
        DelayCommand( 1.0f, SOS_LoadCharacterLocation( poPC ) );
        return;
    }
    else
    {
        SetLocalInt(poPC, "SOS_LoadingLocation", FALSE);

        //Check to see if it is ok that we run the location code.
        if ( GetLocalInt( poPC, "SOS_PC_DoNotLoadLocation" ) == TRUE )
        {
            return;
        }
        else if ( GetLocalInt( poPC, "SOS_PC_AlreadyLoggedIn" ) == TRUE )
        {
            return;
        }
//        else if ( GetLocalInt( poPC, "AP_WK_MOVE_FLAG" ) == FALSE )
//        {
//            return;
//        }
        else if ( GetItemPossessedBy( poPC, "ALFADeathToken" ) != OBJECT_INVALID )
        {
            return;
        }

        oLocation = GetCampaignLocation(WK_LOCATION_TABLE, "CurrentLocation", poPC);

        if ( GetAreaFromLocation( oLocation ) == OBJECT_INVALID )
            return;

 //       SOS_SendMessageNumeric( poPC, 204, TRUE, FALSE, FALSE );
        DelayCommand( 10.0f, AssignCommand( poPC, ActionJumpToLocation( oLocation ) ) );
        SetLocalInt( poPC, "SOS_PC_AlreadyLoggedIn", TRUE );
    }

    SetLocalInt(poPC, "SOS_LoadingLocation", FALSE);

    return;
}
