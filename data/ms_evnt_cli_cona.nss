#include "alfa_charloc"
#include "nwnx_player"

void main( ) {
   object poPC = OBJECT_SELF;
   location oLocation = ALFA_GetPersistentLocation(WK_LOCATION_TABLE,
                                                   "CurrentLocation", poPC);

    if(GetAreaFromLocation(oLocation) == OBJECT_INVALID) {
        WriteTimestampedLogEntry("AREA NOT LOADED");
        if(GetIsDM(poPC)) {
            oLocation = GetLocation(GetObjectByTag("MS_DM_START_WP"));
        } else {
            oLocation = GetLocation(GetObjectByTag("WP_NEW_PC_START_LOCATION"));
        }
    } else {
        WriteTimestampedLogEntry("AREA LOADED: "
                                 + GetResRef(GetAreaFromLocation(oLocation)));
    }

    object oWP = CreateObject(OBJECT_TYPE_WAYPOINT, "nw_waypoint001", oLocation);
    if (GetArea(oWP) != OBJECT_INVALID){
        NWNX_Player_SetPersistentLocation(GetPCPublicCDKey(poPC),
                                          NWNX_Player_GetBicFileName(poPC),
                                          oWP, FALSE);
    }
}
