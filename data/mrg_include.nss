/******************************************************************
 * File: mrg_include
 * Name: ALFA Morgue: Morgue Module
 * Type: Conversation (Action Taken)
 * ---
 * Author: Modal
 * Date: 1/18/03
 * ---
 * This file contains all of the primary functionality of the
 * Morgue.
 * IMPORTANT: THIS FILE IS A CORE ALFA SCRIPT AND MUST NOT BE
 * MODIFIED EXCEPT THROUGH OFFICIAL ALFA PATCHES!
 ******************************************************************/

/* Dummy function to compile correctly */
//int StartingConditional() {  return 0; }


/* Includes */
#include "nw_i0_plot"
#include "subraces"
#include "mrg_constants"
#include "csm_include"
#include "hc_inc"

/*
 * Function Prototypes
 */

/* Corpse Actions */
void   ALFA_MORGUE_CheckCorpseEnter( object oPC );
void   ALFA_MORGUE_CheckCorpseExit( object oPC );
void   ALFA_MORGUE_CorpseToMorgue( object oPCDead, int nWait=TRUE );
int    ALFA_MORGUE_GetCorpseDecayed( string sCorpseID );
object ALFA_MORGUE_GetPCHasCorpse( object oPC );
void   ALFA_MORGUE_DropCorpse( object oCorpseToken );
void   ALFA_MORGUE_RestorePC( object oPC, int nHeal=FALSE, float fDelay=0.0 );

/* Morgue-Specific */
void   ALFA_PCDeadLogin( object oPC );
void   ALFA_PCDeath( object oPC );
void   ALFA_MORGUE_DeleteDeathRecord( string sCorpseID );
object ALFA_MORGUE_SpawnUndertaker( object oPC );
void   ALFA_MORGUE_TakeEquipped( object oUndertaker, object oPC );
void   ALFA_MORGUE_GiveInventory( object oUndertaker, object oPC );

/* Misc */
void   ALFA_CreateItemOnObject( string sItemTemplate, object oTarget=OBJECT_SELF, int nStackSize=1 );
void   ALFA_ApplyDeathPenalty( object oDead );
void   ALFA_MORGUE_AddPCToList( object oPC );
void   ALFA_MORGUE_DisplayList( object oPC );
int    ALFA_MORGUE_GetIsPCInList( string sCorpseID );
int    ALFA_MORGUE_GetIsValidToken( int nToken );
void   ALFA_MORGUE_RemovePCFromList( string sCorpseID );
void   ALFA_MORGUE_SetSelectedToken( int nToken );
void   ALFA_MORGUE_ToggleMorgue( object oPC );
void   ALFA_MORGUE_UpdateListTokens();
void   ALFA_MORGUE_UpdateSelectedToken();
string ALFA_MORGUE_GenUniqueID( object oPC );
string ALFA_MORGUE_GetCorpseID( object oPC );
object ALFA_MORGUE_GetPCByCorpseID( string sCorpseID );

/* HCR Bleeding Hooks */
void   ALFA_MORGUE_BleedToDeath( object oPC );
void   ALFA_MORGUE_StartBleeding( object oPC );
void   ALFA_MORGUE_StopBleeding( object oPC );



/*
 * void ALFA_MORGUE_CorpseToMorgue()
 * ---
 * Transports a dead PC's body to the morgue-limbo.
 * Self-monitoring.. will attempt to transfer the dead PC
 * up to three times.. if it doesn't work, the PC will be
 * booted for a forced morgue re-entry.

 * ---
 * NOTE: Doesn't take into account disintegration (yet)!
 */
void ALFA_MORGUE_CorpseToMorgue( object oPC, int nWait=TRUE )
{
  location lDest = GetLocation( GetWaypointByTag( ALFA_WAYPT_MORGUE_TAG ) );
  int iXfrCnt = GetLocalInt( oPC, "MRG_XFER_CNT" );
  string sCorpseID = GetLocalString( oPC, ALFA_PC_CORPSE_ID );
  object oRecord = GetObjectByTag( ALFA_OBJ_MORGUE_RECORD_TAG );
  int nDeathState = GetLocalInt( oRecord, sCorpseID );


  // Break out if the PC is in the Morgue, or if the PC is alive.
  if ( GetArea( oPC ) == GetAreaFromLocation( lDest )
    || nDeathState == ALFA_FLAG_PC_ALIVE )
  {
    SetLocalInt( oPC, "MRG_XFER_CNT", 0 );
    return;
  }

  if ( iXfrCnt > 10 )
  {
    SendMessageToPC( oPC, "Morgue transfer failed. Booting for reset..." );
    SetLocalInt( oPC, "MRG_XFER_CNT", 0 );
    DelayCommand( 3.0, BootPC( oPC ) );
    return;
  }
  else
    SetLocalInt( oPC, "MRG_XFER_CNT", iXfrCnt+1 );

  Subraces_SafeRemoveEffects( oPC );
  ApplyEffectToObject( DURATION_TYPE_INSTANT, EffectResurrection(), oPC );
  AssignCommand( oPC, ActionDoCommand(JumpToLocation( lDest )) );
  DelayCommand( 2.0, ALFA_MORGUE_CorpseToMorgue( oPC ) );
}




/*
 * void ALFA_MORGUE_DropCorpse()
 * ---
 * Called by OnUnAcquireItem (Module Event)
 * Replaces a dropped corpse token with a
 * placeable corpse object.
 */

