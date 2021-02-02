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
  while (oPC != OBJECT_INVALID) {
    if (OBJECT_SELF == GetArea(oPC)){
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

object highDruid = GetNearestObjectByTag("moonwelldruid000");
    object Druid01 = GetNearestObjectByTag("moonwelldruid001");
    object Druid02 = GetNearestObjectByTag("moonwelldruid002");
    object Druid03 = GetNearestObjectByTag("moonwelldruid003");
    object Druid04 = GetNearestObjectByTag("moonwelldruid004");
    object light = GetNearestObjectByTag("alfa_shaftligt6");

int IsDruid(object oObject) {
    if(GetTag(oObject) == "moonwelldruid000"
       || GetTag(oObject) == "moonwelldruid001"
       || GetTag(oObject) == "moonwelldruid002"
       || GetTag(oObject) == "moonwelldruid003"
       || GetTag(oObject) == "moonwelldruid004"
       || GetTag(oObject) == "alfa_shaftligt6") {
        return TRUE;
    }
    return FALSE;
}

void RemoveDruids(object oArea) {
    object oObject = GetFirstObjectInArea(oArea);
    while(GetIsObjectValid(oObject)) {
         // Destroy any objects tagged
         if(IsDruid(oObject)) {
            DestroyObject(oObject);
         }
         oObject = GetNextObjectInArea(oArea);
    }
}

void main()
{
  object oArea = GetArea(OBJECT_SELF);
  object oPC = GetExitingObject();
  int iNumPlayers = 0;

  //remove them from being underwater
  if(GetLocalInt(oPC, "UNDERWATER") == 1){
    ExecuteScript("vg_area_ext");
    SendMessageToPC(oPC, "AreaExit Detected you are underwater "
                            + "and is removing you from the water.");
  }

  //This section is for DMs and Players
  if(GetIsPC(oPC)){
    oPC = GetFirstPC();
    while (oPC != OBJECT_INVALID) {
        if (OBJECT_SELF == GetArea(oPC)) {
            iNumPlayers++;
        }
        oPC = GetNextPC();
    }

    if(iNumPlayers == 0) {
      // Lets check in 9 minutes (540 seconds) if its still empty.
      // If so, we shut off the heartbeats
      DelayCommand(540.00, ShutOffHeartbeat());
      RemoveDruids(oArea);
    }
  }
}
