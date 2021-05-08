void main()
{
    int debugSpeak = GetLocalInt(GetModule(), "jas_ai_debug_speak");

    if(debugSpeak == TRUE) {
        SetLocalInt(GetModule(), "jas_ai_debug_speak", FALSE);
    } else {
        SetLocalInt(GetModule(), "jas_ai_debug_speak", TRUE);
    }
}
