void main()
{
    object splash1 = GetObjectByTag("_h_drakasplash1");
    object draka = GetLastUsedBy();

    if(GetTag(draka) == "_h_dakacommoner1" || GetTag(OBJECT_SELF) == "_h_dakacommoner2")
    {
         AssignCommand(draka, SpeakString("**Jumps**"));
         DestroyObject(draka, 1.5);
         DelayCommand(2.3, SoundObjectPlay(splash1));
    }
}
