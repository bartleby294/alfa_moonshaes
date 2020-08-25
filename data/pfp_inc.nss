/******************************************************************
 * Name:pfp_inc
 * Type: ALFA Modules Include File
 * ---
 * Author: Creslyn
 * Date: 02/27/04
 * ---
 * Contains ALFA Persistent familiar system
 * IMPORTANT: THIS FILE IS A CORE ALFA SCRIPT AND MUST NOT BE
 * MODIFIED EXCEPT THROUGH OFFICIAL ALFA PATCHES!
 ******************************************************************/

#include "alfa_options"
#include "alfa_persist"

// Check hp's and spell castings of a familiar when
// it is summoned, and if appropriate, reduce them
// to what the familiar had when it was unsummoned.
void FamiliarCheck(object oCaster = OBJECT_SELF);

// Determine if oCaster has a new familiar (new type or new name).
int GetIsNewFamiliar(object oCaster, object oFamiliar = OBJECT_SELF);

// Determine if oCaster's familiar is dead (when it
// can be resummoned depends on what you set the
// PFP_PERMANENT_DEATH constant to).
int GetIsFamiliarDead(object oCaster = OBJECT_SELF);

// Handler for taking care of delayed calls to
// DecrementRemainingSpellUses() for eyeball rays on resummon
// * Were problems dealing with the sheer number of castings
//   to decrement with higher level eyeballs (70+).
void DecrementEyeRays(int nRay, int nSpellID, object oEyeball);

// Track usage of a particular spell (nSpellID) cast by
// oCaster's familiar.
void FamiliarTrackSpell(int nSpellID, object oCaster);

// Track the hit points of oCaster's familiar.
void FamiliarTrackHP(object oCaster);

// Track how much damage oMaster's familiar should heal when
// oMaster rests.
void FamiliarHealOnRest(object oMaster);

// Cleanup unused variables on completed rest, or when a new
// familiar is summoned.
void CleanUp(object oPC);

/*******************************************************

    To alter how you store the variables, be it on the
    module or with persistent db calls, or whatever,
    these are the functions to edit. The default is to
    store the variables on the module itself, which
    is persistent for so long as the server remains
    running, but not over server resets or crashes.

    You will find them at the end of this include file.

*******************************************************/

// Wrapper function for getting stored integer variables
int GetPFPInt(string sVariable);

// Wrapper function for setting stored integer variables
void SetPFPInt(string sVariable, int nValue);

// Wrapper function for getting stored string variables
string GetPFPString(string sVariable);

// Wrapper function for setting stored string variables
void SetPFPString(string sVariable, string sValue);

/************************************************/
/*********                           ************/
/*********  FUNCTION IMPLEMENTATION  ************/
/*********                           ************/
/************************************************/

