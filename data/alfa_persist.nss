/******************************************************************
 * Name: alfa_persist
 * Type: ALFA Modules Include File
 * ---
 * Author: Cereborn
 * Date: 9/8/03
 * ---
 * Contains wrappers for campaign database calls
 *
 * IMPORTANT: THIS FILE IS A CORE ALFA SCRIPT AND MUST NOT BE
 * MODIFIED EXCEPT THROUGH OFFICIAL ALFA PATCHES!
 ******************************************************************/

#include "alfa_options"


// My, but wouldn't templates be nice!

// Forward References:
//    These are for internal use only!!  External users use
//    ALFA_SetPersistentLocation() and ALFA_GetPersistentLocation()

void ALFA_SetCampaignLocation(
    string sDatabase,
    string psVarName,
    location plValue,
    object oPlayer = OBJECT_INVALID
);

location ALFA_GetCampaignLocation(
    string sDatabase,
    string psVarName,
    object oPlayer = OBJECT_INVALID
);

location lAlfaReturnLocation;


// Set a persistent string
//
//  ARGUMENTS:
//      sDatabase    = the name of the database to write to
//      psVarName    = the name of the string variable
//      psValue      = the string value to write
//      poPlayer     = OPTIONAL - Player to associate this string with
//      bPartyInArea = OPTIONAL - Write variable for each player in
//                     poPlayer's party that's also in poPlayer's current
//                     area
//
void ALFA_SetPersistentString( string sDatabase, string psVarName,
  string psValue, object poPlayer=OBJECT_INVALID, int bPartyInArea=FALSE )
{
  if ( bPartyInArea && GetIsObjectValid( poPlayer ) )
  {
    object oPC = GetFirstFactionMember( poPlayer );
    object oArea = GetArea( poPlayer );

    while( GetIsObjectValid( oPC ) )
    {
      if( !GetIsDM( oPC ) && ( oArea == GetArea( oPC ) ) )
      {
        SetCampaignString( sDatabase, psVarName, psValue, oPC );
      }

      oPC = GetNextFactionMember( poPlayer, TRUE );
    }
  }

  else
  {
    SetCampaignString( sDatabase, psVarName, psValue, poPlayer );
  }
}

// Set a persistent integer
//
//  ARGUMENTS:
//      sDatabase    = the name of the database to write to
//      psVarName    = the name of the integer variable
//      pnValue      = the integer value to write
//      poPlayer     = OPTIONAL - Player to associate this integer with
//      bPartyInArea = OPTIONAL - Write variable for each player in
//                     poPlayer's party that's also in poPlayer's current
//                     area
//
void ALFA_SetPersistentInt( string sDatabase, string psVarName, int pnValue,
  object poPlayer=OBJECT_INVALID, int bPartyInArea=FALSE )
{
  if ( bPartyInArea && GetIsObjectValid( poPlayer ) )
  {
    object oPC = GetFirstFactionMember( poPlayer );
    object oArea = GetArea( poPlayer );

    while( GetIsObjectValid( oPC ) )
    {
      if( !GetIsDM( oPC ) && ( oArea == GetArea( oPC ) ) )
      {
        SetCampaignInt( sDatabase, psVarName, pnValue, oPC );
      }

      oPC = GetNextFactionMember( poPlayer, TRUE );
    }
  }

  else
  {
    SetCampaignInt( sDatabase, psVarName, pnValue, poPlayer );
  }
}

// Set a persistent float
//
//  ARGUMENTS:
//      sDatabase    = the name of the database to write to
//      psVarName    = the name of the float variable
//      pfValue      = the float value to write
//      poPlayer     = OPTIONAL - Player to associate this float with
//      bPartyInArea = OPTIONAL - Write variable for each player in
//                     poPlayer's party that's also in poPlayer's current
//                     area
//
void ALFA_SetPersistentFloat( string sDatabase, string psVarName, float pfValue,
  object poPlayer=OBJECT_INVALID, int bPartyInArea=FALSE )
{
  if ( bPartyInArea && GetIsObjectValid( poPlayer ) )
  {
    object oPC = GetFirstFactionMember( poPlayer );
    object oArea = GetArea( poPlayer );

    while( GetIsObjectValid( oPC ) )
    {
      if( !GetIsDM( oPC ) && ( oArea == GetArea( oPC ) ) )
      {
        SetCampaignFloat( sDatabase, psVarName, pfValue, oPC );
      }

      oPC = GetNextFactionMember( poPlayer, TRUE );
    }
  }

  else
  {
    SetCampaignFloat( sDatabase, psVarName, pfValue, poPlayer );
  }
}

