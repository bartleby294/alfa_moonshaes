// Name             :   System of the Sages (SOS) - Include Script
// System           :   Time Synchronization and Management System
// Description      :   This include implements the scripts that make up the core
//                          functionality of the SOS system.
// Authors          :   Stephen "Trismuss" Clayburn
//                      T Guiles
//                      Silmar Trekfollower

// This file is licensed under the terms of the
// GNU GENERAL PUBLIC LICENSE (GPL) Version 2

/******************************************************************************/
/* Function definitions                                                       */
/******************************************************************************/

void SOS_TimeSync();
/******************************************************************************/
/*  SOS_TimeSync

    Parameters:

        None

    Return Values:

        WK_SUCCESS - If the value was successfully retrieved from the database
            this is the return value

        WK_ERROR - If there was a problem executing the SQL statement, this
            will be the return value

    Description: This will pull the time out of the database and set the
                    modules time accordingly.

/******************************************************************************/

void SOS_TimeSync()
{

    int     nError = WK_SUCCESS;
    int     nYear = 0;
    int     nMonth = 0;
    int     nDay = 0;
    int     nHour = 0;
    int     nMinute = 0;
    int     nSecond = 0;

    nYear = GetCampaignInt(WK_MODULE_TABLE, "CurrentYear");
    nMonth = GetCampaignInt(WK_MODULE_TABLE, "CurrentMonth");
    nDay = GetCampaignInt(WK_MODULE_TABLE, "CurrentDay");
    nHour = GetCampaignInt(WK_MODULE_TABLE, "CurrentHour");
    nMinute = GetCampaignInt(WK_MODULE_TABLE, "CurrentMinute");
    nSecond = GetCampaignInt(WK_MODULE_TABLE, "CurrentSecond");

    SetTime(nHour,
        nMinute,
        nSecond, 0);

    SetCalendar(nYear,
        nMonth,
        nDay);

    return;
}
