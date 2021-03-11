//void main(){}
#include "hc_inc_pwdb_func"
#include "alfa_1984"
#include "ms_xp_util"


const int XP_PER_HOUR = 3;

void RepeatAddXPA( object oPC);
// Get the current hour accumulator
float GetXPA( object oPC)
{
    float xpa = GetPersistentFloat( oPC, ".xpa");
    return xpa;
}
// Clear the hour accumulator
void ClearXPA( object oPC)
{
    DeletePersistentFloat( oPC, ".xpa");
}

// Determine if location has changed
int LocationChanged( object oPC)
{
    location locPrev = GetLocalLocation( oPC, ".xLoc");
    object area1 = GetAreaFromLocation( locPrev);
    location now = GetLocation( oPC);
    if( GetIsLocationValid( locPrev))
    {
        if( GetAreaFromLocation( now) == area1 &&
            GetDistanceBetweenLocations( now, locPrev) <= 5.0 )
        {
            PrintString(GetName( oPC)+" location not changed");
            return FALSE;
        }
    }
    PrintString(GetName(oPC)+" Location changed");
    return TRUE;
}
// Set the hour accumulator
void SetXPA( object oPC, float xpa)
{
    PrintString("Setting XPA for "+GetName( oPC));
    SetPersistentFloat( oPC, ".xpa", xpa);
}

// Determine if an object is a PC, not a DM
// and has had a local variable ".xVl" set by talking to,
// damaging, or disturbing an NPC, placeable or door
void SetXPAValid( object o)
{
    if( !GetIsPC( o) || GetIsDM( o))
        return;
    PrintString(GetName(o)+" setting XPA valid");
    SetLocalInt( o, ".xVl", 1);
}

//
// Return the value of the flag which is set during an
// hour if the PC has talked to,
// damaged, or disturbed an NPC, placeable or door
//
int GetXPAValid( object oPC)
{
//    PrintString ("Size of "+GOLD+" is "+IntToString( AP_GetStoreSize( oPC, GOLD)));
//    PrintString ("Size of "+NET+" is "+IntToString( AP_GetStoreSize( oPC, NET)));
//    PrintString ("Size of "+EQUIP_ITEM+" is "+IntToString( AP_GetStoreSize( oPC, EQUIP_ITEM)));
//    PrintString ("Size of "+PACK_ITEM+" is "+IntToString( AP_GetStoreSize( oPC, PACK_ITEM)));
//    PrintString ("Size of "+NEW_ITEMS+" is "+IntToString( AP_GetStoreSize( oPC, NEW_ITEMS)));
//    PrintString ("Size of "+AREA+" is "+IntToString( AP_GetStoreSize( oPC, AREA)));
//    PrintString ("Size of "+NPC+" is "+IntToString( AP_GetStoreSize( oPC, NPC)));
//    PrintString ("Size of "+COMBAT_NUMBER+" is "+IntToString( AP_GetStoreSize( oPC, COMBAT_NUMBER)));
//    PrintString ("Size of "+ENEMY+" is "+IntToString( AP_GetStoreSize( oPC, ENEMY)));
//    PrintString ("Size of "+COMBAT+" is "+IntToString( AP_GetStoreSize( oPC, COMBAT)));
    int isValid = FALSE;
    //Check to see if the PC moved OR if they are talking, fighting or disturbing
    // other PCs
    // Moving and opening a placeable or door or talking to an NPC.
    // If they stand around and do this stuff, they deserve 7 XP per hour, anyway
    isValid = LocationChanged( oPC) || GetLocalInt( oPC, ".xVl");
    DeleteLocalInt( oPC, ".xVl");
    return isValid;
}

void ScheduleXPA( object oPC)
{
    PrintString("SXPA for "+GetName(oPC));
    if( GetIsObjectValid( oPC))
        DelayCommand( HoursToSeconds( 1), RepeatAddXPA( oPC));
}

void RepeatAddXPA( object oPC)
{
    PrintString("RXPA for "+GetName(oPC));
    if( GetXPAValid( oPC))
        SetXPA( oPC, GetXPA( oPC)+1.0);
    SetLocalLocation( oPC, ".xLoc", GetLocation( oPC));
    ScheduleXPA( oPC);
}
