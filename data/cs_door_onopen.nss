// part of the door scripts
void main()
{
/***************************************************************************
/* Modified By: ç i p h é r   2006/1/12
/*
/* The additions to this script allow a builder to schedule store hours.
/* This is achieved by setting two local int variables: HOUR_OPEN & HOUR_CLOSE.
/* These integer values should be based on the 24 hour clock (military time).
/* Access from interiors will be unrestricted to allow exiting at any time.
/*
/* Eg: Close 5pm, Open 10pm
/*   HOUR_OPEN = 17
/*   HOUR_CLOSE = 22
/*
/* Eg: Close 8pm, Open 8am
/*   HOUR_OPEN = 8
/*   HOUR_CLOSE = 20
/*
/* NOTE: Midnight (12am) is 0. This is also the value returned by the GetLocal()
/* functions in the absence of data. It is therefore assumed that if both open
/* and close are 0, no schedule has been stipulated as that's not a valid configuration.
/******************************************************************************/
    object oPC = GetLastOpenedBy();

    // get the open/close data on the door
    int iOpen = GetLocalInt(OBJECT_SELF, "HOUR_OPEN");
    int iClose = GetLocalInt(OBJECT_SELF, "HOUR_CLOSE");

    // check that open and close times are not the same (hours have been defined)
    if (iOpen != iClose)
    {
        int iHour = GetTimeHour();

        // store is open - store closes and opens on the same day
        if ( ((iOpen > iClose) && (iHour < iClose || iHour >= iOpen)) ||
        // store is open - store closes and opens on the following day
             ((iOpen < iClose) && (iHour < iClose && iHour >= iOpen)) )
        {
            // compute the autoclose wait time which factors in closing hours
            float fDelay = (iClose > iHour)
                ? HoursToSeconds(iClose - iHour) - (GetTimeMinute() * 60.0) - GetTimeSecond()
                : HoursToSeconds(24 - iHour + iClose) - (GetTimeMinute() * 60.0) - GetTimeSecond();

            ActionWait(fDelay);
        }
        // store is closed - do not restrict access if the player is INSIDE the building
        else if (GetIsAreaInterior(GetArea(oPC)))
        {
            // give the player 100 seconds to get out
            ActionWait(20.0);
        }
        // store is closed - restrict access
        else
        {
            // clear any pending delays on the door
            ClearAllActions();

            // store is closed, do not introduce any delays on the door object
            // so the door will close itself immediately
            SendMessageToPC(oPC, "The door is barred. A sign says: CLOSED.");
            AssignCommand(oPC, ActionDoCommand(PlaySound("as_dr_locked2")));
        }
    }
    // otherwise, no access restrictions
    else
    {
        // wait 1500 seconds before closing the door - default timer
        ActionWait(1500.0);
    }

    ActionCloseDoor(OBJECT_SELF);
    //SetLocked(OBJECT_SELF, TRUE);
}
