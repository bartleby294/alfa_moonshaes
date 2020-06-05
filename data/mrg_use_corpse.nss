/******************************************************************
 * File: mrg_use_corpse
 * Name: ALFA Morgue: Use Corpse
 * Type: OnUsed
 * ---
 * Author: Modal
 * Date: 07/14/02
 * ---
 * This script allows a PC to access the corpse dialog.
 ******************************************************************/

#include "mrg_include"

void main()
{
  object oCorpse = OBJECT_SELF;
  object oPC, oClosePC;
  float distance;
  string sCorpseID = GetLocalString( oCorpse, ALFA_PC_CORPSE_ID );
  string sName;
  int nKey = 0;

  oPC = GetLastUsedBy();

  if ( oPC == OBJECT_INVALID )
    return;

  if ( GetIsInCombat( oPC ) == TRUE )
    return;


  nKey = FindSubString( sCorpseID, "_" );
  sName = GetStringLeft( sCorpseID, nKey );
  SetCustomToken( 16511, sName );
  SetLocalInt( OBJECT_SELF, ALFA_CORPSE_TALKING, TRUE );
  SetLocalObject( oPC, ALFA_CORPSE_TALKING, oCorpse );

  AssignCommand( oPC, ActionStartConversation (oPC, "mrg_corpse", TRUE));
}


