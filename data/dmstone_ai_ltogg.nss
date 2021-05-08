void main()
{
    int debugLog = GetLocalInt(GetModule(), "jas_ai_debug_log");

    if(debugLog == TRUE) {
        SetLocalInt(GetModule(), "jas_ai_debug_log", FALSE);
    } else {
        SetLocalInt(GetModule(), "jas_ai_debug_log", TRUE);
    }
}
