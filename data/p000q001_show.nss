int StartingConditional()
{
    if(GetCampaignInt("moonshaes","embla_quest_state", GetPCSpeaker()) < 1)
    {
        return TRUE;
    }

    return FALSE;
}
