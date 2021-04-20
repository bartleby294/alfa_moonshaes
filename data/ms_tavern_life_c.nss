#include "ms_tavern_util"

void main()
{
    // Initlize the area note that once this is done once for the area
    // We will not need to be done again until a reset.
    WriteTimestampedLogEntry("MS TAVERN CONTROLLER: On Heartbeat");
    object oArea = GetArea(OBJECT_SELF);
    object oControler = OBJECT_SELF;
    if(GetLocalInt(oArea, MS_TAVERN_INITALIZED) == FALSE) {
        WriteTimestampedLogEntry("MS TAVERN CONTROLLER: Initalizing");
        InitalizeTavernArea(oArea, GetFirstObjectInArea(oArea));
    } else {
        WriteTimestampedLogEntry("MS TAVERN CONTROLLER: Not Initalizing");
    }

    // if the area doesnt know its controller set it.
    if(GetLocalObject(oArea, MS_TAVERN_CONTROLLER_OBJECT) == OBJECT_INVALID) {
        WriteTimestampedLogEntry("MS TAVERN CONTROLLER: Setting Area Controller");
        SetLocalObject(oArea, MS_TAVERN_CONTROLLER_OBJECT, oControler);
    }

    WriteTimestampedLogEntry("MS TAVERN CONTROLLER: Getting Door Count");
    int doorCnt = GetDoorCount(oControler, oArea);
    WriteTimestampedLogEntry("MS TAVERN CONTROLLER: Getting Chair Count");
    int chairCnt = GetChairCount(oControler, oArea);
    WriteTimestampedLogEntry("MS TAVERN CONTROLLER: Getting WP Count");
    int waypointCnt = GetWaypointCount(oControler, oArea);
    WriteTimestampedLogEntry("MS TAVERN CONTROLLER: Getting Patron Count");
    int patronCnt = GetPatronCount(oControler, oArea);
    int barCnt = GetBarCount(oControler, oArea);
    int standCnt = GetStandCount(oControler, oArea);
    int maxPatrons = chairCnt/2;

    if(patronCnt < maxPatrons) {
        WriteTimestampedLogEntry("MS TAVERN CONTROLLER: Under Max Patrons");
        // 20% spawn chance.
        if(Random(100) > 80) {
            WriteTimestampedLogEntry("MS TAVERN CONTROLLER: Creating New Patron");
            object doorWp = NWNX_Data_Array_At_Obj(oArea, MS_TAVERN_DOOR_ARRAY,
                                           Random(doorCnt));
            object paton = CreateRandomPatron(oControler, oArea,
                                              GetLocation(doorWp), patronCnt);
            SetLocalInt(paton, MS_TAVERN_PATRON_STATE,
                        MS_TAVERN_PATRON_JUST_ARRIVED);
            WriteTimestampedLogEntry("MS TAVERN CONTROLLER: New Patron Created");
        }
    }
}
