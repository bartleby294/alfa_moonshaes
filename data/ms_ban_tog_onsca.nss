void main()
{
    int toggle = GetCampaignInt("MS_TOGGLES", "MS_TOGGLES_BANDIT_ONSPELLCAST");
    if(toggle == FALSE) {
        SendMessageToPC(GetLastUsedBy(), "On Spell Cast Set To Core JA.");
        SetCampaignInt("MS_TOGGLES", "MS_TOGGLES_BANDIT_ONSPELLCAST", TRUE);
    } else {
        SendMessageToPC(GetLastUsedBy(), "On Spell Cast Set To Bandit Scripts");
        SetCampaignInt("MS_TOGGLES", "MS_TOGGLES_BANDIT_ONSPELLCAST", FALSE);
    }
}
