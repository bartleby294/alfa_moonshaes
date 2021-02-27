string getState(int state) {

    switch(state)
    {
        case NO_STATE:
            return "NO_STATE";
        case SPAWN_STATE:
            return "SPAWN_STATE";
        case INTEROGATION_STATE:
            return "INTEROGATION_STATE";
        case CONVERSATION_STATE:
            return "CONVERSATION_STATE";
        case IN_CONVERSATION_STATE:
            return "IN_CONVERSATION_STATE";
        case WARN_STATE:
            return "WARN_STATE";
        case ATTACK_STATE:
            return "ATTACK_STATE";
        case ATTACKING_STATE:
            return "ATTACKING_STATE";
        case LEAVING_STATE:
            return "LEAVING_STATE";
        case DONE_STATE:
            return "DONE_STATE";
        case DM_DISABLED_STATE:
            return "DM_DISABLED_STATE";
    }
    return "";
}

int InCombat(object highDruid, object Druid01, object Druid02,
              object Druid03, object Druid04) {
    if(GetIsInCombat(highDruid)) {
        return TRUE;
    }
    if(GetIsInCombat(Druid01)) {
        return TRUE;
    }
    if(GetIsInCombat(Druid02)) {
        return TRUE;
    }
    if(GetIsInCombat(Druid03)) {
        return TRUE;
    }
    if(GetIsInCombat(Druid04)) {
        return TRUE;
    }
    return FALSE;
}

void logDruidInitialCond(object highDruid, object Druid01,  object Druid02,
                         object Druid03, object Druid04, int state, object oPC){

    string uuid = GetObjectUUID(OBJECT_SELF);
    string highDruidUuid = GetObjectUUID(highDruid);
    string Druid01Uuid = GetObjectUUID(Druid01);
    string Druid02Uuid = GetObjectUUID(Druid02);
    string Druid03Uuid = GetObjectUUID(Druid03);
    string Druid04Uuid = GetObjectUUID(Druid04);
    string oPCUuid = GetObjectUUID(oPC);

    //WriteTimestampedLogEntry("===============================================");
    //WriteTimestampedLogEntry("HB Object UUID: " + uuid);
    //WriteTimestampedLogEntry("State: " + getState(state));
    //WriteTimestampedLogEntry("High Druid UUID: " + highDruidUuid);
    //WriteTimestampedLogEntry("Druid01 UUID: " + Druid01Uuid);
    //WriteTimestampedLogEntry("Druid02 UUID: " + Druid02Uuid);
    //WriteTimestampedLogEntry("Druid03 UUID: " + Druid03Uuid);
    //WriteTimestampedLogEntry("Druid04 UUID: " + Druid04Uuid);
    //WriteTimestampedLogEntry("oPCUuid UUID: " + oPCUuid);
}

void checkInputs(object obHbObj, object highDruid, object Druid01,
                object Druid02, object Druid03, object Druid04, object oPC) {
    if(obHbObj == OBJECT_INVALID) {
        WriteTimestampedLogEntry("_btb_moonwelluti 1 - WARN: obHbObj == OBJECT_INVALID" );
    }
    if(highDruid == OBJECT_INVALID) {
        WriteTimestampedLogEntry("WARN: highDruid == OBJECT_INVALID" );
    }
    if(Druid01 == OBJECT_INVALID) {
        WriteTimestampedLogEntry("WARN: Druid01 == OBJECT_INVALID" );
    }
    if(Druid02 == OBJECT_INVALID) {
        WriteTimestampedLogEntry("WARN: Druid02 == OBJECT_INVALID" );
    }
    if(Druid03 == OBJECT_INVALID) {
        WriteTimestampedLogEntry("WARN: Druid03 == OBJECT_INVALID" );
    }
    if(Druid04 == OBJECT_INVALID) {
        WriteTimestampedLogEntry("WARN: Druid04 == OBJECT_INVALID" );
    }
    if(oPC == OBJECT_INVALID) {
        WriteTimestampedLogEntry("WARN: oPC == OBJECT_INVALID" );
    }
}

