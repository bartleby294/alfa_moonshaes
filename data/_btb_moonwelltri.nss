#include "_btb_moonwellcon"
#include "_btb_moonwelluti"

void main() {
    object oPC = GetExitingObject();
    object obHbObj = GetNearestObjectByTag("moonwell01onhbob", oPC);

    int state = GetLocalInt(obHbObj, "state");
    if(!GetIsPC(oPC) || state != NO_STATE){
        return;
    }
    //WriteTimestampedLogEntry("********************************************");
    //WriteTimestampedLogEntry("HB Object UUID: " + GetObjectUUID(obHbObj));

    object oArea = OBJECT_SELF;
    object oObject = GetFirstObjectInArea(oArea);
    while(GetIsObjectValid(oObject))
    {
         if(GetTag(oObject) == "moonwell01onhbob")
         {
            SetLocalInt(obHbObj, "state", SPAWN_STATE);
            SetLocalObject(obHbObj, "oPC", oPC);
            //WriteTimestampedLogEntry("###############################################");
            //WriteTimestampedLogEntry("HB Object UUID: " + GetObjectUUID(oObject));
            //WriteTimestampedLogEntry("State Change From: " + getState(state) +
            //                         " To: " + getState(SPAWN_STATE));
         }
         oObject = GetNextObjectInArea(oArea);
    }
}
