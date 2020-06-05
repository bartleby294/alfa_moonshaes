void main()
{
    object chair = OBJECT_SELF;
    object oPC = GetLastUsedBy();

    ActionStartConversation(oPC, "_h_rag_pile1",FALSE, FALSE);
}
