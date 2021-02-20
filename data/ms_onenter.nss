/******************************************************************
 * Name: alfa_onenter
 * Type: OnClientEnter
 * ---
 * Author: Modal
 * Date: 08/30/02
 * ---
 * This handles the module OnClientEnter event.
 * You can add custom code in the appropriate section, as well as
 * in alfa_userdef.
 ******************************************************************/

/* Includes */
#include "alfa_include"

void ALFA_LoadCharacterLocationMS( object poPC )
{
  location    oLocation;
  location    oCurLocation;

  SetLocalInt(poPC, "ALFA_LoadingLocation", TRUE);

  if (GetIsObjectValid( GetAreaFromLocation( GetLocation( poPC ) ) ) == FALSE)
  {
      DelayCommand( 1.0f, ALFA_LoadCharacterLocation( poPC ) );
      return;
  }

  else
  {
    SetLocalInt(poPC, "ALFA_LoadingLocation", FALSE);

    //Check to see if it is ok that we run the location code.
    if ( GetLocalInt( poPC, "ALFA_PC_DoNotLoadLocation" ) == TRUE )
    {
        return;
    }

    else if ( GetLocalInt( poPC, "ALFA_PC_AlreadyLoggedIn" ) == TRUE )
    {
        return;
    }

//    else if ( GetLocalInt( poPC, "AP_WK_MOVE_FLAG" ) == FALSE )
//    {
//      return;
//    }

    else if ( GetItemPossessedBy( poPC, "ALFADeathToken" ) != OBJECT_INVALID )
    {
        return;
    }

    oLocation = ALFA_GetPersistentLocation(WK_LOCATION_TABLE, "CurrentLocation", poPC);

    if ( GetAreaFromLocation( oLocation ) == OBJECT_INVALID )
    {
        return;
    }

    ALFA_SendCharLocationMessage( poPC, 204, TRUE, FALSE, FALSE );
    DelayCommand( 10.0f, AssignCommand( poPC, ActionJumpToLocation( oLocation ) ) );
    SetLocalInt( poPC, "ALFA_PC_AlreadyLoggedIn", TRUE );
  }

  SetLocalInt(poPC, "ALFA_LoadingLocation", FALSE);
}

/*
 * Module OnClientEnter Event
 */
