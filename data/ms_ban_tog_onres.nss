void main()
{
    int toggle = GetCampaignInt("MS_TOGGLES", "MS_TOGGLES_BANDIT_ONREST");
    if(toggle == FALSE) {
        SendMessageToPC(GetLastUsedBy(), "On Rest Set To Core JA.");
        SetCampaignInt("MS_TOGGLES", "MS_TOGGLES_BANDIT_ONREST", TRUE);
    } else {
        SendMessageToPC(GetLastUsedBy(), "On Rest Set To Bandit Scripts");
        SetCampaignInt("MS_TOGGLES", "MS_TOGGLES_BANDIT_ONREST", FALSE);
    }
}
