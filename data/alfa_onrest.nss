/******************************************************************
 * Name: alfa_onrest
 * Type: OnPlayerRest
 * ---
 * Author: Modal
 * Date: 08/30/02
 * ---
 * This handles the module OnPlayerRest event.
 * You can add custom code in the appropriate section, as well as
 * in alfa_userdef.
 ******************************************************************/

/* Includes */
#include "alfa_include"
#include "ms_onrest"

void main()
{
    object oPC = GetLastPCRested();
    if(RestingAllowed(oPC) == FALSE) {
        if(GetLastRestEventType() == REST_EVENTTYPE_REST_STARTED) {
            SendMessageToPC(oPC, "This doesn't seem like a good place to rest.");
        }
        AssignCommand( oPC, ClearAllActions());
        return;
    }

    SetRestAnimation(oPC);
    ALFA_OnRest();

    /**************** Add Custom Code Here ***************/
    ExecuteScript("cmk_herbsleep", GetItemActivator());
    RestHazards(oPC);
    RestPerks(oPC);
    /*****************************************************/
}
