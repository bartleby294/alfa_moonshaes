#include "_btb_moonwellcon"

void main()
{
    object oPC = GetPCSpeaker();
    object obHbObj = GetNearestObjectByTag("moonwell01onhbob", oPC);
    int oldState = GetLocalInt(obHbObj, "state");
    SetLocalInt(obHbObj, "OldState", oldState);
    SetLocalInt(obHbObj, "state", DM_DISABLED_STATE);
}
