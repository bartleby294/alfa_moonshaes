/******************************************************************
 * Name: alfa_include
 * Type: ALFA Modules Include File
 * ---
 * Author: Modal
 * Date: 1/22/03
 * ---
 * Updates
 * Author: Ronan
 * Date: 8/28/06
 * Contains ALFA include files.
 * IMPORTANT: THIS FILE IS A CORE ALFA SCRIPT AND MUST NOT BE
 * MODIFIED EXCEPT THROUGH OFFICIAL ALFA PATCHES!
 ******************************************************************/

//int StartingConditional(){return 0;}

/* Configuration options */
#include "alfa_options"

/* HC Death Functions */
#include "hc_inc_death"
#include "hc_inc_timecheck"

/* Subdual */
#include "alfa_subdual"

/*Morgue */
#include "mrg_include"

/* Constants */
#include "alfa_constants"

/* ALFA and Custom Item Processing */
#include "alfa_items"

/* persistent functions */
#include "alfa_charloc"
#include "sos_include"

/* Spell Tracking system */
#include "alfa_spelltrack"

/* Animal Companions */
#include "ac_include"

/* Familiar Persistency */
#include "pfp_inc"

/* Horse System */
#include "acr_horse_i"

/* Forward declarations */
void ALFA_CheckAnimations(object oPC);
void ALFA_AttemptTokenDrop( object oPC, object oItem );
void ALFA_LostItem( object oItemLoser, object oItem );
void ALFA_RegisterALFAItems();

/*
 * Module OnEquipItem Event
 */
void ALFA_OnEquip()
{
object oItem = GetPCItemLastEquipped();
object oPC = GetPCItemLastEquippedBy();

//Check for the new Gender property
if (GetItemHasItemProperty(oItem,ITEM_PROPERTY_USE_LIMITATION_GENDER))
  {
    itemproperty ipGenderProperty=GetFirstItemProperty(oItem);
    while ((GetIsItemPropertyValid(ipGenderProperty))&&(GetItemPropertyType(ipGenderProperty)!=ITEM_PROPERTY_USE_LIMITATION_GENDER))
    {
      ipGenderProperty=GetNextItemProperty(oItem);
    }
    if (!GetIsItemPropertyValid(ipGenderProperty)) return;
    if (GetItemPropertySubType(ipGenderProperty)!=GetGender(oPC))
    {
      AssignCommand(oPC,ActionUnequipItem(oItem));
      SendMessageToPC(oPC,"You cannot equip that item due to gender differences.");
    }
  }

//Fires the vfx effects for equipment
ExecuteScript("alfa_equiping", oItem);

}

/*
 * Module OnUnEquipItem Event
 */
void ALFA_OnUnequip()
{
object oItem = GetPCItemLastUnequipped();
object oPC = GetPCItemLastUnequippedBy();

//Fires the vfx effects for equipment
ExecuteScript("alfa_unequiping", oItem);
ALFA_HorseOnUnequipItem();
}

/*
 * Module OnCutSceneAbort Event
 */
void ALFA_OnCutSceneAbort()
{
object oPC = GetLastPCToCancelCutscene();
}

/*
 * Module OnAcquireItem Event
 */
void ALFA_OnAcquireItem()
{
  object oItem = GetModuleItemAcquired();
  object oPC = GetItemPossessor( oItem );

  // Check for an illegal barter/pickup action
  // Break out if item has been destroyed
  // This will probably be moved into ALFA_AcquireItem() for the next
  // release; gotta get this one out the door...
  if ( CSM_OnAcquire( oPC, oItem ) == TRUE )
    return;

  /* Encumberance system */
    if (!GetIsDM(oPC))
    {
    int iItemStack = GetModuleItemAcquiredStackSize();
    if (iItemStack > 99) ExecuteScript("alfa_goldencum", oPC);
    }

  ALFA_AcquireItem( oItem );
  ALFA_HorseOnAcquireItem();
  SignalEvent( OBJECT_SELF, EventUserDefined(ALFA_EVENT_MODULE_ON_ACQUIRE) );
}


