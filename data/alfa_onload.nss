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
#include "nwnx_events"
//#include "nwnx_webhook_rch"

void OnLoadWebHookNotification() {

    string host = NWNX_Util_GetEnvironmentVariable("NWNX_WEBHOOK_HOST");
    string webhook = NWNX_Util_GetEnvironmentVariable("NWNX_WEBHOOK_DEVELOPER_CHANNEL");

    //NWNX_WebHook_SendWebHookHTTPS("discordapp.com", sPath, sMessage);
    NWNX_WebHook_SendWebHookHTTPS("discordapp.com", webhook, "PLEASE WORK");


    /*struct NWNX_WebHook_Message stMessage;
    stMessage.sUsername = "test";
    stMessage.sText = "test 2";

    string sConstructedMsg = NWNX_WebHook_BuildMessageForWebHook(host, webhook, stMessage);

    WriteTimestampedLogEntry("===========================================");
    WriteTimestampedLogEntry("host: " + host);
    WriteTimestampedLogEntry("webhook: " + webhook);
    WriteTimestampedLogEntry("sConstructedMsg: " + sConstructedMsg);
    WriteTimestampedLogEntry("===========================================");


    NWNX_WebHook_SendWebHookHTTPS(host, webhook, sConstructedMsg); */
}

void main()
{
  NWNX_Events_SubscribeEvent("NWNX_ON_CLIENT_CONNECT_AFTER", "ms_evnt_cli_cona");
  ALFA_OnModuleLoad();

  /**************** Add Custom Code Here ***************/
    msOnLoad();
    OnLoadWebHookNotification();
  /*****************************************************/
}
