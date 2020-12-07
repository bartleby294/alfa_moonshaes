////////////////////////////////////////////////////////////
//
//  Scrtipt Name : alfa_portal_incl
//       version : 1.5.1
//       Purpose : Include file for alfa_portal_out and
//                 alfa_portal_in
//          Date : 04 March 2003
//        Author : Ranoulf, ag107093@hotmail.com
//
/////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////
//  Description
//
//  Problem:
//  The player can log onto any server they wish, traveling
//  from WaterDeep to Thay in the blink of an eye.
//
//  Workaround:
//  This scipt gives the player a "Visa" for their stay
//  on your server. When a new player portals in from another
//  server, it checks to make sure they have a "Pass"
//
//  If the Passport or Visa is invalid, the script
//  portals them to where they should be, if that server
//  up. If not, it lets them stay.
///////////////////////////////////////////////////////////////

///////////////////////////////////////////////////////////////
//
//  Note:
//  Please see the How-To at the bottom
//
///////////////////////////////////////////////////////////////

int StartingConditional() {  return 0; }


/*  Portal Behavour */

// Choices for portal behavior are:
    int CHAR_SELECT = 1; // player must reselect character at next server
    int MANUAL      = 2; // player is given passport and booted after 3 seconds
    int CONFIRM     = 3; // confirmation dialog box is presented to player
    int SEAMLESS    = 4; // just like area transistions, no warning or hold
// curent mode is:
int PORTAL_MODE = CHAR_SELECT;
// status of quarantine is:
int QUARANTINE = TRUE;   // TRUE will move players w/o a valid visa or passport to the quarantine area
// portal debugging is currently:
int DEBUG =  TRUE;       // even with debugging off, you will be notified of critical events. TURE is slower

/* World Settings - must match other servers */
//string  CURRENT_AP_PASSWORD = "PlayTheWorld";
string  CURRENT_AP_PASSWORD = "Urmlaspyr";
string  VISANAME            = "ALFA Visa";
string  PASSNAME            = "ALFA Pass";
string  SERVER_PREFIX       = "alfa_";
string  DOMAIN              = ".alandfaraway.org";
int     MAX_SERVERS         = 150;    // used in checking the visa format
string  START_LOCATION_TAG  = "WP_START_LOCATION";
string  QUARENTINE_WP_TAG   = "WP_QUARANTINE";
string  QUARENTINE_AREA_TAG = "QuarantineArea";
string  PORTAL_VESION       = "1.5.1";


/* Tuneable Settings */
int    SEARCH_LIMIT    = 200  ; // Limit of inventory items to check when looking for a Visa, to cut down on possible 'too many instructions' bioware issue
float  SENDBACK_DELAY  =   3.0; // time between notifying the PC they are being rejected, and sending them to thier last server
float  JUMP_PROXIMITY  =  20.0; // how far away they have to be before we jump new arrivials to their destination waypoint.
float  JUMP_DELAY      =   3.0; // time after the area has loaded, but before they are moved to the incomming waypoint on thier passport
float  PORTAL_TIMEOUT  =  16.0; // before we give up on a portal (Bioware's default is like 12)
float  CALLBACK        =   3.0; // how often the portal monitor function checks up on the pc during the portal
float  MAX_AREA_LOAD_TIME = 60.0; // if the area takes any longer to load for the PC than this, we stop waiting
int    DEBUG_DEFAULT_THRESHOLD = 4;
        // Choices for debugging threshold are:
        //      5 - critical notification only
        //      4 - only tells you about significant errors
        //      3 - errors plus program flow events
        //      2 - errors, program flow, and most function calls
        //      1 - every debugging string and notification I've ever put in !



/* Misc constants */

// portal types
int PORTAL_NORMAL = 0;
int PORTAL_SENDBACK = 1;

// area events
int EVENT_MOVE_NEW_PC = 1;
int EVENT_MOVE_PC = 2;
int EVENT_NO_PASS = 3;
int EVENT_BAD_PASS = 4;
int EVENT_DEAD_PC = 5;
int EVENT_RESIDENT_IN_SUCCESS = 6;

//notification events
int NOTE_RESIDENT_IN_SUCCESS = 1;
int NOTE_NONRESIDENT_IN_SUCCESS = 2;
int NOTE_NO_PASS = 3;
int NOTE_BAD_PASS = 4;
int NOTE_BEING_JUMPED = 5;
int NOTE_SENDING_BACK = 6;
int NOTE_PORTAL_FAILED = 7;
int NOTE_NO_QUARANTINE = 8;
int NOTE_BEING_QUARANTINED = 9;
int NOTE_QUARANTINE_OFF = 10;
int NOTE_BAD_PORTAL = 11;
int NOTE_NO_SERVER_PASS = 12;
int NOTE_PORTAL_TO = 13;
int NOTE_NO_VISA = 14;
int NOTE_DEAD_PC = 15;
int NOTE_NEW_PC_WELCOME = 16;
int NOTE_NO_MORGUE = 17;
int NOTE_BAD_QUARANTINE = 18;
int NOTE_PORTAL_IN = 1001;
int NOTE_NEW_PC = 1002;
int NOTE_RESIDENT_WITH_PASS = 1003;
int NOTE_PORTAL_OUT = 1004;
int NOTE_DEAD_PC_WITH_PASS = 1005;

// flags
string FLAG_IS_FROZEN = "is frozen";

    /* the documentation struct */
struct documentation   {
    object oVisa;
    object oPass;
    object oDeathCertificate;
    };


/* external constants */
string DEATH_SYMBOL_NAME = "A Black Symbol";    // used in the GetDocs Function
string DEATH_SYMBOL_TAG = "ALFADeathToken";     // used in the Quarantine Funct
string MORGUE_WAYPOINT_TAG = "ALFA_MORGUE_WAYPT";
string AP_WK_MOVE_FLAG = "AP-WK_MOVE_FLAG";     // inter-comm with the WK scripts


/* global Debug */
void    AP_Debug   (int iDebugLevel, string sCallingFunction, string sMessage);
int     DEBUG_BASE,DEBUG_LOW,DEBUG_MED,DEBUG_HI,DEBUG_MAX;
int     DEBUG_LOG_THRESHOLD,DEBUG_CLIENT_THRESHOLD;


/* Function Declarations    */
void    AP_AfterAreaLoad        (int iEvent, object oPC, object oObject = OBJECT_INVALID, float fTimeElapes = 0.0);
void    AP_AfterAreaLoadEvent   (int iEvent, object oPC, object oDocument = OBJECT_INVALID);
void    AP_FlagForWKMove        (object oPC);
void    AP_FreezeOn             (object oPC);
void    AP_FreezeOff            (object oPC);
string  AP_GetDestTag           (object oPass);
struct  documentation AP_GetDocumets(object oPC);
int     AP_GetHasPriors         (object oPC);
int     AP_GetIsInSameArea      (object oThing1, object oThing2);
int     AP_GetIsLocalVisa       (object Visa);
int     AP_GetIsNearWP          (object oPC,object oWaypoint);
int     AP_GetIsPassAccepted    (struct documentation Docs);
int     AP_GetIsResident        (object oPC, struct documentation Docs);
int     AP_GetIsValidVisa       (object oVisa);
string  AP_GetPortOnVisa        (object oAP_Visa);
string  AP_GetServerOnVisa      (object Visa);
string  AP_GetThisServer        ();
string  AP_GetThisServerPort    ();
object  AP_GiveVisa             (object oPC);
void    AP_MovePC               (object oPC, object oWaypoint, int iUnfreeze = FALSE);
void    AP_MoveNewPC            (object oPC);
void    AP_Notify               (object oPC, int iEvent, string sMessage = "");
void    AP_Portal               (object oPC, string sServer, string sPort, int iPortalType = 0, string sWaypoint = "none");
void    AP_PortalMonitor        (object oPC, int iPortalType, float fTimeElapsed = 0.0);
void    AP_ProcessAcceptedPass  (object oPC, struct documentation Docs);
void    AP_ProcessForeignVisa   (object oPC, struct documentation Docs);
void    AP_ProcessNewPC         (object oPC);
void    AP_ProcessNonResident   (object oPC, struct documentation Docs);
void    AP_ProcessNoPass        (object oPC, struct documentation Docs);
void    AP_ProcessNoVisa        (object oPC, struct documentation Docs);
void    AP_ProcessOffender      (object oPC, struct documentation Docs);
void    AP_ProcessPass          (object oPC, struct documentation Docs);
void    AP_ProcessResident      (object oPC, struct documentation Docs);
void    AP_SendBack             (object oPC, object oVisa);
void    AP_SyncBugLevel         ();
void    AP_QuarantinePC         (object oPC);

object  AP_GetTravler           ();
object  AP_GetPortal            ();
object  AP_GrantPass            (object oPC,object oPortal);
int     AP_GetIsValidPortal     (string sPortalTag);
void    AP_SendPC               (object oPC,object oPass);
string  AP_GetServerOnPass      (object oPass);
string  AP_GetPortOnPass        (object oPass);
string  AP_GetWaypointOnPass    (object oPass);
string  AP_GetWord              (string sSubject, int iElementNumber = 1);
string  AP_RemoveLeadingSpaces  (string sSubject);
string  AP_RemoveTrailingSpaces (string sSubject);
string  AP_GetLastWord          (string sSentence);








/*  Function Defintions */