/*
 * Module OnActivateItem Event
 */
void ALFA_OnActivateItem()
{
  object oItem = GetItemActivated();

    // Check for animal companion items, which don't get registered.
  // They are not being registered because they use a part of the tag
  // to identify themselves, and although each could be registered
  // individually, checking for the partial tag means new ones may be
  // added without changing these scripts
  string sItemTag = GetTag(oItem);
  if (GetStringLowerCase(GetStringLeft(sItemTag, 3)) == "ac_")
  {
    AC_OnActivate( oItem );
  }
  else
  {
    ALFA_ActivateItem( oItem );
  }

  SignalEvent( OBJECT_SELF, EventUserDefined( ALFA_EVENT_MODULE_ON_ACTIVATE ) );

  ExecuteScript("alfa_item_act", oItem);

  DeleteLocalInt(GetItemActivator(), "nLoop");

}

/*
 * Module OnPlayerDeath Event
 */
void DetermineSubduedOrDead()
{
  object oPlayer = OBJECT_SELF;
  object oRecord = GetObjectByTag( ALFA_OBJ_MORGUE_RECORD_TAG );
  object oMod = GetModule();
  string sName=GetName(oPlayer);
  string sCDK=GetPCPublicCDKey(oPlayer);
  string sID=sName+sCDK;
  object oKiller = GetLastHostileActor();
  int iPlayerState = GPS(oPlayer);

  // Filter out familiars who have been possessed
  if ( GetIsPC( oPlayer ) == TRUE && GetIsPlayableRacialType( oPlayer ) == FALSE )
    return;

  int nSubdued = ALFA_GetLastDamageSubdual(oKiller, oPlayer);

  if (nSubdued && (iPlayerState == PWS_PLAYER_STATE_ALIVE ||
                   iPlayerState == PWS_PLAYER_STATE_SUBDUED ||
                   iPlayerState == PWS_PLAYER_STATE_STAGGERED))
  {
    //SendMessageToPC(oPlayer, "You should be subdued!");

    // Set to -9 HP.
    ApplyEffectToObject( DURATION_TYPE_INSTANT, EffectResurrection(), oPlayer );
    ApplyEffectToObject( DURATION_TYPE_INSTANT, EffectDamage(10,
        DAMAGE_TYPE_BLUDGEONING), oPlayer );

    // This flag is set for GetLastDamageSubdual() which would otherwise
    // be confused by the damage this routine just 'caused'.  This lets
    // GetLastDamageSubdual() that it was indeed subdual damage.
    SetLocalInt(oPlayer, "ForcedSubdual", TRUE);

    return;
  }


  if ( GetIsPC( oKiller ) == TRUE )
  {
    WriteTimestampedLogEntry( "----------------------------!PLAYER KILLING OCCURRED!--------------------------" );
    WriteTimestampedLogEntry( "Player '" + GetName( oPlayer )
                              + "' was killed by Player '"
                              + GetName( oKiller ) + "'" );
    WriteTimestampedLogEntry( "Killer PLAYER Name: '" + GetPCPlayerName( oPlayer ) +"'" );
    WriteTimestampedLogEntry( "Killer CD Key: '" + GetPCPublicCDKey( oKiller ) + "'" );
    WriteTimestampedLogEntry( "------------------------------------------------------------------------------" );
  }

  ClearAllActions();

  // * Note: waiting for Sophia to make SetStandardFactionReptuation to clear all personal reputation
  if (GetStandardFactionReputation(STANDARD_FACTION_COMMONER, oPlayer) <= 10)
  {
    SetLocalInt(oPlayer, "NW_G_Playerhasbeenbad", 10); // * Player bad
    SetStandardFactionReputation(STANDARD_FACTION_COMMONER, 80, oPlayer);
  }
  if (GetStandardFactionReputation(STANDARD_FACTION_MERCHANT, oPlayer) <= 10)
  {
    SetLocalInt(oPlayer, "NW_G_Playerhasbeenbad", 10); // * Player bad
    SetStandardFactionReputation(STANDARD_FACTION_MERCHANT, 80, oPlayer);
  }
  if (GetStandardFactionReputation(STANDARD_FACTION_DEFENDER, oPlayer) <= 10)
  {
    SetLocalInt(oPlayer, "NW_G_Playerhasbeenbad", 10); // * Player bad
    SetStandardFactionReputation(STANDARD_FACTION_DEFENDER, 80, oPlayer);
  }

  /* Remove bleeding flags */
  SetLocalInt(oMod, "LastRecCheck"+sID, 0);
  SPS(oPlayer, PWS_PLAYER_STATE_DEAD);
  hcDisabledRemove( oPlayer );

  Subraces_SafeRemoveEffects( oPlayer );

 /*
  * If player is already dead (i.e. player was re-killed
  * on the way to the Morgue), ignore.
  */
  if ( GetLocalInt( oRecord, GetName(oPlayer) ) == ALFA_FLAG_PC_DEAD )
    return;

  ALFA_PCDeath( oPlayer );
  SignalEvent( OBJECT_SELF, EventUserDefined(ALFA_EVENT_MODULE_ON_DEATH) );

}