void FamiliarCheck(object oCaster = OBJECT_SELF)
{
 if(GetIsPC(oCaster))
 {
  object oFamiliar = GetAssociate(ASSOCIATE_TYPE_FAMILIAR,oCaster);
  if(!GetIsObjectValid(oFamiliar))
    return;
  // Does the caster have a new familiar (since the last check)?
  // If so, end check.
  if(GetIsNewFamiliar(oCaster,oFamiliar))
    return;
  // Handle hp check, apply damage if necessary
  object oMaster = (GetIsPossessedFamiliar(oFamiliar))
                        ?oFamiliar:oCaster;
  string sPCName = GetName(oCaster);
  string sProfileName = GetPCPlayerName(oMaster);
  int nDamage = GetPFPInt("FamiliarHPDamage_"
                + sProfileName + sPCName);
  if(nDamage)
  {
    // Ensure that a misclick on the rest button will
    // not result in a dead familiar
    if(nDamage >= GetCurrentHitPoints(oFamiliar))
      nDamage = GetCurrentHitPoints(oFamiliar) - 1;
    DelayCommand(0.3,ApplyEffectToObject(DURATION_TYPE_INSTANT,
                    EffectDamage(nDamage),oFamiliar));
  }
// -- BUG -- //
// Bioware screwed up the GetAnimal/FamiliarCreatureType() functions
// Use is switched (use GetAnimal..() to get familiars, and vice versa).
  int nType = GetFamiliarCreatureType(oCaster);
  int nC1, nC2, nC3, nC4, nC5, nC6, nC7, nC8, nC9, nC10;

  switch(nType)
  {
    // Handle the checks for each familiar creature type separately
    case FAMILIAR_CREATURE_TYPE_BAT:
    {
                //SPELLABILITY_GAZE_FEAR 260
                //SPELLABILITY_HOWL_FEAR 269
                nC1 = GetPFPInt("FamiliarSpell_"
                        + IntToString(260) + "_" + sProfileName
                        + sPCName);
                nC2 = GetPFPInt("FamiliarSpell_"
                        + IntToString(269) + "_" + sProfileName
                        + sPCName);
                while(nC1 > 0)
                {
                  DecrementRemainingSpellUses(oFamiliar,260);
                  nC1--;
                }
                while(nC2 > 0)
                {
                  DecrementRemainingSpellUses(oFamiliar,269);
                  nC2--;
                }
    }
    break;

    case FAMILIAR_CREATURE_TYPE_CRAGCAT:  break; // No abilities

    case FAMILIAR_CREATURE_TYPE_HELLHOUND:
    {
                //SPELLABILITY_HELL_HOUND_FIREBREATH 264
                nC1 = GetPFPInt("FamiliarSpell_"
                    + IntToString(264) + "_" + sProfileName
                    + sPCName);
                while(nC1 > 0)
                {
                  DecrementRemainingSpellUses(oFamiliar,264);
                  nC1--;
                }
    }
    break;

    case FAMILIAR_CREATURE_TYPE_IMP:
    {
                //SPELL_INVISIBILITY 90
                nC1 = GetPFPInt("FamiliarSpell_"
                    + IntToString(90) + "_" + sProfileName
                    + sPCName);
                while(nC1 > 0)
                {
                  DecrementRemainingSpellUses(oFamiliar,90);
                  nC1--;
                }
    }
    break;

    case FAMILIAR_CREATURE_TYPE_FIREMEPHIT:
    {
                //SPELLABILITY_BOLT_FIRE 219
                nC1 = GetPFPInt("FamiliarSpell_"
                    + IntToString(219) + "_" + sProfileName
                    + sPCName);
                while(nC1 > 0)
                {
                  DecrementRemainingSpellUses(oFamiliar,219);
                  nC1--;
                }
    }
    break;

    case FAMILIAR_CREATURE_TYPE_ICEMEPHIT:
    {
                //SPELLABILITY_BOLT_COLD 213
                nC1 = GetPFPInt("FamiliarSpell_"
                    + IntToString(213) + "_" + sProfileName
                    + sPCName);
                while(nC1 > 0)
                {
                  DecrementRemainingSpellUses(oFamiliar,213);
                  nC1--;
                }
    }
    break;

    case FAMILIAR_CREATURE_TYPE_PIXIE:
    {
                //SPELL_IMPROVED_INVISIBILITY 88
                nC1 = GetPFPInt("FamiliarSpell_"
                    + IntToString(88) + "_" + sProfileName
                    + sPCName);
                while(nC1 > 0)
                {
                  DecrementRemainingSpellUses(oFamiliar,88);
                  nC1--;
                }
    }
    break;

    case FAMILIAR_CREATURE_TYPE_RAVEN: break; // No abilities

    case FAMILIAR_CREATURE_TYPE_FAIRY_DRAGON:
    {
                //SPELL_IMPROVED_INVISIBILITY 88
                //SPELLABILITY_BOLT_CONFUSE 214
                nC1 = GetPFPInt("FamiliarSpell_"
                    + IntToString(88) + "_" + sProfileName
                    + sPCName);
                nC2 = GetPFPInt("FamiliarSpell_"
                    + IntToString(214) + "_" + sProfileName
                    + sPCName);
                while(nC1 > 0)
                {
                  DecrementRemainingSpellUses(oFamiliar,88);
                  nC1--;
                }
                while(nC2 > 0)
                {
                  DecrementRemainingSpellUses(oFamiliar,214);
                  nC2--;
                }
    }
    break;

    case FAMILIAR_CREATURE_TYPE_PSEUDO_DRAGON:
    {
                //SPELLABILITY_CONE_FIRE 232
                nC1 = GetPFPInt("FamiliarSpell_"
                    + IntToString(232) + "_" + sProfileName
                    + sPCName);
                while(nC1 > 0)
                {
                  DecrementRemainingSpellUses(oFamiliar,232);
                  nC1--;
                }
    }
    break;

    case FAMILIAR_CREATURE_TYPE_EYEBALL:
    {
                //Eyeball Ray 1 710;
                //Eyeball Ray 2 711;
                //Eyeball Ray 4 712;
                //Eyeball Ray 3 SPELLABILITY_BOLT_SLOW 226
                //SPELL_MAGE_ARMOR 102

                // Doesn't gain the following abilities until
                // at an extremely high level (20+)

                //SPELL_COLOR_SPRAY 24
                //SPELLABILITY_BOLT_KNOCKDOWN 220
                //SPELLABILITY_BOLT_DAZE 215
                //SPELLABILITY_GAZE_FEAR 260
                //SPELL_FLAME_LASH 60
                nC1 = GetPFPInt("FamiliarSpell_"
                    + IntToString(710) + "_" + sProfileName
                    + sPCName);
                nC2 = GetPFPInt("FamiliarSpell_"
                    + IntToString(711) + "_" + sProfileName
                    + sPCName);
                nC3 = GetPFPInt("FamiliarSpell_"
                    + IntToString(712) + "_" + sProfileName
                    + sPCName);
                nC4 = GetPFPInt("FamiliarSpell_"
                    + IntToString(226) + "_" + sProfileName
                    + sPCName);
                nC5 = GetPFPInt("FamiliarSpell_"
                    + IntToString(102) + "_" + sProfileName
                    + sPCName);
                nC6 = GetPFPInt("FamiliarSpell_"
                    + IntToString(24) + "_" + sProfileName
                    + sPCName);
                nC7 = GetPFPInt("FamiliarSpell_"
                    + IntToString(220) + "_" + sProfileName
                    + sPCName);
                nC8 = GetPFPInt("FamiliarSpell_"
                    + IntToString(215) + "_" + sProfileName
                    + sPCName);
                nC9 = GetPFPInt("FamiliarSpell_"
                    + IntToString(260) + "_" + sProfileName
                    + sPCName);
                nC10 = GetPFPInt("FamiliarSpell_"
                    + IntToString(60) + "_" + sProfileName
                    + sPCName);

                float fDelay = 0.0;
                int i, nRay, nCasts;
                for(i=1;i<=10;i++)
                {
                  switch(i)
                  {
                    case 1: nRay = 710; nCasts = nC1; break;
                    case 2: nRay = 102; nCasts = nC5; break;
                    case 3: nRay = 711; nCasts = nC2; break;
                    case 4: nRay = 226; nCasts = nC4; break;
                    case 5: nRay = 712; nCasts = nC3; break;
                    case 6: nRay = 24; nCasts = nC6; break;
                    case 7: nRay = 220; nCasts = nC7; break;
                    case 8: nRay = 215; nCasts = nC8; break;
                    case 9: nRay = 260; nCasts = nC9; break;
                    case 10: nRay = 60; nCasts = nC10; break;
                  }
                  // Keep the loops just slightly spaced out. Only
                  // single casts of the last several, so run
                  // immediately after the larger ones are finished
                  DelayCommand(fDelay,DecrementEyeRays(nCasts,nRay,oFamiliar));
                  fDelay = (fDelay < 0.5)?fDelay+0.1:fDelay;
                }
    }
    break;

    case FAMILIAR_CREATURE_TYPE_NONE: break; // Not a familiar
  }
 }
}

