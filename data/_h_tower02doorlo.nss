void main()
{
    object oPC = GetLastUsedBy();

    if(GetAlignmentGoodEvil(oPC) == ALIGNMENT_GOOD)
    {
        SpeakString("**The door clicks loudly**");
        return;
    }
    if(GetAlignmentGoodEvil(oPC) == ALIGNMENT_NEUTRAL || GetAlignmentGoodEvil(oPC) == ALIGNMENT_EVIL)
    {
        SpeakString("**The doors mechanism clicks open but is quickly reset for some reason.**");
        SetLocked(OBJECT_SELF, 26);
        return;
    }

}
