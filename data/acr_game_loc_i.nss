////////////////////////////////////////////////////////////////////////////////
//
//  System Name : ALFA Core Rules
//     Filename : acr_game_loc_i
//      Version : 0.1
//         Date : 5/28/06
//       Author : Ronan
//
//  Local Variable Prefix = ACR_GLC
//
//
//  Dependencies external of nwscript:
//
//  Description
//  This script provides functions to store and retreive in-game locations which
//  are recognizable across all servers, and stay valid across most module
//  updates.
//
//  Revision History
////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////
// Includes ////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////

#include "acr_tools_i"

////////////////////////////////////////////////////////////////////////////////
// Constants ///////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////

const string _ACR_GLC_LOCATION = "_l";
const string _ACR_GLC_AREA_TAG = "_at";
const string _ACR_GLC_AREA_RESREF = "_ar";
const string _ACR_GLC_SERVER_TAG = "_st";

////////////////////////////////////////////////////////////////////////////////
// Structures //////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////
// Global Variables ////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////
// Function Prototypes /////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////

// Sets the game location lValue named sVarName on object oObject.
void SetLocalGameLocation(object oObject, string sVarName, location lValue);

// Gets the game location named sVarName stored on oObject.
// Returns the starting position if the stored location cannot be found on this
// server, or if the location is undefined.
location GetLocalGameLocation(object oObject, string sVarName);

// Returns 1 if sVarName is the name of a game location on the current server,
// stored on oOject.
// Returns 0 otherwise.
int GetIsGameLocationOnServer(object oObject, string sVarName);

// Deletes the game location named sVarName off of oObject.
void DeleteGameLocation(object oOobject, string sVarName);

// Formats a persistant game location as a readable string.
string GameLocationToString(location loc);

// Returns one if sVarName names a valid game location on oObject, 0 otherwise.
int GetIsValidLocalGameLocation(object oObject, string sVarName);

////////////////////////////////////////////////////////////////////////////////
// Function Definitions ////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////

location GetLocalGameLocation(object oObject, string sVarName) {

    location lLocation = GetLocalLocation(oObject, sVarName + _ACR_GLC_LOCATION);
    string sAreaTag = GetLocalString(oObject, sVarName + _ACR_GLC_AREA_TAG);
    string sAreaResRef = GetLocalString(oObject, sVarName + _ACR_GLC_AREA_RESREF);
    string sServerTag = GetLocalString(oObject, sVarName + _ACR_GLC_SERVER_TAG);
    //PrintString("acr_game_loc_i::GetLocalGameLocation: Looking for area tagged " + sAreaTag + ", blueprint: " + sAreaResRef);

    if( sServerTag != GetTag(GetModule()) ) {
        //PrintString("acr_game_loc_i::GetLocalGameLocation: Server tags unequal. Returning starting location." + sAreaResRef);
        return GetStartingLocation();
    }
    object oArea = GetAreaFromTagAndResref(sAreaResRef, sAreaTag);
    if(oArea == OBJECT_INVALID) {
        return GetStartingLocation();
        //PrintString("acr_game_loc_i::GetLocalGameLocation: Not found.");
    } else {
        //PrintString("acr_game_loc_i::GetLocalGameLocation: Found.");
        return GetLocationInDifferentArea(lLocation, oArea);
    }
}

int GetIsGameLocationOnServer(object oObject, string sVarName) {
    return GetTag(GetModule()) == GetLocalString(oObject, sVarName + _ACR_GLC_SERVER_TAG);
}

int GetIsValidLocalGameLocation(object oObject, string sVarName) {
    return GetLocalString(oObject, sVarName + _ACR_GLC_SERVER_TAG) != "" &&
            GetLocalString(oObject, sVarName + _ACR_GLC_AREA_RESREF) != "" &&
            GetLocalString(oObject, sVarName + _ACR_GLC_AREA_TAG) != "";
}

void SetLocalGameLocation(object oObject, string sVarName, location lValue) {
    //WriteTimestampedLogEntry("Writing game location on " + GetName(oObject) + ", named " + sVarName + ".");
    object oArea = GetAreaFromLocation(lValue);
    SetLocalLocation(oObject, sVarName + _ACR_GLC_LOCATION, lValue);
    SetLocalString(oObject, sVarName + _ACR_GLC_AREA_TAG, GetTag(oArea) );
    SetLocalString(oObject, sVarName + _ACR_GLC_AREA_RESREF, GetResRef(oArea));
    SetLocalString(oObject, sVarName + _ACR_GLC_SERVER_TAG, GetTag(GetModule()));
}

string GameLocationToString(location loc) {
    object oArea = GetAreaFromLocation(loc);
    return "Server: " + GetTag(GetModule()) + ", Area tag: " + GetTag(oArea) + ", Area resref: " + GetResRef(oArea);
}

void DeleteGameLocation(object oObject, string sVarName) {
    DeleteLocalLocation(oObject, sVarName + _ACR_GLC_LOCATION);
    DeleteLocalString(oObject, sVarName + _ACR_GLC_AREA_TAG);
    DeleteLocalString(oObject, sVarName + _ACR_GLC_AREA_RESREF);
    DeleteLocalString(oObject, sVarName + _ACR_GLC_SERVER_TAG);
}

