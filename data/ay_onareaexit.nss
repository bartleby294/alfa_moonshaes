void recordShutdown() {
    //Record the time that we shut down the heartbeat script so we can determine respawn rate when someone re-enters
    SetLocalInt(OBJECT_SELF, "NESSMinute", GetTimeMinute());
    SetLocalInt(OBJECT_SELF, "NESSHour", GetTimeHour());
    SetLocalInt(OBJECT_SELF, "NESSDay", GetCalendarDay());
    SetLocalInt(OBJECT_SELF, "NESSMonth", GetCalendarMonth());
    SetLocalInt(OBJECT_SELF, "NESSYear", GetCalendarYear());

    SendMessageToAllDMs("Heartbeat shutoff in: " + GetName(OBJECT_SELF));


    SendMessageToAllDMs("Time Values recorded are - ");

    SendMessageToAllDMs("Minute: " + IntToString( GetLocalInt(OBJECT_SELF, "NESSMinute") ) );
    SendMessageToAllDMs("Hour: " + IntToString( GetLocalInt(OBJECT_SELF, "NESSHour") ) );
    SendMessageToAllDMs("Day: " + IntToString( GetLocalInt(OBJECT_SELF, "NESSDay") ) );
    SendMessageToAllDMs("Month: " + IntToString( GetLocalInt(OBJECT_SELF, "NESSMonth") ) );

    SendMessageToAllDMs("...................................................." );
}

void ShutOffHeartbeat(){

  object oPC = GetFirstPC();
  while (oPC != OBJECT_INVALID)
    {
        if (OBJECT_SELF == GetArea(oPC)){
            //There is a PC here now, abort
            //SendMessageToAllDMs("Aborting heartbeat shutoff. " +
            //"Seems like a player came back into the area. " +
            //GetName(OBJECT_SELF));
            return;
        }
        oPC = GetNextPC();
    }

  //cleanup stuff on ground
  ExecuteScript("areacleanup");

  //Set the heartbeat script to blank, turning it off
  SetEventScript(OBJECT_SELF, EVENT_SCRIPT_AREA_ON_HEARTBEAT, "");


  //recordShutdown();
  return;
}

void main()
{
  object oArea = GetArea(OBJECT_SELF);
  object oPC = GetExitingObject();
  int iNumPlayers = 0;

  //remove them from being underwater
  if(GetLocalInt(oPC, "UNDERWATER") == 1){
    ExecuteScript("vg_area_ext");
    SendMessageToPC(oPC, "AreaExit Detected you are underwater and is removing you from the water.");
  }

  //This section is for DMs and Players
  if(GetIsPC(oPC)){
    iNumPlayers = 0;
    oPC = GetFirstPC();
    while (oPC != OBJECT_INVALID)
    {
        if (OBJECT_SELF == GetArea(oPC)){
            iNumPlayers++;
        }
        oPC = GetNextPC();
    }

    SetLocalInt(OBJECT_SELF, "iNumPlayers", iNumPlayers);

    if(iNumPlayers != 0)  //if players still left in the area, do nothing
      return;

    // Lets check in 9 minutes (540 seconds) if its still empty.
    // If so, we shut off the heartbeats
    DelayCommand(540.00, ShutOffHeartbeat());
  }


}
