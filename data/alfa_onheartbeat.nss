/******************************************************************
 * Name: alfa_onheartbeat
 * Type: OnHeartbeat
 * ---
 * Author: Modal
 * Date: 08/30/02
 * ---
 * This handles the module OnHeartbeat event.
 * You can add custom code in the appropriate section, as well as
 * in alfa_userdef.
 ******************************************************************/

/* Includes */
#include "alfa_include"

void main()
{
  ALFA_OnHeartbeat();

  /**************** Add Custom Code Here ***************/
  //to force the advancement of time
//put this in your module's OnHeartbeat event
//
//
int iHour = GetTimeHour ();
int iMinute = GetTimeMinute ();
int iSecond = GetTimeSecond ();
int iMillisecond = GetTimeMillisecond();
SetTime(iHour, iMinute, iSecond, iMillisecond);
  /*****************************************************/
}
