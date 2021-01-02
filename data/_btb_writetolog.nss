void writeToLog(string str) {
    string oAreaName = GetName(GetArea(OBJECT_SELF));
    string uuid = GetLocalString(OBJECT_SELF, "uuid");
    WriteTimestampedLogEntry(uuid + " Bandit Camp: " + oAreaName + ": " +  str);
}
