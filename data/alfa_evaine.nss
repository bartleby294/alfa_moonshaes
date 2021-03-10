//::///////////////////////////////////////////////
//:: Name ALFA_EVAINE
//:://////////////////////////////////////////////
/*
    Evaine's include file for ALFA
*/
//:://////////////////////////////////////////////
//:: Created By: Evaine
//:: Created On: 08/07/2002
//:://////////////////////////////////////////////

//////////////////////////////////////////////////
#include "Alfa_Ev_Const"
#include "NW_I0_PLOT"
#include "ms_xp_util"

//////////////////////////////////////////////////

//////////////////////////////////////////////////
//  Function Declarations
//////////////////////////////////////////////////

//:://////////////////////////////////////////////
//:: Created By: Evaine
//:: Created On: 08/07/2002
//:://////////////////////////////////////////////
//  A variation on JumpToLocation() which will keep the jumper's relative position
//   to two specified reference points.
//
//  This can be used to move a PC between 2 nearly identical places,
//   to simulate a change in the environment. If the reference points are
//   well chosen, the player would barely notice moving.
//
//  - oJumper : object to move
//  - oRefOrigin : a reference point in the place the object is jumped away from
//  - oRefDest   : a reference point in the place the object is jumped to
//
//  Ex. : If oJumper is 2 meters east of oRefOrigin, he will be 2 meters east of
//         oRefDest when the function returns
//         ( revision -> if oRefOrigin and oRefDest have the same facing )
//  Revision 10/08
//  The facing of the origin and destination reference is now taken into account,
//    if you are behind the origin ref, you'll end up behind the destination ref.
//:://////////////////////////////////////////////
void ALFA_RelativeJump( object oJumper, object oRefOrigin, object oRefDest );

//:://////////////////////////////////////////////
//:: Created By: Evaine
//:: Created On: 08/07/2002
//:://////////////////////////////////////////////
//   Dump a scripterror to the log and contact DMs
//:://////////////////////////////////////////////
void ALFA_ScriptError( string sMessage );

//:://////////////////////////////////////////////
//:: Created By: Evaine
//:: Created On: 15/07/2002
//:://////////////////////////////////////////////
//  Find an object with a certain tag in a specified area.
//  Useful when tags aren't unique per module, but are per area.
//  Returns OBJECT_INVALID when nothing found
//  iDebug: Dump an error if nothing found, set it to false when
//      for your script the object doesn't need to be found.
//:://////////////////////////////////////////////
object ALFA_FindObjectByTagInArea( string sTag, object oArea, int iDebug = TRUE );

//:://////////////////////////////////////////////
//:: Created By: Evaine
//:: Created On:16/07/2002
//:://////////////////////////////////////////////
//  Save the fired userdefined event. Use only inside
//   a userdefined event. Use together with ALFA_RestartEvent().
//:://////////////////////////////////////////////
void ALFA_SaveEvent( );

//:://////////////////////////////////////////////
//:: Created By: Evaine
//:: Created On:16/07/2002
//:://////////////////////////////////////////////
//  Fire the last UserDefinedEvent again. Only works
//   if ALFA_SaveEvent() has been called there. Useful
//   to get characters to reload their action queue ( as described
//   in the userdefined script ) after an interruption.
//:://////////////////////////////////////////////
void ALFA_RestartEvent();

//:://////////////////////////////////////////////
//:: Created By: Evaine
//:: Created On: 16/07/2002
//:://////////////////////////////////////////////
// Just a faster way to signal a userdefined event
//  on the object running the script.
//:://////////////////////////////////////////////
void ALFA_FireEvent( int iEvent );

//:://////////////////////////////////////////////
//:: Created By: Evaine
//:: Created On: 17/07/2002
//:://////////////////////////////////////////////
//  Send a message to all players in an area.
//  The players are actually whispering something to themselves.
//:://////////////////////////////////////////////
void ALFA_SendMessageInArea( object oArea, string sMessage  );

