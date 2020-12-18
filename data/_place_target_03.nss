void main()
{
    object chair = OBJECT_SELF;
    object oPC = GetLastUsedBy();

    ActionStartConversation(oPC, "_place_target_01",FALSE, FALSE);
}
