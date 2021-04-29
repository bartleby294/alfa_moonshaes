void main()
{
    int toggle = GetCampaignInt("MS_TOGGLES", "MS_TOGGLES_BANDIT_ONDIST");
    if(toggle == FALSE) {
        SendMessageToPC(GetLastUsedBy(), "On Dist Set To Core JA.");
        SetCampaignInt("MS_TOGGLES", "MS_TOGGLES_BANDIT_ONDIST", TRUE);
    } else {
        SendMessageToPC(GetLastUsedBy(), "On Dist Set To Bandit Scripts");
        SetCampaignInt("MS_TOGGLES", "MS_TOGGLES_BANDIT_ONDIST", FALSE);
    }
}