//:://////////////////////////////////////////////
//:: Created By: Evaine
//:: Created On: 12/08/2002
//:://////////////////////////////////////////////
//  This function will reward a party for bringing back proof of a bounty. Any
//   partymembers in the same area will have their quest items taken away from them
//   and share in the reward. Designed for the "Actions taken" slot.The remainder
//   of the reward that can't be evenly divided will be given to oPC.
//  Ex. Get a 100 GP reward for bringing back winter wolf pelts
//   - oPc:  a party member, will be the speaker for conversations
//   - sTag: tag of the item to bring back as proof
//   - iItemGp: reward per quest item, total will be divided among party
//   - iItemXp: experience per quest item, all partymembers get this number
//   - iTokenX: optional: these custom tokens get set for a conversation
//      - iToken1: number of quest items the party brought
//      - iToken2: the total reward
//      - iToken3: gp given to each party member
//      - iToken4: remainder GP given to oPC
//:://////////////////////////////////////////////
void ALFA_BountyReward( object oPC, string sTag, int iItemGp, int iItemXp = 0,
                    int iToken1 = 0, int iToken2 = 0, int iToken3 = 0, int iToken4 = 0 );

//:://////////////////////////////////////////////
//:: Created By: Evaine
//:: Created On: 20/08/2002
//:://////////////////////////////////////////////
// Gives the width of an area in tiles
//:://////////////////////////////////////////////
int ALFA_GetAreaWidth( object oArea );

//:://////////////////////////////////////////////
//:: Created By: Evaine
//:: Created On: 20/08/2002
//:://////////////////////////////////////////////
// Gives the height of an area in tiles
//:://////////////////////////////////////////////
int ALFA_GetAreaHeight( object oArea );

//:://////////////////////////////////////////////
//:: Created By: Evaine
//:: Created On: 20/08/2002
//:://////////////////////////////////////////////
// Checks if an position is within the bounds of an area
//:://////////////////////////////////////////////
int ALFA_IsPositionInArea( vector vPos, object oArea );

//:://////////////////////////////////////////////
//:: Created By: Evaine
//:: Created On: 21/08/2002
//:://////////////////////////////////////////////
//  Returns TRUE if there is a PC int the area specified
//:://////////////////////////////////////////////
int ALFA_PcInArea( object oArea );

//:://////////////////////////////////////////////
//:: Created By: Evaine
//:: Created On: 21/08/2002
//:://////////////////////////////////////////////
//   Removes any creature that was spawned by an encounter from oArea.
//   A delay can be specified. Creatures will not be removed while a player
//    can see it ( retry is automatic ). Requires that the "EV_VANISH" script
//    is present. Use this to clean up what players left standing, espacially
//    for respawning encounters.
//:://////////////////////////////////////////////
void ALFA_RemoveEncounterCreatures( object oArea, float fDelay = 0.0f);

//////////////////////////////////////////////////
// Function Implementation
//////////////////////////////////////////////////


void ALFA_RelativeJump( object oJumper, object oRefOrigin, object oRefDest )
{
//  Test parameters
    if ( !GetIsObjectValid( oJumper ) )
    {
        string sMessage
            = "ALFA_RelativeJump: oJumper invalid object.";
        ALFA_ScriptError( sMessage );
        return;
    }
    if ( !GetIsObjectValid( oRefOrigin ) )
    {
        string sMessage
            = "ALFA_RelativeJump: oRefOrigin invalid object.";
        ALFA_ScriptError( sMessage );
        return;
    }
    if ( !GetIsObjectValid( oRefDest ) )
    {
        string sMessage
            = "ALFA_RelativeJump: oRefDest invalid object.";
        ALFA_ScriptError( sMessage );
        return;
    }


//  Get bearings
    location lJumper    = GetLocation( oJumper );
    location lRefOrigin = GetLocation( oRefOrigin );
    location lRefDest   = GetLocation( oRefDest );

    vector vJumper    = GetPositionFromLocation( lJumper );
    vector vRefOrigin = GetPositionFromLocation( lRefOrigin );
    vector vRefDest   = GetPositionFromLocation( lRefDest );

    float  fFacing = GetFacingFromLocation( lJumper );

    object oAreaDest = GetArea( oRefDest );

//  Compute new location
    vector vDiff = vJumper - vRefOrigin;
    vector vDiffRot;

// Revision 10/08: Rotation
    float fRot = GetFacingFromLocation( lRefOrigin )
                  - GetFacingFromLocation( lRefDest );
    vDiffRot.x = cos( fRot ) * vDiff.x + sin( fRot ) * vDiff.y;
    vDiffRot.y = cos( fRot ) * vDiff.y - sin( fRot ) * vDiff.x;

    vector vDest = vRefDest + vDiffRot;

    fFacing -= fRot;

    location lJumperDest = Location( oAreaDest, vDest, fFacing );

//  Make the jump
    AssignCommand( oJumper, JumpToLocation( lJumperDest ) );
}

