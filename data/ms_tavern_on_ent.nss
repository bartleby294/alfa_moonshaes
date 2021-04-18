#include "x0_i0_position"
#include "ms_tavern_util"
#include "nwnx_area"

void CreatePatronAtChair(object oArea, int chairCnt) {

    object oChair = GetValidChair(oArea, chairCnt);
    if (GetIsObjectValid(oChair)){
        location chairLoc = GetBehindLocation(oChair);
        object patron = CreateRandomPatron(OBJECT_INVALID, oArea, chairLoc, 0);
        AssignCommand(patron, ActionSit(oChair));
        SetLocalInt(oChair, MS_TAVERN_CHAIR_IN_USE, TRUE);
        SetLocalObject(patron, MS_TAVERN_PATRONS_CHAIR, oChair);
    }
}

void SeedAreaWithPatrons(object oArea) {
    int chairCnt = NWNX_Data_Array_Size(NWNX_DATA_TYPE_OBJECT, oArea,
                                        MS_TAVERN_CHAIR_ARRAY);
    int patronsCreated = 0;
    int maxPatrons = chairCnt/2;
    int patronsToCreate =  Random(maxPatrons/4) + maxPatrons/4;

    WriteTimestampedLogEntry("patronsToCreate: " + IntToString(patronsToCreate));
    WriteTimestampedLogEntry("maxPatrons: " + IntToString(maxPatrons));

    while(patronsCreated < patronsToCreate) {
        WriteTimestampedLogEntry("patronsCreated: " + IntToString(patronsCreated));
        CreatePatronAtChair(oArea, chairCnt);
        patronsCreated++;
    }
}

void main()
{
    ExecuteScript("ms_on_area_enter");

    object oArea = OBJECT_SELF;
    object oFirstObject = GetFirstObjectInArea(oArea);
    if(GetLocalInt(oArea, MS_TAVERN_INITALIZED) == FALSE) {
        WriteTimestampedLogEntry("MS TAVERN ON ENTER: Initalizing Area");
        InitalizeTavernArea(oArea, oFirstObject);
    }

    // If no one is in the area and no patrons spawn patrons.
    int numberOfPlayers = NWNX_Area_GetNumberOfPlayersInArea(OBJECT_SELF);
    int zeroPatrons = isZeroPatrons(oArea);
    WriteTimestampedLogEntry("MS TAVERN ON ENTER: numberOfPlayers - " + IntToString(numberOfPlayers));
    WriteTimestampedLogEntry("MS TAVERN ON ENTER: isZeroPatrons - " + IntToString(zeroPatrons));
    if(numberOfPlayers <= 1 && zeroPatrons == TRUE) {
        WriteTimestampedLogEntry("MS TAVERN ON ENTER: Seeding Area");
        SeedAreaWithPatrons(oArea);
    }

    // Set to the tavern script.
    //string script = GetEventScript(OBJECT_SELF, EVENT_SCRIPT_AREA_ON_HEARTBEAT);
    //if(script == "spawn_sample_hb") {
    //  SetEventScript(OBJECT_SELF, EVENT_SCRIPT_AREA_ON_HEARTBEAT,
    //                                    "ms_tavern_on_hb");
    //}
}
