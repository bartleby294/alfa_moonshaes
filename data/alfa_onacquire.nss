/******************************************************************
 * Name: alfa_onacquire
 * Type: OnAcquireItem
 * ---
 * Author: Modal
 * Date: 08/30/02
 * ---
 * This handles the module OnAcquireItem event.
 * You can add custom code in the appropriate section, as well as
 * in alfa_userdef.
 ******************************************************************/

/* Includes */
#include "alfa_include"

#include "nw_i0_plotwizard"
void main()
{
    // PLOT WIZARD MANAGED CODE BEGINS
    PWSetMinLocalIntAndJournalForItemAcquired("p000state", "p000", 2, "PotionOfCLW", 0);
    // PLOT WIZARD MANAGED CODE ENDS

  ALFA_OnAcquireItem();

  /**************** Add Custom Code Here ***************/

  /*****************************************************/
}
