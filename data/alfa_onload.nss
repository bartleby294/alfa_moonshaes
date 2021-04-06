/******************************************************************
 * Name: alfa_onload
 * Type: OnModuleLoad
 * ---
 * Author: Modal
 * Date: 08/30/02
 * ---
 * This handles the module OnModuleLoad event.
 * You can add custom code in the appropriate section, as well as
 * in alfa_userdef.
 ******************************************************************/

/* Includes */
#include "alfa_include_fix"
#include "ms_on_load"
#include "nwnx_webhook"

void main()
{
  ALFA_OnModuleLoad();

  /**************** Add Custom Code Here ***************/
    msOnLoad();
    string webhook = NWNX_Util_GetEnvironmentVariable("NWNX_WEBHOOK_DEVELOPER_CHANNEL");
    WriteTimestampedLogEntry("===========================================");
    WriteTimestampedLogEntry(webhook);
    WriteTimestampedLogEntry("===========================================");
    NWNX_WebHook_SendWebHookHTTPS("discordapp.com",
        webhook,
        "Module has completed start up.");
  /*****************************************************/
}
