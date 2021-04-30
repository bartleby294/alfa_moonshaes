void main()
{
    int toggle = GetCampaignInt("MS_TOGGLES", "MS_TOGGLES_BANDIT_ONDMG");
    if(toggle == FALSE) {
        SendMessageToPC(GetLastUsedBy(), "On Damage Set To Core JA.");
        SetCampaignInt("MS_TOGGLES", "MS_TOGGLES_BANDIT_ONDMG", TRUE);
    } else {
        SendMessageToPC(GetLastUsedBy(), "On Damage Set To Bandit Scripts");
        SetCampaignInt("MS_TOGGLES", "MS_TOGGLES_BANDIT_ONDMG", FALSE);
    }
}
