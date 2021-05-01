#include "ms_terrain_id"
#include "ms_start_locatio"
#include "nwnx_data"

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

void MapAreasWithDelay() {
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

void MapAreasOld2() {

    MapAreaTerrain(GetObjectByTag("q_50_e"));
    MapAreaTerrain(GetObjectByTag("r_50_e"));
    MapAreaTerrain(GetObjectByTag("s_50_e"));
    MapAreaTerrain(GetObjectByTag("t_49_e"));
    MapAreaTerrain(GetObjectByTag("t_50_e"));
    MapAreaTerrain(GetObjectByTag("u_49_e"));
    MapAreaTerrain(GetObjectByTag("u_50_e"));
    MapAreaTerrain(GetObjectByTag("v_48_e"));
    MapAreaTerrain(GetObjectByTag("v_49_e"));
    MapAreaTerrain(GetObjectByTag("v_50_e"));
    MapAreaTerrain(GetObjectByTag("v_51_e"));
    MapAreaTerrain(GetObjectByTag("v_52_e"));
    MapAreaTerrain(GetObjectByTag("w_48_e"));
    MapAreaTerrain(GetObjectByTag("w_49_e"));
    MapAreaTerrain(GetObjectByTag("w_50_e"));
    MapAreaTerrain(GetObjectByTag("w_51_e"));
    MapAreaTerrain(GetObjectByTag("w_52_e"));
    MapAreaTerrain(GetObjectByTag("w_53_e"));
    MapAreaTerrain(GetObjectByTag("x_49_e"));
    MapAreaTerrain(GetObjectByTag("x_50_e"));
    MapAreaTerrain(GetObjectByTag("x_51_e"));
    MapAreaTerrain(GetObjectByTag("y_49_e"));
    MapAreaTerrain(GetObjectByTag("y_50_e"));
    MapAreaTerrain(GetObjectByTag("z_49_e"));
    MapAreaTerrain(GetObjectByTag("z_50_e"));
    MapAreaTerrain(GetObjectByTag("aa_48_e"));
    MapAreaTerrain(GetObjectByTag("aa_49_e"));
    MapAreaTerrain(GetObjectByTag("aa_50_e"));
    MapAreaTerrain(GetObjectByTag("bb_48_e"));
    MapAreaTerrain(GetObjectByTag("bb_49_e"));
    MapAreaTerrain(GetObjectByTag("bb_50_e"));
    MapAreaTerrain(GetObjectByTag("cc_48_e"));
    MapAreaTerrain(GetObjectByTag("cc_49_e"));
}

void MapAreas() {

    object oModule = GetModule();
    int maxI = NWNX_Data_Array_Size(NWNX_DATA_TYPE_STRING, oModule,
                                    "ms_module_areas");
    int i = 0;
    while(i < maxI) {
        string areaStr = NWNX_Data_Array_At_Str(oModule, "ms_module_areas", i);
        MapAreaTerrain(GetObjectByTag(areaStr));
        i++;
    }
}

void SeedMSAreasArray() {

    object oModule = GetModule();
    NWNX_Data_Array_PushBack_Str(oModule, "ms_module_areas", "q_50_e");
    NWNX_Data_Array_PushBack_Str(oModule, "ms_module_areas", "r_50_e");
    NWNX_Data_Array_PushBack_Str(oModule, "ms_module_areas", "s_50_e");
    NWNX_Data_Array_PushBack_Str(oModule, "ms_module_areas", "t_49_e");
    NWNX_Data_Array_PushBack_Str(oModule, "ms_module_areas", "t_50_e");
    NWNX_Data_Array_PushBack_Str(oModule, "ms_module_areas", "u_49_e");
    NWNX_Data_Array_PushBack_Str(oModule, "ms_module_areas", "u_50_e");
    NWNX_Data_Array_PushBack_Str(oModule, "ms_module_areas", "v_48_e");
    NWNX_Data_Array_PushBack_Str(oModule, "ms_module_areas", "v_49_e");
    NWNX_Data_Array_PushBack_Str(oModule, "ms_module_areas", "v_50_e");
    NWNX_Data_Array_PushBack_Str(oModule, "ms_module_areas", "v_51_e");
    NWNX_Data_Array_PushBack_Str(oModule, "ms_module_areas", "v_52_e");
    NWNX_Data_Array_PushBack_Str(oModule, "ms_module_areas", "w_48_e");
    NWNX_Data_Array_PushBack_Str(oModule, "ms_module_areas", "w_49_e");
    NWNX_Data_Array_PushBack_Str(oModule, "ms_module_areas", "w_50_e");
    NWNX_Data_Array_PushBack_Str(oModule, "ms_module_areas", "w_51_e");
    NWNX_Data_Array_PushBack_Str(oModule, "ms_module_areas", "w_52_e");
    NWNX_Data_Array_PushBack_Str(oModule, "ms_module_areas", "w_53_e");
    NWNX_Data_Array_PushBack_Str(oModule, "ms_module_areas", "x_49_e");
    NWNX_Data_Array_PushBack_Str(oModule, "ms_module_areas", "x_50_e");
    NWNX_Data_Array_PushBack_Str(oModule, "ms_module_areas", "x_51_e");
    NWNX_Data_Array_PushBack_Str(oModule, "ms_module_areas", "y_49_e");
    NWNX_Data_Array_PushBack_Str(oModule, "ms_module_areas", "y_50_e");
    NWNX_Data_Array_PushBack_Str(oModule, "ms_module_areas", "z_49_e");
    NWNX_Data_Array_PushBack_Str(oModule, "ms_module_areas", "z_50_e");
    NWNX_Data_Array_PushBack_Str(oModule, "ms_module_areas", "aa_48_e");
    NWNX_Data_Array_PushBack_Str(oModule, "ms_module_areas", "aa_49_e");
    NWNX_Data_Array_PushBack_Str(oModule, "ms_module_areas", "aa_50_e");
    NWNX_Data_Array_PushBack_Str(oModule, "ms_module_areas", "bb_48_e");
    NWNX_Data_Array_PushBack_Str(oModule, "ms_module_areas", "bb_49_e");
    NWNX_Data_Array_PushBack_Str(oModule, "ms_module_areas", "bb_50_e");
    NWNX_Data_Array_PushBack_Str(oModule, "ms_module_areas", "cc_48_e");
    NWNX_Data_Array_PushBack_Str(oModule, "ms_module_areas", "cc_49_e");
}

void msOnLoad() {
    WriteTimestampedLogEntry("MS ON MODULE LOAD: SeedMSAreasArray");
    SeedMSAreasArray();
    WriteTimestampedLogEntry("MS ON MODULE LOAD: PopulateActivePlayersArray");
    PopulateActivePlayersArray();
    WriteTimestampedLogEntry("MS ON MODULE LOAD: SeedPlayerLocation");
    SeedPlayerLocation();
    WriteTimestampedLogEntry("MS ON MODULE LOAD: checkBanditActivity");
    checkBanditActivity();
    WriteTimestampedLogEntry("MS ON MODULE LOAD: MapAreas");
    MapAreas();
    WriteTimestampedLogEntry("MS ON MODULE LOAD: Finished");
}
