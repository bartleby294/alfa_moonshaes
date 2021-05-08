void main()
{
    int debugSpeak = GetLocalInt(GetModule(), "jas_ai_debug_speak");
    int debugLog = GetLocalInt(GetModule(), "jas_ai_debug_log");
    int debugSpeakDM = GetLocalInt(GetModule(), "jas_ai_debug_dm");

    if(debugSpeak == TRUE) {
        SetCustomToken(21471900, "TRUE");
    } else {
        SetCustomToken(21471900, "FALSE");
    }

    if(debugLog == TRUE) {
        SetCustomToken(21471901, "TRUE");
    } else {
        SetCustomToken(21471901, "FALSE");
    }

    if(debugSpeakDM == TRUE) {
        SetCustomToken(21471902, "TRUE");
    } else {
        SetCustomToken(21471902, "FALSE");
    }
}


