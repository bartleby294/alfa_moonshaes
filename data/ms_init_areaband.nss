#include "ms_bandit_ambcon"

void ClearCurrentState() {

    SetCampaignInt(MS_BANDITS_PER_AREA, "q_50_e", 0);
    SetCampaignInt(MS_BANDITS_PER_AREA, "r_50_e", 0);
    SetCampaignInt(MS_BANDITS_PER_AREA, "s_50_e", 0);
    SetCampaignInt(MS_BANDITS_PER_AREA, "t_49_e", 0);
    SetCampaignInt(MS_BANDITS_PER_AREA, "t_50_e", 0);
    SetCampaignInt(MS_BANDITS_PER_AREA, "u_49_e", 0);
    SetCampaignInt(MS_BANDITS_PER_AREA, "u_50_e", 0);
    SetCampaignInt(MS_BANDITS_PER_AREA, "v_48_e", 0);
    SetCampaignInt(MS_BANDITS_PER_AREA, "v_49_e", 0);
    SetCampaignInt(MS_BANDITS_PER_AREA, "v_50_e", 0);
    SetCampaignInt(MS_BANDITS_PER_AREA, "v_51_e", 0);
    SetCampaignInt(MS_BANDITS_PER_AREA, "v_52_e", 0);
    SetCampaignInt(MS_BANDITS_PER_AREA, "w_48_e", 0);
    SetCampaignInt(MS_BANDITS_PER_AREA, "w_49_e", 0);
    SetCampaignInt(MS_BANDITS_PER_AREA, "w_50_e", 0);
    SetCampaignInt(MS_BANDITS_PER_AREA, "w_51_e", 0);
    SetCampaignInt(MS_BANDITS_PER_AREA, "w_52_e", 0);
    SetCampaignInt(MS_BANDITS_PER_AREA, "w_53_e", 0);
    SetCampaignInt(MS_BANDITS_PER_AREA, "x_49_e", 0);
    SetCampaignInt(MS_BANDITS_PER_AREA, "x_50_e", 0);
    SetCampaignInt(MS_BANDITS_PER_AREA, "x_51_e", 0);
    SetCampaignInt(MS_BANDITS_PER_AREA, "y_49_e", 0);
    SetCampaignInt(MS_BANDITS_PER_AREA, "y_50_e", 0);
    SetCampaignInt(MS_BANDITS_PER_AREA, "z_49_e", 0);
    SetCampaignInt(MS_BANDITS_PER_AREA, "z_50_e", 0);
    SetCampaignInt(MS_BANDITS_PER_AREA, "aa_48_e", 0);
    SetCampaignInt(MS_BANDITS_PER_AREA, "aa_49_e", 0);
    SetCampaignInt(MS_BANDITS_PER_AREA, "aa_50_e", 0);
    SetCampaignInt(MS_BANDITS_PER_AREA, "bb_48_e", 0);
    SetCampaignInt(MS_BANDITS_PER_AREA, "bb_49_e", 0);
    SetCampaignInt(MS_BANDITS_PER_AREA, "bb_50_e", 0);
    SetCampaignInt(MS_BANDITS_PER_AREA, "cc_48_e", 0);
    SetCampaignInt(MS_BANDITS_PER_AREA, "cc_49_e", 0);
}

void SetNewState() {

    SetCampaignInt(MS_BANDITS_PER_AREA, "r_50_e", 1);

}

void main()
{
    ClearCurrentState();
    SetNewState();
}
