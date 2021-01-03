#include "_moonwell01const"

void main()
{
    object obHbObj = GetNearestObjectByTag("moonwell01VarStorage");
    DelayCommand(6.0, SetLocalInt(obHbObj, "state", WARN_STATE));
    object light = GetLocalObject(obHbObj, "lightobject");
    DestroyObject(light, 1.0);
}
