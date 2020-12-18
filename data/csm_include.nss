/******************************************************************
 * File: csm_include
 * Name: csm_include
 * Type: Miscellaneous functions
 * ---
 * Author: Modal
 * Date: 4/14/03
 * ---
 * This file contains general-purpose ALFA functions.
 ******************************************************************/

/* Dummy function to compile correctly */
//int StartingConditional() { return 0; }

// Forward declarations due to lack of header wrapping.
void ALFA_MORGUE_DropCorpse(  object oItem );
void Subraces_SafeRemoveEffects( object a_oCreature );

int ALFA_FLAG_PC_ENTERING = 1;
int ALFA_FLAG_PC_LEAVING  = 2;

int ALFA_AREA_DEFAULT     = 0;
int ALFA_AREA_INDOORS     = 1;
int ALFA_AREA_OUTDOORS    = 2;
int ALFA_AREA_UNDERGROUND = 3;

/* List Constants */
string ALFA_LIST_LETTER_ = "ALFA_LIST_LETTER_";

/* ALFA Item Constants */
string ALFA_WAND_PC_NOT_FOUND       = "Not Found";
string ALFA_OBJ_DM_WAND_TAG         = "ALFA_DMWand";
string ALFA_OBJ_XP_WAND_TAG         = "ALFA_XPWand";
string ALFA_OBJ_EMOTE_ITEM_TAG      = "emoteitem";
string ALFA_OBJ_OLDSAP              = "ALFA_Sap";
string ALFA_OBJ_SAP                 = "ALFA_Sap2";
string ALFA_OBJ_BACKPACK            = "alfa_backpack";
string ALFA_OBJ_QUIVER              = "alfa_quiver";
string ALFA_OBJ_SPELLBOOK           = "alfa_spellbook";
string ALFA_OBJ_TRADESCROLL         = "alfa_tradescroll";
string ALFA_OBJ_SCABBARD            = "alfa_scabbard";
string ALFA_OBJ_HIDDEN_POCKET       = "doa_hiddenpocket";
string ALFA_OBJ_SPAWN_BANNER_ROD    = "RodofSpawnBanners";
string ALFA_OBJ_TRANS_TOOL          = "alfa_transtool";
string ALFA_OBJ_XP_ROD_TAG          = "admf_xprod";

/* Realism Constants */
string ALFA_FLAG_REALISM_OFF       = "ALFA_FLAG_REALISM_OFF";
string ALFA_FLAG_REALISM_INIT      = "ALFA_FLAG_REALISM_INIT";

/* Prefix for an NPC indexed on the Area */
string ALFA_OBJ_REALISM_NPC_       = "ALFA_OBJ_REALISM_NPC_";

/* Prefix for an Area indexed on the NPC */
string ALFA_OBJ_REALISM_AREA_      = "ALFA_OBJ_REALISM_AREA_";

/* Number of NPCs on the Area, number of Areas on the NPC */
string ALFA_REALISM_NPC_LIST_MAX   = "ALFA_REALISM_NPC_LIST_MAX";
string ALFA_REALISM_AREA_LIST_MAX  = "ALFA_REALISM_AREA_LIST_MAX";

/* Number of PCs in the Area */
string ALFA_REALISM_PCS_IN_AREA    = "ALFA_REALISM_PCS_IN_AREA";

string REALISM_REGIONS_IN_MODULE   = "REALISM_REGIONS_IN_MODULE";
string REALISM_REGION_INIT         = "REALISM_REGION_INIT";
string REALISM_REGION_             = "REALISM_REGION_";

/* Area initialization flag */
string ALFA_FLAG_REALISM_AREA_INIT = "ALFA_FLAG_REALISM_INIT";

/* Area master flag */
string  ALFA_FLAG_REALISM_MASTER   = "ALFA_FLAG_REALISM_MASTER";

/* Area region (master areas only) */
string ALFA_REALISM_REGION         = "ALFA_REALISM_REGION";

/* NPC's current waypoint */
string ALFA_REALISM_CURR_WAYPT     = "ALFA_REALISM_CURR_WAYPT";

/* NPC's starting location */
string ALFA_REALISM_START_LOC      = "ALFA_REALISM_START_LOC";