//::///////////////////////////////////////////////
//:: AP_AfterAreaLoad
//::
//:://////////////////////////////////////////////
/*

*/
//:://////////////////////////////////////////////
//:: Created By:
//:: Created On:
//:://////////////////////////////////////////////
void AP_AfterAreaLoad   (int iEvent, object oPC, object oObject = OBJECT_INVALID, float fTimeElapsed = 0.0)   {

//  only try as long as the pc doesn't exit or their area doesn't take to long to load
    if ( GetIsObjectValid(oPC) && fTimeElapsed < MAX_AREA_LOAD_TIME ) {

        AP_Debug(DEBUG_LOW,"AP_AfterAreaLoad","PC's area has not loaded yet, continuing to monitor them. (" + IntToString(FloatToInt(fTimeElapsed)) + " seconds elapsed)");

        if ( ! GetIsObjectValid(GetArea(oPC)) )
//          if their area hasn't loaded yet, lets try again in a few seconds
            DelayCommand( CALLBACK, AP_AfterAreaLoad(iEvent,oPC,oObject,fTimeElapsed + CALLBACK) );

        else   {
//          otherwise, its time to handle the event
            AP_Debug (DEBUG_LOW,"AP_AfterAreaLoad","PC's Area has loaded. Handing them off. (" + IntToString(FloatToInt(fTimeElapsed)) + " seconds elapsed) ");
            AP_AfterAreaLoadEvent(iEvent,oPC,oObject);
        }
    }
//  if we didn't meet both conditions, this will be the last exit.
    return;
}

//::///////////////////////////////////////////////
//:: AP_AfterAreaLoadEvent
//::
//:://////////////////////////////////////////////
/*
    We have to be a little carefull as the oDocument
    parameter could be a visa or a passport object
    depending on what event we wanted to happen
*/
//:://////////////////////////////////////////////
//:: Created By:
//:: Created On:
//:://////////////////////////////////////////////
void    AP_AfterAreaLoadEvent  (int iEvent, object oPC, object oDocument = OBJECT_INVALID) {

    switch (iEvent) {

    case 1:
    //  EVENT_MOVE_NEW_PC
        AP_Notify(oPC,NOTE_NEW_PC_WELCOME);
        AP_MoveNewPC(oPC);
        break;
    case 2:
    //  EVENT_MOVE_PC
        AP_Notify(oPC,NOTE_NONRESIDENT_IN_SUCCESS);
        DelayCommand(1.5,AP_Notify(oPC,NOTE_BEING_JUMPED));
        AP_MovePC(oPC,GetWaypointByTag(AP_GetDestTag(oDocument)),TRUE);
        DestroyObject(oDocument);
        break;
    case 3:
    //  EVENT_NO_PASS
        AP_Notify(oPC,NOTE_NO_PASS,GetTag(oDocument));
        DelayCommand(JUMP_DELAY,AP_SendBack(oPC,oDocument));
        break;

    case 4:
    // EVENT_BAD_PASS
        AP_Notify(oPC,NOTE_BAD_PASS,GetTag(oDocument));
        DelayCommand(JUMP_DELAY,AP_SendBack(oPC,oDocument));
        break;

    case 5:
    // EVENT_DEAD_PC
        AP_Notify(oPC,NOTE_DEAD_PC);
        if ( GetIsObjectValid(GetWaypointByTag(MORGUE_WAYPOINT_TAG)) )
            AP_MovePC(oPC,GetWaypointByTag(MORGUE_WAYPOINT_TAG),TRUE);
        else
            AP_Notify(oPC,NOTE_NO_MORGUE);
        break;

    case 6:
    // EVENT_RESIDENT_IN_SUCCESS
        AP_Notify(oPC,NOTE_RESIDENT_IN_SUCCESS);
        AP_FreezeOff(oPC);
        DestroyObject(oDocument);
        AP_FlagForWKMove(oPC);
        break;


    default:
        break;
    }
}

//::///////////////////////////////////////////////
//:: AP_FlagForWKMove
//::
//:://////////////////////////////////////////////
/*
This function places a local variable on the in-
coming oPC that identifes them as needing to be
moved by the world keeper DB software

*/
//:://////////////////////////////////////////////
//:: Created By: Ranoulf, ag107093@hotmail.com
//:: Created On:
//:://////////////////////////////////////////////
void    AP_FlagForWKMove        (object oPC)    {

    SetLocalInt(oPC,AP_WK_MOVE_FLAG,TRUE);

}


//::///////////////////////////////////////////////
//:: AP_FreezeOn
//::
//:://////////////////////////////////////////////
/*
    Modeled after the DM wand effect

*/
//:://////////////////////////////////////////////
//:: Created By: Ranoulf, ag107093@hotmail.com
//:: Created On:
//:://////////////////////////////////////////////
void    AP_FreezeOn             (object oPC)    {

    SetCommandable(FALSE, oPC);

    SetLocalInt(oPC,FLAG_IS_FROZEN,TRUE);
}

//::///////////////////////////////////////////////
//:: AP_FreezeOff
//::
//:://////////////////////////////////////////////
/*
    If there was a subrace effect of type paralyse
    we would have to use the subrace safe remove
    function.
*/
//:://////////////////////////////////////////////
//:: Created By: Ranoulf, ag107093@hotmail.com
//:: Created On:
//:://////////////////////////////////////////////
void    AP_FreezeOff            (object oPC)    {

    SetCommandable(TRUE, oPC);

    DeleteLocalInt(oPC,FLAG_IS_FROZEN);

}


//::///////////////////////////////////////////////
//:: AP_GetDestTag
//::
//:://////////////////////////////////////////////
/*
    AP_nnn_nnn_nnn_xxxxx
*/
//:://////////////////////////////////////////////
//:: Created By: Ranoulf, ag107093@hotmail.com
//:: Created On:
//:://////////////////////////////////////////////
string  AP_GetDestTag (object oPass)   {

    return GetTag(oPass);

}

//::///////////////////////////////////////////////
//:: AP_GetDocumets
//::
//:://////////////////////////////////////////////
/*
    important to remember tha 0 is a possible valid value
    for FindSubString
*/
//:://////////////////////////////////////////////
//:: Created By: Ranoulf, ag107093@hotmail.com
//:: Created On:
//:://////////////////////////////////////////////
struct documentation    AP_GetDocumets  (object oPC) {

    struct documentation Docs; //  this is the struct we'll be putting things in

//  we should make things case insensitive
    string sVisaName    = GetStringUpperCase(VISANAME);
    string sPassName    = GetStringUpperCase(PASSNAME);
    string sDeadSymName = GetStringUpperCase(DEATH_SYMBOL_NAME);

    int iIterations = 0;

    object oItem = GetFirstItemInInventory(oPC);
    string sItemName = GetStringUpperCase(GetName(oItem));

    while ( GetIsObjectValid(oItem) && iIterations <= SEARCH_LIMIT ) {

        if ( FindSubString( sItemName, sVisaName ) >= 0 ) {

            if ( ! GetIsObjectValid(Docs.oVisa) )
                Docs.oVisa = oItem;     // If we don't have one already,
            else                        // this is the one we want, otherwise
                DestroyObject(oItem);   // It's extra so destroy it.
        }

        if ( FindSubString( sItemName ,sPassName ) >= 0 ) {

            if ( ! GetIsObjectValid(Docs.oPass) )
                Docs.oPass = oItem;
            else
                DestroyObject(oItem);
        }

        if ( sItemName == sDeadSymName ) {

            if ( ! GetIsObjectValid(Docs.oDeathCertificate) )
                Docs.oDeathCertificate = oItem;
            else
                DestroyObject(oItem);
        }


        oItem = GetNextItemInInventory(oPC);
        sItemName = GetStringUpperCase(GetName(oItem));

        iIterations ++; // and increment our safety counter
    }

    // if we hit the limit, lets say so
    if (iIterations >= SEARCH_LIMIT ) PrintString("AP_GetDocumets: while looking through PCs inventory, we reached the max iteration (inventory) limit of: " + IntToString(SEARCH_LIMIT) );

    return Docs;

}

//::///////////////////////////////////////////////
//:: AP_GetHasPriors
//::
//:://////////////////////////////////////////////
/*

*/
//:://////////////////////////////////////////////
//:: Created By: Ranoulf, ag107093@hotmail.com
//:: Created On:
//:://////////////////////////////////////////////
int     AP_GetHasPriors    (object oPC) {

    return FALSE;

}

//::///////////////////////////////////////////////
//:: AP_GetInSameArea
//::
//:://////////////////////////////////////////////
/*
compares two fun things, thing 1 and thing 1 (to
quote Dr. Suess) to see if they are in the same
area

Note: doesn't work at OnEnter for a oPC as they
haven't got an area loaded yet
*/
//:://////////////////////////////////////////////
//:: Created By:
//:: Created On:
//:://////////////////////////////////////////////
int     AP_GetIsInSameArea         (object oThing1, object oThing2) {

    if ( ! GetIsObjectValid(oThing1) ) {
        AP_Debug(DEBUG_LOW,"AP_GetIsInSameArea","Thing 1 is not a valid object");
        return FALSE;
    }
    if ( ! GetIsObjectValid(oThing2) ) {
        AP_Debug(DEBUG_LOW,"AP_GetIsInSameArea","Thing 2 is not a valid object");
        return FALSE;
    }

    object oThing1Area = GetArea(oThing1);
    object oThing2Area = GetArea(oThing2);

    if ( oThing1Area != oThing2Area )  {
        AP_Debug(DEBUG_LOW,"AP_GetIsInSameArea","Objects are not in same area");
        if( ! GetIsObjectValid(oThing1Area) ) AP_Debug(DEBUG_LOW,"AP_GetIsInSameArea","Thing 1's area does not exist (yet): " + GetTag(oThing1) );
        if( ! GetIsObjectValid(oThing2Area) ) AP_Debug(DEBUG_LOW,"AP_GetIsInSameArea","Thing 2's area does not exist (yet): " + GetTag(oThing2) );
        return FALSE;
    }

    else
        return TRUE;
}

