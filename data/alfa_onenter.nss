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

void main()
{
  ALFA_OnClientEnter();

  /**************** Add Custom Code Here ***************/
   object oPC = GetEnteringObject();

  // If new player move to new player WP
  if(GetLocalInt(oPC, "seenPCBefore") == 0){
    ActionJumpToLocation(GetLocation(
        GetObjectByTag("WP_NEW_PC_START_LOCATION")));
    SetLocalInt(oPC, "seenPCBefore", 1);
  }

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
