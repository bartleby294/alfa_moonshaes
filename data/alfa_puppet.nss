/******************************************************************
 * Name: alfa_puppet
 * Type: ACR Execute File
 * ---
 * Author: Cereborn
 * Date: 10/24/03
 *      
 * ---
 * This file is executed via ExecuteScript() when a command (enclosed
 * in <>) is heard by a creature that's using the puppet master system.
 * You can add your own commands here.
 *
 ******************************************************************/

void main()
{
    string sCommand = GetLocalString(OBJECT_SELF, "PuppetCommand");

    if (sCommand == "SITCROSS")
    {
        PlayAnimation(ANIMATION_LOOPING_SIT_CROSS, 1.0, 600.0);
    }
    else if (sCommand == "SIT")
    {
        object oSeat;
        string sSeatTag = "Seat";
        location lSeatLocation;

        int nNth = 1;
        object oSittable = GetNearestObjectByTag(sSeatTag, OBJECT_SELF, nNth);
        while (oSittable != OBJECT_INVALID && oSeat == OBJECT_INVALID)
        {
            if (GetSittingCreature(oSittable) == OBJECT_INVALID)
            {
                oSeat = oSittable;
            }
            nNth++;
            oSittable = GetNearestObjectByTag(sSeatTag, OBJECT_SELF, nNth);
        }

        if (GetIsObjectValid(oSeat))
        {
          lSeatLocation = GetLocation(oSeat);
          ClearAllActions();
          ActionMoveToLocation(lSeatLocation);
          ActionSit(oSeat);
        }
    }

    // etc...
    else
    {
        // assume the command is a script name - no harm if it doesn't exist
        ExecuteScript(sCommand, OBJECT_SELF);
    }
}