void ALFA_MORGUE_DropCorpse( object oCorpseToken )
{
  object oLoser = GetModuleItemLostBy();
  object oCorpsePlac,
         oRecord = GetObjectByTag( ALFA_OBJ_MORGUE_RECORD_TAG );
  string sCorpseID = GetLocalString( oCorpseToken, ALFA_PC_CORPSE_ID );
  vector vPos = GetPosition( oCorpseToken );
  float  fDistance;

  // Make sure the item is a corpse token
  if ( GetTag( oCorpseToken ) != ALFA_OBJ_PC_CORPSE_TOKEN_TAG )
    return;

  if ( oLoser == OBJECT_INVALID )
    return;

  /* Determine corpse's distance to 0,0,0 as an indicator of
     whether it is being bartered or dropped */
  fDistance = sqrt( vPos.x * vPos.x + vPos.y * vPos.y + vPos.z + vPos.z );

  /* The corpse is being dropped */
  if ( fDistance > 0.01 )
  {
    // Create ground corpse token
    oCorpsePlac = CreateObject( OBJECT_TYPE_PLACEABLE, ALFA_PC_CORPSE_PLAC_REF, GetLocation( oLoser ) );
    SetLocalObject( oRecord, ALFA_MORGUE_CORPSE_ + sCorpseID, oCorpsePlac );
    SetLocalLocation( oRecord, ALFA_MORGUE_CORPSE_ + sCorpseID, GetLocation( oLoser ) );

    // Transfer local corpse variables
    sCorpseID = GetLocalString( oCorpseToken, ALFA_PC_CORPSE_ID );
    SetLocalString( oCorpsePlac, ALFA_PC_CORPSE_ID, sCorpseID );

    // Update Morgue record's values
    SetLocalLocation( oRecord, sCorpseID, GetLocation( oCorpsePlac ) );

    DestroyObject( oCorpseToken );
  }
  /* The corpse is being bartered */
  else
    return;

}



/*
 * void ALFA_PCCarryFakeCorpse()
 * ---
 * Destroys ground corpse and creates a heavy corpse token
 * in PC's inventory.
 */
void ALFA_PCCarryFakeCorpse( object oPCCarry, object oCorpse )
{
  object oItem,
         oCorpseToken,
         oRecord = GetObjectByTag( ALFA_OBJ_MORGUE_RECORD_TAG );
  string sCorpseID = GetLocalString( oCorpse, ALFA_PC_CORPSE_ID );;

  /* Create corpse token */
  oCorpseToken = CreateItemOnObject( ALFA_PC_CORPSE_TOKEN_REF, oPCCarry );
  SetLocalObject( oRecord, ALFA_MORGUE_CORPSE_ + sCorpseID, oCorpseToken );
  SetLocalLocation( oRecord, ALFA_MORGUE_CORPSE_ + sCorpseID, GetLocation( oPCCarry ) );

  /* Transfer corpse values */
  SetLocalString( oCorpseToken, ALFA_PC_CORPSE_ID, sCorpseID );

  DestroyObject( oCorpse );
}




/*
 * void ALFA_MORGUE_GiveInventory()
 * ---
 * Give all inventory items to a creature; if
 * ALFA_WAS_EQUIPPED is set and equals the creature's
 * name, equip that item.
 */
void ALFA_MORGUE_GiveInventory( object oGiver, object oReceiver )
{
  object oItem;

  oItem = GetFirstItemInInventory( oGiver );

  AssignCommand( oReceiver, ClearAllActions() );

  while ( oItem != OBJECT_INVALID )
  {
    AssignCommand( oGiver, ActionGiveItem( oItem, oReceiver ) );
    if ( GetLocalString( oItem, ALFA_WAS_EQUIPPED_BY ) != "" )
    {
      if ( GetLocalString( oItem, ALFA_WAS_EQUIPPED_BY ) == GetName( oReceiver ) )
        DelayCommand( 0.2, AssignCommand( oReceiver, ActionEquipItem( oItem, GetLocalInt( oItem, ALFA_WAS_EQUIPPED_IN ) ) ) );
      DelayCommand( 0.3, AssignCommand( oReceiver, ActionDoCommand(DeleteLocalString( oItem, ALFA_WAS_EQUIPPED_BY ) )) );
      DelayCommand( 0.3, AssignCommand( oReceiver, ActionDoCommand(DeleteLocalInt( oItem, ALFA_WAS_EQUIPPED_IN ) )) );
    }
    oItem = GetNextItemInInventory( oGiver );
  }
}




/*
 * void ALFA_MORGUE_TakeEquipped()
 * ---
 * Take all equipped items off a creature,
 * except for creature hide/attack items, and
 * label them as having been equipped.
 */
void ALFA_MORGUE_TakeEquipped( object oTaker, object oVictim )
{
  object oItem;
  int nSlot;

  for ( nSlot = INVENTORY_SLOT_CARMOUR; nSlot >= 0; nSlot-- )
  {
    if ( nSlot != INVENTORY_SLOT_CARMOUR
      && nSlot != INVENTORY_SLOT_CWEAPON_B
      && nSlot != INVENTORY_SLOT_CWEAPON_L
      && nSlot != INVENTORY_SLOT_CWEAPON_R )
      {
        if ( (oItem = GetItemInSlot( nSlot, oVictim )) != OBJECT_INVALID
           && !ALFA_CSM_ItemTagContains( oItem, VISANAME )
           && (GetStringLeft( GetTag(oItem), 8 ) != "sei_sla_") )
        {
          SetLocalString( oItem, ALFA_WAS_EQUIPPED_BY, GetName( oVictim ) );
          SetLocalInt( oItem, ALFA_WAS_EQUIPPED_IN, nSlot );
          AssignCommand( oTaker, ActionTakeItem( oItem, oVictim ) );
        }
      }
  }
}




