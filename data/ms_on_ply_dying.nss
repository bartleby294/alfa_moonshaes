//Hardcore Dying
//Bleed's Out at -1.0hp/6 sec
//Archaegeo
//2002 June 24

// This script is used in OnPlayerDying event in Module Properties.  It
// is called if the players hit points drop to 0 to -9.  It sets the
// PlayerState as dying and puts a death amulet on a player to prevent
// them from logging out and back in to get around death effects.  (Note
// that players can get around this in Local Vault environments).

#include "hc_inc_death"
#include "hc_inc_timecheck"

#include "alfa_subdual"
#include "mrg_include"

string DISABLED = "You are now disabled.";
string STAGGERED = "You are now staggered.";

string STABLERECMESSAGE = "The healing you received has stabilized " + "you. Once an hour you will become disabled or remain as you are." + " You are no longer in danger of dying.";
string RECOVERMESSAGE = "You are now recovering " + "and will check once per day for normal healing to resume.";
string DISABLEMESSAGE = "You are now disabled and may take " + "actions as you are able.";
string STABLEMESSAGE = "Your wounds stop bleeding. Once an hour you will start recovery " + "or slip closer to death.";
string SUBDUEDMESSAGE = "You have been subdued.  Once each minute you will have a " + "chance to regain consciousness.";
string STAGGEREDMESSAGE = "You are staggered from subdual damage.";

void DetermineSubduedOrDying(object oMod);

void main()
{
    AssignCommand(GetLastPlayerDying(), DetermineSubduedOrDying(oMod));
}

