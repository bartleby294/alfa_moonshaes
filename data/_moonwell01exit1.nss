#include "_moonwell01spawn"
#include "_moonwell01const"

void main() {
    object oPC = GetExitingObject();
    object obHbObj = GetNearestObjectByTag("moonwell01onhbob", oPC);
    SetLocalInt(obHbObj, "state", SPAWN_STATE);
    //moonwellSpawn(oPC);
}