/************************************************/

int GetIsNewFamiliar(object oCaster, object oFamiliar = OBJECT_SELF)
{
  object oMaster = (GetIsPossessedFamiliar(oFamiliar))
                        ?oFamiliar:oCaster;
  string sPCName = GetName(oCaster);
  string sProfileName = GetPCPlayerName(oMaster);
  // Check name and type of oFamiliar against the stored variables
  int nOldType = GetPFPInt("FamiliarType_" + sProfileName
                    + sPCName);
  int nNewType = GetFamiliarCreatureType(oCaster);
  string sOldName = GetPFPString("FamiliarName_" + sProfileName
                    + sPCName);
  string sNewName = GetName(oFamiliar);
  // If a new familiar, reset the name, type and spell/ability
  // variables stored
  if(nOldType != nNewType || sOldName != sNewName)
  {
    SetPFPInt("FamiliarType_" + sProfileName + sPCName,nNewType);
    SetPFPString("FamiliarName_" + sProfileName + sPCName,sNewName);
    SetPFPInt("FamiliarHPDamage_" + sProfileName + sPCName,0);
    CleanUp(oFamiliar);
    return TRUE;
  }
  return FALSE;
}

/************************************************/

int GetIsFamiliarDead(object oCaster = OBJECT_SELF)
{
  return GetLocalInt(GetItemPossessedBy(oCaster, "emoteitem"), "FamiliarDead");
}

/************************************************/

