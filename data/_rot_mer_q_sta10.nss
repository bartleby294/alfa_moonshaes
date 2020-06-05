int StartingConditional()
{
      if((GetCampaignInt("moonshaes","rott_merch_quest_state",GetPCSpeaker()) != 3))
    {
        return TRUE;
    }

    return FALSE;
}
