void main()
{
    int toggle = GetCampaignInt("MS_TOGGLES", "MS_TOGGLES_BANDIT_ONCONV");
    if(toggle == FALSE) {
        SendMessageToPC(GetLastUsedBy(), "On Convo Set To Core JA.");
        SetCampaignInt("MS_TOGGLES", "MS_TOGGLES_BANDIT_ONCONV", TRUE);
    } else {
        SendMessageToPC(GetLastUsedBy(), "On Convo Set To Bandit Scripts");
        SetCampaignInt("MS_TOGGLES", "MS_TOGGLES_BANDIT_ONCONV", FALSE);
    }
}
