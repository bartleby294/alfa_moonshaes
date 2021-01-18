/**
 * If bandit activity is not set set it to 1.  Can update to a larger default
 * later.
 */
void checkBanditActivity() {
    int banditActivityLevel = GetCampaignInt("FACTION_ACTIVITY",
                               "BANDIT_ACTIVITY_LEVEL_2147440");
    if(banditActivityLevel == 0) {
        banditActivityLevel = 1;
        SetCampaignInt("FACTION_ACTIVITY", "BANDIT_ACTIVITY_LEVEL_2147440",
                            banditActivityLevel);
    }
}

void msOnLoad() {
    checkBanditActivity();
}
