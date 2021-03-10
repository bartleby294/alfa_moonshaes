//::///////////////////////////////////////////////
//:: FileName dlg_elswrth_rwd3
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Script Wizard
//:: Created On: 2
//:://////////////////////////////////////////////
#include "ms_xp_util"

void main()
{
    // Give the speaker some gold
    GiveGoldToCreature(GetPCSpeaker(), 25);

    // Give the speaker some XP
    GiveAndLogXP(GetPCSpeaker(), 55, "ELSWRTH", "for dlg_elswrth_rwd3.");

    // Set the variables
    SetLocalInt(GetPCSpeaker(), "iElsworthquest", 8);

}