/*
 * void ALFA_PCDeadLogin()
 * ---
 * Check to see if a dead PC who is logging in
 * has been resurrected by anyone.
 */
void ALFA_PCDeadLogin( object oPCDead )
{
  ExecuteScript( "mrg_monitorpc", oPCDead );
}




/*
 * void ALFA_PCDeath()
 * ---
 * Initializes the morgue for a PC who has just died.
 */
void ALFA_PCDeath( object oPC )
{
  object oUndertaker,
         oCorpse,
         oRecord = GetObjectByTag( ALFA_OBJ_MORGUE_RECORD_TAG );
  string sCorpseID;
  location lOrigin;

  sCorpseID = ALFA_MORGUE_GetCorpseID( oPC );
  lOrigin = GetLocation( oPC );

  oUndertaker = GetLocalObject( oRecord, sCorpseID );

  /* Death in the Morgue is meaningless */
  if ( GetTag( GetArea( oPC ) ) == ALFA_AREA_MORGUE_TAG )
  {
    ApplyEffectToObject( DURATION_TYPE_INSTANT, EffectResurrection(), oPC );
    return;
  }

  // A PC is NOT in the Morgue, and is supposed to be dead.
  // Booting the PC should reset him to normal.
  if ( GetItemPossessedBy( oPC, "ALFADeathToken" ) != OBJECT_INVALID )
  {
    BootPC( oPC );
    return;
  }

  /* The PC is dead. */

  CSM_ApplyLevelLoss( oPC );

  /* If the PC already has an undertaker, he was bleeding */
  if ( oUndertaker != OBJECT_INVALID )
  {
    ALFA_MORGUE_BleedToDeath( oPC );
    return;
  }

  sCorpseID = ALFA_MORGUE_GenUniqueID( oPC );
  SetLocalString( oPC, ALFA_PC_CORPSE_ID, sCorpseID );

  /* HCR Compatibility Flags */
  SPS( oPC, PWS_PLAYER_STATE_DEAD );

  /* Create PC Record in Morgue */
  SetLocalInt( oRecord, sCorpseID, ALFA_FLAG_PC_DEAD );
  SetLocalLocation( oRecord, sCorpseID, lOrigin );

  /* Spawn Undertaker */
  oUndertaker = ALFA_MORGUE_SpawnUndertaker( oPC );

  /* Create ground corpse token */
  oCorpse = CreateObject( OBJECT_TYPE_PLACEABLE, ALFA_PC_CORPSE_PLAC_REF, GetLocation( oPC ) );
  SetLocalObject( oRecord, ALFA_MORGUE_CORPSE_ + sCorpseID, oCorpse );

  /* Init local corpse variables */
  SetLocalString( oCorpse, ALFA_PC_CORPSE_ID, sCorpseID );

  /* Shift inventory over to Undertaker */
  ALFA_TakeInventory( oUndertaker, oPC );
  ALFA_MORGUE_TakeEquipped( oUndertaker, oPC );

  /* Transfer gold to the Undertaker */
  int nGold = GetGold( oPC );
  AssignCommand( oPC, TakeGoldFromCreature( nGold, oPC, TRUE ) );
  SetLocalInt( oUndertaker, ALFA_MORGUE_GOLD, nGold );

  ALFA_MORGUE_CorpseToMorgue( oPC );
  ALFA_MORGUE_AddPCToList( oPC );

  /* Give the PC a Death Token */
  AssignCommand( oUndertaker, ALFA_CreateItemOnObject( "ablacksymbol", oPC ) );
}





/*
 * void ALFA_MORGUE_StartBleeding()
 * ---
 * Initializes the morgue for a PC who has just started to bleed.
 */
void ALFA_MORGUE_StartBleeding( object oPC )
{
  object oUndertaker,
         oCorpse,
         oRecord = GetObjectByTag( ALFA_OBJ_MORGUE_RECORD_TAG );
  string sCorpseID = ALFA_MORGUE_GenUniqueID( oPC );
  location lOrigin;

  if ( GetTag( GetArea( oPC ) ) == ALFA_AREA_MORGUE_TAG )
    return;

  SetLocalString( oPC, ALFA_PC_CORPSE_ID, sCorpseID );
  lOrigin = GetLocation( oPC );

  /* Create PC Record in Morgue */
  SetLocalInt( oRecord, sCorpseID, ALFA_FLAG_PC_BLEEDING );
  SetLocalLocation( oRecord, sCorpseID, lOrigin );

  /* Spawn Undertaker */
  oUndertaker = ALFA_MORGUE_SpawnUndertaker( oPC );

  /* Shift inventory over to Undertaker */
  ALFA_TakeInventory( oUndertaker, oPC );
  ALFA_MORGUE_TakeEquipped( oUndertaker, oPC );

  /* Transfer gold to the Undertaker */
  int nGold = GetGold( oPC );
  AssignCommand( oPC, TakeGoldFromCreature( nGold, oPC, TRUE ) );
  SetLocalInt( oUndertaker, ALFA_MORGUE_GOLD, nGold );

  ALFA_MORGUE_AddPCToList( oPC );
}



/*
 * void ALFA_MORGUE_BleedToDeath()
 * ---
 * Creates a corpse for a PC who has just bled to death
 * and sets the Morgue variables accordingly.
 */
