/******************************************************************
 * Name: alfa_onactivate
 * Type: OnActivateItem
 * ---
 * Author: Modal
 * Date: 08/30/02
 * ---
 * This handles the module OnActivateItem event.
 * You can add custom code in the appropriate section, as well as
 * in alfa_userdef.
 ******************************************************************/

/* Includes */
#include "alfa_include_fix"
#include "_mooncustonact"

void writeToLog(string str) {
    string oAreaName = GetName(GetArea(OBJECT_SELF));
    string uuid = GetLocalString(OBJECT_SELF, "uuid");
    WriteTimestampedLogEntry(uuid + " Bandit Camp: " + oAreaName + ": " +  str);
}

void main()
{
  // This adds the moonshaes specific special items ((tents shovels drums etc))
  // otherwise exactly the same as standard
  writeToLog("---------------------");
  writeToLog("MoonshaesCustom");
  writeToLog("---------------------");
  MoonshaesCustom();
  ALFA_OnActivateItem();

  /**************** Add Custom Code Here ***************/
    ExecuteScript("cmk_items", GetItemActivator());
        /* Omega Wand */
    ExecuteScript("omega_onactivate", GetItemActivator());
        /* Luskan DM Ring Quest Variable Editor */
    ExecuteScript("scr_dmringact", GetItemActivator());

        /*Black Riding Horse Bridle */
//    ExecuteScript("scr_horse_black", GetItemActivator());
        /*Brown Riding Horse Bridle */
//    ExecuteScript("scr_horse_brown", GetItemActivator());
        /*Grey Riding Horse Bridle */
//    ExecuteScript("scr_horse_grey", GetItemActivator());
  /*****************************************************/
}
