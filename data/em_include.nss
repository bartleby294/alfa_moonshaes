/******************************************************************
 * Name: em_include
 * Type: ALFA Emotes Include File
 * ---
 * Author: ??
 * Date: 9/01/03
 * ---
 * Contains functions used on the ALFA emote wand
 *
 * IMPORTANT: THIS FILE IS A CORE ALFA SCRIPT AND MUST NOT BE
 * MODIFIED EXCEPT THROUGH OFFICIAL ALFA PATCHES!
 ******************************************************************/

/******************************************************************
     Skills we currently support

SKILL_DISABLE_TRAP
SKILL_DISCIPLINE
SKILL_LISTEN
SKILL_LORE
SKILL_OPEN_LOCK
SKILL_PERFORM
SKILL_PERSUADE
SKILL_PICK_POCKET
SKILL_SEARCH
SKILL_SPELLCRAFT
SKILL_SPOT
SKILL_ANIMAL_EMPATHY
SKILL_APPRAISE
SKILL_CONCENTRATION
SKILL_HEAL
SKILL_HIDE
SKILL_MOVE_SILENTLY
SKILL_TAUNT
SKILL_TUMBLE
SKILL_CLIMB
SKILL_SENSE_MOTIVE
SKILL_FORGERY
SKILL_INNUENDO
SKILL_JUMP
SKILL_SWIM
SKILL_RIDE

    And those we don't

(SKILL_CRAFT_TRAP)
(SKILL_PARRY)
(SKILL_SET_TRAP)
(SKILL_USE_MAGIC_DEVICE)
(SKILL_SPEAK_LANGUAGES)

 ******************************************************************/

// Include Files
#include "subraces" // for Subrace_SafeRemoveEffect()

// Constants
const int EMOTE_PUBLIC_ROLL_DISPLAY = 0;
const int EMOTE_NEAREST_DM_DISPLAY = 1;
const int EMOTE_AREA_DMS_DISPLAY = 2;
const int EMOTE_ALL_DMS_DISPLAY = 3;
const string EMOTE_REPORT_TYPE = "EmoteReportType";

// const int ROLL_EFFECT = VFX_DUR_MIRV_ACID; // Too short!
//const int ROLL_EFFECT = VFX_DUR_CESSATE_POSITIVE;
//const int ROLL_EFFECT = VFX_DUR_CESSATE_NEGATIVE;
//const int ROLL_EFFECT_DURATION_TYPE = DURATION_TYPE_TEMPORARY;
//const float ROLL_EFFECT_DURATION = 2.0;

const int ROLL_EFFECT = VFX_COM_BLOOD_LRG_GREEN;
const int ROLL_EFFECT_DURATION_TYPE = DURATION_TYPE_INSTANT;
const float ROLL_EFFECT_DURATION = 0.0;

//const int ROLL_EFFECT = VFX_IMP_MAGIC_RESISTANCE_USE;
//const int ROLL_EFFECT_DURATION_TYPE = DURATION_TYPE_INSTANT;
//const float ROLL_EFFECT_DURATION = 0.0;

// Forward Declarations
void EmoteReport(object oPC, string sReportString);
void EmoteReportPublic(object oPC, string sReportString);
void EmoteReportNearestDM(object oPC, string sReportString);
void EmoteReportAreaDMs(object oPC, string sReportString);
void EmoteReportAllDMs(object oPC, string sReportString);
void PreventRollCheat(object oPC);

void EmoteRollDie(int nValue)
{
  object oPC = GetLastSpeaker();
  int nRoll = Random( nValue ) + 1;
  string sName = GetName(oPC);
  string sRoll = IntToString(nRoll);
  string sValue = IntToString(nValue);
  string sReportString;

  PreventRollCheat(oPC);
  AssignCommand( oPC, ActionPlayAnimation (ANIMATION_LOOPING_GET_MID, 3.0, 3.0));

  sReportString = sName + " rolls a d" + sValue + " and gets a: " + sRoll;
  EmoteReport(oPC, sReportString);
}

void EmoteCheckAbility(int nAbility, string sAbility)
{
  object oPC = GetLastSpeaker();
  int nRoll = d20();
  int nRank = GetAbilityModifier (nAbility, oPC);
  int nResult = nRoll+nRank;
  string sName = GetName(oPC);
  string sRoll = IntToString(nRoll);
  string sRank = IntToString(nRank);
  string sResult = IntToString(nResult);
  string sReportString;

  PreventRollCheat(oPC);
  AssignCommand(oPC, ActionPlayAnimation(ANIMATION_LOOPING_GET_MID, 3.0, 3.0));
  sReportString = sName + "'s " + sAbility + " Check, Roll: " + sRoll +
    " Modifier: " + sRank +" = " + sResult;

  EmoteReport( oPC, sReportString );

}

