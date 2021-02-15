void main()
{
    //object oPC = OBJECT_SELF;
    object oPC = GetItemActivator();
    string areaTag = GetTag(GetArea(oPC));

    // Corwell City DM Conversation Options.
    if(areaTag == "CorwellTownNorth") {
        ActionStartConversation(oPC, "_btb_cor_dm_ston", TRUE, FALSE);
    } else {
        ActionStartConversation(oPC, "_btb_dmstone_non", TRUE, FALSE);
    }

}
