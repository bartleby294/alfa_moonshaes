//::///////////////////////////////////////////////
//:: FileName dlg_elswrth_tkgd
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Script Wizard
//:: Created On: 2
//:://////////////////////////////////////////////
void main()
{
                            // Set the variables
    SetLocalInt(GetPCSpeaker(), "iElsworthquest", 5);

    // Remove some gold from the player
    TakeGoldFromCreature(20, GetPCSpeaker(), TRUE);

    // Create alignment shift +1 GOOD  +1 LAWFUL

    {
    object oReader = GetPCSpeaker();
    AdjustAlignment(oReader, ALIGNMENT_GOOD, 1, FALSE);
    AdjustAlignment(oReader, ALIGNMENT_LAWFUL, 1, FALSE);
    }

}