void EmoteCheckSkill(int nSkill, string sSkill)
{
  object oPC = GetLastSpeaker();
  int nRoll = d20();
  int nRank = GetSkillRank(nSkill, oPC);
  int nResult = nRoll + nRank;
  string sName = GetName(oPC);
  string sRoll = IntToString(nRoll);
  string sRank = IntToString(nRank);
  string sResult = IntToString(nResult);
  string sReportString;

  PreventRollCheat(oPC);
  AssignCommand( oPC, ActionPlayAnimation(ANIMATION_LOOPING_GET_MID, 3.0, 3.0));
  sReportString = sName + "'s " + sSkill + " Check, Roll: " + sRoll +
    " Skill Modifier: " + sRank + " = " + sResult;

  EmoteReport( oPC, sReportString );
}

void EmoteSavingThrow(int nSavingThrow)
{
  object oPC = GetLastSpeaker();

  int nBase;
  int nModifier;
  int nRoll = d20();
  int nResult;
  string sSaveName;

  if ( nSavingThrow == SAVING_THROW_FORT )
  {
    sSaveName = "Fortitude Save";
    nBase = GetFortitudeSavingThrow( oPC );
    nModifier = GetAbilityModifier( ABILITY_CONSTITUTION, oPC );
  }

  else if ( nSavingThrow == SAVING_THROW_REFLEX )
  {
    sSaveName = "Reflex Save";
    nBase = GetReflexSavingThrow( oPC );
    nModifier = GetAbilityModifier( ABILITY_DEXTERITY, oPC );
  }

  else if ( nSavingThrow == SAVING_THROW_WILL )
  {
    sSaveName = "Will Save";
    nBase = GetWillSavingThrow( oPC );
    nModifier = GetAbilityModifier( ABILITY_WISDOM, oPC );
  }

  nResult = nRoll + nBase + nModifier;

  string sName = GetName(oPC);
  string sRoll = IntToString(nRoll);
  string sBase = IntToString(nBase);
  string sModifier = IntToString(nModifier);
  string sResult = IntToString(nResult);
  string sReportString;


  PreventRollCheat(oPC);
  AssignCommand( oPC, ActionPlayAnimation(ANIMATION_LOOPING_GET_MID, 3.0, 3.0));
  sReportString = sName + "'s " + sSaveName + " Check, Roll: " + sRoll +
    " Base Save Bonus: " + sBase + " Ability Modifier: " + sModifier + " = " +
     sResult;

  EmoteReport( oPC, sReportString );


}

void EmoteAutoFollow()
{
  object oSpeaker = GetLastSpeaker();
  object oTarget = GetLocalObject(oSpeaker, "EmoteItemTarget");

  if(GetIsObjectValid(oTarget))
  {
    AssignCommand (oSpeaker, ActionForceFollowObject(oTarget, 5.0f));
  }
}

void EmoteDance()
{
  object oPC=GetLastSpeaker();

  AssignCommand(oPC, ActionPlayAnimation(ANIMATION_FIREFORGET_VICTORY2));
  DelayCommand(3.0, AssignCommand(oPC, ActionPlayAnimation(
    ANIMATION_LOOPING_TALK_LAUGHING, 3.0, 2.0)));
  DelayCommand(5.0, AssignCommand(oPC, ActionPlayAnimation(
    ANIMATION_FIREFORGET_VICTORY1)));
  DelayCommand(8.5, AssignCommand(oPC, ActionPlayAnimation(
    ANIMATION_FIREFORGET_VICTORY3)));
  DelayCommand(11.0, AssignCommand(oPC, ActionPlayAnimation(
    ANIMATION_LOOPING_GET_MID, 3.0, 2.0)));
  DelayCommand(13.0, AssignCommand(oPC, ActionPlayAnimation(
    ANIMATION_FIREFORGET_VICTORY3)));
}

void EmoteDeadFront()
{
  object oPC=GetLastSpeaker();
  AssignCommand(oPC, ActionPlayAnimation(ANIMATION_LOOPING_DEAD_FRONT, 1.0,
    1000.0));
}

void EmoteDrunk()
{
  object oPC=GetLastSpeaker();
  AssignCommand(oPC, ActionPlayAnimation(ANIMATION_LOOPING_PAUSE_DRUNK, 1.0,
    12.0));
}

void EmoteLookFar()
{
  object oPC=GetLastSpeaker();
  AssignCommand(oPC, ActionPlayAnimation(ANIMATION_LOOPING_LOOK_FAR, 1.0,
    6.0));
}

void EmoteMeditate()
{
  object oPC=GetLastSpeaker();
  AssignCommand(oPC, ActionPlayAnimation( ANIMATION_LOOPING_MEDITATE, 1.0,
    1000.0));
}

