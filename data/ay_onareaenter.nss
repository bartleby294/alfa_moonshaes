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


void StartHeartbeat(){

  int iTicks = 0;

  int iMonths = 0;
  int iDays = 0;
  int iHours = 0;
  int iMinute = 0;


  //SendMessageToAllDMs("Restarting heartbeat for " + GetName(OBJECT_SELF) );

  //GetLocalInt(OBJECT_SELF, "NESSMinute", GetTimeMinute());
  //GetLocalInt(OBJECT_SELF, "NESSHour", GetTimeHour());
 //GetLocalInt(OBJECT_SELF, "NESSDay", GetCalendarDay());
  //GetLocalInt(OBJECT_SELF, "NESSMonth", GetCalendarMonth());

  /*SendMessageToAllDMs("Time Values read are - ");

  SendMessageToAllDMs("Minute: " + IntToString( GetLocalInt(OBJECT_SELF, "NESSMinute") ) );
  SendMessageToAllDMs("Hour: " + IntToString( GetLocalInt(OBJECT_SELF, "NESSHour") ) );
  SendMessageToAllDMs("Day: " + IntToString( GetLocalInt(OBJECT_SELF, "NESSDay") ) );
  SendMessageToAllDMs("Month: " + IntToString( GetLocalInt(OBJECT_SELF, "NESSMonth") ) );

  SendMessageToAllDMs("...................................................." );
           */

  /*if( GetCalendarYear() - GetLocalInt(OBJECT_SELF, "NESSYear") > 0)
    iTicks = iTicks + (5256000 * (GetCalendarYear() - GetLocalInt(OBJECT_SELF, "NESSYear")));

  if( GetCalendarMonth() - GetLocalInt(OBJECT_SELF, "NESSMonth") > 0){
    iMonths = GetCalendarMonth() - GetLocalInt(OBJECT_SELF, "NESSMonth");
  }
  else
    iMonths = 12 - GetLocalInt(OBJECT_SELF, "NESSMonth") + GetCalendarMonth();

  iTicks = iTicks + 1440 * 28 * 10 * iMonths;  //1440 minutes per day, 28 days, 10 ticks/heartbeats per minute


  if( GetCalendarDay() - GetLocalInt(OBJECT_SELF, "NESSDay") > 0){
    iDays = GetCalendarDay() - GetLocalInt(OBJECT_SELF, "NESSDay");
  }
  else
    iDays = 28 - GetLocalInt(OBJECT_SELF, "NESSDay") + GetCalendarDay();

  iTicks = iTicks + 1440 * 10 * iDays;  //1440 minutes per day, 10 ticks/heartbeats per minute


  if( GetTimeHour() - GetLocalInt(OBJECT_SELF, "NESSHour") > 0){
    iHours = GetTimeHour() - GetLocalInt(OBJECT_SELF, "NESSHour");
  }
  else
    iHours = 23 - GetLocalInt(OBJECT_SELF, "NESSHour") + GetTimeHour();

  iTicks = iTicks + 60 * 10 * iHours;  //60 minutes per hour, 10 ticks/heartbeats per minute


  if( GetTimeMinute() - GetLocalInt(OBJECT_SELF, "NESSMinute") > 0){
    iMinute = GetTimeMinute() - GetLocalInt(OBJECT_SELF, "NESSMinute");
  }
  else
    iMinute = 59 - GetLocalInt(OBJECT_SELF, "NESSMinute") + GetTimeMinute();

  iTicks = iTicks + 10 * iMinute;  //10 ticks/heartbeats per minute

  */




  SetEventScript(OBJECT_SELF, EVENT_SCRIPT_AREA_ON_HEARTBEAT, "spawn_sample_hb");





}