/* NPC's last location. Used for un-sticking NPCs. */
string ALFA_REALISM_LAST_LOC       = "ALFA_REALISM_LAST_LOC";

/* Number of ticks NPC's been stuck */
string ALFA_REALISM_STUCK_CNT      = "ALFA_REALISM_STUCK_CNT";

/* Waypoint prefixes */
string ALFA_REALISM_WANDER_PREF    = "WANDER_";
string ALFA_REALISM_REST_PREF      = "REST_";

/* NPC state flags */
string ALFA_FLAG_REALISM_SLEEPING  = "ALFA_FLAG_REALISM_SLEEPING";
string ALFA_FLAG_REALISM_OTW_REST  = "ALFA_FLAG_REALISM_OTW_REST";
string ALFA_FLAG_REALISM_OTW_WAKE  = "ALFA_FLAG_REALISM_OTW_WAKE";

/* NPC behavioral flags */
string ALFA_FLAG_REALISM_WANDER    = "ALFA_FLAG_REALISM_WANDER";
string ALFA_FLAG_REALISM_RANDOM    = "ALFA_FLAG_REALISM_RANDOM";
string ALFA_FLAG_REALISM_DELAY     = "ALFA_FLAG_REALISM_DELAY";
string ALFA_FLAG_REALISM_REST      = "ALFA_FLAG_REALISM_REST";
string ALFA_FLAG_REALISM_NOCT      = "ALFA_FLAG_REALISM_NOCT";
string ALFA_FLAG_REALISM_SPECIAL   = "ALFA_FLAG_REALISM_STATIC";

/* NPC behavioral instructions */
string ALFA_VAL_REALISM_WANDER    = "ALFA_VAL_REALISM_WANDER";
string ALFA_VAL_REALISM_RANDOM    = "ALFA_VAL_REALISM_RANDOM";
string ALFA_VAL_REALISM_DELAY     = "ALFA_VAL_REALISM_DELAY";
string ALFA_VAL_REALISM_REST      = "ALFA_VAL_REALISM_REST";
string ALFA_VAL_REALISM_SPECIAL   = "ALFA_VAL_REALISM_SPECIAL";

/* Waypoint keys */
string REALISM_KEY_REGION    = "REG_";

/* NPC realism tag keys */
string REALISM_KEY_REAL      = "REAL";  // Runs a realism script
string REALISM_KEY_DELAY     = "D";     // Has a custom heartbeat other than 6
string REALISM_KEY_WANDER    = "W";     // Wanders a set of waypoints
string REALISM_KEY_RANDOM    = "N";     // Wanders waypoints RANDOMLY
string REALISM_KEY_REST      = "R";     // Will sleep at night (can set sleeping waypoint);
string REALISM_KEY_SPECIAL   = "S";     // Has a special behavior script
string REALISM_KEY_NOCTURNAL = "L";     // Rests during the DAY

/* Resrefs */
string ALFA_BADVISA_REF            = "alfa_999";

/* Starting Values */
int    ALFA_STARTING_GOLD    = 300;

/* This value is set on the player when a DM uses the wand to 'plink'
 * them to the next value (levels 11+) */
string ALFA_ALLOW_LEVELUP = "ALFA_ALLOW_LEVELUP";

/* Inventory */
void   ALFA_DestroyEquipped( object oTarget, int nDestroyCItems=FALSE );
void   ALFA_DestroyInventory( object oTarget );
void   ALFA_GiveInventory( object oGiver, object oReceiver );
void   ALFA_TakeEquipped( object oTaker, object oVictim );
void   ALFA_TakeInventory( object oTaker, object oVictim );

/* Misc */
void   ALFA_Error( string sErrMsg, int nBroadcast=TRUE );
object ALFA_GetPCByName( string sName );
void   ALFA_RemoveEffects( object oPC );
int    ALFA_IsStringGreaterThan( string sString1, string sString2 );
int    CSM_DestroyObjectInArea( object oItem, object oArea );
void   CSM_UseBeltItem( object oItem );
void   CSM_ApplyLevelLoss( object oPC );

/* List */
void ALFA_LIST_Initialize();


int ALFA_CSM_ItemTagContains( object oItem, string sSearchKey );





        /* added section by Ranoulf - 3/4/03 */

