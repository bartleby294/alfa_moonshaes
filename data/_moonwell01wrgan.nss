#include "_moonwell01const"

void main()
{
    object obHbObj = GetNearestObjectByTag("Moonwell01OnHBObj");
    DelayCommand(6.0, SetLocalInt(obHbObj, "state", WARN_STATE));
    object light = GetLocalObject(obHbObj, "lightobject");
    DestroyObject(light, 1.0);
    object trigger = GetNearestObjectByTag("MoonwellTrigger02");
    DestroyObject(trigger, 0.1);
}
