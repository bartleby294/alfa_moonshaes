void main()
{
    int toggle = GetCampaignInt("MS_TOGGLES", "MS_TOGGLES_BANDIT_ONBLOCK");
    if(toggle == FALSE) {
        SendMessageToPC(GetLastUsedBy(), "On Block Set To Core JA.");
        SetCampaignInt("MS_TOGGLES", "MS_TOGGLES_BANDIT_ONBLOCK", TRUE);
    } else {
        SendMessageToPC(GetLastUsedBy(), "On Block Set To Bandit Scripts");
        SetCampaignInt("MS_TOGGLES", "MS_TOGGLES_BANDIT_ONBLOCK", FALSE);
    }
}
