void writeToLog(string str) {
    string oAreaName = GetName(GetArea(OBJECT_SELF));
    WriteTimestampedLogEntry("Bandit Camp: " + oAreaName + ": " +  str);
}

void DestroyCamp(object oArea){
    int arraySize = NWNX_Data_Array_Size(NWNX_DATA_TYPE_STRING, OBJECT_SELF,
                                         BANDIT_UUID_ARRAY);
    int i = 0;
    while(i < arraySize) {

        if(i > 100) {
            writeToLog("WARNING: NEW LIMITER REACHED!!!");
            return;
        }
        string banUUID = NWNX_Data_Array_At_Str(OBJECT_SELF, BANDIT_UUID_ARRAY,
                                                i);
        object oBandit = GetObjectByUUID(banUUID);
        if(oBandit != OBJECT_INVALID) {
            writeToLog("| Destroying: " + GetTag(oBandit));
            DestroyObject(oBandit, 2.0);
        }
        i++;
    }
}