void ALFA_MORGUE_BleedToDeath( object oPC )
{
  object oCorpse,
         oRecord = GetObjectByTag( ALFA_OBJ_MORGUE_RECORD_TAG );
  string sCorpseID = ALFA_MORGUE_GetCorpseID( oPC );
  location lOrigin = GetLocation( oPC );

  /* Death in the Morgue is meaningless */
  if ( GetTag( GetArea( oPC ) ) == ALFA_AREA_MORGUE_TAG )
  {
    ApplyEffectToObject( DURATION_TYPE_INSTANT, EffectResurrection(), oPC );
    return;
  }

  /* HCR Compatibility Flags */
  SPS( oPC, PWS_PLAYER_STATE_DEAD );

  /* Update PC Record in Morgue */
  SetLocalInt( oRecord, sCorpseID, ALFA_FLAG_PC_DEAD );
  SetLocalLocation( oRecord, sCorpseID, lOrigin );

  /* Create ground corpse token */
  oCorpse = CreateObject( OBJECT_TYPE_PLACEABLE, ALFA_PC_CORPSE_PLAC_REF, GetLocation( oPC ) );
  SetLocalObject( oRecord, ALFA_MORGUE_CORPSE_ + sCorpseID, oCorpse );
  SetLocalLocation( oRecord, ALFA_MORGUE_CORPSE_ + sCorpseID, GetLocation( oPC ) );

  /* Init local corpse variables */
  SetLocalString( oCorpse, ALFA_PC_CORPSE_ID, sCorpseID );

  /* Give PC Death Token */
  CreateItemOnObject( "ablacksymbol", oPC );

  /* Move PC to Morgue */
  ALFA_MORGUE_CorpseToMorgue( oPC );

}




/*
 * void ALFA_MORGUE_StopBleeding()
 * ---
 * Returns a PC who was bleeding to normal.
 */
void ALFA_MORGUE_StopBleeding( object oPC )
{
  object oMod = GetModule();
  object oRecord = GetObjectByTag( ALFA_OBJ_MORGUE_RECORD_TAG );
  string sCorpseID = ALFA_MORGUE_GetCorpseID( oPC );

  SetLocalInt( oRecord, sCorpseID, ALFA_FLAG_PC_ALIVE );

  /* HCR Compatibility Flags */
  SetLocalInt( oMod,"DR_APPLIED"+GetName(oPC)+GetPCPublicCDKey(oPC),FALSE );

  ALFA_MORGUE_RestorePC( oPC, FALSE );
}




/*
 * object ALFA_MORGUE_SpawnUndertaker()
 * ---
 * Create and assign an "undertaker" for a PC who
 * has just died.
 */
object ALFA_MORGUE_SpawnUndertaker( object oPC )
{
  object oUndertaker;
  object oRecord = GetObjectByTag( ALFA_OBJ_MORGUE_RECORD_TAG );
  location lDest;
  string sCorpseID = ALFA_MORGUE_GetCorpseID( oPC );
  object oItem;

  if ( oRecord == OBJECT_INVALID )
    ALFA_Error( "No Death Record! Reset your module ASAP!" );

  /* Has the PC _just_ been resurrected? */
  oUndertaker = GetLocalObject( oRecord, sCorpseID );
  if ( oUndertaker != OBJECT_INVALID )
  {
    SetLocalInt( oUndertaker, ALFA_MORGUE_CLEANUP, FALSE );
    return oUndertaker;
  }

  lDest = GetLocation( GetWaypointByTag( ALFA_WAYPT_UNDERTAKER_TAG ) );
  oUndertaker = CreateObject( OBJECT_TYPE_PLACEABLE, ALFA_OBJ_UNDERTAKER_REF, lDest );

  /* Strip Undertaker Items */
  ALFA_DestroyInventory( oUndertaker );

  /* Set Undertaker's values */
  SetLocalString( oUndertaker, ALFA_PC_CORPSE_ID, sCorpseID );
  SetLocalInt( oUndertaker, ALFA_PC_TOD_YEAR, GetCalendarYear() );
  SetLocalInt( oUndertaker, ALFA_PC_TOD_MONTH, GetCalendarMonth() );
  SetLocalInt( oUndertaker, ALFA_PC_TOD_DAY, GetCalendarDay() );
  SetLocalInt( oUndertaker, ALFA_PC_TOD_HOUR, GetTimeHour() );

  /* Set Morgue record's values */
  SetLocalObject( oRecord, sCorpseID, oUndertaker );

  return oUndertaker;
}




void ALFA_MORGUE_RestorePC( object oPC, int nHeal=FALSE, float fDelay=0.0 )
{
  object oRecord = GetObjectByTag( ALFA_OBJ_MORGUE_RECORD_TAG );
  object oUndertaker;
  string sCorpseID = ALFA_MORGUE_GetCorpseID( oPC );

  oUndertaker = GetLocalObject( oRecord, sCorpseID );

  ALFA_RemoveEffects( oPC );

  if ( nHeal == TRUE )
    ApplyEffectToObject( DURATION_TYPE_INSTANT, EffectHeal( GetMaxHitPoints(oPC) ), oPC );
  else
    SetLocalInt( oUndertaker, ALFA_MORGUE_CORRECT_HP, TRUE );

  SPS( oPC, PWS_PLAYER_STATE_ALIVE );

  ExecuteScript( "mrg_undertaker", oUndertaker );
}





/*
 * void ALFA_MORGUE_DeleteDeathRecord()
 * ---
 * Clean up after a PC upon resurrection.
 */
void ALFA_MORGUE_DeleteDeathRecord( string sCorpseID )
{
  object oRecord = GetObjectByTag( ALFA_OBJ_MORGUE_RECORD_TAG );
  object oUndertaker;
  object oPC = ALFA_MORGUE_GetPCByCorpseID( sCorpseID );

  oUndertaker = GetLocalObject( oRecord, sCorpseID );

  DestroyObject( oUndertaker );

  DeleteLocalInt( oRecord, sCorpseID );
  DeleteLocalObject( oRecord, sCorpseID );

  ALFA_MORGUE_RemovePCFromList( sCorpseID );

  DeleteLocalString( oPC, ALFA_PC_CORPSE_ID );
}