void EmoteRead()
{
  object oPC=GetLastSpeaker();

  AssignCommand(oPC, ActionPlayAnimation( ANIMATION_FIREFORGET_READ));
  DelayCommand(3.0, AssignCommand(oPC, ActionPlayAnimation(
    ANIMATION_FIREFORGET_READ)));
  DelayCommand(3.0, AssignCommand(oPC, ActionPlayAnimation(
    ANIMATION_FIREFORGET_READ)));
}

void EmoteSit()
{
  object oPC=GetLastSpeaker();
  AssignCommand(oPC, ActionPlayAnimation( ANIMATION_LOOPING_SIT_CROSS, 1.0,
    1000.0));
}

void EmoteSteal()
{
  object oPC=GetLastSpeaker();

  AssignCommand(oPC, ActionPlayAnimation(ANIMATION_FIREFORGET_STEAL));
  DelayCommand(3.0, AssignCommand(oPC, ActionPlayAnimation(
     ANIMATION_LOOPING_GET_MID, 3.0, 2.0)));
}

void EmoteTired()
{
  object oPC=GetLastSpeaker();
  AssignCommand(oPC, ActionPlayAnimation(ANIMATION_LOOPING_PAUSE_TIRED, 1.0,
   6.0));
}

void EmoteWorship()
{
  object oPC=GetLastSpeaker();
  AssignCommand(oPC, ActionPlayAnimation( ANIMATION_LOOPING_WORSHIP, 1.0,
    6.0));
}

void EmoteKnock()
{
  object oPC = GetLastSpeaker();
  PlaySound("as_cv_hammering2");
  AssignCommand(oPC, ActionPlayAnimation(ANIMATION_FIREFORGET_GREETING, 1.0, 1.0));
}

void EmotePickLock()
{
  object oPC = GetLastSpeaker();

  AssignCommand(oPC, ActionPlayAnimation(ANIMATION_LOOPING_GET_MID, 1.0, 1.0));
}

void EmoteTrack()
{
  object oPC = GetLastSpeaker();

  AssignCommand(oPC, ActionPlayAnimation(ANIMATION_LOOPING_GET_LOW, 1.0, 0.5));
  AssignCommand(oPC, ActionPlayAnimation(ANIMATION_FIREFORGET_PAUSE_SCRATCH_HEAD));
}

void EmoteLaugh()
{
  object oPC=GetLastSpeaker();

  AssignCommand(oPC, ActionPlayAnimation(ANIMATION_LOOPING_TALK_LAUGHING, 1.0,
    6.0));
}

void EmotePlead()
{
  object oPC=GetLastSpeaker();

  AssignCommand(oPC, ActionPlayAnimation(ANIMATION_LOOPING_TALK_PLEADING, 1.0,
    6.0));
}

void EmoteSalute()
{
  object oPC = GetLastSpeaker();

  AssignCommand(oPC, ActionPlayAnimation(ANIMATION_FIREFORGET_SALUTE));
}

void EmoteReport(object oPC, string sReportString)
{
  int nReportType = GetLocalInt(oPC, EMOTE_REPORT_TYPE);

  switch (nReportType)
  {
  case EMOTE_PUBLIC_ROLL_DISPLAY:
    EmoteReportPublic(oPC, sReportString);
    break;

  case EMOTE_NEAREST_DM_DISPLAY:
    EmoteReportNearestDM(oPC, sReportString);
    break;

  case EMOTE_AREA_DMS_DISPLAY:
    EmoteReportAreaDMs(oPC, sReportString);
    break;

  case EMOTE_ALL_DMS_DISPLAY:
    EmoteReportAllDMs(oPC, sReportString);
    break;

  default:
    EmoteReportPublic(oPC, sReportString);
    break;
  }
}

void EmoteReportPublic(object oPC, string sReportString)
{
   DelayCommand( 2.0, AssignCommand( oPC, SpeakString(sReportString ) ) );
}

void EmoteReportNearestDM(object oPC, string sReportString)
{
  object oClosest = OBJECT_INVALID;
  float fClosestDistance = 100000.0;
  float fCheckDistance;

  object oOurArea = GetArea( oPC );

  object oCheckPC = GetFirstPC();

  while ( oCheckPC != OBJECT_INVALID )
  {
      if ( GetArea( oCheckPC ) == oOurArea )
      {
          if ( GetIsDM( oCheckPC ) == TRUE )
          {
            // Get distance from oPC to oCheckPC
            fCheckDistance = GetDistanceBetween( oPC, oCheckPC );

            // less that current closest?
            if ( fCheckDistance < fClosestDistance )
            {
              fClosestDistance = fCheckDistance;
              oClosest = oCheckPC;
            }
          }
      }

      oCheckPC = GetNextPC();
  }

  if (oClosest != OBJECT_INVALID)
  {
    SendMessageToPC( oClosest, sReportString );
  }

  SendMessageToPC( oPC, sReportString );

}

