/******************************************************************
 * Name: alfa_onuserdef
 * Type: OnUserDefined
 * ---
 * Author: Modal
 * Date: 08/30/02
 * ---
 * This handles the module OnUserDefined event. Simply add your
 * functionality in the appropriate section.
 ******************************************************************/

/* Includes */
#include "alfa_include"

void main()
{
  int nUser = GetUserDefinedEventNumber();

  /* OnAcquireItem Module Event */
  if ( nUser == ALFA_EVENT_MODULE_ON_ACQUIRE )
  {
  }

  /* OnItemActivated Module Event */
  else if ( nUser == ALFA_EVENT_MODULE_ON_ACTIVATE )
  {
  }

  /* OnPlayerDeath Module Event */
  else if ( nUser == ALFA_EVENT_MODULE_ON_DEATH )
  {
  }

  /* OnPlayerDying Module Event */
  else if ( nUser == ALFA_EVENT_MODULE_ON_DYING )
  {
  }

  /* OnClientEnter Module Event */
  else if ( nUser == ALFA_EVENT_MODULE_ON_ENTER )
  {
  }

  /* OnHeartbeat Module Event */
  else if ( nUser == ALFA_EVENT_MODULE_ON_HEARTBEAT )
  {
  }

  /* OnClientLeave Module Event */
  else if ( nUser == ALFA_EVENT_MODULE_ON_LEAVE )
  {
  }

  /* OnPlayerLevelUp Module Event */
  else if ( nUser == ALFA_EVENT_MODULE_ON_LEVEL_UP )
  {
  }

  /* OnModuleLoad Module Event */
  else if ( nUser == ALFA_EVENT_MODULE_ON_LOAD )
  {
  }

  /* OnPlayerRest Module Event */
  else if ( nUser == ALFA_EVENT_MODULE_ON_REST )
  {
  }

  /* OnUnacquireItem Module Event */
  else if ( nUser == ALFA_EVENT_MODULE_ON_UNACQUIRE )
  {
  }

  /* Invalid Event Signalled */
  else
    return;
}