void DetermineSubduedOrDying(object oMod)
{
    object oPlayer = OBJECT_SELF;
    object oAttacker = GetLastHostileActor(oPlayer);
    int nSubdued;
    int nLoginUnconscious;

    int iPlayerState = GPS(oPlayer);

    // Death/Bleeding in the Morgue is meaningless (Acid bug)
    WriteTimestampedLogEntry("DetermineSubduedOrDying: Started");
    if (GetTag(GetArea(oPlayer)) == ALFA_AREA_MORGUE_TAG
        || GetItemPossessedBy(oPlayer, "ALFADeathToken") != OBJECT_INVALID) {
        WriteTimestampedLogEntry("DetermineSubduedOrDying: Bleeding in the Morge");
        //ApplyEffectToObject( DURATION_TYPE_INSTANT, EffectResurrection(), oPlayer );
        //ApplyEffectToObject( DURATION_TYPE_INSTANT, EffectHeal(GetMaxHitPoints(oPlayer)), oPlayer );
        return;
    }

    //SendMessageToPC(oPlayer, "state = " + IntToString(iPlayerState));

    // If the onDying event is triggered and the player is already in one
    // of these states, this is a login with an unconscious player
    if (iPlayerState == PWS_PLAYER_STATE_DYING
        || iPlayerState == PWS_PLAYER_STATE_STABLE
        || iPlayerState == PWS_PLAYER_STATE_RECOVERY
        || iPlayerState == PWS_PLAYER_STATE_STABLEHEAL
        || iPlayerState == PWS_PLAYER_STATE_SUBDUED) {

        if(GetLocalInt(oPlayer, "hit_zero_this_round") == TRUE) {
            WriteTimestampedLogEntry("DetermineSubduedOrDying: State Check 0");
            SendMessageToPC(oPlayer, "DetermineSubduedOrDying: State Check 0");
            return;
        }

        WriteTimestampedLogEntry("DetermineSubduedOrDying: State Check 1");
        SendMessageToPC(oPlayer, "DetermineSubduedOrDying: State Check 1");
        nLoginUnconscious = TRUE;
        if (iPlayerState == PWS_PLAYER_STATE_SUBDUED) {
            WriteTimestampedLogEntry("DetermineSubduedOrDying: State Check 2");
            SendMessageToPC(oPlayer, "DetermineSubduedOrDying: State Check 2");
            nSubdued = TRUE;
        }
    }

    else {
        WriteTimestampedLogEntry("DetermineSubduedOrDying: State Check 3");
        SendMessageToPC(oPlayer, "DetermineSubduedOrDying: State Check 3");
        nLoginUnconscious = FALSE;
        nSubdued = ALFA_GetLastDamageSubdual(oAttacker, oPlayer);
    }
    WriteTimestampedLogEntry("DetermineSubduedOrDying: State Check 4");
    SendMessageToPC(oPlayer, "DetermineSubduedOrDying: State Check 4");
    // Sets up Heartbeat tracking if anyone enters OnPlayerDying
    int iCurrentHitPoints = GetCurrentHitPoints(oPlayer);
    string sID = GetName(oPlayer) + GetPCPublicCDKey(oPlayer);

    int nAlreadySlowed = GetLocalInt(oMod,
        "DR_APPLIED" + GetName(oPlayer) + GetPCPublicCDKey(oPlayer));

    // iCurrentHitPoints won't be 0 on a login, so no need to check that case...
    if (iCurrentHitPoints == 0
        && GetLocalInt(oPlayer, "hit_zero_this_round") == FALSE) {
        WriteTimestampedLogEntry("DetermineSubduedOrDying: State Check 5");
        SendMessageToPC(oPlayer, "DetermineSubduedOrDying: State Check 5");
        SetLocalInt(oPlayer, "hit_zero_this_round", 1);
        DelayCommand(7.0, SetLocalInt(oPlayer, "hit_zero_this_round", 0));

        if (nSubdued
                &&(iPlayerState == PWS_PLAYER_STATE_ALIVE
                    || iPlayerState == PWS_PLAYER_STATE_STAGGERED)) {
            WriteTimestampedLogEntry("DetermineSubduedOrDying: State Check 6");
            SendMessageToPC(oPlayer, "DetermineSubduedOrDying: State Check 6");
            // They're just staggered
            ALFA_SetLastStateCheckTime(oPlayer, SecondsSinceBegin());
            SPS(oPlayer, PWS_PLAYER_STATE_STAGGERED);
            SendMessageToPC(oPlayer, STAGGEREDMESSAGE);
        }
        else {
            WriteTimestampedLogEntry("DetermineSubduedOrDying: State Check 7");
            SendMessageToPC(oPlayer, "DetermineSubduedOrDying: State Check 7");
            // They're just disabled
            SPS(oPlayer, PWS_PLAYER_STATE_DISABLED);
            SendMessageToPC(oPlayer, DISABLEMESSAGE);
        }

        // need to call disabled setup to get healed back to 1 HP
        hcDisabledSetup(oPlayer);

        if (!nAlreadySlowed) {
            WriteTimestampedLogEntry("DetermineSubduedOrDying: State Check 8");
            SendMessageToPC(oPlayer, "DetermineSubduedOrDying: State Check 8");
            DelayCommand(6.0, ExecuteScript("hc_bleeding", oPlayer));
        }
        return;
    }

    // They're dying or subdued
    if (nAlreadySlowed) {
        WriteTimestampedLogEntry("DetermineSubduedOrDying: State Check 9");
        SendMessageToPC(oPlayer, "DetermineSubduedOrDying: State Check 9");
        hcDisabledRemove(oPlayer);
    }

    if (nSubdued
        && (iPlayerState == PWS_PLAYER_STATE_ALIVE
            || iPlayerState == PWS_PLAYER_STATE_STAGGERED
            || (nLoginUnconscious && (iPlayerState == PWS_PLAYER_STATE_SUBDUED)))) {
        WriteTimestampedLogEntry("DetermineSubduedOrDying: State Check 10");
        SendMessageToPC(oPlayer, "DetermineSubduedOrDying: State Check 10");
        ALFA_SetLastStateCheckTime(oPlayer, SecondsSinceBegin());
        SetLocalInt(oMod, "LastSubHealCheck" + sID, SecondsSinceBegin());
        SendMessageToPC(oPlayer, SUBDUEDMESSAGE);
        SPS(oPlayer, PWS_PLAYER_STATE_SUBDUED);
    }

    else {
        WriteTimestampedLogEntry("DetermineSubduedOrDying: State Check 11");
        SendMessageToPC(oPlayer, "DetermineSubduedOrDying: State Check 11");
        if (nLoginUnconscious) {
            WriteTimestampedLogEntry("DetermineSubduedOrDying: State Check 12");
            SendMessageToPC(oPlayer, "DetermineSubduedOrDying: State Check 12");
            switch (iPlayerState) {
            case 1: // PWS_PLAYER_STATE_DYING
                WriteTimestampedLogEntry("DetermineSubduedOrDying: State Check 13");
                SendMessageToPC(oPlayer, "DetermineSubduedOrDying: State Check 13");
                SendMessageToPC(oPlayer, "You're dying.");
                break;

            case 3: // PWS_PLAYER_STATE_STABLE
                WriteTimestampedLogEntry("DetermineSubduedOrDying: State Check 14");
                SendMessageToPC(oPlayer, "DetermineSubduedOrDying: State Check 14");
                SendMessageToPC(oPlayer, STABLEMESSAGE);
                break;

            case 5: // PWS_PLAYER_STATE_RECOVERY
                WriteTimestampedLogEntry("DetermineSubduedOrDying: State Check 15");
                SendMessageToPC(oPlayer, "DetermineSubduedOrDying: State Check 15");
                SendMessageToPC(oPlayer, RECOVERMESSAGE);
                break;

            case 6: // PWS_PLAYER_STATE_STABLEHEAL
                WriteTimestampedLogEntry("DetermineSubduedOrDying: State Check 16");
                SendMessageToPC(oPlayer, "DetermineSubduedOrDying: State Check 16");
                SendMessageToPC(oPlayer, STABLERECMESSAGE);
                break;
            }
        }

        else {
            WriteTimestampedLogEntry("DetermineSubduedOrDying: State Check 17");
            SendMessageToPC(oPlayer, "DetermineSubduedOrDying: State Check 17");
            SendMessageToPC(oPlayer, "You're dying.");
            SPS(oPlayer, PWS_PLAYER_STATE_DYING);
        }
    }

    // Don't kick off hc_bleeding if in STAGGERED, DISABLED, or RECOVERY state,
    // since it's already running
    if (!nAlreadySlowed) {
        SendMessageToPC(oPlayer, "kicking off hc_bleeding");
        WriteTimestampedLogEntry("kicking off hc_bleeding");
        DelayCommand(6.0, ExecuteScript("hc_bleeding", oPlayer));
    }
}

