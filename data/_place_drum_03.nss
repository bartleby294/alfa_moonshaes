void main()
{
    object chair = OBJECT_SELF;
    object oPC = GetLastUsedBy();

    ActionStartConversation(oPC, "_place_drum_01",FALSE, FALSE);
}