//::///////////////////////////////////////////////
//:: AP_GetIsLocalVisa
//::
//:://////////////////////////////////////////////
/*
This function compares the server on the Visa to
this server. This used to use the entire server
name but was recently changed to extract just the
number to help with typos on the DMs part.
*/
//:://////////////////////////////////////////////
//:: Created By: Ranoulf, ag107093@hotmail.com
//:: Created On: 02 Aug 2002
//:://////////////////////////////////////////////
int AP_GetIsLocalVisa (object oAP_Visa)   {

    if (DEBUG) AP_Debug(DEBUG_LOW,"AP_GetIsLocalVisa","AP_GetIsLocalVisa: Checking if the visa is local to this server");

    string sVisaServer = AP_GetServerOnVisa(oAP_Visa);
    string sVisaport = AP_GetPortOnVisa(oAP_Visa);

    string sThisServer = AP_GetThisServer();
    string sThisPort = AP_GetThisServerPort();

    return (sVisaServer+sVisaport == sThisServer+sThisPort);

}

//::///////////////////////////////////////////////
//:: AP_GetIsNearWP
//::
//:://////////////////////////////////////////////
/*
does not work if area isn't loaded yet
*/
//:://////////////////////////////////////////////
//:: Created By:
//:: Created On:
//:://////////////////////////////////////////////
int     AP_GetIsNearWP           (object oPC,object oWayPoint) {

    if ( ! GetIsObjectValid(GetArea(oPC)))
        AP_Debug(DEBUG_HI,"AP_GetIsNearWP","Warning: this function was called before the area had loaded giving inaccurate answer");

    if ( ! AP_GetIsInSameArea(oPC,oWayPoint) )
        return FALSE;

    return ( GetDistanceBetween(oPC,oWayPoint) > JUMP_PROXIMITY );



} //end function

//::///////////////////////////////////////////////
//:: AP_GetIsPassAccepted
//::
//:://////////////////////////////////////////////
/*

*/
//:://////////////////////////////////////////////
//:: Created By: Ranoulf, ag107093@hotmail.com
//:: Created On:
//:://////////////////////////////////////////////
int     AP_GetIsPassAccepted  (struct documentation Docs) {

    return  GetIsObjectValid( GetWaypointByTag( AP_GetDestTag(Docs.oPass) ) );

}

//::///////////////////////////////////////////////
//:: AP_GetIsResident
//::
//:://////////////////////////////////////////////
/*
    if their Visa doesn't exist, we assume they are
    either new, or trying to sneak in.
    We want to run them trough immigration in either
    case so see if they've been here before and 'lost'
    thier visa from another server.
*/
//:://////////////////////////////////////////////
//:: Created By: Ranoulf, ag107093@hotmail.com
//:: Created On:
//:://////////////////////////////////////////////
int     AP_GetIsResident(object oPC, struct documentation Docs) {

    return (    GetIsObjectValid(Docs.oVisa) &&
                AP_GetIsLocalVisa(Docs.oVisa)
            );
}



//::///////////////////////////////////////////////
//:: AP_GetPortOnVisa
//::
//:://////////////////////////////////////////////
/*

*/
//:://////////////////////////////////////////////
//:: Created By:
//:: Created On:
//:://////////////////////////////////////////////
string  AP_GetPortOnVisa          (object oVisa) {

    string sDefaultPort = "5121";
    string sVisaTag = GetTag(oVisa);

    string sPort = AP_GetWord(sVisaTag,3);

    if ( sPort != "" )  {

        if ( StringToInt(sPort) < 1 ) {
            AP_Debug(DEBUG_HI,"AP_GetPortOnVisa","Your Visa (" + sVisaTag + ") port is malfomred. It must fit be numeric and greater than 1");
            return "";
        }
        if ( GetStringLength(sPort) > 5 ) {
            AP_Debug(DEBUG_HI,"AP_GetPortOnVisa","Your Visa (" + sVisaTag + ") port is malfomred. It must be less than 6 digits");
            return "";
        }
        return sPort;
    }

    else
        return sDefaultPort;
}



//::///////////////////////////////////////////////
//:: AP_GetServerOnVisa
//::
//:://////////////////////////////////////////////
/*
Returns the destination server on Visa

      Server  Port
      Number  Number
         |  (Optional)
         |     |
prefix_xxxxx_nnnn
*/
//:://////////////////////////////////////////////
//:: Created By: Ranoulf, ag107093@hotmail.com
//:: Created On: 21 Oct 2002
//:://////////////////////////////////////////////
string AP_GetServerOnVisa (object oVisa) {


    return AP_GetWord(GetTag(oVisa),2);
}


//::///////////////////////////////////////////////
//:: AP_GetThisServer
//::
//:://////////////////////////////////////////////
/*
This function returns the second 'word' of the server.

If it was server_0007_5121 you'd get '0007'

*/
//:://////////////////////////////////////////////
//:: Created By: Ranoulf, ag107093@hotmail.com
//:: Created On: 05 Aug 2002
//:: Modified on: 02 Nov 2002
//:://////////////////////////////////////////////
string AP_GetThisServer()    {

    // string sModuleName = GetModuleName();

    string sModuleTag = GetTag(GetModule());

    string sPrefix = AP_GetWord(sModuleTag,1) + "_";

    string sNumber = AP_GetWord(sModuleTag,2);

    if (sPrefix != SERVER_PREFIX)
        AP_Debug(DEBUG_MAX,"AP_GetThisServer","ERROR: your module NAME (" + sModuleTag + ") must start with: " + SERVER_PREFIX + ", not: " + sPrefix);

    if ( StringToInt(sNumber) >  MAX_SERVERS )   // doesn't work if there are letters in the server field
        AP_Debug(DEBUG_MAX,"AP_GetThisServer","ERROR: your module number (" + sNumber + ") is greater than the max set at: " + IntToString(MAX_SERVERS) );

    return sNumber; // added this for mandos

}

//::///////////////////////////////////////////////
//:: AP_GetThisServerPort
//::
//:://////////////////////////////////////////////
/*
This function returns the third 'word' of the server.

If it was server_0007_5121 you'd get '5121'
*/
//:://////////////////////////////////////////////
//:: Created By: Ranoulf, ag107093@hotmail.com
//:: Created On: 05 Aug 2002
//:: Modified on: 02 Nov 2002
//:://////////////////////////////////////////////
string AP_GetThisServerPort()    {

    string sModuleTag = GetTag(GetModule());

    string sPort = AP_GetWord(sModuleTag,3);

    if ( sPort == "" )
        return "5121";


    else {

        int iPort = StringToInt(sPort);

        if ( iPort > 65555 || iPort < 1 ) {

            AP_Debug(DEBUG_HI,"AP_GetThisServerPort","Error - server ports but be between 1 and 65,555, not : " + sPort);

            return "";
        }

        return sPort;
    }

}



//::///////////////////////////////////////////////
//:: AP_GiveVisa
//::
//:://////////////////////////////////////////////
/*
This function gives the oPC a item with the name
VISANAME (defined at the top) and the tag SERVER_NAME
which it gets from the name field of your module that
you set in the module properties.

The function does not create this item (the scripting
language doesn't allow this), it just gives one to
the PC. The DM must have already created an item as
descibed in the Quick How To.
*/
//:://////////////////////////////////////////////
//:: Created By: Ranoulf, ag107093@hotmail.com
//:: Created On: 23 Oct 2002
//:://////////////////////////////////////////////
object AP_GiveVisa (object oPC)   {

    AP_Debug(DEBUG_LOW,"AP_CreateVisa","Creating a Visa for the PC");

    // lets get the tag of this module
    //string sModuleName = GetModuleName();

    string sModuleName = GetTag(GetModule());


    // and create the visa with the matching Resref
    object oVisa = CreateItemOnObject(sModuleName,oPC);

    if ( ! GetIsObjectValid(oVisa) ) {

        AP_Debug (DEBUG_MAX,"AP_CreateVisa","The DM has not created a Visa that matches the name of this server: " + sModuleName);

        AP_Notify(oPC,NOTE_NO_VISA);
    }

    else  {

        if ( ! AP_GetIsValidVisa(oVisa) ) {

            DestroyObject(oVisa);
            oVisa = OBJECT_INVALID;
        }

        else {

            AP_Debug (DEBUG_MED,"AP_CreateVisa","Visa created/renewed for " + GetName(oPC));
        }
    }


    return oVisa;
}
//  add error control for full inventory...somehow




//::///////////////////////////////////////////////
//:: AP_GetIsValidVisa
//::
//:://////////////////////////////////////////////
/*

*/
//:://////////////////////////////////////////////
//:: Created By: Ranoulf, ag107093@hotmail.com
//:: Created On:
//:://////////////////////////////////////////////
int     AP_GetIsValidVisa   (object oVisa) {

    string sVisaTag = GetTag(oVisa);
    string sPrefix = AP_GetWord(sVisaTag,1) + "_";
    string sServer = AP_GetWord(sVisaTag,2);
    string sPort   = AP_GetWord(sVisaTag,3);

    if ( sPrefix != SERVER_PREFIX ) {
        AP_Debug (DEBUG_HI,"AP_GetIsValidVisa","Error - Visa tag (" + sVisaTag + ") does not start with server prefix : " + SERVER_PREFIX);
        return FALSE;
    }

    if ( sServer != AP_GetThisServer() ) {
        AP_Debug (DEBUG_HI,"AP_GetIsValidVisa","Error - Visa tag (" + sVisaTag + ") server does not match this server : " + AP_GetThisServer() );
        return FALSE;
    }

    if ( sPort != ""){
        if ( StringToInt(sPort) < 1 ) AP_Debug(DEBUG_HI,"AP_GetIsValidVisa","Your Visa (" + sVisaTag + ") port is malfomred. It must fit be numeric and greater than 1");
        if ( GetStringLength(sPort) > 5 ) AP_Debug(DEBUG_HI,"AP_GetIsValidVisa","Your Visa (" + sVisaTag + ") port is malfomred. It must be less than 6 digits");
    }

    return TRUE;
}

