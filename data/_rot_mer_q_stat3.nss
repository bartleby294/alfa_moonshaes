int StartingConditional()
{
      if((GetCampaignInt("moonshaes","rott_merch_quest_state",GetPCSpeaker()) == 1))
    {
        return TRUE;
    }

    return FALSE;
}