void EmoteReportAreaDMs(object oPC, string sReportString)
{
  object oOurArea = GetArea( oPC );

  object oCheckPC = GetFirstPC();

  while ( oCheckPC != OBJECT_INVALID )
  {
      if ( GetArea( oCheckPC ) == oOurArea )
      {
          if ( GetIsDM( oCheckPC ) == TRUE )
          {
            SendMessageToPC( oCheckPC, sReportString );
          }
      }

      oCheckPC = GetNextPC();
  }

  SendMessageToPC( oPC, sReportString );

}

void EmoteReportAllDMs(object oPC, string sReportString)
{
  SendMessageToPC(oPC, sReportString);
  SendMessageToAllDMs(sReportString);
}

void PreventRollCheat(object oPC)
{
  effect ePreventCheat = EffectVisualEffect(ROLL_EFFECT);
  ApplyEffectToObject(ROLL_EFFECT_DURATION_TYPE, ePreventCheat, oPC,
    ROLL_EFFECT_DURATION);

  DelayCommand(3.0, ApplyEffectToObject(ROLL_EFFECT_DURATION_TYPE, ePreventCheat, oPC,
      ROLL_EFFECT_DURATION));
}

void EmoteRemoveGoodEffects()
{
  object oTarget = GetLastSpeaker();
  effect eGood = GetFirstEffect(oTarget);

  //Search for positive effects
  while(GetIsEffectValid(eGood))
  {
    if (GetEffectType(eGood) == EFFECT_TYPE_ABILITY_INCREASE  ||
      GetEffectType(eGood) == EFFECT_TYPE_AC_INCREASE  ||
      GetEffectType(eGood) == EFFECT_TYPE_ATTACK_INCREASE  ||
      GetEffectType(eGood) == EFFECT_TYPE_CONCEALMENT  ||
      GetEffectType(eGood) == EFFECT_TYPE_DAMAGE_IMMUNITY_INCREASE  ||
      GetEffectType(eGood) == EFFECT_TYPE_DAMAGE_INCREASE  ||
      GetEffectType(eGood) == EFFECT_TYPE_DAMAGE_REDUCTION  ||
      GetEffectType(eGood) == EFFECT_TYPE_DAMAGE_RESISTANCE  ||
      GetEffectType(eGood) == EFFECT_TYPE_ELEMENTALSHIELD  ||
      GetEffectType(eGood) == EFFECT_TYPE_ENEMY_ATTACK_BONUS  ||
      GetEffectType(eGood) == EFFECT_TYPE_ETHEREAL  ||
      GetEffectType(eGood) == EFFECT_TYPE_HASTE  ||
      GetEffectType(eGood) == EFFECT_TYPE_IMMUNITY  ||
      GetEffectType(eGood) == EFFECT_TYPE_IMPROVEDINVISIBILITY  ||
      GetEffectType(eGood) == EFFECT_TYPE_INVISIBILITY  ||
      GetEffectType(eGood) == EFFECT_TYPE_INVULNERABLE  ||
      GetEffectType(eGood) == EFFECT_TYPE_MISS_CHANCE  ||
      GetEffectType(eGood) == EFFECT_TYPE_MOVEMENT_SPEED_INCREASE  ||
      GetEffectType(eGood) == EFFECT_TYPE_REGENERATE  ||
      GetEffectType(eGood) == EFFECT_TYPE_SANCTUARY  ||
      GetEffectType(eGood) == EFFECT_TYPE_SAVING_THROW_INCREASE  ||
      GetEffectType(eGood) == EFFECT_TYPE_SEEINVISIBLE  ||
      GetEffectType(eGood) == EFFECT_TYPE_SKILL_INCREASE  ||
      GetEffectType(eGood) == EFFECT_TYPE_SPELL_IMMUNITY  ||
      GetEffectType(eGood) == EFFECT_TYPE_SPELL_RESISTANCE_INCREASE  ||
      GetEffectType(eGood) == EFFECT_TYPE_SPELLLEVELABSORPTION  ||
      GetEffectType(eGood) == EFFECT_TYPE_TEMPORARY_HITPOINTS  ||
      GetEffectType(eGood) == EFFECT_TYPE_TRUESEEING  ||
      GetEffectType(eGood) == EFFECT_TYPE_ULTRAVISION  ||
      GetEffectType(eGood) == EFFECT_TYPE_DISPELMAGICALL ||
      GetEffectType(eGood) == EFFECT_TYPE_DISPELMAGICBEST)
    {
      //Remove effect if it is negative.
      Subraces_SafeRemoveEffect(oTarget, eGood);
    }

    eGood = GetNextEffect(oTarget);
  }
}