/*
 * object ALFA_MORGUE_GetPCHasCorpse()
 * ---
 * Find if the PC is carrying a corpse,
 * and return a pointer to it.
 */
object ALFA_MORGUE_GetPCHasCorpse( object oPC )
{
  return GetItemPossessedBy( oPC, ALFA_OBJ_PC_CORPSE_TOKEN_TAG );
}




/*
 * void ALFA_ApplyDeathPenalty()
 * ---
 * Taken from Bioware - ALFA will need to
 * modify this.
 */
void ALFA_ApplyDeathPenalty( object oDead )
{
    int nXP = GetXP(oDead);
    int nPenalty = 50 * GetHitDice(oDead);
    int nHD = GetHitDice(oDead);
    // * You can not lose a level with this respawning
    int nMin = ((nHD * (nHD - 1)) / 2) * 1000;

    int nNewXP = nXP - nPenalty;
    if (nNewXP < nMin)
       nNewXP = nMin;
    SetXP(oDead, nNewXP);
}




/*
 * string ALFA_MORGUE_TimeToDecayString()
 * ---
 * If the corpse associated with sCorpseID has not yet
 * decayed, return a string with the time left until the
 * corpse decays.
 */
string ALFA_MORGUE_TimeToDecayString( string sCorpseID )
{
  int nYearTOD, nYearCur,
      nMonthTOD, nMonthCur,
      nDayTOD, nDayCur,
      nHourTOD, nHourCur,
      nHourTotalTOD, nHourTotalCur;
  int nTotalYears, nTotalHours;
  int nYears, nMonths, nDays, nHours;
  string sMonths, sDays, sHours, sTimeLeft;
  object oRecord = GetObjectByTag( ALFA_OBJ_MORGUE_RECORD_TAG );
  object oUndertaker;

  oUndertaker = GetLocalObject( oRecord, sCorpseID );
  // Initialize dates and times
  nYearTOD = GetLocalInt( oUndertaker, ALFA_PC_TOD_YEAR );
  nMonthTOD = GetLocalInt( oUndertaker, ALFA_PC_TOD_MONTH );
  nDayTOD = GetLocalInt( oUndertaker, ALFA_PC_TOD_DAY );
  nHourTOD = GetLocalInt( oUndertaker, ALFA_PC_TOD_HOUR );

  nYearCur = GetCalendarYear();
  nMonthCur = GetCalendarMonth();
  nDayCur = GetCalendarDay();
  nHourCur = GetTimeHour();

  nYears = nYearCur - nYearTOD;

  nHourTotalTOD = (nMonthTOD - 1)*28*24 + (nDayTOD - 1)*24 + nHourTOD;
  nHourTotalCur = (nMonthCur - 1)*28*24 + (nDayCur - 1)*24 + nHourCur;
  nHours = nHourTotalCur - nHourTotalTOD;

  /* Correct nYears, nHours */
  if ( nYears > 0 && nHourTotalCur <= nHourTotalTOD )
  {
      nYears = nYears - 1;
      nHours = nHourTotalCur + (8064 - nHourTotalTOD);
  }

  if ( nYears > 0 || nHours > ALFA_MORGUE_DECAY_TIME )
    return "Your corpse has decayed.";

  nHours = ALFA_MORGUE_DECAY_TIME - nHours;
  nTotalHours = nHours;

  nMonths = FloatToInt( IntToFloat(nTotalHours)/(24.0*28.0) );
  nTotalHours = nTotalHours - nMonths*24*28;
  nDays = FloatToInt( IntToFloat(nTotalHours)/(24.0) );
  nTotalHours = nTotalHours - nDays*24;
  nHours = nTotalHours;

  sTimeLeft = "Your corpse will decay in ";

  if ( nMonths > 0 )
  {
    sTimeLeft = sTimeLeft + IntToString( nMonths ) + " month";
    if ( nMonths > 1 )
      sTimeLeft = sTimeLeft + "s";
  }

  if ( nDays > 0 )
  {
    if ( nHours == 0 && nMonths > 0 )
      sTimeLeft = sTimeLeft + ", and " + IntToString( nDays ) + " day";
    else if ( nMonths > 0 )
      sTimeLeft = sTimeLeft + ", " + IntToString( nDays ) + " day";
    else
      sTimeLeft = sTimeLeft + IntToString( nDays ) + " day";
    if ( nDays > 1 )
      sTimeLeft = sTimeLeft + "s";
  }

  if ( nHours > 0 )
  {
    if ( nDays > 0 || nMonths > 0 )
      sTimeLeft = sTimeLeft + ", and " + IntToString( nHours ) + " hour";
    else
      sTimeLeft = sTimeLeft + IntToString( nHours ) + " hour";
    if ( nHours > 1 )
      sTimeLeft = sTimeLeft + "s";
  }

  sTimeLeft = sTimeLeft + ".";

  return sTimeLeft;
}

/*
 * int ALFA_MORGUE_GetCorpseDecayed( string sCorpseID )
 * ---
 * Calculate whether or not a PC's corpse has
 * decayed.
 */
