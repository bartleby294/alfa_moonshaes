#include "nw_i0_plot"
#include "nwnx_data"

const string AREA_WPS = "area_waypoints";


void main()
{
    string baseWpStr = "corwell_to_kingsbay_wp_";
    int curWPInt = GetLocalInt(OBJECT_SELF, "curWP");

    if(curWPInt == 0) {
        int i = 1;
        string waypointStr = baseWpStr + IntToString(i);
        object areaWP = GetObjectByTag(waypointStr);
        while (areaWP != OBJECT_INVALID) {
            NWNX_Data_Array_PushBack_Obj(OBJECT_SELF, AREA_WPS, areaWP);
            i++;
            waypointStr = baseWpStr + IntToString(i);
            areaWP = GetObjectByTag(waypointStr);
        }
        SetLocalInt(OBJECT_SELF, "curWP", 1);
    }

    object curWP = NWNX_Data_Array_At_Obj(OBJECT_SELF, AREA_WPS, curWPInt);
    if(GetDistanceToObject(curWP) < 3.0) {
        SetLocalInt(OBJECT_SELF, "curWP", curWPInt + 1);
        curWP = NWNX_Data_Array_At_Obj(OBJECT_SELF, AREA_WPS, curWPInt + 1);
    }

    AssignCommand(OBJECT_SELF, ActionMoveToObject(curWP));
}


void mainOLD()
{
    string baseWPStr = "corwell_to_kingsbay_wp";
    WriteTimestampedLogEntry("1");
    int curWPInt = GetLocalInt(OBJECT_SELF, "curWP");
    WriteTimestampedLogEntry("2");
    WriteTimestampedLogEntry("curWPInt: " + IntToString(curWPInt));
    // seed waypoints if uninitalized
    if(curWPInt == 0) {
        WriteTimestampedLogEntry("3");
        int i = 1;
        object areaWP = GetNearestObjectByTag(baseWPStr, OBJECT_SELF, i);
        WriteTimestampedLogEntry("4");
        while(areaWP != OBJECT_INVALID) {
            WriteTimestampedLogEntry("areaWP Tag: " + GetTag(areaWP));
            WriteTimestampedLogEntry("i: " + IntToString(i));
            NWNX_Data_Array_PushBack_Obj(OBJECT_SELF, AREA_WPS, areaWP);
            i++;
            areaWP =GetNearestObjectByTag(baseWPStr, OBJECT_SELF, i);
        }
        WriteTimestampedLogEntry("6");
        SetLocalInt(OBJECT_SELF, "curWP", 1);
    }
    WriteTimestampedLogEntry("7");
    ///object oPC = GetNearestPC();
    object curWP = NWNX_Data_Array_At_Obj(OBJECT_SELF, AREA_WPS, curWPInt);
    WriteTimestampedLogEntry("8");
    if(GetDistanceToObject(curWP) < 3.0) {
        WriteTimestampedLogEntry("9");
        SetLocalInt(OBJECT_SELF, "curWP", curWPInt + 1);
        curWP = NWNX_Data_Array_At_Obj(OBJECT_SELF, AREA_WPS, curWPInt + 1);
        WriteTimestampedLogEntry("10");
    }
    WriteTimestampedLogEntry("11");
    AssignCommand(OBJECT_SELF, ActionMoveToObject(curWP));
}