//::///////////////////////////////////////////////
//:: AP_JumpToNewPCArea
//::
//:://////////////////////////////////////////////
/*

*/
//:://////////////////////////////////////////////
//:: Created By: Ranoulf, ag107093@hotmail.com
//:: Created On:
//:://////////////////////////////////////////////
void    AP_MoveNewPC  (object oPC)    {

    object oDestination = GetObjectByTag(START_LOCATION_TAG);

    if ( GetIsObjectValid(oDestination) )

        AP_MovePC(oPC,oDestination,TRUE);

    else {
        AP_Debug(DEBUG_HI,"AP_JumpToNewPCArea","The Server does not have a custom waypoint for newly minted characters, please create one tagged " + START_LOCATION_TAG);
        AP_FreezeOff(oPC);  // without this, the PC is left frozen
    }

}

//::///////////////////////////////////////////////
//:: AP_MovePC
//::
//:://////////////////////////////////////////////
/*

*/
//:://////////////////////////////////////////////
//:: Created By: Ranoulf, ag107093@hotmail.com
//:: Created On:
//:://////////////////////////////////////////////
void    AP_MovePC   (object oPC, object oWayPoint, int iUnfreeze = FALSE)  {

    DelayCommand( JUMP_DELAY, AP_FreezeOff(oPC));

    if (! AP_GetIsNearWP(oPC,oWayPoint) )

        DelayCommand( JUMP_DELAY, AssignCommand(oPC, JumpToObject(oWayPoint)) );

    else

        if (DEBUG) AP_Debug(DEBUG_LOW,"AP_JumpToPassLocal","The PC is close to the waypoint and do not need jumped");


    if ( ! iUnfreeze ) DelayCommand( JUMP_DELAY + 1, AP_FreezeOn(oPC));

}


//::///////////////////////////////////////////////
//:: AP_Portal
//::
//:://////////////////////////////////////////////
/*

*/
//:://////////////////////////////////////////////
//:: Created By: Ranoulf, ag107093@hotmail.com
//:: Created On: 21 Oct 2002
//:://////////////////////////////////////////////
void    AP_Portal               (object oPC, string sServer, string sPort, int iPortalType = 0, string sWaypoint = "none") {

    if (DEBUG) AP_Debug(DEBUG_LOW,"AP_Portal","Portaling PC");

    string sFullAddress = SERVER_PREFIX + sServer + DOMAIN + ":" + sPort;

// Now lets pick one of the four ways we can portal

    switch (PORTAL_MODE) {

    // CHAR_SELECT
    case 1:
        ActivatePortal(oPC,sFullAddress,CURRENT_AP_PASSWORD);
        break;

    // MANUAL
    case 2:
        BootPC(oPC);
        break;
                                                 // Providing a waypoint is
    // CONFIRM                                   // what skips the choose char
    case 3:                                      // screen on the next server
        ActivatePortal(oPC,sFullAddress,CURRENT_AP_PASSWORD,sWaypoint,FALSE);
        break;

    // SEAMLESS
    case 4:
        ActivatePortal(oPC,sFullAddress,CURRENT_AP_PASSWORD,sWaypoint,TRUE);
        break;

    default:
        AP_Debug(DEBUG_MAX,"AP_Portal","Error- invalid portal mode selected -> " + IntToString(PORTAL_MODE) );
        break;
    }

    AP_PortalMonitor(oPC,iPortalType);
}


//::///////////////////////////////////////////////
//:: PortalMonitor
//::
//:://////////////////////////////////////////////
/*
This function keeps a tab on the oPC that just tried
to portal by calling itself until the oPC leaves or the
portal time out is reached, then does some clean up.
*/
//:://////////////////////////////////////////////
//:: Created By:
//:: Created On:
//:://////////////////////////////////////////////
void    AP_PortalMonitor          (object oPC, int iPortalType, float fTimeElapsed = 0.0) {

//  only try as long as the pc is still here and they have not passed the portal timeout
    if ( GetIsObjectValid(oPC) && fTimeElapsed < PORTAL_TIMEOUT ) {

        if (DEBUG) AP_Debug(DEBUG_LOW,"AP_PortalMonitor","PC has not portaled yet, continuing to monitor them. (" + IntToString(FloatToInt(fTimeElapsed)) + " seconds elapsed)");

        DelayCommand( CALLBACK, AP_PortalMonitor(oPC, iPortalType, fTimeElapsed + CALLBACK) );
    }

    else {

//      The PC has left the server
        if ( ! GetIsObjectValid(oPC) ) {

            if (DEBUG) AP_Debug (DEBUG_LOW,"AP_PortalMonitor","The PC has left the server");
        }

//      Or the PC's Portal has failed
        else {

            AP_Notify(oPC,NOTE_PORTAL_FAILED);

            if ( iPortalType == PORTAL_SENDBACK) {

                if (DEBUG) AP_Debug (DEBUG_LOW,"AP_PortalMonitor","The PC's Sendback Portal has failed");

                AP_QuarantinePC(oPC);
            }

            else {

                if (DEBUG) AP_Debug (DEBUG_LOW,"AP_PortalMonitor","The PC's Portal has failed");
            }
        }
    }
}


//::///////////////////////////////////////////////
//:: AP_ProcessAcceptedPass
//::
//:://////////////////////////////////////////////
/*
    If the PC is dead but has a passport...something
    funny is going on.
*/
//:://////////////////////////////////////////////
//:: Created By:
//:: Created On:
//:://////////////////////////////////////////////
void AP_ProcessAcceptedPass(object oPC, struct documentation Docs)  {

    if ( ! GetIsObjectValid(Docs.oDeathCertificate) )

        AP_AfterAreaLoad(EVENT_MOVE_PC,oPC,Docs.oPass);

    else {

        AP_Notify(oPC,NOTE_DEAD_PC_WITH_PASS,GetTag(Docs.oPass));

        AP_AfterAreaLoad(EVENT_DEAD_PC,oPC);

        DestroyObject(Docs.oPass); // if they were dead BUT had a pass, we already notified the proper people and want to destroy it here

   }

}

//::///////////////////////////////////////////////
//:: AP_ProcessForeignVisa
//::
//:://////////////////////////////////////////////
/*

*/
//:://////////////////////////////////////////////
//:: Created By: Ranoulf, ag107093@hotmail.com
//:: Created On:
//:://////////////////////////////////////////////
void    AP_ProcessForeignVisa(object oPC, struct documentation Docs) {

    if ( GetIsObjectValid(Docs.oPass) )

        AP_ProcessPass(oPC,Docs);

    else

       AP_ProcessNoPass(oPC,Docs);
}

//::///////////////////////////////////////////////
//:: AP_ProcessNewPC
//::
//:://////////////////////////////////////////////
/*

*/
//:://////////////////////////////////////////////
//:: Created By:
//:: Created On:
//:://////////////////////////////////////////////
void        AP_ProcessNewPC   (object oPC)    {

    AP_Notify(oPC,NOTE_NEW_PC);

    if (DEBUG) AP_Debug(DEBUG_LOW,"AP_ProcessNewPC","Character is being considered New");

    // Now lets give them a new Visa for their stay
    AP_GiveVisa(oPC);

    //  Jump them to the new PC area after it loads
    AP_AfterAreaLoad(EVENT_MOVE_NEW_PC,oPC);

    if (DEBUG) AP_Debug(DEBUG_LOW,"AP_ProcessNewPC","Done processing new pc");

    return;
}

//::///////////////////////////////////////////////
//:: AP_ProcessNonresident
//::
//:://////////////////////////////////////////////
/*
This function handles the controll logic for the
entering char holding a AP Pass. The waypoint is
extracted and they are jumped to it. (if set to on)
If the Pass is invalid, such as with a formatting
error, you are left alone. You'll end up at the
module start point.
*/
//:://////////////////////////////////////////////
//:: Created By: Ranoulf, ag107093@hotmail.com
//:: Created On: 26 Jan 2003
//:://////////////////////////////////////////////
void    AP_ProcessNonResident   (object oPC,struct documentation Docs) {

    AP_Debug(DEBUG_LOW,"AP_ProcessNonresident","PC is a non-resident");

//  if they have no visa, we handle them differently than if they do (they might be new)
    if ( ! GetIsObjectValid(Docs.oVisa) )

        AP_ProcessNoVisa(oPC,Docs);

    else

        AP_ProcessForeignVisa(oPC,Docs);

}

//::///////////////////////////////////////////////
//:: AP_ProcessNoPass
//::
//:://////////////////////////////////////////////
/*

*/
//:://////////////////////////////////////////////
//:: Created By: Ranoulf, ag107093@hotmail.com
//:: Created On:
//:://////////////////////////////////////////////
void    AP_ProcessNoPass(object oPC, struct documentation Docs) {

    AP_Debug(DEBUG_LOW,"AP_ProcessNoPass","PC did not have a passport, sending them back");

    AP_AfterAreaLoad(EVENT_NO_PASS, oPC,Docs.oVisa);
}

//::///////////////////////////////////////////////
//:: AP_ProcessNoVisa
//::
//:://////////////////////////////////////////////
/*

*/
//:://////////////////////////////////////////////
//:: Created By: Ranoulf, ag107093@hotmail.com
//:: Created On:
//:://////////////////////////////////////////////
void    AP_ProcessNoVisa    (object oPC,struct documentation Docs) {

    AP_Debug(DEBUG_LOW,"AP_ProcessNoVisa","PC did not have a visa");

//  we keep a list of people that have been here before and we are
//  also interested if you come in with a pass, but no visa
    if ( AP_GetHasPriors(oPC) || GetIsObjectValid(Docs.oPass) || GetIsObjectValid(Docs.oDeathCertificate) )

        AP_ProcessOffender(oPC,Docs);

    else

        AP_ProcessNewPC(oPC);
}