int ALFA_MORGUE_GetCorpseDecayed( string sCorpseID )
{
  object oRecord = GetObjectByTag( ALFA_OBJ_MORGUE_RECORD_TAG );
  object oUndertaker;
  int nTODYear, nYears,
      nTODMonth, nMonths,
      nTODDay, nDays,
      nTODHour, nHours;

  oUndertaker = GetLocalObject( oRecord, sCorpseID );

  nTODYear = GetLocalInt( oUndertaker, ALFA_PC_TOD_YEAR );
  nTODMonth = GetLocalInt( oUndertaker, ALFA_PC_TOD_MONTH );
  nTODDay = GetLocalInt( oUndertaker, ALFA_PC_TOD_DAY );
  nTODHour = GetLocalInt( oUndertaker, ALFA_PC_TOD_HOUR );

  nYears =  nTODYear - GetCalendarYear();

  /* Died on New Year's? */
  if ( nYears > 0 )
  {
    if ( nYears > 1 )
      return TRUE;

    if ( nTODMonth == 12 && GetCalendarMonth() == 1 )
      nMonths = 1;
    else
      return TRUE;
  }
  else
    nMonths = nTODMonth - GetCalendarMonth();

  /* Died on the last day of the month? */
  if ( nMonths > 0 )
  {
    if ( nMonths > 1 )
      return TRUE;

    if ( nTODDay == 28 && GetCalendarDay() == 1 )
      nDays = 1;
    else
      return TRUE;
  }
  else
    nDays = nTODDay - GetCalendarDay();

  /* Calc. Hours */
  if ( nDays > 0 )
  {
    if ( nDays > 1 )
      return TRUE;

    nHours = (24 - nTODHour) + GetTimeHour();
    if ( nHours > 24 )
      return TRUE;
  }

  return FALSE;
}




/*
 * void ALFA_MORGUE_DisplayList()
 * ---
 * Print a list of all dead PCs in the morgue.
 */
void ALFA_MORGUE_DisplayList( object oPC )
{
  object oRecord = GetObjectByTag( ALFA_OBJ_MORGUE_RECORD_TAG );
  int nListSize;
  string sIndex,
         sStatus;
  int i;

  nListSize = GetLocalInt( oRecord, ALFA_MORGUE_LIST_SIZE );

  SendMessageToPC( oPC, "[+-----Players in the Morgue------+]" );

  for ( i = 0; i < nListSize; i++ )
  {
    sIndex = ALFA_MORGUE_ARR_PREFIX + IntToString( i );
    if ( ALFA_MORGUE_GetPCByCorpseID( GetLocalString( oRecord, sIndex ) ) == OBJECT_INVALID )
      sStatus = " (Offline)";
    else
      sStatus = " (Online)";
    SendMessageToPC( oPC, IntToString(i+1) + ". " + GetLocalString( oRecord, sIndex ) + sStatus );
  }
}




/*
 * void ALFA_MORGUE_AddPCToList()
 * ---
 * Create an entry in the morgue index list.
 */
void ALFA_MORGUE_AddPCToList( object oPC )
{
  object oRecord = GetObjectByTag( ALFA_OBJ_MORGUE_RECORD_TAG );
  int nListSize;
  string sIndex,
         sCorpseID = ALFA_MORGUE_GetCorpseID( oPC );
  int i;

  nListSize = GetLocalInt( oRecord, ALFA_MORGUE_LIST_SIZE );

  /* Don't add doubles */
  for ( i = 0; i < nListSize; i++ )
  {
    sIndex = ALFA_MORGUE_ARR_PREFIX + IntToString( i );
    if ( GetLocalString( oRecord, sIndex ) == ALFA_MORGUE_GetCorpseID( oPC ) )
      return;
  }

  /* Find insertion point */

  sIndex = ALFA_MORGUE_ARR_PREFIX + IntToString( nListSize );
  SetLocalString( oRecord, sIndex, ALFA_MORGUE_GetCorpseID( oPC ) );
  SetLocalInt( oRecord, ALFA_MORGUE_LIST_SIZE, nListSize + 1 );
}




/*
 * void ALFA_MORGUE_RemovePCFromList()
 * ---
 * Delete an entry in the morgue index list.
 */
void ALFA_MORGUE_RemovePCFromList( string sCorpseID )
{
  object oRecord = GetObjectByTag( ALFA_OBJ_MORGUE_RECORD_TAG );
  int nListSize;
  string sIndexThis,
         sIndexNext,
         sValueNext;
  int i, nEmpty = -1;

  nListSize = GetLocalInt( oRecord, ALFA_MORGUE_LIST_SIZE );

  /* Find the spot in the array which we want to remove */
  for ( i = 0; i < nListSize; i++ )
  {
    sIndexThis = ALFA_MORGUE_ARR_PREFIX + IntToString( i );
    if ( GetLocalString( oRecord, sIndexThis ) == sCorpseID )
    {
      nEmpty = i;
      break;
    }
  }

  /* Did we find it? */
  if ( nEmpty < 0 )
    return;

  /* Collapse the array down */
  for ( i = nEmpty; i < nListSize - 1; i++ )
  {
    sIndexThis = ALFA_MORGUE_ARR_PREFIX + IntToString( i );
    sIndexNext = ALFA_MORGUE_ARR_PREFIX + IntToString( i+1 );

    sValueNext = GetLocalString( oRecord, sIndexNext );
    SetLocalString( oRecord, sIndexThis, sValueNext );
  }

  if ( nEmpty == nListSize - 1 )
    DeleteLocalString( oRecord, ALFA_MORGUE_ARR_PREFIX + IntToString( nEmpty ) );
  else
    DeleteLocalString( oRecord, ALFA_MORGUE_ARR_PREFIX + IntToString( nListSize - 1 ) );

  SetLocalInt( oRecord, ALFA_MORGUE_LIST_SIZE, nListSize - 1 );
}