void ALFA_OnPlayerDeath()
{
  object oPC = GetLastPlayerDied();
  ALFA_MountedDying(oPC);
  AssignCommand(oPC, DetermineSubduedOrDead());
  AC_OnPlayerDeath(oPC);
}


/*
 * Module OnPlayerDying Event
 */
void ALFA_OnPlayerDying()
{
  object oPC = GetLastPlayerDying();

  ALFA_MountedDying(oPC);

  // Kill familiars who were possessed.
  if ( GetIsPC( oPC ) == TRUE
    && GetIsPlayableRacialType( oPC ) == FALSE )
  {
    ApplyEffectToObject( DURATION_TYPE_INSTANT, EffectDeath(), oPC );
    return;
  }

  ExecuteScript( "hc_on_ply_dying", OBJECT_SELF );

  SignalEvent( OBJECT_SELF, EventUserDefined(ALFA_EVENT_MODULE_ON_DYING) );
}


/*
 * Module OnClientEnter Event
 */
void ALFA_OnClientEnter()
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
  ALFA_LoadCharacterLocation( oPC );

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
  ALFA_OnHorseOwnerEnter(GetEnteringObject());

  /* Animations and Maneuvers */
  DelayCommand(30.0f, ALFA_CheckAnimations(oPC));

  /* User Defined */
  SignalEvent( OBJECT_SELF, EventUserDefined(ALFA_EVENT_MODULE_ON_ENTER) );
}


/*
 * Module OnHeartbeat Event
 */
void ALFA_OnHeartbeat()
{
  ExecuteScript( "csm_heartbeat", OBJECT_SELF );

  /* Initializing the Persistent Time system */
  if (gALFA_PERSISTENT_TIME) ExecuteScript("alfa_pers_timehb", OBJECT_SELF);

  object oPC = GetFirstPC();
  while(oPC != OBJECT_INVALID) {
    ALFA_HorseOnHeartbeat(oPC);
    oPC = GetNextPC();
  }

  SignalEvent( OBJECT_SELF, EventUserDefined(ALFA_EVENT_MODULE_ON_HEARTBEAT) );
}


/*
 * Module OnClientLeave Event
 */