//::///////////////////////////////////////////////
//:: AP_ProcessOffender
//::
//:://////////////////////////////////////////////
/*

*/
//:://////////////////////////////////////////////
//:: Created By: Ranoulf, ag107093@hotmail.com
//:: Created On:
//:://////////////////////////////////////////////
void    AP_ProcessOffender  (object  oPC, struct documentation Docs)   {

    //SendMessageToPC(oPC,"You are offensive");
    DelayCommand(1.0,SendMessageToPC(oPC,"You have been judged to be attempting an exploit of some kind by the portal process."));
    DelayCommand(1.0,SendMessageToPC(oPC,"To regain your freedom, please send a message to the DM of this server and plead your case."));
    DelayCommand(1.0,SendMessageToPC(oPC,"They may decide to use the 'Normalise' feature of the DM wand."));
    return;

}

//::///////////////////////////////////////////////
//:: AP_ProcessPass
//::
//:://////////////////////////////////////////////
/*

*/
//:://////////////////////////////////////////////
//:: Created By: Ranoulf, ag107093@hotmail.com
//:: Created On:
//:://////////////////////////////////////////////
void    AP_ProcessPass(object oPC, struct documentation Docs) {

    if ( AP_GetIsPassAccepted(Docs) ) {

        if (DEBUG) AP_Debug(DEBUG_MED,"AP_ProcessPass","PC's Passport has been accepted");

        DestroyObject(Docs.oVisa); // get rif of their old visa

        AP_GiveVisa(oPC);          // and give them a new one

        AP_ProcessAcceptedPass(oPC, Docs);
    }

    else {     // send them back to the server on thier Visa

        if (DEBUG) AP_Debug(DEBUG_MED,"AP_ProcessPass","PC's Passport has been rejected, sending them back");

        AP_AfterAreaLoad(EVENT_BAD_PASS,oPC, Docs.oVisa);
    }

}

//::///////////////////////////////////////////////
//:: AP_ProcessResident
//::
//:://////////////////////////////////////////////
/*

*/
//:://////////////////////////////////////////////
//:: Created By: Ranoulf, ag107093@hotmail.com
//:: Created On:
//:://////////////////////////////////////////////
void    AP_ProcessResident(object oPC, struct documentation Docs) {

    AP_Debug(DEBUG_LOW,"AP_ProcessResident","The player has a visa for this server, processing them as a resident");

//  if they have a passport on them, they are up to something funny
    if ( GetIsObjectValid(Docs.oPass) ) {
        AP_Notify(oPC,NOTE_RESIDENT_WITH_PASS,GetTag(Docs.oPass));
        DestroyObject((Docs.oPass));
    }

//  if they are dead, we have to move them to the morgue
    if ( GetIsObjectValid(Docs.oDeathCertificate) )
        AP_AfterAreaLoad(EVENT_DEAD_PC,oPC);

    else {
        //  this is where we would tag them to be moved to their
        //  last known spot if we were keeping track

       AP_AfterAreaLoad(EVENT_RESIDENT_IN_SUCCESS,oPC);

       AP_Debug(DEBUG_LOW,"AP_ProcessResident","Finished processing the PC, they are being left in place");
    }
}

//::///////////////////////////////////////////////
//:: AP_SendBack
//::
//:://////////////////////////////////////////////
/*
This function is called when the script realizes
the player holds a Visa for another server and
has no passport.
*/
//:://////////////////////////////////////////////
//:: Created By: Ranoulf, ag107093@hotmail.com
//:: Created On: 02 Aug 2002
//:://////////////////////////////////////////////
void AP_SendBack (object oPC, object oVisa)    {

    string sServer = AP_GetServerOnVisa(oVisa);

    string sPort = AP_GetPortOnVisa(oVisa);

    AP_Portal(oPC,sServer,sPort,PORTAL_SENDBACK);

    return;

}


//::///////////////////////////////////////////////
//:: AP_QuarantinePC
//::
//:://////////////////////////////////////////////
/*

*/
//:://////////////////////////////////////////////
//:: Created By:
//:: Created On:
//:://////////////////////////////////////////////
void    AP_QuarantinePC (object oPC) {

    if ( QUARANTINE ) {

        object oQuarantineWP = GetObjectByTag(QUARENTINE_WP_TAG);

        int iIsValid = GetIsObjectValid(oQuarantineWP);

//      some people moved their Q WP out of the Q area in the past, so we check
        int iIsInCorrectArea = ( QUARENTINE_AREA_TAG == GetTag(GetArea(oQuarantineWP)));

        if ( iIsValid && iIsInCorrectArea ) {

            AP_Debug(DEBUG_HI,"AP_QuarantinePC",GetName(oPC) + " is being quarantined");

            AP_Notify(oPC,NOTE_BEING_QUARANTINED);

            AP_MovePC(oPC, oQuarantineWP );

            return;
        }

        else    {

            if ( ! iIsValid ) {

                AP_Debug(DEBUG_HI,"AP_QuarantinePC","Quarantine area does not exist, leaving PC in place");

                AP_Notify(oPC,NOTE_NO_QUARANTINE);
            }

            else { // must be in another area

                AP_Debug(DEBUG_HI,"AP_QuarantinePC","Quarantine area does not exist, leaving PC in place");

                AP_Notify(oPC,NOTE_BAD_QUARANTINE);
            }

        }
    }

//  if Quarantine is off
    else {

        AP_Debug(DEBUG_HI,"AP_QuarantinePC","PC send-back portal failed, but quarantine is off. Leaving them in place.");

        AP_Notify(oPC,NOTE_QUARANTINE_OFF);

        AP_FreezeOff(oPC);
    }

//  if quarantine didn't happen, and the PC is dead, we need to get them to the morgue
    if ( GetIsObjectValid(GetItemPossessedBy(oPC,DEATH_SYMBOL_TAG)) ) {

        AP_AfterAreaLoadEvent(EVENT_DEAD_PC,oPC);

    }
}// end function
















// ----------- General Use ------------------------




//::///////////////////////////////////////////////
//:: AP_DeBug
//::
//:://////////////////////////////////////////////
/*

*/
//:://////////////////////////////////////////////
//:: Created By: Ranoulf, ag107093@hotmail.com
//:: Created On:
//:://////////////////////////////////////////////
void AP_Debug   (int iDebugLevel, string sCallingFunction, string sMessage) {

    if (iDebugLevel >= DEBUG_LOG_THRESHOLD)
        PrintString("Portal Error - " + sCallingFunction + " : " + sMessage);

    if (iDebugLevel >= DEBUG_CLIENT_THRESHOLD) {
        object oPC = GetEnteringObject();
        if ( GetIsObjectValid(oPC) ) {
            SendMessageToPC(oPC,sMessage);
            SendMessageToAllDMs(" Character " + GetName(oPC) + " got error: " + sMessage);
        }
        else
            SpeakString(sMessage,TALKVOLUME_SHOUT);

    }
}



