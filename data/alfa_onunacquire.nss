/******************************************************************
 * Name: alfa_onunacquire
 * Type: OnUnAcquireItem
 * ---
 * Author: Modal
 * Date: 08/30/02
 * ---
 * This handles the module OnUnAcquireItem event.
 * You can add custom code in the appropriate section, as well as
 * in alfa_userdef.
 ******************************************************************/

/* Includes */
#include "alfa_include"

void main()
{
  ALFA_OnUnacquireItem();

  /**************** Add Custom Code Here ***************/
    ExecuteScript("cmk_pets_uaq",GetModuleItemLostBy());
  /*****************************************************/
}


