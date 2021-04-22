#include "alfa_charloc"
#include "nwnx_player"
#include "nwnx_events"

object GetEnteringPlayer(string playerName) {

    object oPC = GetFirstPC();

    if(oPC == OBJECT_INVALID) {
        WriteTimestampedLogEntry("ms_evnt_cli_cona oPC OBJ INV");
    }

    while (GetIsObjectValid(oPC))
    {
        WriteTimestampedLogEntry("ms_evnt_cli_cona GetEnteringPlayer: " + GetPCPlayerName(oPC));
        WriteTimestampedLogEntry("ms_evnt_cli_cona GetEnteringPlayer: " + GetName(oPC));

        if(GetPCPlayerName(oPC) == playerName) {
            return oPC;
        }
        oPC = GetNextPC();
    }

    return OBJECT_INVALID;
}


void main( ) {

    string playerName = NWNX_Events_GetEventData("PLAYER_NAME");
    string sCDKey = NWNX_Events_GetEventData("CDKEY");
    string isDM = NWNX_Events_GetEventData("IS_DM");
    string ipAddress = NWNX_Events_GetEventData("IP_ADDRESS");

    object poPC = GetEnteringPlayer(playerName);
    WriteTimestampedLogEntry("ms_evnt_cli_cona name: " + GetName(poPC));
    location oLocation = ALFA_GetPersistentLocation(WK_LOCATION_TABLE,
                                                   "CurrentLocation", poPC);

    WriteTimestampedLogEntry("ms_evnt_cli_cona playerName: " + playerName);
    WriteTimestampedLogEntry("ms_evnt_cli_cona sCDKey: " + sCDKey);
    WriteTimestampedLogEntry("ms_evnt_cli_cona isDM: " + isDM);
    WriteTimestampedLogEntry("ms_evnt_cli_cona ipAddress: " + ipAddress);

    if(GetAreaFromLocation(oLocation) == OBJECT_INVALID) {

        WriteTimestampedLogEntry("ms_evnt_cli_cona AREA NOT LOADED");
        if(GetIsDM(poPC)) {
            oLocation = GetLocation(GetObjectByTag("MS_DM_START_WP"));
        } else {
            oLocation = GetLocation(GetObjectByTag("WP_NEW_PC_START_LOCATION"));
        }
    } else {
        WriteTimestampedLogEntry("ms_evnt_cli_cona AREA LOADED: "
                                 + GetResRef(GetAreaFromLocation(oLocation)));
    }

    object oWP = CreateObject(OBJECT_TYPE_WAYPOINT, "nw_waypoint001", oLocation);
    if (GetArea(oWP) != OBJECT_INVALID){
        NWNX_Player_SetPersistentLocation(GetPCPublicCDKey(poPC),
                                          NWNX_Player_GetBicFileName(poPC),
                                          oWP, FALSE);
    }
}
