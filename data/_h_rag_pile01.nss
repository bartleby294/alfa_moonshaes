void main()
{
    object oPC = GetPCSpeaker();

    CreateItemOnObject("rag", oPC, 1);
    AssignCommand(oPC, ActionSpeakString("*Picks up Rag*"));



}
