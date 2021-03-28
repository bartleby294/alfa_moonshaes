//::///////////////////////////////////////////////
//:: FileName dlg_elswrth_strt
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Script Wizard
//:: Created On: 2
//:://////////////////////////////////////////////
int StartingConditional()
{

    // Inspect local variables
    if(!(GetCampaignInt("MinorQuests", "iElsworthquest", GetPCSpeaker()) != 1))
        return FALSE;
    if(!(GetCampaignInt("MinorQuests", "iElsworthquest", GetPCSpeaker()) != 2))
        return FALSE;
    if(!(GetCampaignInt("MinorQuests", "iElsworthquest", GetPCSpeaker()) != 3))
        return FALSE;
    if(!(GetCampaignInt("MinorQuests", "iElsworthquest", GetPCSpeaker()) != 4))
        return FALSE;
    if(!(GetCampaignInt("MinorQuests", "iElsworthquest", GetPCSpeaker()) != 5))
        return FALSE;
    if(!(GetCampaignInt("MinorQuests", "iElsworthquest", GetPCSpeaker()) != 6))
        return FALSE;
    if(!(GetCampaignInt("MinorQuests", "iElsworthquest", GetPCSpeaker()) != 7))
        return FALSE;
    if(!(GetCampaignInt("MinorQuests", "iElsworthquest", GetPCSpeaker()) != 8))
        return FALSE;
    if(!(GetCampaignInt("MinorQuests", "iElsworthquest", GetPCSpeaker()) != 9))
        return FALSE;
    if(!(GetCampaignInt("MinorQuests", "iElsworthquest", GetPCSpeaker()) != 10))
        return FALSE;
    if(!(GetCampaignInt("MinorQuests", "iElsworthquest", GetPCSpeaker()) != 11))
        return FALSE;
    return TRUE;
}