void ALFA_ScriptError( string sMessage )
{
   string sDebug =  "!!! Script error: " + sMessage;
   WriteTimestampedLogEntry ( sDebug );
   SendMessageToAllDMs ( sDebug );
}

object ALFA_FindObjectByTagInArea( string sTag, object oArea, int iDebug = TRUE )
{
    if ( !GetIsObjectValid( oArea ) )
    {
        string sMessage = "ALFA_FindObjectByTagInArea: invalid area given.";
        ALFA_ScriptError( sMessage );
        return OBJECT_INVALID;
    }

    object oResult = GetFirstObjectInArea( oArea );

    while ( GetIsObjectValid( oResult ) && GetTag( oResult ) != sTag )
    {
        oResult = GetNextObjectInArea( oArea );
    }

    if ( iDebug && !GetIsObjectValid( oResult ) )
    {
        string sError = " No object with tag " + sTag + " found in area " +
                            GetTag( oArea );

        ALFA_ScriptError( sError );
    }
    return oResult;
}

void ALFA_SaveEvent( )
{
    int iEvent = GetUserDefinedEventNumber();
    SetLocalInt( OBJECT_SELF, ALFA_LAST_UDEFINED, iEvent );
}

void ALFA_RestartEvent()
{
    int iEvent = GetLocalInt( OBJECT_SELF, ALFA_LAST_UDEFINED);
    SignalEvent( OBJECT_SELF, EventUserDefined( iEvent ));
}

void ALFA_FireEvent( int iEvent )
{
    SignalEvent( OBJECT_SELF, EventUserDefined ( iEvent ) );
}

void ALFA_SendMessageInArea( object oArea, string sMessage )
{
    object oTarget = GetFirstPC();

    while ( GetIsObjectValid ( oTarget ) )
    {
        if ( GetArea( oTarget ) == oArea )
        {
            AssignCommand( oTarget, SpeakString( sMessage, TALKVOLUME_WHISPER ) );
        }

        oTarget = GetNextPC();
    }
}

