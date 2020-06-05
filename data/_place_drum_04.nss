void main()
{
    object oPC = GetPCSpeaker();
    AssignCommand(oPC, ActionSpeakString("*Plays drum.*"));
    PlaySound("as_cv_drums1");

}
