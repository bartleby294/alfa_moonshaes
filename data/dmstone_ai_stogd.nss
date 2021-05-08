void main()
{
    int debugSpeakDM = GetLocalInt(GetModule(), "jas_ai_debug_dm");

    if(debugSpeakDM == TRUE) {
        SetLocalInt(GetModule(), "jas_ai_debug_dm", FALSE);
    } else {
        SetLocalInt(GetModule(), "jas_ai_debug_dm", TRUE);
    }
}