// Set a persistent location - Note Well: Setting persistent locations is
// essentially broken in the current Bioware database implementation.
// Use of this function is not currently recommended.
//
//  ARGUMENTS:
//      sDatabase    = the name of the database to write to
//      psVarName    = the name of the location variable
//      plValue      = the location value to write
//      poPlayer     = OPTIONAL - Player to associate this location with
//      bPartyInArea = OPTIONAL - Write variable for each player in
//                     poPlayer's party that's also in poPlayer's current
//                     area
//
void ALFA_SetPersistentLocation( string sDatabase, string psVarName,
  location plValue, object poPlayer=OBJECT_INVALID, int bPartyInArea=FALSE )
{
  if ( bPartyInArea && GetIsObjectValid( poPlayer ) )
  {
    object oPC = GetFirstFactionMember( poPlayer );
    object oArea = GetArea( poPlayer );

    while( GetIsObjectValid( oPC ) )
    {
      if( !GetIsDM( oPC ) && ( oArea == GetArea( oPC ) ) )
      {
        ALFA_SetCampaignLocation( sDatabase, psVarName, plValue, oPC );
      }

      oPC = GetNextFactionMember( poPlayer, TRUE );
    }
  }

  else
  {
    ALFA_SetCampaignLocation( sDatabase, psVarName, plValue, poPlayer );
  }
}

// Set a persistent vector
//
//  ARGUMENTS:
//      sDatabase    = the name of the database to write to
//      psVarName    = the name of the vector variable
//      pvValue      = the vector value to write
//      poPlayer     = OPTIONAL - Player to associate this vector with
//      bPartyInArea = OPTIONAL - Write variable for each player in
//                     poPlayer's party that's also in poPlayer's current
//                     area
//
void ALFA_SetPersistentVector( string sDatabase, string psVarName,
  vector pvValue, object poPlayer=OBJECT_INVALID, int bPartyInArea=FALSE )
{
  if ( bPartyInArea && GetIsObjectValid( poPlayer ) )
  {
    object oPC = GetFirstFactionMember( poPlayer );
    object oArea = GetArea( poPlayer );

    while( GetIsObjectValid( oPC ) )
    {
      if( !GetIsDM( oPC ) && ( oArea == GetArea( oPC ) ) )
      {
        SetCampaignVector( sDatabase, psVarName, pvValue, oPC );
      }

      oPC = GetNextFactionMember( poPlayer, TRUE );
    }
  }

  else
  {
    SetCampaignVector( sDatabase, psVarName, pvValue, poPlayer );
  }
}

// Set a persistent object
//
//  ARGUMENTS:
//      sDatabase    = the name of the database to write to
//      psVarName    = the name of the object variable
//      poObject     = the object to write
//      poPlayer     = OPTIONAL - Player to associate this object with
//      bPartyInArea = OPTIONAL - Write variable for each player in
//                     poPlayer's party that's also in poPlayer's current
//                     area
//
void ALFA_SetPersistentObject( string sDatabase, string psVarName,
  object poObject, object poPlayer=OBJECT_INVALID, int bPartyInArea=FALSE )
{
  if ( bPartyInArea && GetIsObjectValid( poPlayer ) )
  {
    object oPC = GetFirstFactionMember( poPlayer );
    object oArea = GetArea( poPlayer );

    while( GetIsObjectValid( oPC ) )
    {
      if( !GetIsDM( oPC ) && ( oArea == GetArea( oPC ) ) )
      {
        StoreCampaignObject(sDatabase, psVarName, poObject, poPlayer);
      }

      oPC = GetNextFactionMember( poPlayer, TRUE );
    }
  }

  else
  {
    StoreCampaignObject(sDatabase, psVarName, poObject, poPlayer);
  }







  StoreCampaignObject(sDatabase, psVarName, poObject, poPlayer);
}


// Get a persistent string
//
//  ARGUMENTS:
//      sDatabase    = the name of the database to get the string from
//      psVarName    = the name of the string variable
//      poPlayer     = OPTIONAL - Player associated with this string
//
string ALFA_GetPersistentString( string sDatabase, string psVarName,
  object poPlayer=OBJECT_INVALID )
{
  return GetCampaignString( sDatabase, psVarName, poPlayer );
}

// Get a persistent integer
//
//  ARGUMENTS:
//      sDatabase    = the name of the database to get the integer from
//      psVarName    = the name of the integer variable
//      poPlayer     = OPTIONAL - Player associated with this integer
//
int ALFA_GetPersistentInt(string sDatabase, string psVarName,
  object poPlayer=OBJECT_INVALID)
{
  return GetCampaignInt( sDatabase, psVarName, poPlayer );
}

// Get a persistent float
//
//  ARGUMENTS:
//      sDatabase    = the name of the database to get the float from
//      psVarName    = the name of the float variable
//      poPlayer     = OPTIONAL - Player associated with this float
//
float ALFA_GetPersistentFloat( string sDatabase, string psVarName,
  object poPlayer=OBJECT_INVALID )
{
  return GetCampaignFloat( sDatabase, psVarName, poPlayer );
}

