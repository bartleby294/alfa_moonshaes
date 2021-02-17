#include "_btb_moonwellcon"

void main()
{
    object oPC = GetItemActivator();
    object obHbObj = GetNearestObjectByTag("moonwell01onhbob", oPC);
    int oldState = GetLocalInt(obHbObj, "state");
    SetLocalInt(obHbObj, "OldState", oldState);
    SetLocalInt(obHbObj, "state", LEAVING_STATE);
}
