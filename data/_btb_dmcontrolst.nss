void main()
{
    //object oPC = OBJECT_SELF;
    object oPC = GetItemActivator();
    string areaTag = GetTag(GetArea(oPC));

    // Corwell City DM Conversation Options.
    if(areaTag == "CorwellTownNorth") {
        ActionStartConversation(oPC, "dmstone_corewell", TRUE, FALSE);
    } else if(areaTag == "caer_corwell") {
        ActionStartConversation(oPC, "dmstone_moonwel1", TRUE, FALSE);
    } else if(areaTag == "cw_redstag") {
        ActionStartConversation(oPC, "dmstone_redstagi", TRUE, FALSE);
    } else {
        ActionStartConversation(oPC, "dmstone_default", TRUE, FALSE);
    }



}
