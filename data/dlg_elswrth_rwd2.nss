//::///////////////////////////////////////////////
//:: FileName dlg_elswrth_rwd2
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Script Wizard
//:: Created On: 2
//:://////////////////////////////////////////////
#include "ms_xp_util"

void main()
{
    // Give the speaker some XP
    GiveAndLogXP(GetPCSpeaker(), 75, "ELSWRTH RWD2", "dlg_elswrth_rwd2.");


                            // Set the variables
    SetCampaignInt("MinorQuests", "iElsworthquest", 7, GetPCSpeaker());

    // Create alignment shift +1 GOOD

    {
    object oReader = GetPCSpeaker();
    AdjustAlignment(oReader, ALIGNMENT_GOOD, 1, FALSE);
       }
    }