//::///////////////////////////////////////////////
//:: AP_Notify
//::
//:://////////////////////////////////////////////
/*

*/
//:://////////////////////////////////////////////
//:: Created By: Ranoulf, ag107093@hotmail.com
//:: Created On:
//:://////////////////////////////////////////////
void    AP_Notify (object oPC, int iEvent, string sMessage = "") {

    // kluge to get PC a message from a indirect function
    //if ( ! GetIsObjectValid(oActor) )  oActor = GetEnteringObject();
    //if ( ! GetIsObjectValid(oActor) )  oActor = GetClickingObject();

    string sCharacter = GetName(oPC);
    string sPlayer = GetPCPlayerName(oPC);

    switch (iEvent) {

    case 1 :
    // NOTE_RESIDENT_IN_SUCCESS :
//      This is for the players behalf so "AP Visa lost" isn't the last
//      thing they see
        DelayCommand( 2.0, SendMessageToPC(oPC,"Your Visa has been renewed, welcome back") );
        FloatingTextStringOnCreature("Residency Established",oPC);
        break;

    case 2 :
    // NOTE_NONRESIDENT_IN_SUCCESS :
        DelayCommand(0.5,SendMessageToPC(oPC, "New Visa Issued"));
        FloatingTextStringOnCreature("Portal Successful",oPC);
        break;

    case 3 :
    // NOTE_NO_PASS :
        SendMessageToPC(oPC,"Your have arrived without a passport and are being sent back");
        FloatingTextStringOnCreature("Passport required",oPC);
        DelayCommand(1.5, FloatingTextStringOnCreature("Being sent back to " + sMessage,oPC));
        break;

    case 4 :
    // NOTE_BAD_PASS :
        SendMessageToPC(oPC,"This server does not accept your passport, you are being sent back");
        FloatingTextStringOnCreature("Passport Rejected",oPC);
        DelayCommand(1.5, FloatingTextStringOnCreature("Being sent back to " + sMessage,oPC));
        break;

    case 5 :
    // NOT_NEAR_WAYPOINT :
        FloatingTextStringOnCreature("Being Jumped to Waypoint ", oPC);
        break;

    case 6 :
    // NOTE_SENDING_BACK
        FloatingTextStringOnCreature("You are being sent back to server " + sMessage, oPC);
        break;

    case 7 :
    // NOTE_PORTAL_FAILED = 7
        FloatingTextStringOnCreature("Portal failed", oPC);
        break;

    case 8 :
    // NOTE_NO_QUARANTINE
    //      need to delay these so the prior 'portal failed' notification has time to display
        DelayCommand( 1.5 , FloatingTextStringOnCreature("No Quarantine WP, frozen in place", oPC) );
        break;

    case 9 :
    // NOTE_BEING_QUARANTINED
    //      need to delay these so the 'portal failed' notification has time to display
        DelayCommand( 1.5 , FloatingTextStringOnCreature("Being moved to Quarantine area", oPC) );
        break;

    case 10:
    // NOTE_QUARANTINE_OFF
        DelayCommand( 1.5 , FloatingTextStringOnCreature("Quarantine disabled, left in place", oPC) );
        break;

    case 11:
    //  NOTE_BAD_PORTAL
        DelayCommand( 1.5 , FloatingTextStringOnCreature("Portal cannot be used", oPC) );
        break;

    case 12:
    //  NOTE_NO_SERVER_PASS
        DelayCommand( 1.5 , FloatingTextStringOnCreature("Server has no passport for this portal", oPC) );
        break;

    case 13 :
    //  NOTE_PORTAL_TO
        DelayCommand( 1.5 , FloatingTextStringOnCreature("Traveling to server " + sMessage, oPC) );
        break;

    case 14 :
    //  NOTE_NO_VISA
        DelayCommand( 1.5 , FloatingTextStringOnCreature("Cannot Create Visa", oPC) );
        break;

    case 15 :
    //  NOTE_DEAD_PC
        DelayCommand( 1.5 , FloatingTextStringOnCreature("You are dead. Moving to Morgue", oPC) );
        break;

    case 16 :
    //  NOTE_NEW_PC_WELCOME
        DelayCommand( 1.5 , FloatingTextStringOnCreature("Welcome To ALFA", oPC) );
        break;

    case 17 :
    //  NOTE_NO_MORGUE
        DelayCommand( 2.5 , FloatingTextStringOnCreature("Morgue WayPoint Does Not Exist", oPC) );
        SendMessageToAllDMs("The Portal Script cannot find the morgue waypoint. Tag should be: " + MORGUE_WAYPOINT_TAG);
        break;

    case 18 :
    //  NOTE_BAD_QUARANTINE
        DelayCommand( 2.5 , FloatingTextStringOnCreature("Quarantine WP is not in Correct Area", oPC) );
        SendMessageToAllDMs("Your Quarantine WP is not in the quaratine area");
        break;



//  NOTE_PORTAL_IN
    case 1001 :
        if (DEBUG) {
            PrintString(" ");
            PrintString("Portal Event: " + sCharacter + " played by " + sPlayer + " Entered server");
            if (DEBUG_LOG_THRESHOLD <= DEBUG_LOW) { // meaning show even low-level events
                PrintString("    Portal Version = " + PORTAL_VESION);
                PrintString("   Debug Threshold = " + IntToString(DEBUG_LOG_THRESHOLD));
                PrintString("   Portal Mode     = " + IntToString(PORTAL_MODE) );
                PrintString("    Portal Timeout = " + FloatToString(PORTAL_TIMEOUT));
                PrintString("   Sendback Delay  = " + FloatToString(SENDBACK_DELAY));
                PrintString("       Jump Delay  = " + FloatToString(JUMP_DELAY));
                PrintString("     Client Alerts = " + IntToString(DEBUG_CLIENT_THRESHOLD));
            }
        }
    break;

//  NOTE_NEW_PC
    case 1002 :
        PrintString("");
        PrintString("Portal Event:" + sCharacter + " ! New PC detected (has no visa)");
    break;

//  NOTE_RESIDENT_WITH_PASS
    case 1003 :
        PrintString("");
        PrintString(" __--==> Suspicious Behavior from: " + sPlayer + "(" + sCharacter + ")");
        PrintString("Player has arrived with visa for this server, AND a passport. This should never happen unless in exploit");
        PrintString("Passport tag : " + sMessage);
        SendMessageToAllDMs("Attention - Player " + sPlayer + " has arrived with a local visa AND a passport. This should never happen");
        DelayCommand(10.0,SendMessageToPC(oPC,"You have arrived with both a visa for this server and a passport. Please contact a DM and tell them about this"));
    break;

//  NOTE_PORTAL_OUT
    case 1004 :
        PrintString(" ");
        PrintString("Portal Event: " + sCharacter + " is portaling out");
    break;

//  NOTE_DEAD_PC_WITH_PASS
    case 1005 :
        PrintString("");
        PrintString(" __--==> Suspicious Behavior from: " + sPlayer + "(" + sCharacter + ")");
        PrintString("Player has arrived with a valid passport to from server " + AP_GetWord(sMessage,2)  );
        PrintString(" This should never happen unless in exploit");
        PrintString("Passport tag : " + sMessage);
        SendMessageToAllDMs("Attention - Player " + sPlayer + " has arrived from server " + AP_GetWord(sMessage,2) + " with a valid passport, but they are dead. This is probably an exploit");
        DelayCommand(10.0,SendMessageToPC(oPC,"You have arrived with a valid passport but are dead. Please contact a DM and tell them about this"));
    break;


    default :
        PrintString("Portal Event: Warning, non event called: " + IntToString(iEvent));
    break;

    }   // end switch
}

//::///////////////////////////////////////////////
//:: AP_SyncBugLevel
//::
//:://////////////////////////////////////////////
/*

*/
//:://////////////////////////////////////////////
//:: Created By:
//:: Created On:
//:://////////////////////////////////////////////
void    AP_SyncBugLevel        () {

//  These are the names of the local variables names that store the current debug levels
    string sDebugLog = "AP_FLAG_CURRENT_DEBUG_THRESHOLD";
    string sDebugClient = "AP_FLAG_CURRENT_SENDTOCLIENT";
    object oStorageObject = GetModule();

//  Lets define the relative importance of the global debug variables
    DEBUG_BASE  = 1;    // base level string stuff, not important
    DEBUG_LOW   = 2;    // not very important
    DEBUG_MED   = 3;    // nice to know about
    DEBUG_HI    = 4;    // you really should know about this
    DEBUG_MAX   = 5;    // You're getting told whether you like it or not


//  Now lets see if level has been changed
    int iLogAlertLevel = GetLocalInt(oStorageObject,sDebugLog);
    int iClientAlertLevel = GetLocalInt(oStorageObject,sDebugClient);

//  If either level is non-zero, that means someone has used the wand to change
//  it. Wo we need to make sure we set the global DEBUG to true if it's not already
    if ( iLogAlertLevel != 0 || iClientAlertLevel != 0)
        DEBUG = TRUE;

//  If the log alert level has not been set yet, it will be 0 so we should remain at the default
//  Otherwise we should make it match what the user wants
    if (iLogAlertLevel == 0) {
        DEBUG_LOG_THRESHOLD = DEBUG_DEFAULT_THRESHOLD;
        // if (DEBUG) AP_Debug(DEBUG_LOW,"AP_SyncBugLevel","Log alert level at default level: " + IntToString(DEBUG_LOG_THRESHOLD) );
        //    the above line is always true for some reason
    }
    else {
        DEBUG_LOG_THRESHOLD = iLogAlertLevel;
        if (DEBUG) AP_Debug(DEBUG_LOW,"AP_SyncBugLevel","Log alert level set to: " + IntToString(iLogAlertLevel) );
    }

//  same deal for the client settings
    if (iClientAlertLevel == 0) {
        DEBUG_CLIENT_THRESHOLD  = DEBUG_DEFAULT_THRESHOLD;
        if (DEBUG) AP_Debug(DEBUG_LOW,"AP_SyncBugLevel","Client alert level at default level: " + IntToString(DEBUG_CLIENT_THRESHOLD));
    }
    else {
        DEBUG_CLIENT_THRESHOLD = iClientAlertLevel;
        if (DEBUG) AP_Debug(DEBUG_LOW,"AP_SyncBugLevel","Client alert level set to: " + IntToString(DEBUG_CLIENT_THRESHOLD) );
    }

//  Lastly, let's make sure we are within our ranges
    if (DEBUG_LOG_THRESHOLD < DEBUG_BASE || DEBUG_LOG_THRESHOLD > DEBUG_MAX) {
        AP_Debug(DEBUG_MAX,"AP_SyncBugLevel","!! Error - Log alert level set to: " + IntToString(DEBUG_LOG_THRESHOLD) + ", Settings must be between: " + IntToString(DEBUG_BASE) + "-" + IntToString(DEBUG_MAX) );
        if (DEBUG) AP_Debug(DEBUG_HI,"AP_SyncBugLevel","Resetting thresholds to defualt levels");
        DEBUG_LOG_THRESHOLD = DEBUG_DEFAULT_THRESHOLD;
    }

    if (DEBUG_CLIENT_THRESHOLD < DEBUG_BASE || DEBUG_CLIENT_THRESHOLD > DEBUG_MAX) {
        AP_Debug(DEBUG_MAX,"AP_SyncBugLevel","!! Error - Client alert level set to: " + IntToString(DEBUG_CLIENT_THRESHOLD) + ", Settings must be between: " + IntToString(DEBUG_BASE) + "-" + IntToString(DEBUG_MAX) );
        if (DEBUG) AP_Debug(DEBUG_HI,"AP_SyncBugLevel","Resetting thresholds to defualt levels");
        DEBUG_CLIENT_THRESHOLD  = DEBUG_DEFAULT_THRESHOLD;
    }


}



















///////////////////////////////////////////////////////////////////////////




















//::///////////////////////////////////////////////
//:: AP_GetTravler
//::
//:://////////////////////////////////////////////
/*
    Added this function to handle PCs that are using
    something like a door or object rather than
    a trigger
*/
//:://////////////////////////////////////////////
//:: Created By: Ranoulf, ag107093@hotmail.com
//:: Created On:
//:://////////////////////////////////////////////
object  AP_GetTravler() {

    object oPC;

    oPC = GetClickingObject();
    if ( GetIsObjectValid(oPC) ) return oPC;

    oPC = GetEnteringObject();
    if ( GetIsObjectValid(oPC) ) return oPC;

    oPC = GetLastOpenedBy();
    if ( GetIsObjectValid(oPC) ) return oPC;

    oPC = GetLastUsedBy();
    if ( GetIsObjectValid(oPC) ) return oPC;

    // this last one could have unintended consequences
    if (DEBUG) AP_Debug(DEBUG_HI,"AP_GetPortalingObject","Triggering object is invalid. Searching for nearest PC");

