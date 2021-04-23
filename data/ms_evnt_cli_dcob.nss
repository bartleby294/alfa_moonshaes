#include "alfa_charloc"
#include "nwnx_player"
#include "nwnx_events"
#include "ms_start_locatio"

void main( ) {

    object poPC = OBJECT_SELF;
    WriteTimestampedLogEntry("ms_evnt_cli_dcob name: " + GetName(poPC));
    location oLocation = GetLocation(poPC);

    if(GetAreaFromLocation(oLocation) == OBJECT_INVALID) {

        WriteTimestampedLogEntry("ms_evnt_cli_dcob AREA NOT LOADED");
        if(GetIsDM(poPC)) {
            oLocation = GetLocation(GetObjectByTag("MS_DM_START_WP"));
        } else {
            oLocation = GetLocation(GetObjectByTag("WP_NEW_PC_START_LOCATION"));
        }
    } else {
        WriteTimestampedLogEntry("ms_evnt_cli_dcob AREA LOADED: "
                                 + GetResRef(GetAreaFromLocation(oLocation)));
    }

    SetCampaignLocation("nwnx_persistant_locations", GetPCPublicCDKey(poPC)
                      + NWNX_Player_GetBicFileName(poPC), oLocation );

    CreatePlayerStartLocation(GetPCPublicCDKey(poPC),
                              NWNX_Player_GetBicFileName(poPC),
                              oLocation);
}
