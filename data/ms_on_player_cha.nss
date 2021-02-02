#include "_moonwell01const"
#include "_btb_moonwelluti"

// use this so sparingly!!!
void main()
{
    object oPC = GetPCChatSpeaker();
    if(!GetIsPC(oPC)){
        return;
    }

    string sCommand = GetStringLowerCase(GetPCChatMessage());
    while((sCommand != "") && (GetStringLeft(sCommand, 1) == " ")) {
        sCommand = GetStringRight(sCommand, GetStringLength(sCommand) -1);
    }
    SendMessageToPC(oPC, sCommand);
    SendMessageToPC(oPC, GetStringLeft(sCommand, 10));
    if(GetStringLeft(sCommand, 10) == "high druid") {
        SendMessageToPC(oPC, "you said high druid");
        object obHbObj = GetNearestObjectByTag("moonwell01onhbob", oPC);
        float druidDist = GetDistanceBetween(obHbObj, oPC);
        SendMessageToPC(oPC, "druidDist Dist: " + FloatToString(druidDist));
        if(druidDist > 0.0 && druidDist < 15.0) {
            SetLocalInt(obHbObj, "state", SPAWN_STATE);
            SetLocalObject(obHbObj, "oPC", oPC);

            int state = GetLocalInt(obHbObj, "state");
            WriteTimestampedLogEntry("+++++++++++++++++++++++++++++++++++++++++++++++");
            WriteTimestampedLogEntry("HB Object UUID: " + GetObjectUUID(obHbObj));
            WriteTimestampedLogEntry("State Change From: " + getState(state) +
                                     " To: " + getState(SPAWN_STATE));
        }
    }

}
