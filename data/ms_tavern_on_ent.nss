#include "x0_i0_position"
#include "ms_tavern_util"
#include "nwnx_area"

object GetValidChair(object oArea, int chairCnt) {

    int cutOff = 0;
    while(cutOff < 20) {
        object oChair = NWNX_Data_Array_At_Obj(oArea, MS_TAVERN_CHAIR_ARRAY,
                                               Random(chairCnt));
        if(!GetIsObjectValid(GetSittingCreature(oChair))) {
            return oChair;
        }
        cutOff++;
    }

    return OBJECT_INVALID;
}

void CreatePatronAtChair(object oArea, int chairCnt) {

    object oChair = GetValidChair(oArea, chairCnt);
    if (GetIsObjectValid(oChair)){
        location chairLoc = GetBehindLocation(oChair);
        object patron = CreateRandomPatron(OBJECT_INVALID, oArea, chairLoc, 0);
        AssignCommand(patron, ActionSit(oChair));
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
        InitalizeTavernArea(oArea, oFirstObject);
    }

    // If no one is in the area and no patrons spawn patrons.
    int numberOfPlayers = NWNX_Area_GetNumberOfPlayersInArea(OBJECT_SELF);
    int zeroPatrons = isZeroPatrons(oArea);
    if(numberOfPlayers <= 1 && zeroPatrons == TRUE) {
        SeedAreaWithPatrons(oArea);
    }

    // Set to the tavern script.
    //string script = GetEventScript(OBJECT_SELF, EVENT_SCRIPT_AREA_ON_HEARTBEAT);
    //if(script == "spawn_sample_hb") {
    //  SetEventScript(OBJECT_SELF, EVENT_SCRIPT_AREA_ON_HEARTBEAT,
    //                                    "ms_tavern_on_hb");
    //}
}
