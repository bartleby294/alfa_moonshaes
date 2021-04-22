#include "ms_start_locatio"
#include "nwnx_player"
#include "nwnx_time"

void MS_On_Client_Enter() {

    object oPC = GetEnteringObject();
    object oModule = GetModule();

    // Set Last Seen Timestamp.
    string playerId = GetPCPublicCDKey(oPC) + NWNX_Player_GetBicFileName(oPC);
    SetCampaignInt(ACTIVE_PLAYER_TIMESTAMPS, playerId,
                   NWNX_Time_GetTimeStamp());

    if(NWNX_Data_Array_Contains_Str(oModule, ACTIVE_PLAYER_LIST, playerId)
       == FALSE) {
        int index = NWNX_Data_Array_Size(NWNX_DATA_TYPE_STRING, oModule,
                                         ACTIVE_PLAYER_LIST);
        SetCampaignString(ACTIVE_PLAYER_LIST, IntToString(index), playerId);
        NWNX_Data_Array_PushBack_Str(oModule, ACTIVE_PLAYER_LIST, playerId);
    }
}
