#include "_btb_moonwellcon"

void main()
{
    object oPC = GetPCSpeaker();
    object obHbObj = GetNearestObjectByTag("moonwell01onhbob", oPC);
    int oldState = GetLocalInt(obHbObj, "OldState");
    SetLocalInt(obHbObj, "state", oldState);
}
