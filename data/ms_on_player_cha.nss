#include "_btb_moonwellcon"
#include "_btb_moonwelluti"
#include "nwnx_time"

void callDruid(object oPC) {
    string sCommand = GetStringLowerCase(GetPCChatMessage());
    while((sCommand != "") && (GetStringLeft(sCommand, 1) == " ")) {
        sCommand = GetStringRight(sCommand, GetStringLength(sCommand) -1);
    }
    //SendMessageToPC(oPC, sCommand);
    //SendMessageToPC(oPC, GetStringLeft(sCommand, 10));
    if(GetStringLeft(sCommand, 10) == "high druid") {
        //SendMessageToPC(oPC, "you said high druid");
        object obHbObj = GetNearestObjectByTag("moonwell01onhbob", oPC);
        float druidDist = GetDistanceBetween(obHbObj, oPC);
        int state = GetLocalInt(obHbObj, "state");
        WriteTimestampedLogEntry("Called Druid: State Change From: " + getState(state) +
                                     " To: " + getState(SPAWN_STATE));
        //SendMessageToPC(oPC, "druidDist Dist: " + FloatToString(druidDist));
        if(druidDist > 0.0 && druidDist < 15.0) {
            if(!GetIsPC(oPC) || state == DM_DISABLED_STATE
                || state == ATTACKING_STATE){
                return;
            }

            int lastCall = GetLocalInt(obHbObj, "lastCall");
            if(NWNX_Time_GetTimeStamp() - lastCall < HIGHDRUID_DELAY) {
                SpeakString("Patience");
                return;
            }

            SetLocalInt(obHbObj, "state", SPAWN_STATE);
            SetLocalObject(obHbObj, "oPC", oPC);
            SetLocalInt(obHbObj, "leaveCnt", 0);
            SetLocalInt(obHbObj, "timer", 0);
            SetLocalInt(obHbObj, "lastCall", lastCall);
            WriteTimestampedLogEntry("###############################################");
            WriteTimestampedLogEntry("HB Object UUID: " + GetObjectUUID(obHbObj));
            WriteTimestampedLogEntry("Called Druid: State Change From: " + getState(state) +
                                     " To: " + getState(SPAWN_STATE));

        }
    }
}


// use this so sparingly!!!
void main()
{
    object oPC = GetPCChatSpeaker();
    if(!GetIsPC(oPC)){
        return;
    }

    // If were in caer corwell try to call for the druids.
    if(GetTag(GetArea(oPC)) == "caer_corwell") {
        callDruid(oPC);
    }

}