// Get a persistent location
//
//  ARGUMENTS:
//      sDatabase    = the name of the database to get the location from
//      psVarName    = the name of the location variable
//      poPlayer     = OPTIONAL - Player associated with this location
//
location ALFA_GetPersistentLocation( string sDatabase, string psVarName,
  object poPlayer=OBJECT_INVALID )
{
  return ALFA_GetCampaignLocation( sDatabase, psVarName, poPlayer );
}

// Get a persistent vector
//
//  ARGUMENTS:
//      sDatabase    = the name of the database to get the vector from
//      psVarName    = the name of the vector variable
//      poPlayer     = OPTIONAL - Player associated with this vector
//
vector ALFA_GetPersistentVector( string sDatabase, string psVarName,
  object poPlayer=OBJECT_INVALID )
{
  return GetCampaignVector( sDatabase, psVarName, poPlayer );
}

// Get a persistent object
//
//  ARGUMENTS:
//      sDatabase         = the name of the database to get the object from
//      psVarName         = the name of the object variable
//      lCreateAtLocation = create the object at this location
//      oCreateOnOwner    = OPTIONAL - create the object on this owner
//      poPlayer          = OPTIONAL - Player associated with this object
//
object ALFA_GetPersistentObject( string sDatabase, string psVarName,
  location lCreateAtLocation, object oCreateOnOwner = OBJECT_INVALID,
  object poPlayer = OBJECT_INVALID )
{
  return RetrieveCampaignObject( sDatabase, psVarName, lCreateAtLocation,
    oCreateOnOwner, poPlayer );
}

// Delete a persistent variable - Note that variables are not actually deleted,
// but rather marked for deletion.  When possible, variable reuse is preferred.
// 3rd party tools (such as DBFNavigator) may be used to 'pack' the database
// (which does the actual deletion).
//
//  ARGUMENTS:
//      sDatabase         = the name of the database to delete the variable from
//      psVarName         = the name of the variable to delete
//      poPlayer          = OPTIONAL - Player associated with this variable
//
void ALFA_DeletePersistentVariable( string sDatabase, string psVarName,
  object poPlayer=OBJECT_INVALID )
{
  DeleteCampaignVariable( sDatabase, psVarName, poPlayer );
}

// The Set/Get Campaign Location functions are broken, because they store the
// OBJECT ID of the area portion of the location, which can change across server
// resets (especially if the module is modified).  These versions store and
// retrieve the tag of the area, a vector and the facing.  This works only if
// the module has unique area tags.  A flag is used to indicate if this is so; if
// not, we fall back to the somewhat less broken Bioware versions.

void ALFA_SetCampaignLocation( string sDatabase, string psVarName,
  location plValue, object oPlayer = OBJECT_INVALID )
{
  if ( gALFA_MODULE_HAS_UNIQUE_AREA_TAGS )
  {
    string sTagVarName;
    string sAreaTag;
    object oArea;

    // Set up the variable names
    sTagVarName = psVarName + "_tag";

    // Get the data we need to store from the location passed in
    oArea = GetAreaFromLocation( plValue );
    sAreaTag = GetTag( oArea );

    // Store the data
    SetCampaignString( sDatabase, sTagVarName, sAreaTag, oPlayer );
  }

  SetCampaignLocation( sDatabase, psVarName, plValue, oPlayer );

}

location ALFA_GetCampaignLocation( string sDatabase, string psVarName,
  object oPlayer = OBJECT_INVALID)
{
  location lReturnLoc;

  if ( gALFA_MODULE_HAS_UNIQUE_AREA_TAGS )
  {
    string sTagVarName;
    string sAreaTag;
    vector vAreaVec;
    float fFacing;
    object oArea;
    location oStoredLocation;

    sTagVarName = psVarName + "_tag";

    // Retrieve the data from the database
    sAreaTag = GetCampaignString( sDatabase, sTagVarName, oPlayer );
    oStoredLocation = GetCampaignLocation( sDatabase, psVarName, oPlayer );

    oArea = GetObjectByTag( sAreaTag );

    if ( GetIsObjectValid( oArea ) )
    {
      vAreaVec = GetPositionFromLocation( oStoredLocation );
      fFacing = GetFacingFromLocation( oStoredLocation );
      lReturnLoc = Location( oArea, vAreaVec, fFacing );
    }

    else
    {
      lReturnLoc = oStoredLocation;
    }
  }

  else
  {
    // If the module doesn't have unique area tags, use the old Bioware forms
    lReturnLoc = GetCampaignLocation( sDatabase, psVarName, oPlayer );
  }

  return lReturnLoc;
}




