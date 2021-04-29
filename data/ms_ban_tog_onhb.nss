void main()
{
    int toggle = GetCampaignInt("MS_TOGGLES", "MS_TOGGLES_BANDIT_ONHB");
    if(toggle == FALSE) {
        SendMessageToPC(GetLastUsedBy(), "On HB Set To Core JA.");
        SetCampaignInt("MS_TOGGLES", "MS_TOGGLES_BANDIT_ONHB", TRUE);
    } else {
        SendMessageToPC(GetLastUsedBy(), "On HB Set To Bandit Scripts");
        SetCampaignInt("MS_TOGGLES", "MS_TOGGLES_BANDIT_ONHB", FALSE);
    }
}
