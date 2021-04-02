void main()
{
    //object oPC = OBJECT_SELF;
    object oPC = GetItemActivator();
    string areaTag = GetTag(GetArea(oPC));

    // Corwell City DM Conversation Options.
    if(areaTag == "v_49_e") {
        ActionStartConversation(oPC, "dmstone_corewell", TRUE, FALSE);
    } else if(areaTag == "v_48_e") {
        ActionStartConversation(oPC, "dmstone_moonwel1", TRUE, FALSE);
    } else if(areaTag == "v_49_i_14") {
        ActionStartConversation(oPC, "dmstone_redstagi", TRUE, FALSE);
    } else if(areaTag == "v_50_e_x_02") {
        ActionStartConversation(oPC, "dmstone_xvartrai", TRUE, FALSE);
    } else {
        ActionStartConversation(oPC, "dmstone_default", TRUE, FALSE);
    }
}