void ALFA_OnClientLeave()
{
  object oPC = GetExitingObject();
  object oModule = GetModule();
  string sName=GetName(oPC);
  string sCDK=GetPCPublicCDKey(oPC);
  string sID=sName+sCDK;

  /* Prevent player corpses from leaving the module */
  ALFA_MORGUE_CheckCorpseExit( oPC );

  /* Force HP persistence over logouts */
  if( !GetIsDM( oPC ) )
  {
    SetLocalInt(oModule, "LastHP"+sID, GetCurrentHitPoints(oPC));

    // Clear this, so we know to reapply it on login if needed
    SetLocalInt(oModule,"DR_APPLIED"+GetName(oPC)+GetPCPublicCDKey(oPC),FALSE);

  }

  /* Run HCR OnLeave */
  //  This no longer exists
  // ExecuteScript( "hc_on_cl_leave", OBJECT_SELF );

  /* Run 1984 OnLeave */
  ExecuteScript( "alfa_1984_leave", OBJECT_SELF );

  // Horse system
  ALFA_OnHorseOwnerLeave();

  /* User Defined */
  SignalEvent( OBJECT_SELF, EventUserDefined(ALFA_EVENT_MODULE_ON_LEAVE) );
}



/*
 * Module OnPlayerLevelUp Event
 */
void ALFA_OnPlayerLevelUp()
{
  object oPC = GetPCLevellingUp();

  /* Force DM assistance on levels 11+ */
  ExecuteScript( "csm_onlvlup", OBJECT_SELF );

  /* Subraces */
  ExecuteScript( "sei_subracelvlup", OBJECT_SELF );

  /* Animal Companions */
  AC_OnLevelUp(oPC);

  /* Familiar adjustment */
  FamiliarCheckOnLevelUp(oPC);

  /* User Defined */
  SignalEvent( OBJECT_SELF, EventUserDefined(ALFA_EVENT_MODULE_ON_LEVEL_UP) );
}



/*
 * Module OnModuleLoad Event
 */
void ALFA_OnModuleLoad()
{
  ALFA_RegisterALFAItems();

  /* Set up the weather system, if in use */
  ExecuteScript("alfa_weather_sim", OBJECT_SELF);

  /* Set up the spellhook system */
  SetLocalString(GetModule(), "X2_S_UD_SPELLSCRIPT", "alfa_spellhook");

  /* Set up persistent character location saving */
  SOS_Initialize();

  /* Set up the ALFA customized traps */
  ExecuteScript("alfa_traps_load", OBJECT_SELF);

  /* Set up Morgue System */
  object oRecord = GetObjectByTag( ALFA_OBJ_MORGUE_RECORD_TAG );

  if ( ALFA_MORGUE_ENABLED == FALSE )
    SetLocalInt( oRecord, ALFA_MORGUE_DISABLED, TRUE );

  /* Initialize Tokens */
  SetCustomToken( 16510, "\n" );
  ExecuteScript( "csm_at_set_ct", OBJECT_SELF );
  ExecuteScript( "csm_at_set_dt", OBJECT_SELF );

  /* Initialize Subraces */
  ExecuteScript( "sei_subracesinit", OBJECT_SELF );

  /* Initialize Loot Notification System */
  ExecuteScript( "gbl_mod_load", OBJECT_SELF );

  /* Initialize Areas (option) */

  /* Usage: CSM_SetAreaType( GetObjectByTag( "YourAreaName" ), ALFA_AREA_* );
            ALFA_AREA_* must be one of:

                   ALFA_AREA_INDOORS      (aboveground, inside)
                   ALFA_AREA_OUTDOORS     (aboveground, outside)
                   ALFA_AREA_UNDERGROUND  (undeground)
                   ALFA_AREA_DEFAULT      (whatever your module's default is)

     Example: CSM_SetAreaType( GetObjectByTag( "Forest001" ), ALFA_AREA_OUTSIDE );
   */

  /* Initialize ACR */
  SetLocalInt( oMod, "YearStart", GetCalendarYear() );
  SetLocalInt( oMod, "MonthStart", GetCalendarMonth() );
  SetLocalInt( oMod, "DayStart", GetCalendarDay() );
  SetLocalInt( oMod, "HourStart", GetTimeHour() );

  SignalEvent( OBJECT_SELF, EventUserDefined(ALFA_EVENT_MODULE_ON_LOAD) );

  /* Initializing the new HotU constants */
  ExecuteScript("alfa_x2_constant", OBJECT_SELF);

  /* Initializing the Persistent Time system */
  if (gALFA_PERSISTENT_TIME) ExecuteScript("alfa_pers_time", OBJECT_SELF);

  /* Initializing the Encumberance system */
    object oTemp = CreateObject(OBJECT_TYPE_ITEM,"alfa_gold_pouch",GetStartingLocation());
    SetCustomToken(40000, GetStringLeft(GetName(oTemp),6));
    DestroyObject(oTemp);

}



