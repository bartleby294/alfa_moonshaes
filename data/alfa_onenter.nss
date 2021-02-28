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
#include "alfa_include_fix"

void main()
{

  object oPC = GetEnteringObject();
  // Create the effect to apply
  //SendMessageToPC(oPC, "FROZEN");
  effect eImmobilize = EffectCutsceneImmobilize();
  ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eImmobilize, oPC, 15.0);
  //ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eImmobilize, oPC, 20.0);
  //DelayCommand(10.0, SendMessageToPC(oPC, "FROZEN FOR 10"));
  //DelayCommand(50.0, SendMessageToPC(oPC, "FROZEN FOR 5"));
  //DelayCommand(20.0, SendMessageToPC(oPC, "FROZEN FOR 0"));

  //SendMessageToPC(oPC, "Before ALFA_OnClientEnter");
  ALFA_OnClientEnter();
  //SendMessageToPC(oPC, "After ALFA_OnClientEnter");

  /**************** Add Custom Code Here ***************/

  // Give DMs an Omega Wand
  if ( GetIsObjectValid(GetItemPossessedBy(oPC, "omega_wand" ))==FALSE
    && GetIsDM(oPC))
    CreateItemOnObject("omega_wand", oPC);

  // Give DMs an Area Transition Tool for Base module
  if ( GetIsObjectValid(GetItemPossessedBy(oPC, "alfa_transtool_b" ))==FALSE
    && GetIsDM(oPC))
    CreateItemOnObject("alfa_transtool_b", oPC);

  /*****************************************************/
}