/* backup.. look in the old acr for a pure version. */
/*
//Hardcore Dying
//Bleed's Out at -1.0hp/6 sec
//Archaegeo
//2002 June 24

// This script is used in OnPlayerDying event in Module Properties.  It
// is called if the players hit points drop to 0 to -9.  It sets the
// PlayerState as dying and puts a death amulet on a player to prevent
// them from logging out and back in to get around death effects.  (Note
// that players can get around this in Local Vault environments).

#include "hc_inc_death"
#include "mrg_include"

string DISABLED = "You are now disabled.";

void main()
{

    object oPlayer=GetLastPlayerDying();

  if ( GetTag( GetArea( oPlayer ) ) == ALFA_AREA_MORGUE_TAG
     || GetItemPossessedBy( oPlayer, "ALFADeathToken" ) != OBJECT_INVALID )
  {
    ApplyEffectToObject( DURATION_TYPE_INSTANT, EffectResurrection(), oPlayer );
    ApplyEffectToObject( DURATION_TYPE_INSTANT, EffectHeal(GetMaxHitPoints(oPlayer)), oPlayer );
    return;
  }


// Sets up Heartbeat tracking if anyone enters OnPlayerDying
    int iCurrentHitPoints = GetCurrentHitPoints( oPlayer );
    string sID = GetName( oPlayer ) + GetPCPublicCDKey( oPlayer );

    if ( iCurrentHitPoints == 0 )
    {
// They're just disabled
        SPS( oPlayer, PWS_PLAYER_STATE_DISABLED);
        effect eHeal = EffectHeal( 1 );

//        SendMessageToPC( oPlayer, "You're disabled at " + IntToString( iCurrentHitPoints ) );

        ApplyEffectToObject( DURATION_TYPE_INSTANT, eHeal, oPlayer);
        SendMessageToPC( oPlayer, DISABLED);
        ApplyEffectToObject( DURATION_TYPE_TEMPORARY, EffectParalyze(), oPlayer, 6.0);
        ExecuteScript("hc_bleeding", oPlayer);
        return;
    }

// They're dying
    SendMessageToPC( oPlayer, "You're dying." );

    if(GPS(oPlayer) != PWS_PLAYER_STATE_RECOVERY)
        SPS(oPlayer, PWS_PLAYER_STATE_DYING);
    DelayCommand(6.0,ExecuteScript("hc_bleeding", oPlayer));
}
*/