//  Constant from the alfa_portal_incl so it doesn't have to
//  be included - making things faster (an extra 2000 lines of
//  code you can do without ;-)  - it will never change anyways
string  VISANAME            = "ALFA Visa";

//  This function isn't used in the portal scripts anymore, so
//  it made more sense to put it here.
int AP_GetIsVisa    (object oItem ){

    return ( FindSubString(GetName(oItem),VISANAME) >= 0 ) ;

                                            // note: changed to
                                            // '>= 0' to make no drop
                                            // work. - Ranoulf 3-4-02

}

// Return whether or not an item is a death token
int ALFA_GetIsDeathToken( object oItem )
{
    if ( GetTag( oItem ) == "ALFADeathToken" )
        return TRUE;

    return FALSE;
}



/*
 * void ALFA_GiveInventory()
 * ---
 * Give all inventory items to a creature.
 */
void ALFA_GiveInventory( object oGiver, object oReceiver )
{
  object oItem;

  oItem = GetFirstItemInInventory( oGiver );

  while ( oItem != OBJECT_INVALID )
  {
    /* Don't give Visas or Spell-Like Abilities */
    if ( !AP_GetIsVisa( oItem )
      && !ALFA_GetIsDeathToken( oItem )
      && (GetStringLeft( GetTag(oItem), 8 ) != "sei_sla_") )
      AssignCommand( oGiver, ActionGiveItem( oItem, oReceiver ) );
    oItem = GetNextItemInInventory( oGiver );
  }
}




/*
 * void ALFA_TakeInventory()
 * ---
 * Take all non-ALFA inventory items from a PC.
 */
void ALFA_TakeInventory( object oTaker, object oVictim )
{
  object oItem;

  oItem = GetFirstItemInInventory( oVictim );

  while ( oItem != OBJECT_INVALID )
  {
    /* Don't take Visas */
    if ( !AP_GetIsVisa( oItem )
      && !ALFA_GetIsDeathToken( oItem )
      && GetTag( oItem ) != ALFA_OBJ_EMOTE_ITEM_TAG
      && GetTag( oItem ) != ALFA_OBJ_SAP
      && (GetStringLeft( GetTag(oItem), 8 ) != "sei_sla_") )
      AssignCommand( oTaker, ActionTakeItem( oItem, oVictim ) );
    oItem = GetNextItemInInventory( oVictim );
  }
}




/*
 * void ALFA_TakeEquipped()
 * ---
 * Take all equipped items off a creature,
 * except for creature hide/attack items.
 */
void ALFA_TakeEquipped( object oTaker, object oVictim )
{
  object oItem;
  int nSlot;

  for ( nSlot = 0; nSlot <= INVENTORY_SLOT_CARMOUR; nSlot++ )
  {
    if ( nSlot != INVENTORY_SLOT_CARMOUR
      && nSlot != INVENTORY_SLOT_CWEAPON_B
      && nSlot != INVENTORY_SLOT_CWEAPON_L
      && nSlot != INVENTORY_SLOT_CWEAPON_R )
      {
        // Veto untakeable items
        if ( (oItem = GetItemInSlot( nSlot, oVictim )) != OBJECT_INVALID
          && !ALFA_GetIsDeathToken( oItem )
          && !AP_GetIsVisa( oItem )
          && (GetStringLeft( GetTag(oItem), 8 ) != "sei_sla_") )
          AssignCommand( oTaker, ActionTakeItem( oItem, oVictim ) );
      }
  }
}




/*
 * void ALFA_DestroyInventory()
 * ---
 * Nuke a creature's inventory, but does not destroy
 * racial abilities or any ALFA-centric items.
 */
void ALFA_DestroyInventory( object oTarget )
{
  object oItem;

  oItem = GetFirstItemInInventory( oTarget );

  while ( oItem != OBJECT_INVALID )
  {
    if ( !AP_GetIsVisa( oItem )
      && !ALFA_GetIsDeathToken( oItem )
      && (GetStringLeft( GetTag(oItem), 8 ) != "sei_sla_")
      && GetTag( oItem ) != "bedroll"
      && GetTag( oItem ) != ALFA_OBJ_SAP
      && GetTag( oItem ) != ALFA_OBJ_SPELLBOOK
      && GetTag( oItem ) != ALFA_OBJ_EMOTE_ITEM_TAG
      && GetTag( oItem ) != ALFA_OBJ_HIDDEN_POCKET )
      DestroyObject( oItem );

    oItem = GetNextItemInInventory( oTarget );
  }
}


