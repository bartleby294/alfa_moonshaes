////////////////////////////////////////////////////////////
//
//  Scrtipt Name : alfa_portal_out
//                 Works with ap_portal_incl
//        version: 1.5
//        Author : Ranoulf, ag107093@hotmail.com
//
/////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////
//
//  Description
//
//  Note:
//  This script is part of the ap_portal set of scripts
//  and is designed to work in conjunction with portal_in
//  running on the other side.
//
//  Please see the bottom of portal_incl for instructions
//
////////////////////////////////////////////////////////

#include "alfa_portal_incl"


void main()   {

//  Check the current setting on the module, and change the globals if need be
    AP_SyncBugLevel();

//  Get the PC and portal trigger in question
    object oPC     = AP_GetTravler();
    object oPortal = AP_GetPortal();

    if ( ! GetIsObjectValid(oPC)  ||  ! GetIsObjectValid(oPortal) ) return;

//  Notify the proper places
    AP_Notify(oPC,NOTE_PORTAL_OUT);

//  Create the passport from the trigger, giving it to the PC
    object oPass = AP_GrantPass(oPC,oPortal);

    if (! GetIsObjectValid(oPass) )     return ;

//  and send the PC on his way
    AP_SendPC(oPC,oPass);
}

/*



main-|
     |-AP_GetTravler
     |
     |-AP_GetPortal
     |
     |-AP_Notify
     |
     |-AP_GrantPass -|- AP_NotifyPC
     |               |- AP_GetIsValidPortal
     |
     |
     |-AP_SendPC-|-AP_GetServerOnPass
                 |-AP_GetPortOnPass
                 |-AP_NotifyPC
                 |-AP_Portal
