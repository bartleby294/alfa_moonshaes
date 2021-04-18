#include "ms_tavern_util"

void main()
{
    // Initlize the area note that once this is done once for the area
    // We will not need to be done again until a reset.
    WriteTimestampedLogEntry("MS TAVERN CONTROLLER: On Heartbeat");
    object oArea = GetArea(OBJECT_SELF);
    object oControler = GetFirstObjectInArea(oArea);
    if(GetLocalInt(oArea, MS_TAVERN_INITALIZED) == FALSE) {
        WriteTimestampedLogEntry("MS TAVERN CONTROLLER: Initalizing");
        InitalizeTavernArea(oArea, oControler);
    } else {
        WriteTimestampedLogEntry("MS TAVERN CONTROLLER: Not Initalizing");
    }

    // if the area doesnt know its controller set it.
    if(GetLocalObject(oArea, MS_TAVERN_CONTROLLER_OBJECT) == OBJECT_INVALID) {
        WriteTimestampedLogEntry("MS TAVERN CONTROLLER: Setting Area Controller");
        SetLocalObject(oArea, MS_TAVERN_CONTROLLER_OBJECT, oControler);
    }

    int doorCnt = GetDoorCount(oControler, oArea);
    int chairCnt = GetChairCount(oControler, oArea);
    int waypointCnt = GetWaypointCount(oControler, oArea);
    int patronCnt = GetPatronCount(oControler, oArea);
    int maxPatrons = chairCnt/2;

    if(patronCnt < maxPatrons) {
        WriteTimestampedLogEntry("MS TAVERN CONTROLLER: Under Max Patrons");
        // 50% chance for testing
        if(Random(100) > 50) {
            WriteTimestampedLogEntry("MS TAVERN CONTROLLER: Creating New Patron");
            object doorWp = NWNX_Data_Array_At_Obj(oArea, MS_TAVERN_DOOR_ARRAY,
                                           Random(doorCnt));
            CreateRandomPatron(oControler, oArea, GetLocation(doorWp),
                               patronCnt);
            WriteTimestampedLogEntry("MS TAVERN CONTROLLER: New Patron Created");
        }
    }
}
