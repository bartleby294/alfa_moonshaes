void main()
{
    int toggle = GetCampaignInt("MS_TOGGLES", "MS_TOGGLES_BANDIT_ONSPAWN");
    if(toggle == FALSE) {
        SendMessageToPC(GetLastUsedBy(), "On Spawn Set To Core JA.");
        SetCampaignInt("MS_TOGGLES", "MS_TOGGLES_BANDIT_ONSPAWN", TRUE);
    } else {
        SendMessageToPC(GetLastUsedBy(), "On Spawn Set To Bandit Scripts");
        SetCampaignInt("MS_TOGGLES", "MS_TOGGLES_BANDIT_ONSPAWN", FALSE);
    }
}
