void main()
{    object oPC = GetPCSpeaker();
    AssignCommand(oPC, ActionSpeakString("*Plays drum.*"));
    PlaySound("al_pl_x2wardrum2");
}
