int StartingConditional()
{
    if(GetCampaignInt("moonshaes","pace_merch_quest_state", GetPCSpeaker()) == 0)
    {
        return TRUE;
    }

    return FALSE;
}
