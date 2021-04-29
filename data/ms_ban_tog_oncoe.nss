void main()
{
    int toggle = GetCampaignInt("MS_TOGGLES", "MS_TOGGLES_BANDIT_ONCOMEND");
    if(toggle == FALSE) {
        SendMessageToPC(GetLastUsedBy(), "On Combat End Set To Core JA.");
        SetCampaignInt("MS_TOGGLES", "MS_TOGGLES_BANDIT_ONCOMEND", TRUE);
    } else {
        SendMessageToPC(GetLastUsedBy(), "On Combat End Set To Bandit Scripts");
        SetCampaignInt("MS_TOGGLES", "MS_TOGGLES_BANDIT_ONCOMEND", FALSE);
    }
}
