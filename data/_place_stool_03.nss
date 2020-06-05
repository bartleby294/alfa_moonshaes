void main()
{
    object chair = OBJECT_SELF;
    object oPC = GetLastUsedBy();

    ActionStartConversation(oPC, "_stool_opt_conv1",FALSE, FALSE);
}
