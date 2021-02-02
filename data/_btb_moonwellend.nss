#include "_btb_moonwellcon"
#include "_btb_moonwelluti"

void main()
{
    object oPC = GetPCSpeaker();
    object obHbObj = GetNearestObjectByTag("moonwell01onhbob", oPC);

    int state = GetLocalInt(obHbObj, "state");
    WriteTimestampedLogEntry("$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$");
    WriteTimestampedLogEntry("HB Object UUID: " + GetObjectUUID(obHbObj));
    WriteTimestampedLogEntry("State Change From: " + getState(state) +
                             " To: " + getState(SPAWN_STATE));

    SetLocalInt(obHbObj, "state", SPAWN_STATE);
}
