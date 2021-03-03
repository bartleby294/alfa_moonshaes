//::///////////////////////////////////////////////
//:: FileName dlg_elswrth_rwrd
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Script Wizard
//:: Created On: 2
//:://////////////////////////////////////////////
void main()
{
    // Give the speaker some gold
    GiveGoldToCreature(GetPCSpeaker(), 25);

    // Give the speaker some XP
    GiveXPToCreature(GetPCSpeaker(), 55);

                         // Set the variables
    SetLocalInt(GetPCSpeaker(), "iElsworthquest", 7);

}
