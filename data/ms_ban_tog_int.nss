void main()
{
    int intNum = GetCampaignInt("MS_TOGGLES", "MS_TOGGLES_BANDIT_INT");
    if(intNum == 10) {
        intNum = 1;
    } else {
        intNum++;
    }
    SendMessageToPC(GetLastUsedBy(), "Bandit Int Set To: "
                                     + IntToString(intNum));
    SetCampaignInt("MS_TOGGLES", "MS_TOGGLES_BANDIT_INT", intNum);
}
