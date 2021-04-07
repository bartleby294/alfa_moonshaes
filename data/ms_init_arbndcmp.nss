#include "ms_bandit_ambcon"

void ClearCurrentState() {

    SetCampaignInt(MS_BANDIT_CAMP_NUM,  "q_50_e", 0);
    SetCampaignInt(MS_BANDIT_CAMP_NUM,  "r_50_e", 0);
    SetCampaignInt(MS_BANDIT_CAMP_NUM,  "s_50_e", 0);
    SetCampaignInt(MS_BANDIT_CAMP_NUM,  "t_49_e", 0);
    SetCampaignInt(MS_BANDIT_CAMP_NUM,  "t_50_e", 0);
    SetCampaignInt(MS_BANDIT_CAMP_NUM,  "u_49_e", 0);
    SetCampaignInt(MS_BANDIT_CAMP_NUM,  "u_50_e", 0);
    SetCampaignInt(MS_BANDIT_CAMP_NUM,  "v_48_e", 0);
    SetCampaignInt(MS_BANDIT_CAMP_NUM,  "v_49_e", 0);
    SetCampaignInt(MS_BANDIT_CAMP_NUM,  "v_50_e", 0);
    SetCampaignInt(MS_BANDIT_CAMP_NUM,  "v_51_e", 0);
    SetCampaignInt(MS_BANDIT_CAMP_NUM,  "v_52_e", 0);
    SetCampaignInt(MS_BANDIT_CAMP_NUM,  "w_48_e", 0);
    SetCampaignInt(MS_BANDIT_CAMP_NUM,  "w_49_e", 0);
    SetCampaignInt(MS_BANDIT_CAMP_NUM,  "w_50_e", 0);
    SetCampaignInt(MS_BANDIT_CAMP_NUM,  "w_51_e", 0);
    SetCampaignInt(MS_BANDIT_CAMP_NUM,  "w_52_e", 0);
    SetCampaignInt(MS_BANDIT_CAMP_NUM,  "w_53_e", 0);
    SetCampaignInt(MS_BANDIT_CAMP_NUM,  "x_49_e", 0);
    SetCampaignInt(MS_BANDIT_CAMP_NUM,  "x_50_e", 0);
    SetCampaignInt(MS_BANDIT_CAMP_NUM,  "x_51_e", 0);
    SetCampaignInt(MS_BANDIT_CAMP_NUM,  "y_49_e", 0);
    SetCampaignInt(MS_BANDIT_CAMP_NUM,  "y_50_e", 0);
    SetCampaignInt(MS_BANDIT_CAMP_NUM,  "z_49_e", 0);
    SetCampaignInt(MS_BANDIT_CAMP_NUM,  "z_50_e", 0);
    SetCampaignInt(MS_BANDIT_CAMP_NUM, "aa_48_e", 0);
    SetCampaignInt(MS_BANDIT_CAMP_NUM, "aa_49_e", 0);
    SetCampaignInt(MS_BANDIT_CAMP_NUM, "aa_50_e", 0);
    SetCampaignInt(MS_BANDIT_CAMP_NUM, "bb_48_e", 0);
    SetCampaignInt(MS_BANDIT_CAMP_NUM, "bb_49_e", 0);
    SetCampaignInt(MS_BANDIT_CAMP_NUM, "bb_50_e", 0);
    SetCampaignInt(MS_BANDIT_CAMP_NUM, "cc_48_e", 0);
    SetCampaignInt(MS_BANDIT_CAMP_NUM, "cc_49_e", 0);
}

void SetNewState() {

    SetCampaignInt(MS_BANDIT_CAMP_NUM, "bb_49_e", 1);
    SetCampaignInt(MS_BANDIT_CAMP_NUM, "aa_49_e", 1);
    SetCampaignInt(MS_BANDIT_CAMP_NUM,  "x_50_e", 1);
    SetCampaignInt(MS_BANDIT_CAMP_NUM,  "w_50_e", 1);
    SetCampaignInt(MS_BANDIT_CAMP_NUM,  "w_51_e", 1);
    SetCampaignInt(MS_BANDIT_CAMP_NUM,  "w_52_e", 1);

}

void main()
{
    ClearCurrentState();
    SetNewState();
}