/*
 * void ALFA_DestroyEquipped()
 * ---
 * Destroy ALL equipped items on a creature,
 * with the option of not including Creature Hide/Attack
 * slots.
 */
void ALFA_DestroyEquipped( object oTarget, int nDestroyCItems=TRUE )
{
  object oItem;
  int nSlot;

  for ( nSlot = 0; nSlot <= INVENTORY_SLOT_CARMOUR; nSlot++ )
  {
    if ( nSlot == INVENTORY_SLOT_CARMOUR
      || nSlot == INVENTORY_SLOT_CWEAPON_B
      || nSlot == INVENTORY_SLOT_CWEAPON_L
      || nSlot == INVENTORY_SLOT_CWEAPON_R )
      {
        if ( nDestroyCItems == TRUE
          && (oItem = GetItemInSlot( nSlot, oTarget )) != OBJECT_INVALID
          && !AP_GetIsVisa( oItem )
          && !ALFA_GetIsDeathToken( oItem )
          && (GetStringLeft( GetTag(oItem), 8 ) != "sei_sla_") )
          DestroyObject( oItem );
      }
    else if ( (oItem = GetItemInSlot( nSlot, oTarget )) != OBJECT_INVALID
      && !AP_GetIsVisa( oItem )
      && !ALFA_GetIsDeathToken( oItem )
      && (GetStringLeft( GetTag(oItem), 8 ) != "sei_sla_") )
      DestroyObject( oItem );
  }
}




/*
 * void ALFA_RemoveEffects()
 * ---
 * Purge ALL effects on a PC.
 */
void ALFA_RemoveEffects( object oPC )
{
  Subraces_SafeRemoveEffects( oPC );
}




/*
 * object ALFA_GetPCByName( string sName )
 * ---
 * Return a pointer to the PC with name sName.
 * This MUST be used instead of GetObjectByTag, as
 * PCs do not have Tags.
 */
object ALFA_GetPCByName( string sName )
{
  object oPC;

  oPC = GetFirstPC();

  while ( oPC != OBJECT_INVALID )
  {
    if ( GetName( oPC ) == sName )
      return oPC;
    oPC = GetNextPC();
  }

  return OBJECT_INVALID;
}





/*
 * void ALFA_Error()
 * ---
 * Log and broadcast an error message.
 */
void ALFA_Error( string sErrMsg, int nBroadcast=TRUE )
{
  sErrMsg = "[ALFA-NWScript] " + sErrMsg;

  WriteTimestampedLogEntry( sErrMsg );
  if ( nBroadcast == TRUE )
    SendMessageToAllDMs( sErrMsg );
}



/*
 * void ALFA_SendMessageToAllPCs()
 * ---
 * Broadcast a message to all PCs
 */
void ALFA_SendMessageToAllPCs( string sMessage )
{
  object oPC = GetFirstPC();

  while ( oPC != OBJECT_INVALID )
  {
    SendMessageToPC( oPC, sMessage );
    oPC = GetNextPC();
  }
}


