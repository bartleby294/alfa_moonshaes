
int StartingConditional()
{
    if(GetCampaignInt("moonshaes","rott_merch_quest_state", GetPCSpeaker()) == 0)
    {
        return TRUE;
    }

    return FALSE;
}