/*
 * Module OnRespawn Event
 */
void ALFA_OnRespawn()
{
  object oRespawner = GetLastRespawnButtonPresser();

  ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectResurrection(),oRespawner);
  ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectHeal(GetMaxHitPoints(oRespawner)), oRespawner);
}


/*
 * Module OnRest Event
 */
void ALFA_OnRest()
{
  object oPC = GetLastPCRested();
  int nRestEvent = GetLastRestEventType();

  /* Subraces */
  ExecuteScript( "sei_onpcrested", OBJECT_SELF );

  /* HCR */
  ExecuteScript( "hc_on_play_rest", OBJECT_SELF );

  /* User Defined */
  SignalEvent( OBJECT_SELF, EventUserDefined(ALFA_EVENT_MODULE_ON_REST) );

  /* Horse System */
  ALFA_MountedRest(oPC);

  /* Spell Tracking System */
  if(nRestEvent == REST_EVENTTYPE_REST_CANCELLED)
    {
    TrackSpellsOnRestCancelled(oPC);
    }
  else if(nRestEvent == REST_EVENTTYPE_REST_FINISHED)
    {
    TrackSpellsOnRestFinished(oPC);
    }

  /* Familiar adjusting*/
  FamiliarRestCheck(GetLastPCRested());
}


/*
 * Module OnUnacquireItem Event
 */
void ALFA_OnUnacquireItem()
{
  object oItemLoser = GetModuleItemLostBy();
  object oItem = GetModuleItemLost();
  int nDestroyed = FALSE;

  /* ACR No-drop Items - handle containers */
  if ( GetHasInventory( oItem ) == TRUE )
  {
    object oInvItem = GetFirstItemInInventory( oItem );
    while ( oInvItem != OBJECT_INVALID )
    {
      if ( CSM_OnUnacquire( oItemLoser, oInvItem ) == TRUE )
        nDestroyed = TRUE;
      oInvItem = GetNextItemInInventory( oItem );
    }
  }

  if ( CSM_OnUnacquire( oItemLoser, oItem ) )
    nDestroyed = TRUE;

  // If the item has been marked as destroyed, break out.
  if ( nDestroyed == TRUE )
    return;

  /* Subraces */
  ExecuteScript( "sei_subracedrop", OBJECT_SELF );

  ALFA_UnacquireItem( oItem );

  // Animal Companions
  AC_OnUnacquire( oItem, oItemLoser );

  /* Encumberance system */
    if (!GetIsDM(oItemLoser))
    {
    string sItemResRef = GetResRef(oItem);
    if (sItemResRef == "nw_it_gold001") ExecuteScript("alfa_goldencum", oItemLoser);
    if (GetBaseItemType(oItem) == BASE_ITEM_LARGEBOX) ExecuteScript("alfa_goldencum", oItemLoser);
    }

  // Horse system.
  ALFA_HorseOnUnacquireItem();

  /* User Defined */
  SignalEvent( OBJECT_SELF, EventUserDefined(ALFA_EVENT_MODULE_ON_UNACQUIRE) );
}

/*
 * Area OnEnter Event
 */
