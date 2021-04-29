void main()
{
    int toggle = GetCampaignInt("MS_TOGGLES", "MS_TOGGLES_BANDIT_ONPATTACK");
    if(toggle == FALSE) {
        SendMessageToPC(GetLastUsedBy(), "On Phys Attack Set To Core JA.");
        SetCampaignInt("MS_TOGGLES", "MS_TOGGLES_BANDIT_ONPATTACK", TRUE);
    } else {
        SendMessageToPC(GetLastUsedBy(), "On Phys Attack Set To Bandit Scripts");
        SetCampaignInt("MS_TOGGLES", "MS_TOGGLES_BANDIT_ONPATTACK", FALSE);
    }
}