    oPC = GetNearestCreature(CREATURE_TYPE_PLAYER_CHAR, PLAYER_CHAR_IS_PC);
    if ( GetIsObjectValid(oPC) ) return oPC;

    if (DEBUG) AP_Debug(DEBUG_HI,"AP_GetPortalingObject","Could not find a PC to portal");
    return OBJECT_INVALID;
}

//::///////////////////////////////////////////////
//:: AP_GetPortal
//::
//:://////////////////////////////////////////////
/*

*/
//:://////////////////////////////////////////////
//:: Created By: Ranoulf, ag107093@hotmail.com
//:: Created On:
//:://////////////////////////////////////////////
object  AP_GetPortal()    {

    if ( GetIsObjectValid(OBJECT_SELF) ) return OBJECT_SELF;

    if (DEBUG) AP_Debug(DEBUG_HI,"AP_GetPortal","Error - OBJECT_SELF is invalid, script has no way to referece the portal. Exiting.");
    return OBJECT_INVALID;

    /* no good way to do something like
        object oTrigger = GetFirstObjectInArea();
        while ( GetLastUsedBy(oTrigger)) == OBJECT_INVALID ) {
        GetNextObjectInArea
    */
}


//::///////////////////////////////////////////////
//:: AP_GrantPass
//::
//:://////////////////////////////////////////////
/*

*/
//:://////////////////////////////////////////////
//:: Created By: Ranoulf, ag107093@hotmail.com
//:: Created On:
//:://////////////////////////////////////////////
object  AP_GrantPass(object oPC,object oPortal) {

    object oPass = CreateItemOnObject(GetTag(oPortal),oPC);

    if ( ! GetIsObjectValid(oPass) ) {

        AP_Notify(oPC,NOTE_NO_SERVER_PASS);

        AP_Debug(DEBUG_HI,"AP_GrantPass","Error - no coresponding passport resref in your pallatte for portal tag : " + GetTag(oPortal));
    }

    else {

        DestroyObject(oPass,PORTAL_TIMEOUT); // this will clean up if the portal fails

        if ( ! AP_GetIsValidPortal(GetTag(oPass)) ) {

            AP_Notify(oPC,NOTE_BAD_PORTAL);

            oPass = OBJECT_INVALID;
        }

//      does the name actually contain PASSNAME specified above
        else if ( FindSubString(GetStringUpperCase(GetName(oPass)),GetStringUpperCase(PASSNAME)) < 0 )  {

            AP_Notify(oPC,NOTE_BAD_PORTAL);

            AP_Debug(DEBUG_HI,"AP_GrantPass","Passport name (" + GetName(oPass) + ") must contain the name " + PASSNAME);

            oPass = OBJECT_INVALID;
        }
    }// end else

    return oPass;
}

//::///////////////////////////////////////////////
//:: AP_GetIsValidPortal
//::
//:://////////////////////////////////////////////
/*
    This function gets fed the passport tag, which
    includes the port.
*/
//:://////////////////////////////////////////////
//:: Created By: Ranoulf, ag107093@hotmail.com
//:: Created On:
//:://////////////////////////////////////////////
int     AP_GetIsValidPortal    (string sPassTag) {

    string sPrefix       = AP_GetWord(sPassTag,1);
    string sOriginServer = AP_GetWord(sPassTag,2);
    string sPortalNumber = AP_GetWord(sPassTag,3);
    string sDestinationServer = AP_GetWord(sPassTag,4);
    string sPort = AP_GetWord(sPassTag,5);

    string sThisServer = AP_GetThisServer();

    if (  sPrefix == "" || sOriginServer == "" || sPortalNumber == "" || sDestinationServer == "") {
        AP_Debug(DEBUG_HI,"GetIsValidPortal","Portal tag (" + sPassTag + ") is missing a component. It must take the form of 'AP_XXX_YYY_ZZZ'");
        return FALSE;
    }

    if ( ! (sPrefix == "AP" ) ) {
        AP_Debug(DEBUG_HI,"GetIsValidPortal","Portal tags are case sensitive and must start with 'AP', not :" + sPrefix);
        return FALSE;
    }

    if ( sOriginServer !=  sThisServer ) {
        AP_Debug(DEBUG_HI,"GetIsValidPortal","You are issuing a passport claiming to be from server (" + sOriginServer + ") but you are server : " + sThisServer + ". This IS case sensitive");
        return FALSE;
    }

    if ( sDestinationServer ==  sThisServer ) {

       if ( sPort == "" ) {
            AP_Debug(DEBUG_HI,"AP_GetIsPortalTagValid","Portals between server instances on the same machine must include port numbers for all ports, even the default one");
            return 0;
        }

        if ( sPort == AP_GetThisServerPort() )  {
            AP_Debug(DEBUG_HI,"AP_GetIsPortalTagValid","Portal leads back to this server");
            return 0;
        }

    }

    if ( sPort != "" ) {
        int iPort = StringToInt(sPort);
        if (iPort <= 0) {
            AP_Debug(DEBUG_HI,"AP_GetIsPortalTagValid","Port numbers must be numeric and greater than 0, not : " + sPort);
            return FALSE;
        }
        if (iPort > 65555) {
            AP_Debug(DEBUG_HI,"AP_GetIsPortalTagValid","Port numbers must be less than 65,555, not : " + sPort);
            return FALSE;
        }
    }

    return TRUE;
}

//::///////////////////////////////////////////////
//:: AP_SendPC
//::
//:://////////////////////////////////////////////
/*

*/
//:://////////////////////////////////////////////
//:: Created By: Ranoulf, ag107093@hotmail.com
//:: Created On:
//:://////////////////////////////////////////////
void    AP_SendPC   (object oPC,object oPass){

    string sServer = AP_GetServerOnPass(oPass);

    string sPort = AP_GetPortOnPass(oPass);

    string sWaypoint = AP_GetWaypointOnPass(oPass);

    AP_Notify(oPC,NOTE_PORTAL_TO,sServer + " : " + sPort);

    DelayCommand(JUMP_DELAY,AP_Portal(oPC,sServer,sPort,PORTAL_NORMAL,sWaypoint));
}

//::///////////////////////////////////////////////
//:: AP_GetWaypointOnPass
//::
//:://////////////////////////////////////////////
/*
    This was more complicated in the past when the
    get resref function didn't work

*/
//:://////////////////////////////////////////////
//:: Created By: Ranoulf, ag107093@hotmail.com
//:: Created On:
//:://////////////////////////////////////////////
string  AP_GetWaypointOnPass (object oPass) {

    return GetResRef(oPass);

}

//::///////////////////////////////////////////////
//:: AP_GetServerOnPass
//::
//:://////////////////////////////////////////////
/*

*/
//:://////////////////////////////////////////////
//:: Created By: Ranoulf, ag107093@hotmail.com
//:: Created On:
//:://////////////////////////////////////////////
string  AP_GetServerOnPass  (object oPass){

    return  AP_GetWord(GetTag(oPass),4);


}

//::///////////////////////////////////////////////
//:: AP_GetPortOnPass
//::
//:://////////////////////////////////////////////
/*
    if there is a port, it will be the 5th word
    if the 4th word and the last word are the same

*/
//:://////////////////////////////////////////////
//:: Created By: Ranoulf, ag107093@hotmail.com
//:: Created On:
//:://////////////////////////////////////////////
string  AP_GetPortOnPass  (object oPass){

    string sTag = GetTag(oPass);

    string sLastWord = AP_GetLastWord(sTag);

    string sWord4 = AP_GetWord(sTag,4);

    if (sLastWord != sWord4)
        return sLastWord;

    else
        return "5121";

}

//::///////////////////////////////////////////////
//:: AP_GetWord
//::
//:://////////////////////////////////////////////
/*
Returns word number n from a string.

a.  returns "" if the string is empty.
b.  returns the string minus any leading or trailing
    whitespaces if there are none internal to the string.
c.  returns "" if the Element Number asked for is greater
    than the number of words in the string.

Example:
string sample = "  three blind mice   ";
2ndWord = AP_GetWord(sample,2);

the contents of the var 2ndWord is "blind"

Note: left in flow reporting for future bug fixes
*/
//:://////////////////////////////////////////////
//:: Created By: Ranoulf, ag107093@hotmail.com
//:: Created On: 13 Aug 2002
//:://////////////////////////////////////////////
string AP_GetWord(string sSentence,int iElementNumber = 1) {

//  see if its an empty string
    if ( ! GetStringLength(sSentence) ) return "";

//  remove any whitespace on the ends
    sSentence = AP_RemoveLeadingSpaces(sSentence);
    sSentence = AP_RemoveTrailingSpaces(sSentence);

//  return the shortened string if no more whitespace (just one word)
    int iLocationOfSpace = FindSubString(sSentence,"_");
    if ( iLocationOfSpace == -1 ) return sSentence;

    //  otherwise, lets get the element they want

    // initalize our variables
    int iSentenceLength = GetStringLength(sSentence);
    string sWord = "";
    int i = 0; // iteration limiter

    // pull out the first word (we know there's at least two)
    do {
        sWord = GetStringLeft(sSentence,iLocationOfSpace);
        sSentence = GetStringRight(sSentence,iSentenceLength - iLocationOfSpace -1); // the -1 leaves off the whtspc
        iSentenceLength = GetStringLength(sSentence);
        iLocationOfSpace = FindSubString(sSentence,"_");
        i++;
        if ( i > SEARCH_LIMIT ) break;
        } // keep looping until we get there, or there is only one word left
    while ( i < iElementNumber && iLocationOfSpace > 0 );

    if (i >= SEARCH_LIMIT) AP_Debug(DEBUG_HI,"AP_GetWord","max iteration limit reached");

    // The natuture of the loop above leaves us with the last
    // element in sSubject and the next to last in sWord
    if (i == iElementNumber){  // this is the element they wanted

        return sWord;
    }

    if (i+1 == iElementNumber) {// they wanted the last element in the string

        return sSentence;
    }

    return ""; //   they wanted an element that didn't exist

}

