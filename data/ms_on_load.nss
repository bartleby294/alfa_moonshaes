#include "ms_terrain_id"

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

void MapAreas() {
    float loadDilation = 2.0;
    DelayCommand(1.0 * loadDilation, MapAreaTerrain(GetObjectByTag("q_50_e")));
    DelayCommand(2.0 * loadDilation, MapAreaTerrain(GetObjectByTag("r_50_e")));
    DelayCommand(3.0 * loadDilation, MapAreaTerrain(GetObjectByTag("s_50_e")));
    DelayCommand(4.0 * loadDilation, MapAreaTerrain(GetObjectByTag("t_49_e")));
    DelayCommand(5.0 * loadDilation, MapAreaTerrain(GetObjectByTag("t_50_e")));
    DelayCommand(6.0 * loadDilation, MapAreaTerrain(GetObjectByTag("u_49_e")));
    DelayCommand(7.0 * loadDilation, MapAreaTerrain(GetObjectByTag("u_50_e")));
    DelayCommand(8.0 * loadDilation, MapAreaTerrain(GetObjectByTag("v_48_e")));
    DelayCommand(9.0 * loadDilation, MapAreaTerrain(GetObjectByTag("v_49_e")));
    DelayCommand(19.0 * loadDilation, MapAreaTerrain(GetObjectByTag("v_50_e")));
    DelayCommand(11.0 * loadDilation, MapAreaTerrain(GetObjectByTag("v_51_e")));
    DelayCommand(12.0 * loadDilation, MapAreaTerrain(GetObjectByTag("v_52_e")));
    DelayCommand(13.0 * loadDilation, MapAreaTerrain(GetObjectByTag("w_48_e")));
    DelayCommand(14.0 * loadDilation, MapAreaTerrain(GetObjectByTag("w_49_e")));
    DelayCommand(15.0 * loadDilation, MapAreaTerrain(GetObjectByTag("w_50_e")));
    DelayCommand(16.0 * loadDilation, MapAreaTerrain(GetObjectByTag("w_51_e")));
    DelayCommand(17.0 * loadDilation, MapAreaTerrain(GetObjectByTag("w_52_e")));
    DelayCommand(18.0 * loadDilation, MapAreaTerrain(GetObjectByTag("w_53_e")));
    DelayCommand(19.0 * loadDilation, MapAreaTerrain(GetObjectByTag("x_49_e")));
    DelayCommand(20.0 * loadDilation, MapAreaTerrain(GetObjectByTag("x_50_e")));
    DelayCommand(21.0 * loadDilation, MapAreaTerrain(GetObjectByTag("x_51_e")));
    DelayCommand(22.0 * loadDilation, MapAreaTerrain(GetObjectByTag("y_49_e")));
    DelayCommand(23.0 * loadDilation, MapAreaTerrain(GetObjectByTag("y_50_e")));
    DelayCommand(24.0 * loadDilation, MapAreaTerrain(GetObjectByTag("z_49_e")));
    DelayCommand(25.0 * loadDilation, MapAreaTerrain(GetObjectByTag("z_50_e")));
    DelayCommand(26.0 * loadDilation, MapAreaTerrain(GetObjectByTag("aa_48_e")));
    DelayCommand(27.0 * loadDilation, MapAreaTerrain(GetObjectByTag("aa_49_e")));
    DelayCommand(28.0 * loadDilation, MapAreaTerrain(GetObjectByTag("aa_50_e")));
    DelayCommand(29.0 * loadDilation, MapAreaTerrain(GetObjectByTag("bb_48_e")));
    DelayCommand(30.0 * loadDilation, MapAreaTerrain(GetObjectByTag("bb_49_e")));
    DelayCommand(31.0 * loadDilation, MapAreaTerrain(GetObjectByTag("bb_50_e")));
    DelayCommand(32.0 * loadDilation, MapAreaTerrain(GetObjectByTag("cc_48_e")));
    DelayCommand(33.0 * loadDilation, MapAreaTerrain(GetObjectByTag("cc_49_e")));
}


void msOnLoad() {
    checkBanditActivity();
    MapAreas();
}