void ALFA_OnAreaEnter()
{
  object oPC = GetEnteringObject();
  ExecuteScript( "alfa_one_weather", oPC );
  SetLocalInt(GetArea(oPC), "X2_L_WILD_MAGIC", TRUE);

  if ( GetIsPC( oPC ) )
  {
    // Determine the area type
    object oCurrArea = OBJECT_SELF;

    if ( GetIsAreaAboveGround( oCurrArea ) )
    {
      if ( GetIsAreaNatural( oCurrArea ) )
      {
        Subraces_OnEnterArea( oPC, SEI_AREA_SUN + SEI_AREA_ABOVEGROUND );
      }

      else
      {
        Subraces_OnEnterArea( oPC, SEI_AREA_DARK + SEI_AREA_ABOVEGROUND );
      }
    }

    else
    {
      Subraces_OnEnterArea( oPC, SEI_AREA_DARK + SEI_AREA_UNDERGROUND );
    }


/*
    // Check for a value already set (for those still using
    // the on_enter subrace scripts)

    string sLighting = GetLocalString( oCurrArea, "CSM_Area_Lighting" );

    if ( GetStringLength( sLighting ) > 0 )
    {
      if ( sLighting == "INDOORS" )
        Subraces_OnEnterArea( oPC, SEI_AREA_DARK + SEI_AREA_ABOVEGROUND );
      else if ( sLighting == "OUTSIDE" )
        Subraces_OnEnterArea( oPC, SEI_AREA_SUN + SEI_AREA_ABOVEGROUND );
      else if ( sLighting == "UNDERGROUND" )
        Subraces_OnEnterArea( oPC, SEI_AREA_DARK + SEI_AREA_UNDERGROUND );
      else
        Subraces_OnEnterArea( oPC );
    }

    // Check for the appropriate area tag
    else
    {
      string sAreaTag = GetStringUpperCase( GetTag( oCurrArea ) );

      if ( FindSubString( sAreaTag, "_IN" ) >= 0 )
        Subraces_OnEnterArea( oPC, SEI_AREA_DARK + SEI_AREA_ABOVEGROUND );
      else if ( FindSubString( sAreaTag, "_OUT" ) >= 0 )
        Subraces_OnEnterArea( oPC, SEI_AREA_SUN + SEI_AREA_ABOVEGROUND );
      else if ( FindSubString( sAreaTag, "_UG" ) >= 0 )
        Subraces_OnEnterArea( oPC, SEI_AREA_DARK + SEI_AREA_UNDERGROUND );
      else
        Subraces_OnEnterArea( oPC );
    }
*/
    //Save the location of the PC
    ALFA_SaveCharacterLocation( GetEnteringObject() );
  }
}