void ALFA_LIST_Initialize()
{
  object oModule = GetModule();
  SetLocalInt( oModule, ALFA_LIST_LETTER_ + "A",  1 );
  SetLocalInt( oModule, ALFA_LIST_LETTER_ + "B",  2 );
  SetLocalInt( oModule, ALFA_LIST_LETTER_ + "C",  3 );
  SetLocalInt( oModule, ALFA_LIST_LETTER_ + "D",  4 );
  SetLocalInt( oModule, ALFA_LIST_LETTER_ + "E",  5 );
  SetLocalInt( oModule, ALFA_LIST_LETTER_ + "F",  6 );
  SetLocalInt( oModule, ALFA_LIST_LETTER_ + "G",  7 );
  SetLocalInt( oModule, ALFA_LIST_LETTER_ + "H",  8 );
  SetLocalInt( oModule, ALFA_LIST_LETTER_ + "I",  9 );
  SetLocalInt( oModule, ALFA_LIST_LETTER_ + "J", 10 );
  SetLocalInt( oModule, ALFA_LIST_LETTER_ + "K", 11 );
  SetLocalInt( oModule, ALFA_LIST_LETTER_ + "L", 12 );
  SetLocalInt( oModule, ALFA_LIST_LETTER_ + "M", 13 );
  SetLocalInt( oModule, ALFA_LIST_LETTER_ + "N", 14 );
  SetLocalInt( oModule, ALFA_LIST_LETTER_ + "O", 15 );
  SetLocalInt( oModule, ALFA_LIST_LETTER_ + "P", 16 );
  SetLocalInt( oModule, ALFA_LIST_LETTER_ + "Q", 17 );
  SetLocalInt( oModule, ALFA_LIST_LETTER_ + "R", 18 );
  SetLocalInt( oModule, ALFA_LIST_LETTER_ + "S", 19 );
  SetLocalInt( oModule, ALFA_LIST_LETTER_ + "T", 20 );
  SetLocalInt( oModule, ALFA_LIST_LETTER_ + "U", 21 );
  SetLocalInt( oModule, ALFA_LIST_LETTER_ + "V", 22 );
  SetLocalInt( oModule, ALFA_LIST_LETTER_ + "W", 23 );
  SetLocalInt( oModule, ALFA_LIST_LETTER_ + "X", 24 );
  SetLocalInt( oModule, ALFA_LIST_LETTER_ + "Y", 25 );
  SetLocalInt( oModule, ALFA_LIST_LETTER_ + "Z", 26 );
  SetLocalInt( oModule, ALFA_LIST_LETTER_ + " ", 27 );
}

/* Compare sString1 > sString2 */
int ALFA_IsStringGreaterThan( string sString1, string sString2 )
{
  object oModule = GetModule();
  int nLength1 = GetStringLength( sString1 );
  int nLength2 = GetStringLength( sString2 );
  int i, nShortest;
  string sChar1, sChar2;

  if ( nLength1 > nLength2 )
    nShortest = nLength2;
  else
    nShortest = nLength1;

  for ( i = 1; i <= nShortest; i++ )
  {
    sChar1 = GetStringLeft( sString1, 1 );
    sChar2 = GetStringLeft( sString2, 1 );
    sString1 = GetStringRight( sString1, nLength1 - i );
    sString2 = GetStringRight( sString2, nLength2 - i );
    if ( GetLocalInt( oModule, ALFA_LIST_LETTER_ + sChar1 )
       > GetLocalInt( oModule, ALFA_LIST_LETTER_ + sChar2 ) )
      return TRUE;
    else
      return FALSE;
  }

  /* Strings have a matching segment */
  if ( nLength1 > nLength2 )
    return TRUE;
  else
    return FALSE;
}


/*
 * This script assumes that there will, on average,
 * be more non-PC objects in an area than there
 * will be PCs in the overall module.
 */
object ALFA_GetFirstPCInArea( object oArea )
{
  object oPC;

  if ( oArea == OBJECT_INVALID )
    return OBJECT_INVALID;

  oPC = GetFirstPC();

  while ( oPC != OBJECT_INVALID )
  {
    if ( GetArea( oPC ) == oArea )
      return oPC;
    oPC = GetNextPC();
  }

  return OBJECT_INVALID;
}


/*
 * Get an object by explicit indexing; slower,
 * but independent of the Area's current object
 * index pointer.
 */
object ALFA_GetObjectInArea( object oArea, int nIndex )
{
  object oObject = GetFirstObjectInArea( oArea );
  int i = 1;

  while ( i < nIndex && oObject != OBJECT_INVALID )
  {
    oObject = GetNextObjectInArea( oArea );
    i++;
  }

  return oObject;
}


/*
 * int ALFA_GetHighestLevel()
 * ---
 * Determine what a PC's highest level is.
 */
int ALFA_GetHighestLevel( object oPC )
{
  int i;
  int nHighestLevel = 1;
  int nClass, nLevel;

  for ( i = 0; i < 3; i++ )
  {
    nClass = GetClassByPosition( i, oPC );
    nLevel = GetLevelByClass( nClass, oPC );

    if ( nLevel > nHighestLevel )
      nHighestLevel = nLevel;
  }

  return nHighestLevel;
}


