void main()
{
    object cart = OBJECT_SELF;
    object oPC = GetLastUsedBy();

    ActionStartConversation(oPC, "_mines03orecart",FALSE, FALSE);
    //AssignCommand(oPC, ActionSpeakString("*Grunts*"));
}
