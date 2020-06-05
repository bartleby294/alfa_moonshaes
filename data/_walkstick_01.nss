void main()
{
    object chair = OBJECT_SELF;
    object oPC = GetLastUsedBy();

    ActionStartConversation(oPC, "_walkstick_con1",FALSE, FALSE);
}