/*
 * void ALFA_MORGUE_UpdateListTokens()
 * ---
 * Update the 5 browse page tokens.
 */
void ALFA_MORGUE_UpdateListTokens()
{
  object oRecord = GetObjectByTag( ALFA_OBJ_MORGUE_RECORD_TAG );
  string sIndex,
         sStatus,
         sTokenIndex;
  int nOffset,
      nListSize,
      i;

  nOffset = GetLocalInt( oRecord, ALFA_MORGUE_LIST_OFFSET );
  nListSize = GetLocalInt( oRecord, ALFA_MORGUE_LIST_SIZE );

  for ( i = 0; i < 5; i++ )
  {
    sIndex = ALFA_MORGUE_ARR_PREFIX + IntToString( nOffset + i );
    sTokenIndex = ALFA_MORGUE_TOK_PREFIX + IntToString( 16501 + i );
    if ( nOffset + i > nListSize - 1 )
    {
      SetCustomToken( 16501 + i, "" );
      SetLocalString( oRecord, sTokenIndex, "" );
    }
    else
    {
      if ( ALFA_MORGUE_GetPCByCorpseID( GetLocalString( oRecord, sIndex ) ) == OBJECT_INVALID )
        sStatus = " (Offline)";
      else
        sStatus = " (Online)";

      SetCustomToken( 16501 + i, GetLocalString( oRecord, sIndex ) + sStatus );
      SetLocalString( oRecord, sTokenIndex, GetLocalString( oRecord, sIndex ) );
    }
  }
}



/*
 * int ALFA_MORGUE_GetIsPCInList()
 * ---
 * Check to see a PC by the name of sCorpseID
 * is in the list.
 */
int ALFA_MORGUE_GetIsPCInList( string sCorpseID )
{
  object oRecord = GetObjectByTag( ALFA_OBJ_MORGUE_RECORD_TAG );
  int nListSize;
  string sIndex;
  int i;

  nListSize = GetLocalInt( oRecord, ALFA_MORGUE_LIST_SIZE );

  /* Find the spot in the array which we want to remove */
  for ( i = 0; i < nListSize; i++ )
  {
    sIndex = ALFA_MORGUE_ARR_PREFIX + IntToString( i );
    if ( GetLocalString( oRecord, sIndex ) == sCorpseID )
      return TRUE;
  }

  return FALSE;
}



/*
 * int ALFA_MORGUE_GetIsValidToken( int nToken )
 * ---
 * Checks if a token is still associated with the
 * correct player.
 */
int ALFA_MORGUE_GetIsValidToken( int nToken )
{
  object oRecord = GetObjectByTag( ALFA_OBJ_MORGUE_RECORD_TAG );
  int nOffset,
      nListSize;

  nOffset = GetLocalInt( oRecord, ALFA_MORGUE_LIST_OFFSET );
  nListSize = GetLocalInt( oRecord, ALFA_MORGUE_LIST_SIZE );

  if ( nToken - 16501 + nOffset > nListSize - 1 )
    return FALSE;

  return TRUE;
}




/*
 * void ALFA_MORGUE_UpdateSelectedToken()
 * ---
 * Update the selected player token (16506) to
 * current values.
 */
void ALFA_MORGUE_UpdateSelectedToken()
{
  object oRecord = GetObjectByTag( ALFA_OBJ_MORGUE_RECORD_TAG );
  string sCorpseID,
         sIndex,
         sState;
  int nOffset,
      nListSize,
      nState;

  /* Retrieve the token's information */
  sCorpseID = GetLocalString( oRecord, ALFA_MORGUE_TOK_PREFIX + IntToString( 16506 ) );
  nState = GetLocalInt( oRecord, sCorpseID );

  /* Check to see if the list has changed */
  if ( sCorpseID == "" || ALFA_MORGUE_GetIsPCInList( sCorpseID ) == FALSE )
  {
    sCorpseID = ALFA_WAND_PC_NOT_FOUND;
    SetLocalString( oRecord, ALFA_MORGUE_TOK_PREFIX + IntToString( 16506 ), sCorpseID );
    SetCustomToken( 16506, sCorpseID );
    SetCustomToken( 16507, "" );
  }
  /* Update the token's values */
  else
  {
    SetLocalString( oRecord, ALFA_MORGUE_TOK_PREFIX + IntToString( 16506 ), sCorpseID );
    SetCustomToken( 16506, sCorpseID );
    if ( nState == ALFA_FLAG_PC_DEAD )
      sState = "Dead";
    else if ( nState == ALFA_FLAG_PC_RAISED )
      sState = "Raised";
    else if ( nState == ALFA_FLAG_PC_RESURRECTED )
      sState = "Resurrected";
    else if ( nState == ALFA_FLAG_PC_BLEEDING )
      sState = "Bleeding";
    else
      sState = "BAD STATE";
    if ( ALFA_MORGUE_GetPCByCorpseID( sCorpseID ) == OBJECT_INVALID )
      sState = sState + " (Offline)";
    else
      sState = sState + " (Online)";

    SetCustomToken( 16507, sState );
  }
}





/*
 * void ALFA_MORGUE_SetSelectedToken()
 * ---
 * Set the Selected Player token (16506) to nToken.
 */
