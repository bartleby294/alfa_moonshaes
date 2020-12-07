/******************************************************************
 * File: mrg_at_sp_rd
 * Name: ALFA Morgue: Spell Raise Dead
 * Type: Conversation (Action Taken)
 * ---
 * Author: Modal
 * Date: 09/06/02
 * ---
 * This script is called when a player uses a Raise Dead scroll
 * or spell to resurrect a dead body.
 ******************************************************************/

#include "mrg_include"

void MORGUE_DMForceRaise( object oPC, string sCorpseID, int nHeal );

void main()
{
  object oCastingPC = GetLastSpellCaster();
  object oCorpse = OBJECT_SELF;
  object oPCDead,
         oRecord = GetObjectByTag( ALFA_OBJ_MORGUE_RECORD_TAG );
  string sCorpseID = GetLocalString( oCorpse, ALFA_PC_CORPSE_ID );
  int nSpell = GetLastSpell();
  int nHeal = FALSE;

  /* Resurrection/Raise Dead Spells only */
  if ( nSpell != SPELL_RESURRECTION && nSpell != SPELL_RAISE_DEAD )
    return;

  /* Resurrected PCs will get healed */
  if ( nSpell == SPELL_RESURRECTION )
    nHeal = TRUE;

  /* Received reports of a bug when a DM casts this spell; we won't
     take any chances here. */
  if ( GetIsDM( oCastingPC ) == TRUE )
  {
    MORGUE_DMForceRaise( oCastingPC, sCorpseID, nHeal );
    DestroyObject( oCorpse );
    return;
  }

  if ( ALFA_MORGUE_GetCorpseDecayed( sCorpseID ) == TRUE )
  {
    SendMessageToPC( oCastingPC, "The corpse has decayed for far too long, and may no longer be raised." );
    return;
  }

  oPCDead = ALFA_MORGUE_GetPCByCorpseID( sCorpseID );

  if ( nSpell == SPELL_RAISE_DEAD )
    SetLocalInt( oRecord, sCorpseID, ALFA_FLAG_PC_RAISED );
  else if ( nSpell == SPELL_RESURRECTION )
    SetLocalInt( oRecord, sCorpseID, ALFA_FLAG_PC_RESURRECTED );

  /* Destroy the corpse */
  DestroyObject( oCorpse );

  /* Is dead PC offline? */
  if ( oPCDead == OBJECT_INVALID )
  {
    SetLocalLocation( oRecord, sCorpseID, GetLocation( oCorpse ) );
    return;
  }

  /* Dead PC is online - proceed! */

  ALFA_MORGUE_RestorePC( oPCDead, nHeal );
  DelayCommand( 1.0, AssignCommand( oPCDead, JumpToLocation(GetLocation(oCorpse)) ) );
}



/*
 * This function overrides the default Resurrect/Raise script
 * if cast by a DM.
 */
void MORGUE_DMForceRaise( object oPC, string sCorpseID, int nHeal )
{
  object oPCDead = ALFA_MORGUE_GetPCByCorpseID( sCorpseID );
  object oCorpse,
         oRecord = GetObjectByTag( ALFA_OBJ_MORGUE_RECORD_TAG );

  if ( nHeal == TRUE )
    SetLocalInt( oRecord, sCorpseID, ALFA_FLAG_PC_RESURRECTED );
  else
    SetLocalInt( oRecord, sCorpseID, ALFA_FLAG_PC_RAISED );

  SetLocalLocation( oRecord, sCorpseID, GetLocation( oPC ) );

  /* Destroy PC's corpse */
  oCorpse = GetLocalObject( oRecord, ALFA_MORGUE_CORPSE_ + sCorpseID );

  if ( oCorpse != OBJECT_INVALID )
    DestroyObject( oCorpse );

  /* Is dead PC offline? */
  if ( oPCDead == OBJECT_INVALID )
  {
    SetLocalLocation( oRecord, sCorpseID, GetLocation( oCorpse ) );
    return;
  }

  /* Dead PC is online - proceed! */
  ALFA_MORGUE_RestorePC( oPCDead, nHeal );
  DelayCommand( 1.0, AssignCommand( oPCDead, JumpToLocation(GetLocation(oCorpse)) ) );
}

