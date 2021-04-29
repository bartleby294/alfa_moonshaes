void main()
{
    int toggle = GetCampaignInt("MS_TOGGLES", "MS_TOGGLES_BANDIT_ONPERCEP");
    if(toggle == FALSE) {
        SendMessageToPC(GetLastUsedBy(), "On Percevied Set To Core JA.");
        SetCampaignInt("MS_TOGGLES", "MS_TOGGLES_BANDIT_ONPERCEP", TRUE);
    } else {
        SendMessageToPC(GetLastUsedBy(), "On Percevied Set To Bandit Scripts");
        SetCampaignInt("MS_TOGGLES", "MS_TOGGLES_BANDIT_ONPERCEP", FALSE);
    }
}
