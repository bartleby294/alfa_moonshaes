#include "ms_aat_utility"
#include "nwnx_data"

const string AREA_WPS = "area_waypoints";

void main()
{
    object enterObj = GetEnteringObject();
    if(GetTag(enterObj) != "tradewagon") {
        WriteTimestampedLogEntry("not a tradewagon");
        return;
    }

    object oArea = GetArea(enterObj);
    int x = GetAreaTransitionX(enterObj);
    int y = GetAreaTransitionY(enterObj);

    object newArea = GetAreaAtCoordinates(oArea, x, y);

    vector curPosition = GetPosition(enterObj);
    float newX = curPosition.y;
    float newY = curPosition.y;

    if(x > 0) {
        newX = 6.0;
    } else if (x < 0) {
        newX = 314.0;
    }

    if(y > 0) {
        newY = 6.0;
    } else if (y < 0) {
        newY = 314.0;
    }

    location newLoc = Location(newArea, Vector(newX, newY, 0.0), 0.0);
    float newZ = GetGroundHeight(newLoc);
    newLoc = Location(newArea, Vector(newX, newY, newZ), 0.0);
    WriteTimestampedLogEntry("Sending To: " + GetTag(newArea));
    WriteTimestampedLogEntry("Sending To: (" + FloatToString(newX) + ", "
                             + FloatToString(newY) + ", "
                             + FloatToString(newZ));
    //NWNX_Data_Array_Clear(NWNX_DATA_TYPE_OBJECT, enterObj, AREA_WPS);
    //SetLocalInt(enterObj, "curWP", 0);
    WriteTimestampedLogEntry("curWPInt: " + IntToString(GetLocalInt(enterObj, "curWP")));
    AssignCommand(enterObj, ActionJumpToLocation(newLoc));
}

void mainOLD()
{
    object enterObj = GetEnteringObject();
    if(GetTag(enterObj) != "tradewagon") {
        WriteTimestampedLogEntry("not a tradewagon");
        return;
    }

    object oArea = GetArea(enterObj);
    int x = GetAreaTransitionX(enterObj);
    int y = GetAreaTransitionY(enterObj);

    object newArea = GetAreaAtCoordinates(oArea, x, y);

    vector curPosition = GetPosition(enterObj);
    float newX = curPosition.y;
    float newY = curPosition.y;

    if(x > 0) {
        newX = 6.0;
    } else if (x < 0) {
        newX = 314.0;
    }

    if(y > 0) {
        newY = 6.0;
    } else if (y < 0) {
        newY = 314.0;
    }

    location newLoc = Location(newArea, Vector(newX, newY, 0.0), 0.0);
    float newZ = GetGroundHeight(newLoc);
    newLoc = Location(newArea, Vector(newX, newY, newZ), 0.0);
    WriteTimestampedLogEntry("Sending To: " + GetTag(newArea));
    WriteTimestampedLogEntry("Sending To: (" + FloatToString(newX) + ", "
                             + FloatToString(newY) + ", "
                             + FloatToString(newZ));
    NWNX_Data_Array_Clear(NWNX_DATA_TYPE_OBJECT, enterObj, AREA_WPS);
    SetLocalInt(enterObj, "curWP", 0);
    WriteTimestampedLogEntry("curWPInt: " + IntToString(GetLocalInt(enterObj, "curWP")));
    AssignCommand(enterObj, ActionJumpToLocation(newLoc));
}
