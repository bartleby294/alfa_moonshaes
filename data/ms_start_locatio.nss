#include "nwnx_player"
#include "nwnx_data"
#include "nwnx_time"
#include "_btb_util"

const string ACTIVE_PLAYER_LIST = "active_player_list";
const string NON_ACTIVE_PLAYER_LIST = "non_active_player_list";
const string RAW_ACTIVE_PLAYER_LIST = "raw_active_player_list";
const string ACTIVE_PLAYER_TIMESTAMPS = "active_player_timestamps";
const string NWNX_PERSISTANT_LOCATIONS = "nwnx_persistant_locations";
const string NWNX_PERSISTANT_LOCATIONS_VEC = "nwnx_persistant_locations_vec";
const string NWNX_PERSISTANT_LOCATIONS_AREA = "nwnx_persistant_locations_area";

void SavePlayerLocation(object oPC) {

    location lLocation = GetLocation(oPC);
    string index = GetPCPublicCDKey(oPC) + NWNX_Player_GetBicFileName(oPC);
    string areaTag = GetTag(GetAreaFromLocation(lLocation));
    vector position = GetPositionFromLocation(lLocation);

    SetCampaignLocation(NWNX_PERSISTANT_LOCATIONS, index, lLocation);
    SetCampaignVector(NWNX_PERSISTANT_LOCATIONS_VEC, index, position);
    SetCampaignString(NWNX_PERSISTANT_LOCATIONS_AREA, index, areaTag);

    WriteTimestampedLogEntry("Character Location: Saved For: "
                           + GetPCPublicCDKey(oPC)
                           + NWNX_Player_GetBicFileName(oPC));
}

void CreatePlayerStartLocation(string cdKey, string bicName, location loc) {

    int i = 0;
    string startWpTag = "StartLoc" + cdKey + bicName;
    object startWp = GetObjectByTag(startWpTag, i);
    while(startWp != OBJECT_INVALID) {
        DestroyObject(startWp);
        i++;
        startWp = GetObjectByTag(startWpTag, i);
        WriteTimestampedLogEntry("Destroy OLD WP");
    }

    WriteTimestampedLogEntry("Create Start Location");
    WriteTimestampedLogEntry("cdKey: " + cdKey);
    WriteTimestampedLogEntry("bicName: " + bicName);

    object oWP = CreateObject(OBJECT_TYPE_WAYPOINT, "nw_waypoint001", loc,
                              FALSE, startWpTag);

    if (GetArea(oWP) != OBJECT_INVALID){
        NWNX_Player_SetPersistentLocation(cdKey, bicName, oWP, FALSE);
    }
}

void SeedPlayerLocation() {
    object oModule = GetModule();
    // use the seeded player list to set player locations.
    int i = 0;
    int maxI = NWNX_Data_Array_Size(NWNX_DATA_TYPE_STRING, oModule,
                                ACTIVE_PLAYER_LIST);
    WriteTimestampedLogEntry("SeedPlayerLocation");
    while(i < maxI) {
        string activePlayer = NWNX_Data_Array_At_Str(oModule,
                                                     ACTIVE_PLAYER_LIST, i);
        location playerLoc = GetCampaignLocation(NWNX_PERSISTANT_LOCATIONS,
                                                 activePlayer);
        WriteTimestampedLogEntry("activePlayer: " + activePlayer);
        int apStrLen = GetStringLength(activePlayer);
        string cdKey = GetStringLeft(activePlayer, 8);
        string bicName = GetStringRight(activePlayer, apStrLen - 8);
        ////////////////////////////////////////////////////////////////////////
        string areaTag = GetCampaignString(NWNX_PERSISTANT_LOCATIONS_AREA,
                                           activePlayer);
        vector position = GetCampaignVector(NWNX_PERSISTANT_LOCATIONS_VEC,
                                           activePlayer);
        string areaTagLoc = GetTag(GetAreaFromLocation(playerLoc));
        vector positionLoc = GetPositionFromLocation(playerLoc);

        WriteTimestampedLogEntry("areaTag: " + areaTag);
        PrintVectorToLog("position: ", position);

        WriteTimestampedLogEntry("areaTagLoc: " + areaTagLoc);
        PrintVectorToLog("positionLoc: ", positionLoc);

        playerLoc = Location(GetObjectByTag(areaTag), position, 0.0);
        ////////////////////////////////////////////////////////////////////////

        CreatePlayerStartLocation(cdKey, bicName, playerLoc);
        i++;
    }
}

void PopulateActivePlayersArray() {
    int curTime = NWNX_Time_GetTimeStamp();
    int cutOff = curTime - 15780000;  // 6 month cut off time.

    int i = 0;
    object oModule = GetModule();
    string activePlayer = GetCampaignString(ACTIVE_PLAYER_LIST, IntToString(i));

    // Gather all our raw active players.
    WriteTimestampedLogEntry("Gather all our raw active players");
    while(activePlayer != "") {
        NWNX_Data_Array_PushBack_Str(oModule, RAW_ACTIVE_PLAYER_LIST,
                                     activePlayer);
        i++;
        activePlayer = GetCampaignString(ACTIVE_PLAYER_LIST, IntToString(i));
    }

    // Sort into active or non active based on timestamps.
    WriteTimestampedLogEntry("Sort into active or non active based on timestamps");
    i = 0;
    int maxI = NWNX_Data_Array_Size(NWNX_DATA_TYPE_STRING, oModule,
                                    RAW_ACTIVE_PLAYER_LIST);
    while(i < maxI) {
        string rawActivePlayer = NWNX_Data_Array_At_Str(oModule,
                                                        RAW_ACTIVE_PLAYER_LIST,
                                                        i);
        int timeStamp = GetCampaignInt(ACTIVE_PLAYER_TIMESTAMPS,
                                       rawActivePlayer);

        if(timeStamp > cutOff) {
            NWNX_Data_Array_PushBack_Str(oModule, ACTIVE_PLAYER_LIST,
                                         rawActivePlayer);
        } else {
            NWNX_Data_Array_PushBack_Str(oModule, NON_ACTIVE_PLAYER_LIST,
                                         rawActivePlayer);
        }
        i++;
    }

    // Drop the active player db and reseed.
    WriteTimestampedLogEntry("Drop the active player db and reseed");
    DestroyCampaignDatabase(ACTIVE_PLAYER_LIST);
    i = 0;
    maxI = NWNX_Data_Array_Size(NWNX_DATA_TYPE_STRING, oModule,
                                ACTIVE_PLAYER_LIST);
    while(i < maxI) {
        activePlayer = NWNX_Data_Array_At_Str(oModule,
                                              ACTIVE_PLAYER_LIST, i);
        SetCampaignString(ACTIVE_PLAYER_LIST, IntToString(i), activePlayer);
        i++;
    }

    // Clear out old entries from the time stamp db.
    WriteTimestampedLogEntry("Clear out old entries from the time stamp db");
    i = 0;
    maxI = NWNX_Data_Array_Size(NWNX_DATA_TYPE_STRING, oModule,
                                NON_ACTIVE_PLAYER_LIST);
    while(i < maxI) {
        string nonActivePlayer = NWNX_Data_Array_At_Str(oModule,
                                                        NON_ACTIVE_PLAYER_LIST,
                                                        i);
        DeleteCampaignVariable(ACTIVE_PLAYER_TIMESTAMPS, nonActivePlayer);
        i++;
    }

}