void ALFA_MORGUE_SetSelectedToken( int nToken )
{
  object oRecord = GetObjectByTag( ALFA_OBJ_MORGUE_RECORD_TAG );
  string sCorpseID,
         sIndex,
         sState,
         sTokenIndex = ALFA_MORGUE_TOK_PREFIX + IntToString( nToken );
  int nOffset,
      nListSize,
      nState,
      i;

  /* Retrieve information about the token */
  sCorpseID = GetLocalString( oRecord, sTokenIndex );
  nState = GetLocalInt( oRecord, sCorpseID );

  /* Check to see if the list changed */
  if ( sCorpseID == "" || ALFA_MORGUE_GetIsPCInList( sCorpseID ) == FALSE )
  {
    sCorpseID = ALFA_WAND_PC_NOT_FOUND;
    SetLocalString( oRecord, ALFA_MORGUE_TOK_PREFIX + IntToString( 16506 ), sCorpseID );
    SetCustomToken( 16506, sCorpseID );
    SetCustomToken( 16507, "" );
  }
  /* Set the token's values */
  else
  {
    SetLocalString( oRecord, ALFA_MORGUE_TOK_PREFIX + IntToString( 16506 ), sCorpseID );
    SetCustomToken( 16506, sCorpseID );
    if ( nState == ALFA_FLAG_PC_DEAD )
      sState = "Dead";
    else if ( nState == ALFA_FLAG_PC_RAISED )
      sState = "Raised";
    else if ( nState == ALFA_FLAG_PC_RESURRECTED )
      sState = "Resurrected";
    else if ( nState == ALFA_FLAG_PC_BLEEDING )
      sState = "Bleeding";
    else
      sState = "BAD STATE";

    if ( ALFA_MORGUE_GetPCByCorpseID( sCorpseID ) == OBJECT_INVALID )
      sState = sState + " (Offline)";
    else
      sState = sState + " (Online)";

    SetCustomToken( 16507, sState );
  }
}





/*
 * void ALFA_MORGUE_ToggleMorgue()
 * ---
 * Toggles the Morgue on and off.
 */
void ALFA_MORGUE_ToggleMorgue( object oPC )
{
  object oRecord = GetObjectByTag( ALFA_OBJ_MORGUE_RECORD_TAG );

  if ( GetLocalInt( oRecord, ALFA_MORGUE_DISABLED ) == TRUE )
  {
    SetLocalInt( oRecord, ALFA_MORGUE_DISABLED, FALSE );
    SendMessageToPC( oPC, "Morgue toggled ON." );
  }
  else
  {
    SetLocalInt( oRecord, ALFA_MORGUE_DISABLED, TRUE );
    SendMessageToPC( oPC, "Morgue toggled OFF." );
  }
}



/*
 * void ALFA_MORGUE_CheckCorpseExit( object oPC )
 * ---
 * If oPC is carrying any corpses, create new ones
 * at his location and set them as being the "valid"
 * corpses.
 */
void ALFA_MORGUE_CheckCorpseExit( object oPC )
{
  object oCorpseToken = GetItemPossessedBy( oPC, ALFA_OBJ_PC_CORPSE_TOKEN_TAG );

  if ( oCorpseToken != OBJECT_INVALID )
  {
    string sCorpseID = GetLocalString( oCorpseToken, ALFA_PC_CORPSE_ID );
    object oCorpsePlac;
    object oRecord = GetObjectByTag( ALFA_OBJ_MORGUE_RECORD_TAG );
    location lCorpse = GetLocalLocation( oRecord, ALFA_MORGUE_CORPSE_ + sCorpseID );

    /* Create ground corpse token */
    oCorpsePlac = CreateObject( OBJECT_TYPE_PLACEABLE, ALFA_PC_CORPSE_PLAC_REF, lCorpse );
    SetLocalObject( oRecord, ALFA_MORGUE_CORPSE_ + sCorpseID, oCorpsePlac );

    /* Transfer local corpse variables */
    SetLocalString( oCorpsePlac, ALFA_PC_CORPSE_ID, sCorpseID );

    /* Update Morgue record's values */
    SetLocalLocation( oRecord, sCorpseID, GetLocation( oCorpsePlac ) );
  }
}


/*
 * void ALFA_MORGUE_CheckCorpseEnter( object oPC )
 * ---
 * If oPC is carrying any corpses, destroy them.
 */
void ALFA_MORGUE_CheckCorpseEnter( object oPC )
{
  object oCorpseToken = GetItemPossessedBy( oPC, ALFA_OBJ_PC_CORPSE_TOKEN_TAG );

  if ( oCorpseToken != OBJECT_INVALID )
  {
    DestroyObject( oCorpseToken );
    SendMessageToPC( oPC, "The corpse crumbles into dust." );
  }
}

string ALFA_MORGUE_GetCorpseID( object oPC )
{
  return GetLocalString( oPC, ALFA_PC_CORPSE_ID );
}

string ALFA_MORGUE_GenUniqueID( object oPC )
{
  string sCorpseID = GetName( oPC );
  object oRecord = GetObjectByTag( ALFA_OBJ_MORGUE_RECORD_TAG );
  int nListSize = GetLocalInt( oRecord, ALFA_MORGUE_LIST_SIZE );

  return sCorpseID + "_" + IntToString( nListSize );
}


/*
 * object ALFA_MORGUE_GetPCByCorpseID( string sCorpseID )
 * ---
 * Return a pointer to the PC with corpse ID sCorpseID.
 */
object ALFA_MORGUE_GetPCByCorpseID( string sCorpseID )
{
  object oPC;

  oPC = GetFirstPC();

  while ( oPC != OBJECT_INVALID )
  {
    if ( ALFA_MORGUE_GetCorpseID( oPC ) == sCorpseID )
      return oPC;
    oPC = GetNextPC();
  }

  return OBJECT_INVALID;
}

void ALFA_CreateItemOnObject( string sItemTemplate, object oTarget=OBJECT_SELF, int nStackSize=1 )
{
  CreateItemOnObject( sItemTemplate, oTarget, nStackSize );
}

