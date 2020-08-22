/******************************************************************
 * Name: alfa_onareaenter
 * Type: OnAreaEnter
 * ---
 * Author: Cereborn
 * Date: 10/24/03
 * ---
 * This handles the module OnAreaEnter event.
 * You can add custom code in the appropriate section
 ******************************************************************/

/* Includes */
//#include "alfa_include"
//#include "spawn_main"


void main()
{
  //ALFA_OnAreaEnter();
  object oArea = GetArea(OBJECT_SELF);
  object oPC = GetEnteringObject();

  int iDice = GetLocalInt(GetModule(), "randomizer");

  /**************** Add Custom Code Here ***************/

  if(GetLocalInt(oArea,"AREA_UNDERWATER")==1 && GetLocalInt(oPC, "UNDERWATER") == 1)
    {
    ExecuteScript("vg_area_enter", OBJECT_SELF);
    }
  else if(GetMaster(oPC)!= OBJECT_INVALID && GetLocalInt(oArea,"AREA_UNDERWATER")==1) ExecuteScript("vg_area_enter", OBJECT_SELF);
  if(GetLocalInt(oArea,"TRAPS")==1)
    {
      ExecuteScript("dbhsc_oe_trapme", OBJECT_SELF);
    }

  int iNewGold = GetGold(oPC);
  if(GetIsPC(oPC) && !GetIsDM(oPC)){
    if ((GetLocalInt(oPC, "alfa_doa_gold") / 500) != (iNewGold/500)) ExecuteScript("alfa_goldencum", oPC);
  }


  SetLocalInt(oArea, "X2_L_WILD_MAGIC", 1);
  /*****************************************************/
}
