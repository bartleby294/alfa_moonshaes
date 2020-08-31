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
void MyGetVector(object oPC){
vector vAreaVec; // = GetPosition(oPC);

  vAreaVec = GetPosition(oPC);
  SetCampaignVector("Location", "vAreaVec", vAreaVec, oPC);


}

void main()
{
  //ALFA_OnAreaEnter();
  object oArea = GetArea(OBJECT_SELF);
  object oPC = GetEnteringObject();
  int iFired = GetLocalInt(OBJECT_SELF, "setup");

  //int iDice = GetLocalInt(GetModule(), "randomizer");

  /**************** Add Custom Code Here ***************/
  if(iFired != 1){
    SetLocalInt(oArea, "X2_L_WILD_MAGIC", 1);
    SetLocalInt(OBJECT_SELF, "setup", 1);
  }
  if(GetLocalInt(oArea,"AREA_UNDERWATER")==1 && GetLocalInt(oPC, "UNDERWATER") == 1)
    {
    ExecuteScript("vg_area_enter", OBJECT_SELF);
    }
  else if(GetMaster(oPC)!= OBJECT_INVALID && GetLocalInt(oArea,"AREA_UNDERWATER")==1) ExecuteScript("vg_area_enter", OBJECT_SELF);
  if(GetIsPC(oPC)){
    if(GetLocalInt(oArea,"TRAPS")==1)
    {
      ExecuteScript("dbhsc_oe_trapme", OBJECT_SELF);
    }
  }





  int iNewGold = GetGold(oPC);
  if(GetIsPC(oPC) && !GetIsDM(oPC)){
    if ((GetLocalInt(oPC, "alfa_doa_gold") / 500) != (iNewGold/500)) ExecuteScript("alfa_goldencum", oPC);
  }
  else{
    return;  //everything after is Player only
  }


 /////////////////////////////////////////////////////////////////////////////




  object oModule = GetModule();
  // Make sure each XP trigger has a unique tag so PCs can't double dip xp or lose out on xp from other triggers
  string sTrigTag = GetResRef(oArea);

  if((GetCampaignInt("ExploreXPDB",sTrigTag+GetName(oPC)+"Fired")!=1) && GetIsPC(oPC) && !GetIsDM(oPC) )
    {
    //Base 15xp for exploring a new area
    int iXP = 15; //GetLocalInt(OBJECT_SELF,"ExploreXP");
    GiveXPToCreature(oPC, iXP);
    SendMessageToPC(oPC, "You have gained experience for finding a new area.");

    SetCampaignInt("ExploreXPDB",sTrigTag+GetName(oPC)+"Fired",1);
    }



  SetCampaignInt("Location", "updated", 2, oPC);

  location lLast = GetLocation(oPC);

  SetCampaignLocation("Location", "last", lLast, oPC);


  string sAreaTag = GetTag(oArea);
  SetCampaignString("Location", "Area", sAreaTag, oPC);

  vector vAreaVec; // = GetPosition(oPC);
  DelayCommand(2.0, MyGetVector(oPC) );
 //


  //SetLocalInt(oArea, "X2_L_WILD_MAGIC", 1);
  /*****************************************************/
}
