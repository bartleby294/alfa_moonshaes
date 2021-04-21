void main()
{
    int pwfxp_toggle = GetCampaignInt("MS_PWFXP_TOGGLE", "MS_PWFXP_TOGGLE");
    if(pwfxp_toggle == FALSE) {
        SendMessageToPC(GetLastUsedBy(), "PWFXP ON");
        SetCampaignInt("MS_PWFXP_TOGGLE", "MS_PWFXP_TOGGLE", TRUE);
    } else {
        SendMessageToPC(GetLastUsedBy(), "PWFXP OFF");
        SetCampaignInt("MS_PWFXP_TOGGLE", "MS_PWFXP_TOGGLE", FALSE);
    }
}
