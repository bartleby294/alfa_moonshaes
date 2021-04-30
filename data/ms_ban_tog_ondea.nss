void main()
{
    int toggle = GetCampaignInt("MS_TOGGLES", "MS_TOGGLES_BANDIT_ONDEATH");
    if(toggle == FALSE) {
        SendMessageToPC(GetLastUsedBy(), "On Death Set To Core JA.");
        SetCampaignInt("MS_TOGGLES", "MS_TOGGLES_BANDIT_ONDEATH", TRUE);
    } else {
        SendMessageToPC(GetLastUsedBy(), "On Death Set To Bandit Scripts");
        SetCampaignInt("MS_TOGGLES", "MS_TOGGLES_BANDIT_ONDEATH", FALSE);
    }
}
