#include "_btb_moonwellcon"
#include "_btb_moonwelluti"

void main()
{
    object oPC = GetPCSpeaker();
    object obHbObj = GetNearestObjectByTag("moonwell01onhbob", oPC);

    int state = GetLocalInt(obHbObj, "state");
    //WriteTimestampedLogEntry("$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$");
    //WriteTimestampedLogEntry("HB Object UUID: " + GetObjectUUID(obHbObj));
    //WriteTimestampedLogEntry("State Change From: " + getState(state) +
    //                         " To: " + getState(LEAVING_STATE));

    //SetLocalInt(obHbObj, "state", LEAVING_STATE);
    SetLocalInt(obHbObj, "state", CONVO_END_STATE);
    SetLocalInt(obHbObj, "turns_since_convo", 0);
}