int ALFA_CSM_ItemTagContains( object oItem, string sSearchKey )
{
  string sItemName = GetStringUpperCase(GetName(oItem));

  // see if the string is present (-1 returned if not found)
  int iContainsKey = FindSubString(sItemName,sSearchKey);

  if ( iContainsKey >= 0 )
    return TRUE;

  return FALSE;
}


// This function used to check for a DROPPED item vs.
// a BARTERED item. Returns TRUE if successful, FALSE otherwise
int CSM_DestroyObjectInArea( object oItem, object oArea )
{
  object oIncItem = GetFirstObjectInArea(oArea);

  while ( oIncItem != OBJECT_INVALID )
  {
    if ( oIncItem == oItem )
    {
      DestroyObject( oItem );
      return TRUE;
    }
    oIncItem = GetNextObjectInArea(oArea);
  }

  return FALSE;
}


int CSM_AttemptTokenDrop( object oPC, object oItem )
{
  int nWarning = GetLocalInt( oPC, "TOKENDROP_WARN" ) + 1;
  object oArea = GetArea( oPC );

  SetLocalInt( oPC, "TOKENDROP_WARN", nWarning );

  // Flag set in case the item is being bartered
  SetLocalInt( oPC, "DESTROY_ONACQUIRE", TRUE );

  switch ( nWarning )
  {
    case 1:
      SendMessageToPC( oPC, "You cannot get rid of this, and should not try. This is your first warning." );
      CreateItemOnObject( "ablacksymbol", oPC );
      break;
    case 2:
      SendMessageToPC( oPC, "You cannot get rid of this, and should not try. This is your final warning." );
      CreateItemOnObject( "ablacksymbol", oPC );
      break;
    default:
      CreateItemOnObject( "ablacksymbol", oPC );
      DelayCommand( 0.5, BootPC( oPC ) );
      break;
  }

  WriteTimestampedLogEntry( "Player '" + GetPCPlayerName(oPC) + "' using PC '"
                          + GetName(oPC) + "' with CD-Key '" + GetPCPublicCDKey( oPC )
                          + "' attempted to drop death token." );

  // Try to destroy the item
  // Return TRUE if the item has been destroyed
  return CSM_DestroyObjectInArea( oItem, oArea );
}


int CSM_AttemptVisaDrop( object oPC, object oItem )
{
  object oItemPossessor = GetItemPossessor( oItem );
  string sRef = GetResRef( oItem );
  string sName = GetModuleName();
  object oArea = GetArea( oPC );

  int nWarning = GetLocalInt( oPC, "VISADROP_WARN" ) + 1;

  SetLocalInt( oPC, "VISADROP_WARN", nWarning );

  // Flag set in case the item is being bartered
  SetLocalInt( oPC, "DESTROY_ONACQUIRE", TRUE );

  if ( sRef != sName )
  {
    CreateItemOnObject( ALFA_BADVISA_REF, oPC );
  }
  else
  {
    CreateItemOnObject( sName, oPC );

    if( GetObjectType( oItemPossessor ) == OBJECT_TYPE_STORE )
    {
      int iGoldValue = GetGoldPieceValue(oItem);
      if ( iGoldValue > 0 )
      {
        SendMessageToPC( oPC, "You cannot sell this item." );
        AssignCommand( oPC, TakeGoldFromCreature(iGoldValue, oPC, TRUE ));
      }
    }
  }

  // Warning Messages/Boot
  switch ( nWarning )
  {
    case 1:
      SendMessageToPC( oPC, "You cannot get rid of this, and should not try. This is your first warning." );
      break;
    case 2:
      SendMessageToPC( oPC, "You cannot get rid of this, and should not try. This is your final warning." );
      break;
    default:
      DelayCommand( 0.5, BootPC( oPC ) );
      break;
  }

  WriteTimestampedLogEntry( "Player '" + GetPCPlayerName(oPC) + "' using PC '"
                          + GetName(oPC) + "' with CD-Key '" + GetPCPublicCDKey( oPC )
                          + "' attempted to drop Visa." );


  // Try to destroy the item
  if( GetObjectType( oItemPossessor ) == OBJECT_TYPE_STORE )
  {
    DestroyObject( oItem );
    return TRUE;
  }

  // Return TRUE if the item has been destroyed
  return CSM_DestroyObjectInArea( oItem, oArea );
}