void WaterCheck(object oArea, object oPC){

  if(GetLocalInt(oArea,"AREA_UNDERWATER")==1 )
    {
    if(GetLocalInt(oPC, "UNDERWATER") == 1){
      SendMessageToPC(oPC, "AreaEnter Detected you are underwater");
      ExecuteScript("vg_area_enter", OBJECT_SELF);
    }
    }
  else if(GetMaster(oPC)!= OBJECT_INVALID && GetLocalInt(oArea,"AREA_UNDERWATER")==1){
    SendMessageToPC(oPC, "AreaEnter associate Detected you are underwater");
    ExecuteScript("vg_area_enter", OBJECT_SELF);
  }

}



void main()
{

  object oArea = GetArea(OBJECT_SELF);
  object oPC = GetEnteringObject();
  int iFired = GetLocalInt(OBJECT_SELF, "setup");
  int iNumPlayers = 0;

  /**************** This section fires for all players, NPCs, and DMs***************/
  if(iFired != 1){
    SetLocalInt(oArea, "X2_L_WILD_MAGIC", 1);
    SetLocalInt(OBJECT_SELF, "setup", 1);
  }

  //SendMessageToPC(oPC, "All NPCs/PCs");

  WaterCheck(oArea, oPC);






  if(!GetIsPC(oPC)){

    return;
  }

  /**************** This section fires for all players, and DMs***************/


  //SendMessageToPC(oPC, "Player and DM section.");






  SetLocalInt(oArea, "LagBustInit", 42);
  //Track number of players in the area
  iNumPlayers = 0;
  while (oPC != OBJECT_INVALID)
  {
    if (OBJECT_SELF == GetArea(oPC)){

      iNumPlayers++;

      }
    oPC = GetNextPC();
  }
  SetLocalInt(OBJECT_SELF, "iNumPlayers", iNumPlayers);

  oPC = GetEnteringObject();      //reset oPC back to the original entry person
  //SendMessageToAllDMs("Entry detected.  Number of Players in " + GetName(OBJECT_SELF) + ": " + IntToString(iNumPlayers));

  if(iNumPlayers >= 1){
    if(GetEventScript(OBJECT_SELF, EVENT_SCRIPT_AREA_ON_HEARTBEAT) == ""){
      StartHeartbeat();
    }
    /*else{
      SendMessageToAllDMs("At least one player detected, but script was still assigned.  Quick re-entry?");
    } */
  }

//SendMessageToPC(oPC, "Before traps.");



  if(GetLocalInt(oArea, "TRAPS") == 1){
    ExecuteScript("dbhsc_oe_trapme", OBJECT_SELF);
  }

//SendMessageToPC(oPC, "After traps.");


  if(GetIsDM(oPC)){
   //SendMessageToPC(oPC, "DM detected.  Stopping here.");
    return;

  }

  /**************** This section fires for ONLY Player characters***************/

  //SendMessageToPC(oPC, "Player only section.");

  //Gold encumberance
  int iNewGold = GetGold(oPC);
  if ((GetLocalInt(oPC, "alfa_doa_gold") / 500) != (iNewGold/500)) ExecuteScript("alfa_goldencum", oPC);





  //New area exploration XP
  object oModule = GetModule();
  string sTrigTag = GetResRef(oArea);

   if((GetCampaignInt("ExploreXPDB",sTrigTag+GetName(oPC)+"Fired")!=1) && GetIsPC(oPC) && !GetIsDM(oPC) )
    {
    //Base 15xp for exploring a new area
    int iXP = 15;

    SendMessageToPC(oPC, "You have gained experience for finding a new area.");

    SetCampaignInt("ExploreXPDB",sTrigTag+GetName(oPC)+"Fired",1);
    }



  //Location tracking

  SetCampaignInt("Location", "updated", 2, oPC);

  location lLast = GetLocation(oPC);

  SetCampaignLocation("Location", "last", lLast, oPC);

  string sAreaTag = GetTag(oArea);
  SetCampaignString("Location", "Area", sAreaTag, oPC);

  vector vAreaVec;
  DelayCommand(2.0, MyGetVector(oPC) );



}