void ALFA_RegisterALFAItems()
{
  //ALFA_RegisterItem(string sItemTag, string sActivateScript="",
  //  string sAcquireScript="", string sUnacquireScript="",
  //  int nNoDrop=FALSE, int nDMOnly=FALSE, int nGiveToDM=FALSE,
  //  int nGiveToPlayer=FALSE);

  ALFA_RegisterItem(ALFA_OBJ_DM_WAND_TAG, "dmw_activate", "", "", TRUE,
     TRUE, TRUE, FALSE);

  ALFA_RegisterItem(ALFA_OBJ_XP_ROD_TAG, "admf_xprod", "", "", TRUE,
     TRUE, TRUE, FALSE);

  ALFA_RegisterItem(ALFA_OBJ_XP_WAND_TAG, "xpw_activate", "", "", TRUE,
     TRUE, TRUE, FALSE);

  ALFA_RegisterItem(ALFA_OBJ_TRANS_TOOL, "alfa_transtool", "", "", TRUE,
     TRUE, TRUE, FALSE);

  ALFA_RegisterItem(ALFA_OBJ_EMOTE_ITEM_TAG, "emote_activ_item", "", "", TRUE,
     FALSE, TRUE, TRUE);

  ALFA_RegisterItem(ALFA_OBJ_HIDDEN_POCKET, "doa_hiddenpocket", "", "", TRUE,
     FALSE, FALSE, TRUE);

  ALFA_RegisterItem(ALFA_OBJ_SPELLBOOK, "alfa_spellbook", "", "", TRUE,
     FALSE, FALSE, TRUE);

  ALFA_RegisterItem(ALFA_OBJ_LANTERN, "hc_on_act_item", "hc_on_acquire_item");
  ALFA_RegisterItem(ALFA_OBJ_HEALKIT, "hc_on_act_item");
  ALFA_RegisterItem(ALFA_OBJ_BANDAGES, "hc_on_act_item");
  ALFA_RegisterItem(ALFA_OBJ_MEDBAG, "hc_on_act_item");
  ALFA_RegisterItem(ALFA_OBJ_ACIDFLASK, "hc_on_act_item");
  ALFA_RegisterItem(ALFA_OBJ_ALCHFIRE, "hc_on_act_item");
  ALFA_RegisterItem(ALFA_OBJ_HOLYWATER, "hc_on_act_item");
  ALFA_RegisterItem(ALFA_OBJ_TANGLE, "hc_on_act_item");
  ALFA_RegisterItem(ALFA_OBJ_THUNDER, "hc_on_act_item");
  ALFA_RegisterItem(ALFA_OBJ_OILFLASK, "hc_on_act_item");
  ALFA_RegisterItem(ALFA_OBJ_CLW_POTION, "hc_on_act_item");
  ALFA_RegisterItem(ALFA_OBJ_CMW_POTION, "hc_on_act_item");
  ALFA_RegisterItem(ALFA_OBJ_CSW_POTION, "hc_on_act_item");
  ALFA_RegisterItem(ALFA_OBJ_CCW_POTION, "hc_on_act_item");
  ALFA_RegisterItem(ALFA_OBJ_SAP, "subdual_toggle");
  ALFA_RegisterItem(ALFA_OBJ_BACKPACK, "alfa_backpack");
  ALFA_RegisterItem(ALFA_OBJ_QUIVER, "alfa_quiver");
  ALFA_RegisterItem(ALFA_OBJ_TRADESCROLL, "alfa_tradescroll");
  ALFA_RegisterItem(ALFA_OBJ_SCABBARD, "alfa_scabbard");
  ALFA_RegisterItem(ALFA_OBJ_SPAWN_BANNER_ROD, "spawnb_sample_ai");
}

void ALFA_InitPuppetMaster( int nSetListening=TRUE )
{
  if ( nSetListening )
  {
    SetListening( OBJECT_SELF, TRUE );
  }

  string sName = GetName(OBJECT_SELF);  //What's my name
  int nSpace = FindSubString(sName, " "); //DO I have a space in my name?
  if (nSpace > -1) // Why yes I do
  {
      //shorten it to just the first name
      sName = GetStringLeft(sName, nSpace);
  }
  // Set myself to listen for any sentence that starts with my name.
  SetListenPattern(OBJECT_SELF, "#" + sName + "**", 16650);
}

void ALFA_CheckAnimations(object oPC)
{
    if(GetIsObjectValid(GetItemInSlot(INVENTORY_SLOT_CARMOUR, oPC)))
    {
        if(!GetHasFeat(3010, oPC)) AddItemProperty(DURATION_TYPE_PERMANENT, ItemPropertyBonusFeat(51), GetItemInSlot(INVENTORY_SLOT_CARMOUR, oPC)); //checking for additional animations I
        if(!GetHasFeat(3011, oPC)) AddItemProperty(DURATION_TYPE_PERMANENT, ItemPropertyBonusFeat(52), GetItemInSlot(INVENTORY_SLOT_CARMOUR, oPC)); //checking for additional animations II
        if(!GetHasFeat(3073, oPC)) AddItemProperty(DURATION_TYPE_PERMANENT, ItemPropertyBonusFeat(58), GetItemInSlot(INVENTORY_SLOT_CARMOUR, oPC)); //checking for ALFA maneuvers
    }
    else
    {
        object oHide = CreateItemOnObject("alfa_pcskin", oPC);
        AssignCommand(oPC, ActionEquipItem(oHide, INVENTORY_SLOT_CARMOUR));
    }
}