int CSM_OnAcquire( object oPC, object oItem )
{
  if ( GetLocalInt( oItem, "DESTROY_ONACQUIRE" ) == TRUE )
  {
    SendMessageToPC( oPC, GetName(oItem) + " crumbles into dust as you touch it." );
    DestroyObject( oItem );
    return TRUE;
  }

  return FALSE;
}


int CSM_OnUnacquire( object oItemLoser, object oItem )
{
  string sItemName = GetStringUpperCase(GetName(oItem));
  string sItemTag = GetStringUpperCase(GetTag(oItem));
  object oItemPossessor = GetItemPossessor( oItem );
  object oArea = GetArea( oItemLoser );

  /* Morgue - Player Corpse Tokens */
  // string ALFA_OBJ_PC_CORPSE_TOKEN_TAG   = "ALFA_PC_CorpseToken";
  // ...stupid lack of wrappers forces use of a literal here.
  if ( GetTag( oItem ) == "ALFA_PC_CorpseToken" )
  {
    ALFA_MORGUE_DropCorpse( oItem );
    return TRUE;
  }

  /* Morgue - Player Death Tokens */
  if ( GetTag( oItem ) == "ALFADeathToken" )
    return CSM_AttemptTokenDrop( oItemLoser, oItem );

  /* Portalling - Visas */
  if ( AP_GetIsVisa( oItem ) )
    return CSM_AttemptVisaDrop( oItemLoser, oItem );


  /* Regular NO-DROP items and Subrace Abilities */
  if ( FindSubString( sItemTag, "_NODD" ) > 0
    || FindSubString( sItemTag, "_NODROP" ) > 0
    || GetStringLeft( GetTag(oItem), 8 ) == "sei_sla_" )
  {
    // Flag set in case the item is being bartered
    SetLocalInt( oItemLoser, "DESTROY_ONACQUIRE", TRUE );

    // Handle stores
    if( GetObjectType( oItemPossessor ) == OBJECT_TYPE_STORE )
    {
      int iGoldValue = GetGoldPieceValue(oItem);
      if ( iGoldValue > 0 )
      {
        SendMessageToPC( oItemLoser, "You cannot sell this item." );
        AssignCommand( oItemLoser, TakeGoldFromCreature(iGoldValue, oItemLoser, TRUE ));
      }
      DestroyObject( oItem );

      return TRUE;
    }
    else
      return CSM_DestroyObjectInArea( oItem, oArea );
  }

  return FALSE;
}


void CSM_ProcessNewPlayer( object oPC )
{
  int nGold = GetGold( oPC );
  object oArea = GetArea( oPC );

  // Wait until the player has been fully initialized
  // by the game
  if ( oArea == OBJECT_INVALID )
  {
    DelayCommand( 0.5, CSM_ProcessNewPlayer( oPC ) );
    return;
  }

  ALFA_DestroyInventory( oPC );

  // Give new PCs a bedroll for the rest system
  if ( GetIsObjectValid( GetItemPossessedBy(oPC,"bedroll") ) == FALSE )
    CreateItemOnObject( "bedroll", oPC );

  GiveGoldToCreature( oPC, ALFA_STARTING_GOLD-nGold );

  SetXP(oPC, 1);
}


void CSM_RemindDMDifficulty( object oDM )
{
  int nDiff = GetGameDifficulty();
  string sDiff;

  if ( nDiff == GAME_DIFFICULTY_CORE_RULES )
    return;

  switch( nDiff )
  {
    case GAME_DIFFICULTY_VERY_EASY:
         sDiff = "Very Easy";
         break;
    case GAME_DIFFICULTY_EASY:
         sDiff = "Easy";
         break;
    case GAME_DIFFICULTY_NORMAL:
         sDiff = "Normal";
         break;
    case GAME_DIFFICULTY_DIFFICULT:
         sDiff = "Difficult";
         break;
    default:
         sDiff = "Invalid";
         break;
  }

  SendMessageToAllDMs( "Game Difficulty has been reset to '" + sDiff + "' by " + GetName(oDM) + "'s entrance." );
  SendMessageToAllDMs( "Please set difficulty to 'Core Rules'!" );

  DelayCommand( 6.0, CSM_RemindDMDifficulty( oDM ) );
}



