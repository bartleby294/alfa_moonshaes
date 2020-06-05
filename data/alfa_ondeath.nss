/******************************************************************
 * Name: alfa_ondeath
 * Type: OnPlayerDeath
 * ---
 * Author: Modal
 * Date: 08/30/02
 * ---
 * This handles the module OnPlayerDeath event.
 * You can add custom code in the appropriate section, as well as
 * in alfa_userdef.
 ******************************************************************/

/* Includes */
#include "alfa_include"

// This is needed for animal companions to work, and it need to be
// *here* rather than someplace logical, because of Jasperre's AI's
// crappy code.  Hopefully this can be removed when (if!) JAI 1.3
// ever comes out.
#include "x0_inc_henai"

void main()
{
  ALFA_OnPlayerDeath();

  /**************** Add Custom Code Here ***************/

  /*****************************************************/
}


