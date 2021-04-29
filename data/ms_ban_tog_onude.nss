void main()
{
    int toggle = GetCampaignInt("MS_TOGGLES", "MS_TOGGLES_BANDIT_ONUSRDEF");
    if(toggle == FALSE) {
        SendMessageToPC(GetLastUsedBy(), "On Usr Def Set To Core JA.");
        SetCampaignInt("MS_TOGGLES", "MS_TOGGLES_BANDIT_ONUSRDEF", TRUE);
    } else {
        SendMessageToPC(GetLastUsedBy(), "On Usr Def Set To Bandit Scripts");
        SetCampaignInt("MS_TOGGLES", "MS_TOGGLES_BANDIT_ONUSRDEF", FALSE);
    }
}
