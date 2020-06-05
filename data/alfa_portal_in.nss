////////////////////////////////////////////////////////////
//
//  Scrtipt Name : alfa_portal_in
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

/* Includes */
#include "alfa_portal_incl"

/*  Main    */
void main()    {

//  check the current setting on the module, and change the globals if need be
    AP_SyncBugLevel();

//  get the PC
    object oPC = GetEnteringObject();

//  if it's a DM, let's assume he is OK
    if ( GetIsDM(oPC) ) return;

//  otherwise, let's start the portal-in process by notifying the right places
    AP_Notify(oPC,NOTE_PORTAL_IN);

//  paralize the player until we figure out what to do with them
    AP_FreezeOn(oPC);

//  to save going through inventory multiple times, we'll try and get thier papers now.
    struct documentation stALFADocs = AP_GetDocumets(oPC);

//  if the PC is a resident, process them as such
    if ( AP_GetIsResident(oPC,stALFADocs) )
        AP_ProcessResident(oPC,stALFADocs);

//  if not, run them through immigration
    else AP_ProcessNonResident(oPC,stALFADocs);

}


/* road map

 main-|-AP_SyncBugLevel
      |-AP_Notify
      |-AP_FreezeOn
      |-AP_GetDocumets
      |
      |                                                                                   |- AP_MovePC(MORGUE)
      |     |-AP_ProcessResident-|-AP_Notify(RESIDENT_WITH_PASS)   |-EVENT_DEAD_PC -------|- AP_Notify
      |     |                    |                                 |
      |     |                    |-AP_AfterAreaLoad - AP_AfterAreaLoadEvent
      |     |                                                      |
      |     |                                                      |-RESIDENT_IN_SUCCESS -|- AP_Notify
      |     |                                                                             |- AP_FreezeOff
      |     |
      |-AP_GetIsResident---AP_GetIsLocalVisa-|-AP_GetServerOnVisa
            |                                |-AP_GetThisServer
            |
            |
            |                                                   |-AP_ProcessOffender
            |                                                   |
            |                       |- AP_ProcessNoVisa---AP_GetHasPriors (|| dead || pass)
            |                       |                           |
            |                       |                           |- AP_ProcessNewPC-|-AP_GiveVisa
            |                       |                                              |-AP_AfterAreaLoad - AfterAreaEvent - MoveNewPC - MovePC-|-FreezeOff
            |                       |                                                                                                       |-AP_GetIsNearWP
            |-AP_ProcessNonResident-|
                                    |
                                    |                                 |-AP_AfterAreaLoad - - - - - AfterAreaEvent - EVENT_NO_PASS
                                    |            |-AP_ProcessNoPass---|-AP_NotifyPC                                         |
                                    |            |                                                                          | - - - - - - |-AP_NotifyPC
                                    |            |                                                                          |             |-AP-Sendback -|-AP_GetServerOnVisa                   |- AP_AfterAreaLoadEvent - EVENT_DEAD_PC
                                    |- AP_ProcessForeignVisa                  |-AP_AfterAreaLoad - AfterAreaEvent - EVENT_BAD_PASS                       |-AP_GetPortOnVisa                     |
                                                 |                            |-AP_NotifyPC                                                              |-AP_Portal - PortalMonitor - AP_QuarantinePC
                                                 |                            |                                                                                                                 |
                                                 |-AP_ProcessPass---AP_GetIsPassAccepted                                                                                                        |- MovePC -|- FreezeOff
                                                                              |                                                                      |-AP_Notify                                           |- AP_GetIsNearWP
                                                                              |-AP_NotifyPC                                          |-EVENT_MOVE_PC-|-AP_GetDestTag                                       |- FreezeOn
                                                                              |-AP_GiveVisa                                          |               |-AP_MovePC -|- FreezeOff
                                                                              |-AP_ProcessAcceptedPass - AP_AfterAreaLoad - AfterAreaEvent                        |- AP_GetIsNearWP
                                                                                                                                     |
                                                                                                                                     |-EVENT_DEAD_PC-|-AP_Notify
                                                                                                                                                     |-AP_MovePC -|- FreezeOff
                                                                                                                                                                  |- AP_GetIsNearWP




