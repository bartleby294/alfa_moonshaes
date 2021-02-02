#include "_moonwell01const"
#include "_btb_moonwelluti"

void main() {
    object oPC = GetExitingObject();
    object obHbObj = GetNearestObjectByTag("moonwell01onhbob", oPC);
    SetLocalInt(obHbObj, "state", SPAWN_STATE);
    SetLocalObject(obHbObj, "oPC", oPC);

    int state = GetLocalInt(obHbObj, "state");
    WriteTimestampedLogEntry("###############################################");
    WriteTimestampedLogEntry("HB Object UUID: " + GetObjectUUID(obHbObj));
    WriteTimestampedLogEntry("State Change From: " + getState(state) +
                             " To: " + getState(SPAWN_STATE));
}