void DecrementEyeRays(int nRay, int nSpellID, object oEyeball)
{
  while(nRay > 0)
  {
    DecrementRemainingSpellUses(oEyeball,nSpellID);
    nRay--;
  }
}

/************************************************/

void FamiliarTrackSpell(int nSpellID, object oCaster)
{
  if(GetAssociate(ASSOCIATE_TYPE_FAMILIAR,oCaster) == OBJECT_SELF)
  {
    // Ensure that you're keeping variable names the same regardless of
    // whether or not oMaster is possessing oFamiliar at the time
    object oMaster = (GetIsPossessedFamiliar(OBJECT_SELF))
                        ?OBJECT_SELF:oCaster;
    // Increment tracking variable and store the new value
    string sVar = "FamiliarSpell_" + IntToString(nSpellID) + "_"
                    + GetPCPlayerName(oMaster) + GetName(oCaster);
    int nCasts = GetPFPInt(sVar) + 1;
    SetPFPInt(sVar,nCasts);
  }
}

/************************************************/

void FamiliarTrackHP(object oCaster)
{
// Cant rest while possessing a familiar, so no need
// for the check on whether the familiar is possessed
// for this one conditional.
  if(GetIsObjectValid(OBJECT_SELF) && !GetLocalInt(GetModule(),
    "FamiliarResting_" + GetPCPlayerName(oCaster) + GetName(oCaster)))
  {
    // Ensure that you're keeping variable names the same
    // regardless of whether or not oMaster is possessing
    // oFamiliar at the time
    object oMaster = (GetIsPossessedFamiliar(OBJECT_SELF))
                        ?OBJECT_SELF:oCaster;

    string sVar = "FamiliarHPDamage_" + GetPCPlayerName(oMaster)
                    + GetName(oCaster);
    int nFamDamage = GetMaxHitPoints(OBJECT_SELF)
                    - GetCurrentHitPoints(OBJECT_SELF);
    SetPFPInt(sVar,nFamDamage);
  }
}

/************************************************/

void FamiliarHealOnRest(object oMaster)
{
  string sVar = "FamiliarHPDamage_" + GetPCPlayerName(oMaster)
                + GetName(oMaster);
  int nDamage = GetPFPInt(sVar);
  if(nDamage)
  {
    nDamage -= GetLevelByClass(CLASS_TYPE_WIZARD,oMaster)
                + GetLevelByClass(CLASS_TYPE_SORCERER,oMaster);
    if(nDamage < 0)
      nDamage = 0;
    SetPFPInt(sVar,nDamage);
  }
}

/************************************************/

void CleanUp(object oPC)
{
  if(GetHasFeat(FEAT_SUMMON_FAMILIAR,oPC))
  {
    object oFamiliar = GetAssociate(ASSOCIATE_TYPE_FAMILIAR,oPC);
    object oMaster = (GetIsPossessedFamiliar(oFamiliar))
                        ?oFamiliar:oPC;
    string sPCName = GetName(oPC);
    string sProfileName = GetPCPlayerName(oMaster);
// Note: May want to use DeleteLocalInt() here, depends on how you're
//       handling persistency.
    SetPFPInt("FamiliarSpell_" + IntToString(24)
                + "_" + sProfileName + sPCName,0);
    SetPFPInt("FamiliarSpell_" + IntToString(60)
                + "_" + sProfileName + sPCName,0);
    SetPFPInt("FamiliarSpell_" + IntToString(88)
                + "_" + sProfileName + sPCName,0);
    SetPFPInt("FamiliarSpell_" + IntToString(90)
                + "_" + sProfileName + sPCName,0);
    SetPFPInt("FamiliarSpell_" + IntToString(102)
                + "_" + sProfileName + sPCName,0);
    SetPFPInt("FamiliarSpell_" + IntToString(213)
                + "_" + sProfileName + sPCName,0);
    SetPFPInt("FamiliarSpell_" + IntToString(214)
                + "_" + sProfileName + sPCName,0);
    SetPFPInt("FamiliarSpell_" + IntToString(215)
                + "_" + sProfileName + sPCName,0);
    SetPFPInt("FamiliarSpell_" + IntToString(219)
                + "_" + sProfileName + sPCName,0);
    SetPFPInt("FamiliarSpell_" + IntToString(220)
                + "_" + sProfileName + sPCName,0);
    SetPFPInt("FamiliarSpell_" + IntToString(226)
                + "_" + sProfileName + sPCName,0);
    SetPFPInt("FamiliarSpell_" + IntToString(232)
                + "_" + sProfileName + sPCName,0);
    SetPFPInt("FamiliarSpell_" + IntToString(260)
                + "_" + sProfileName + sPCName,0);
    SetPFPInt("FamiliarSpell_" + IntToString(264)
                + "_" + sProfileName + sPCName,0);
    SetPFPInt("FamiliarSpell_" + IntToString(269)
                + "_" + sProfileName + sPCName,0);
    SetPFPInt("FamiliarSpell_" + IntToString(710)
                + "_" + sProfileName + sPCName,0);
    SetPFPInt("FamiliarSpell_" + IntToString(711)
                + "_" + sProfileName + sPCName,0);
    SetPFPInt("FamiliarSpell_" + IntToString(712)
                + "_" + sProfileName + sPCName,0);
  }
}