//::///////////////////////////////////////////////
//:: AP_RemoveLeadingSpaces
//::
//:://////////////////////////////////////////////
/*
This function returns the given string without
any whitespace in front.
*/
//:://////////////////////////////////////////////
//:: Created By:Ranoulf, ag107093@hotmail.com
//:: Created On: 13 Aug. 2002
//:://////////////////////////////////////////////
string AP_RemoveLeadingSpaces(string sSubject)  {

    int iNumChars = GetStringLength(sSubject);
    string sFirstChar = GetStringLeft(sSubject,1);

    while ((sFirstChar == " " || sFirstChar == "_") && iNumChars > 0) {
        sSubject = GetStringRight(sSubject,iNumChars -1);
        sFirstChar = GetStringLeft(sSubject,1);
        iNumChars = GetStringLength(sSubject);
    }

    return sSubject;

}

//::///////////////////////////////////////////////
//:: AP_RemoveTrailingSpaces
//::
//:://////////////////////////////////////////////
/*
This function returns the given string without
any whitespace behind it.
*/
//:://////////////////////////////////////////////
//:: Created By:Ranoulf, ag107093@hotmail.com
//:: Created On: 13 Aug. 2002
//:://////////////////////////////////////////////
string  AP_RemoveTrailingSpaces(string sSubject)  {


    int iNumChars = GetStringLength(sSubject);
    string sLastChar = GetStringRight(sSubject,1);

    while ((sLastChar == " " || sLastChar == "_") && iNumChars > 0) {
        sSubject = GetStringLeft(sSubject,iNumChars -1);
        sLastChar = GetStringRight(sSubject,1);
        iNumChars = GetStringLength(sSubject);
    }

    return sSubject;
}

//::///////////////////////////////////////////////
//:: AP_GetLastWord
//::
//:://////////////////////////////////////////////
/*
Returns the last word in a given string.
A 'word' is defined as one or more characters seperated
from others by a whitespace OR UNDERSCORE
*/
//:://////////////////////////////////////////////
//:: Created By:
//:: Created On:
//:://////////////////////////////////////////////
string AP_GetLastWord (string sSentence) {

//  see if its an empty string
    if ( GetStringLength(sSentence) <= 0 ) return "";

//  get rid of any whitespace or underscores on the end
    sSentence = AP_RemoveTrailingSpaces(sSentence);

    //  return the shortened string if no internal whitespace
    int iLocationOfSpace = FindSubString(sSentence," ");
    int iLocationOfUnderscore = FindSubString(sSentence,"_");
    if (iLocationOfSpace <= 0 && iLocationOfUnderscore <= 0) {
        return sSentence;
    }

    // otherwise, let's pull out the last word on the right
    string sRightChar,sNextChar,sLastWord = "";
    do {
        sRightChar = GetStringRight(sSentence,1);
        sLastWord =  sRightChar + sLastWord;
        sSentence = GetStringLeft(sSentence,GetStringLength(sSentence) - 1);
        sNextChar = GetStringRight(sSentence,1);
        } // keep looping until we get there, or there is only one word left
    while (sNextChar != " " && sNextChar != "_" && sNextChar != "");

    return sLastWord;

}

////////////////////////////////////////////////////////////////
//
//  How-To
//
///////////////////////////////////////////////////////////////

///////////////////////////////////////////////////////////////
//
//  Note:
//  This how-to is included for historical referance only.
//
//  Please refer to the On Line Portal How-To:
//  http://www.gattis.org/ALFA/resources/portaling/the_portal_how-to.htm
//
///////////////////////////////////////////////////////////////
/*
How To, Long version:

    Part I - Configure your Visa
        A. Before you edit your module.
        B. Make some changes to your module properties
        C. Now create a matching Visa.

    Part II - Configure your Portals and Passports
        A. Make the trigger
        B.  Create the matching passport
        C.  Talk to the other server

Part I - Configure your Visa


A. Before you edit your module.

1.  Get a domain name for your server's address from one of the
    free services, such as DynDNS. It should be:
        16 characters or less
        all lower case
        no spaces.
    For instance, if you were running The Reaching Woods,
    you would try to get "reaching_woods". That lets your server
    be found at the address "reaching_woods.DynDNS.net."

    Note: If you already have a domain name and want to use it,
    that's even better.

2.  Your DNS admin needs to know what it is so he can create an
    "alias" for you. He will tell you what it is, then you'll
    have two names.
        server_name.DynDNS.net
        ap_xxx.alandfaraway.net
    where xxx is your server number.

    If you don't have a DNS admin, don't sweat. Just make sure
    everyone uses the same dynamic provider and gets names that
    are almost identical, like
        OurWorld_003.DynDNS.net
        OurWorld_004.DynDNS.net
    And so on. Just stick to 16 characters or less, and 3 digits
    for the numerals.

3.  For testing, you can get around all off this by editing the
    hosts file on you computer. Seach for 'hosts' on your C drive
    and open it in notepad. Put a line like the following in it;
        127.0.0.1   OurWorld_003.DynDNS.com
        127.0.0.1   OurWorld_004.DynDNS.com
    That will run multiple modules on the same box without DNS.

    You can also use real IPs like;
        67.124.5.34   OurWorld_003.DynDNS.com
        125.234.154.5 OurWorld_004.DynDNS.com

    The one thing is your clients won't be able to connect unless
    they share the same hosts file. Theoretically, you could just
    distribute one.

4.  Most importantly, open the portal_incl and edit the variables
    in the "World Settings" section at the top. The ones you are most
    interested in are SERVER_PREFIX and DOMAIN. You will want
    to change the password as well. It needs to match the password
    you're asking for on your nwserver config file.

B. Make some changes to your module properties

1.  In the toolset, go to the Edit menu and select module properties.
    Change your module name field to match your AP hostname.
    That's the part before the first period.
        Example: "ourworld_003"

2.  In the OnEnter properties of the module, select ap_portal_in
    to run. If you are running a core rules type variant, no prob.
    Just see what script runs in that spot and edit that script
    call the ap_portal_in script first (Use the ExecuteScript() function)

C. Now create a matching Visa.

1. Start the item wizard, scroll down to misc med and click next.

2. For "Name", put in your hostname (such as: ourworld_003).
   This is where it's important to have all lower case with no
   spaces. The Item Wizard auto-generates the "Blueprint ResRef"
   from what you type here, and you can't change it later. This
   ResRef is uniquely identifies the Visa for item creation. It
   also distinguishes your server from all the others.

3. Put it in the special custom 1 location in the palate and
   togle the "Launch Item's Properties" box, then click finish

4. Change the name to "AP Visa" - this is what the player sees.
   We couldn't do it before because it interferes with the
   Blueprint ResRef auto-generation.

5. If you are running on a non-standard port, append that to the
   end of the TAG like so:
      OurWorld_003_63457
   You can't do this at item creation as it messes up Resrefs

6. Change the appearance to something other than a dead body.
   (that is, if you want to ;-)
   In the "Identified Description" area, type the description
   you want the players to see. Putting in a welcome, or some
   rules might be a good idea, this is specific to your server
   after all.

7. Save the Module, you're done with setting up your server's
   Visa.




Part II - Configure your Portals and Passports

A. Make the trigger

1.  Place an Area Transition Trigger (or open an existing one)
    and give it a TAG like AP_073_007_056 where:

          AP   stands for Area Portal
          073  coming from server 73
          007  leaving area 7
          056  going to server 56
          (always use 3 digits)

    Use your server number for the first set of numbers.

    The second set designates the area on your server that the
    PC is leaving from. This is important when servers have
    multiple connecting points. It will keep someone entering
    from the north from winding up in the south of the other
    server. You dont actually need to have an area named 007,
    it's just used to stand for some area on your map, like
    "The northen trade route tip" that is too big to use as a
    waypoint.

    The last set of numbers is the you intend them to travel to.
    If the other server is running on a non-standard port, don't
    worry. That's handled by the passport tag later.

2.  Open the properties of the Area Transition, go to the
    Scripts Tab, and in the OnEnter field and select the
    ap_portal_out script

B.  Create the matching passport

1.  Now start the Create Item Wizard and make an item with
    the EXACT same NAME as the TAG of your trigger.
    Misc Med works best for type. Select the "launch item
    properties' box and click finished.

2.  Now that the Blueprint ResRef has been auto-generated by the
    Item Wizard, we can go back and change the item NAME to
    "AP Pass". You can't give it this name in the lase step
    because of the way the Item Wizard auto-generates things.

3.  Leave the tag alone unless the other server is running on
    a non standard port. In that case, append the port number
    to the TAG with an underscore like so;
        AP_073_007_056_5122

    If you are portaling between modules on the same server,
    include a port for every one, even the default port.
       AP_073_007_056_5121 or AP_073_008_056_5122

C.  Talk to the other server

1.  Contact your neighboring HDM (server 56 in our example) and
    tell him  the area on your server you are leaving from
    (like "The northen trade route") and give him
    the tag you created. (AP_073_007_056 in our example)

    In essence, you are telling him here the players are leavig
    from. Its up to him to decide where you show up at.

2.  The DM on the other side plunks down a WayPoint with that
    name wherever he sees fitand he's done. (AP_073_007_056 in our
    example, or AP_073_007_056_60000 for a non standard port)

3.  If he doesn't create a matching waypoint, the server on the
    other side will declair the portaling player as rejected and
    try to send them back, possibly quarantining them is that fails.

///////////////////////////////////////////////////////////////
*/

/*

To Do

Tell more about why someone is offensive


AP_GetHasPriors

Flag when multiple visas and passports



*/

/*

Recent Change Log:

Added a the function AP_FlagForWKMove(oPC) that marks the oPC as needing moved
by the world keeper function with the local varibale AP_WK_MOVE_FLAG