void ALFA_OnClientEnterMS()
{
  object oPC = GetEnteringObject();
  location lExit;

  // All PrCs are disabled by default
  // In the future, we'll check for a persistent var (such as
  // "ALFA_AllowArcher" that would prevent these from being called
  // for individual PCs.  My intention is to put the ability to write
  // that var onto a player via the DM wand at some point.
  //  - Cereborn 09/01/03
  //
  // Hordes of the Underdark PrCs are added to the list
  // and disabled by defalt.
  //  - Murky 01/04/04
  //
  // PrCs have now been added to the DM-wand and been made available for activation.
  // Please check with current DM Guidelines for more information.
  //  - Murky 12/03/04
  //
  SetLocalInt(oPC, "X1_AllowArcher", 1);
  SetLocalInt(oPC, "X1_AllowAsasin", 1);
  SetLocalInt(oPC, "X1_AllowBlkGrd", 1);
  SetLocalInt(oPC, "X1_AllowHarper", 1);
  SetLocalInt(oPC, "X1_AllowShadow", 1);
  SetLocalInt(oPC, "X2_AllowWM", 1);
  SetLocalInt(oPC, "X2_AllowShiftr", 1);
  SetLocalInt(oPC, "X2_AllowPalema", 1);
  SetLocalInt(oPC, "X2_AllowDwDef", 1);
  SetLocalInt(oPC, "X2_AllowDrDis", 1);
  SetLocalInt(oPC, "X2_AllowDivcha", 1);

  /* Set up the weather and/or skies system for the player, if in use */
  if (gALFA_USE_GLOBAL_SKIES)
    {
    SetLocalInt(oPC, "alfa_play_weath", 1);
    }

  if ( gALFA_USE_GLOBAL_WEATHER || gALFA_USE_GLOBAL_SKIES )
  {
    ExecuteScript("alfa_weather", oPC);
  }

  /* Handle new players */
  if ( GetXP( oPC ) < 1 && !GetIsDM( oPC ) )
    CSM_ProcessNewPlayer( oPC );

  /* Kick out a PC on the "Banned" list */
  ExecuteScript( "csm_autoban", oPC );

  SendMessageToPC( oPC, LOGINMESSAGE );

  /* Remind DMs to set appropriate difficulty level */
  if ( GetIsDM( oPC ) == TRUE )
    CSM_RemindDMDifficulty( oPC );

  /* Prevent the XP/Level bug */
  CSM_XPInquisition( oPC );

  /* Validate player's server visa */
  ExecuteScript( "alfa_portal_in", OBJECT_SELF );

  /* Init subrace scripts */
  ExecuteScript( "sei_subraceinit", OBJECT_SELF );

  /* Check for dead players logging in */
  ALFA_PCDeadLogin( oPC );

  /* Clean up any player corpses being carried */
  ALFA_MORGUE_CheckCorpseEnter( oPC );

  /* Run HCR OnEnter */
  ExecuteScript( "hc_on_cl_enter", OBJECT_SELF );

  /* Run 1984 OnEnter */
  ExecuteScript( "alfa_1984_enter", OBJECT_SELF );

  /* Log the character in from Central Authentication */
  SOS_PlayerLogin( oPC );

  /* Puts the character back to their last known location */
  ALFA_LoadCharacterLocationMS( oPC );

  /* Begin the save location script monitor that will run */
  if ( gALFA_LOCATION_SAVE_TIMER )
  {
    ALFA_SaveCharacterLocationOnTimer( oPC );
  }

  /* Do a character save for backup purposes */
  // ACR 1.18 this is marked off
  // ExportSingleCharacter( oPC );

  /* Remove all temp effects from items */
  ExecuteScript("alfa_tmp_eff_rem", oPC);

    /* Spell Tracking system */
  TrackSpellsOnEnter(oPC);

    /* Encumberance system */
    if (!GetIsDM(oPC))
      AssignCommand(oPC, ExecuteScript("alfa_gold_hb", OBJECT_SELF));

  /* Horse System */
  //ALFA_OnHorseOwnerEnter(GetEnteringObject());

  /* Animations and Maneuvers */
  DelayCommand(30.0f, ALFA_CheckAnimations(oPC));

  /* User Defined */
  SignalEvent( OBJECT_SELF, EventUserDefined(ALFA_EVENT_MODULE_ON_ENTER) );
}

void main()
{

  object oPC = GetEnteringObject();

  // If new player move to new player WP
  if(GetLocalInt(oPC, "seenPCBefore") == 0){
    AssignCommand(oPC, ActionJumpToLocation(GetLocation(
        GetObjectByTag("WP_NEW_PC_START_LOCATION"))));
    SetLocalInt(oPC, "seenPCBefore", 1);
  }

  ALFA_OnClientEnter();

  /**************** Add Custom Code Here ***************/

  // Give DMs an Omega Wand
  if ( GetIsObjectValid(GetItemPossessedBy(oPC, "omega_wand" ))==FALSE
    && GetIsDM(oPC))
    CreateItemOnObject("omega_wand", oPC);

  // Give DMs an Area Transition Tool for Base module
  if ( GetIsObjectValid(GetItemPossessedBy(oPC, "alfa_transtool_b" ))==FALSE
    && GetIsDM(oPC))
    CreateItemOnObject("alfa_transtool_b", oPC);

  // Give DMs a Control Stone
  if ( GetIsObjectValid(GetItemPossessedBy(oPC, "dmcontrolstone" ))==FALSE
    && GetIsDM(oPC))
    CreateItemOnObject("dmcontrolstone", oPC);

  /*****************************************************/
}