/************************************************/

void FamiliarRestCheck(object oMaster)
{
  int nType = GetLastRestEventType();
  if(nType == REST_EVENTTYPE_REST_STARTED)
  {
    if(GetIsObjectValid(GetAssociate(ASSOCIATE_TYPE_FAMILIAR,
                oMaster)))
    {
//!----> do NOT make this a persistent variable! <----!//
      SetLocalInt(GetModule(),"FamiliarResting_"
                + GetPCPlayerName(oMaster) + GetName(oMaster),
                TRUE);
    }
  }
  else if(nType == REST_EVENTTYPE_REST_CANCELLED)
  {
    DeleteLocalInt(GetModule(),"FamiliarResting_"
                + GetPCPlayerName(oMaster) + GetName(oMaster));

    // Problems with familiars not actually having their
    // rest cancelled when the player cancels theirs.
    // Continues to heal, so remove it on a cancelled rest
    if(GetIsObjectValid(GetAssociate(ASSOCIATE_TYPE_FAMILIAR,
                oMaster)))
    {
      DestroyObject(GetAssociate(ASSOCIATE_TYPE_FAMILIAR,
                oMaster));
    }
  }

  else if(nType == REST_EVENTTYPE_REST_FINISHED)
  {
    if(GetHasFeat(FEAT_SUMMON_FAMILIAR,oMaster))
    {
      DeleteLocalInt(GetModule(),"FamiliarResting_"
                + GetPCPlayerName(oMaster) + GetName(oMaster));
      CleanUp(oMaster);
      FamiliarHealOnRest(oMaster);
      DelayCommand(1.0,FamiliarCheck(oMaster));
      if(!PFP_PERMANENT_DEATH)
      {
        if(GetPFPInt("FamiliarDead_"
            + GetPCPlayerName(oMaster) + GetName(oMaster)))
        {
          SetPFPInt("FamiliarDead_"
            + GetPCPlayerName(oMaster) + GetName(oMaster),FALSE);
        }
      }
    }
  }
}

/************************************************/

void FamiliarCheckOnLevelUp(object oMaster)
{
  if(PFP_PERMANENT_DEATH == 1)
  {
    int nWizLvl = GetLevelByClass(CLASS_TYPE_WIZARD,oMaster);
    int nSorcLvl = GetLevelByClass(CLASS_TYPE_SORCERER,oMaster);
    int nOldWiz = GetPFPInt("FamiliarWizLvl_"
                + GetPCPlayerName(oMaster) + GetName(oMaster));
    int nOldSorc = GetPFPInt("FamiliarSorcLvl_"
                + GetPCPlayerName(oMaster) + GetName(oMaster));
    if(nWizLvl > nOldWiz || nSorcLvl > nOldSorc)
    {
      SetPFPInt("FamiliarWizLvl_" + GetPCPlayerName(oMaster)
                + GetName(oMaster),nWizLvl);
      SetPFPInt("FamiliarSorcLvl_" + GetPCPlayerName(oMaster)
                + GetName(oMaster),nWizLvl);
      SetPFPInt("FamiliarDead_" + GetPCPlayerName(oMaster)
                + GetName(oMaster),FALSE);
    }
  }
}

/******************************************************

    Wrapper functions for getting/setting variables

******************************************************/

int GetPFPInt(string sVariable)
{
  return GetLocalInt(GetModule(),sVariable);
}

/************************************************/

void SetPFPInt(string sVariable, int nValue)
{
SetLocalInt(GetModule(),sVariable,nValue);
}

/************************************************/

string GetPFPString(string sVariable)
{
  return GetLocalString(GetModule(),sVariable);
}

/************************************************/

void SetPFPString(string sVariable, string sValue)
{
  SetLocalString(GetModule(),sVariable,sValue);
}

/************************************************/
