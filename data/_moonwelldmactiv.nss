#include "_moonwell01const"

void main()
{
    object lastUser = GetLastUsedBy();
    if(GetIsDM(lastUser)){
        object obHbObj = GetObjectByTag("moonwell01onhbob");
        if(GetLocalInt(obHbObj, "state") == DM_DISABLED_STATE) {
            SetLocalInt(obHbObj, "state", NO_STATE);
            SendMessageToPC(lastUser, "State Set To: NO_STATE");
        } else {
            SetLocalInt(obHbObj, "state", DM_DISABLED_STATE);
            SendMessageToPC(lastUser, "State Set To: DM_DISABLED_STATE");
        }
    } else {
        SendMessageToPC(lastUser, "You get a strange ooc feeling you may want to stay away from this rock.");
    }
}