void ALFA_BountyReward( object oPC, string sTag, int iItemGp, int iItemXp = 0,
                    int iToken1 = 0, int iToken2 = 0, int iToken3 = 0, int iToken4 = 0 )
{
    object oMember;

    object oItem;

    // Compute party size and amount of quest items the party has
    // Loop over the party
    // Take away their quest items
    int iAmount = 0;
    int iPartySize = 0;
    int iAmountPlayer = 0;
    oMember = GetFirstFactionMember( oPC, TRUE );

    while ( GetIsObjectValid( oMember ) )
    {
        // Don't count party members who are not around
        if ( GetArea( oPC ) == GetArea( oMember ) )
        {
            iPartySize++;
            iAmountPlayer = GetNumItems( oMember, sTag );
            iAmount = iAmount + iAmountPlayer;

            // Remove quest items
            oItem = GetFirstItemInInventory( oMember );
            while ( GetIsObjectValid( oItem ) )
            {
                if ( GetTag( oItem ) == sTag ) DestroyObject( oItem );
                oItem = GetNextItemInInventory( oMember );
            }
        }
        oMember = GetNextFactionMember ( oPC , TRUE );
    }

    // Compute reward
    int iReward = iAmount * iItemGp;
    int iXp = iAmount * iItemXp;

    // Set the custom tokens for the conversation
    if ( iToken1 > 0 ) SetCustomToken( iToken1, IntToString( iAmount ) );
    if ( iToken2 > 0 ) SetCustomToken( iToken2, IntToString( iReward ) );

    // Reward leftover ( when no even distribution possible ).
    int iLeftOver = iReward % iPartySize; // % is modulus

    // reward per player
    iReward = iReward / iPartySize;

    // Set more custom tokens for money distribution
    if ( iToken3 > 0 ) SetCustomToken( iToken3, IntToString( iReward ) );
    if ( iToken4 > 0 ) SetCustomToken( iToken4, IntToString( iLeftOver ) );

    // Hand out the rewards
    RewardGP( iReward, oPC, TRUE ); // Everyone gets a share
    RewardGP( iLeftOver, oPC, FALSE ); // Leftovers go to speaker

    // Loop over party to give XP ( RewardXP() not useable here )
    oMember = GetFirstFactionMember( oPC, TRUE );

    while ( GetIsObjectValid( oMember ) )
    {
        if ( GetArea( oPC ) == GetArea( oMember ) )
        {
            GiveAndLogXP(oMember, iXp, "EVAINE", "for alfa_evaine.");
        }
        oMember = GetNextFactionMember ( oPC , TRUE );

    }
}

int ALFA_GetAreaWidth( object oArea )
{
    int iResult = 32;
    vector vPos = Vector(0.0f, 0.0f, 0.0f );
    location lLoc;

    int iColor = 517; // seems to be the standard invalid tile color

    // Start at 32, count down to 0
    while ( iResult > 0 )
    {
        // Position of tile
        vPos.x = IntToFloat( iResult - 1 );
        lLoc = Location( oArea, vPos, 0.0f );

        iColor = GetTileMainLight1Color( lLoc );

        // We have the size if we found a valid tile color
        if ( iColor > -1 && iColor < 32 )
        {
            return iResult;
        }

        iResult--;
    }

    return 0;
}

int ALFA_GetAreaHeight( object oArea )
{
    int iResult = 32;
    vector vPos = Vector(0.0f, 0.0f, 0.0f );
    location lLoc;

    int iColor = 517; // seems to be the standard invalid tile color

    // Start at 32, count down to 0
    while ( iResult > 0 )
    {
        // Position of tile
        vPos.y = IntToFloat( iResult - 1 );
        lLoc = Location( oArea, vPos, 0.0f );

        iColor = GetTileMainLight1Color( lLoc );

        // We have the size if we found a valid tile color
        if ( iColor > -1 && iColor < 32 )
        {
            return iResult;
        }

        iResult--;
    }

    return 0;
}

int ALFA_IsPositionInArea( vector vPos, object oArea )
{
    if ( vPos.x < 0.0f ) return FALSE;
    if ( vPos.y < 0.0f ) return FALSE;

    float x = IntToFloat( FloatToInt( vPos.x / 10 ) );
    float y = IntToFloat( FloatToInt( vPos.y / 10 ) );
    vector vTile = Vector( x, y, 0.0f );

    int iColor = GetTileMainLight1Color( Location( oArea, vTile, 0.0f ) );

    if ( iColor < 0 || iColor > 31 ) return FALSE;
    else return TRUE;
}

int ALFA_PcInArea( object oArea )
{
    object oPc = GetFirstPC();
    while ( GetIsObjectValid( oPc ) )
    {
        if ( GetArea( oPc ) == oArea ) return TRUE;
        oPc = GetNextPC();
    }
    return FALSE;
}

void ALFA_RemoveEncounterCreatures( object oArea, float fDelay = 0.0f)
{
    object oCreature = GetFirstObjectInArea( oArea );
    while ( GetIsObjectValid( oCreature ) )
    {
        if ( GetIsEncounterCreature( oCreature ) )
        {
            DelayCommand( fDelay, ExecuteScript("ev_vanish", oCreature ) );
        }
        oCreature = GetNextObjectInArea( oArea );
    }
}