void CSM_UseBeltItem( object oItem )
{
  string sTag = GetTag( oItem );
  object oPC = GetItemPossessor( oItem );
  object oExtra;

  if ( oPC == OBJECT_INVALID )
    return;

  oExtra = GetFirstItemInInventory( oPC );

  while ( oExtra != OBJECT_INVALID )
  {
    // Destroy an item of the same type as the 'belted' item.
    if ( GetTag( oExtra ) == sTag
      && oExtra != oItem )
    {
      DestroyObject( oExtra );
      return;
    }

    oExtra = GetNextItemInInventory( oPC );
  }

  // 'Belted' item is the last of its kind.
  DestroyObject( oItem );
}

void CSM_SetAreaType( object oArea, int iType )
{
  if ( oArea == OBJECT_INVALID )
  {
    WriteTimestampedLogEntry( "CSM_SetAreaType: Attempted to configure a non-existing area! Please check your spelling!" );
    return;
  }

  switch( iType )
  {
    case 1: // ALFA_AREA_INDOORS
      SetLocalString( oArea, "CSM_Area_Lighting", "INDOORS" );
      break;
    case 2: // ALFA_AREA_OUTDOORS
      SetLocalString( oArea, "CSM_Area_Lighting", "OUTSIDE" );
      break;
    case 3: // ALFA_AREA_UNDERGROUND
      SetLocalString( oArea, "CSM_Area_Lighting", "UNDERGROUND" );
      break;
    default: // ALFA_AREA_DEFAULT
      SetLocalString( oArea, "CSM_Area_Lighting", "DEFAULT" );
      break;
  }
}

int CSM_GetXPForLevel( int iLevel )
{
  int iXP = 0;
  int i;

  for ( i = 0; i < iLevel; i++ )
    iXP += 1000 * i;

  return iXP;
}

/*
 * Function: void CSM_XPInquisition( object oPC )
 * ---
 * Spanish Inquisition-style XP enforcement.
 * If you're (wittingly or unwittingly) exploiting
 * the level/xp bug, you will be punished.
 */
void CSM_XPInquisition( object oPC )
{
  int iLevel = GetHitDice( oPC );
  int iXPToLevel = CSM_GetXPForLevel( iLevel + 1 );
  int iXP = GetXP( oPC );

  if ( iXP > FloatToInt( 1.10 * iXPToLevel ) )
    SetXP( oPC, iXPToLevel );
}



/*
 * Function: void CSM_ApplyLevelLoss( object oPC )
 * ---
 * Permanently drain one level of XP from a player.
 * Note: Yes, it could be ever so slightly more efficient,
 * but it's more readable this way :P.
 */
void CSM_ApplyLevelLoss( object oPC )
{
  int iLevel = GetHitDice( oPC );
  int iPrevLvlXP;
  int iCurrLvlXP;
  int iNewXP;

  // If the PC has gained enough XP for the next level
  // but hasn't yet pushed the button, don't screw him
  // completely :)

  if ( GetXP( oPC ) >= CSM_GetXPForLevel( iLevel + 1 ) )
    iLevel++;
  // Can't drop below Level 1
  else if ( iLevel == 1 )
    return;


  iPrevLvlXP = CSM_GetXPForLevel( iLevel - 1 );
  iCurrLvlXP = CSM_GetXPForLevel( iLevel );

  iNewXP = iPrevLvlXP + FloatToInt( (iCurrLvlXP - iPrevLvlXP) / 2.0 );

 /* Addition by Zelknolf, Aug 26 2007, to let the DMs know what the damages are. */
  int iXP = GetXP( oPC );
  int iDamages = iXP - iNewXP;
  SendMessageToAllDMs("The PC "+GetName(oPC)+" has died, losing "+IntToString(iDamages)+" experience points.");
 /* End of Zelknolf modifications */

  SetXP( oPC, iNewXP );
}



