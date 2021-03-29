#include "nw_i0_plot"
#include "nwnx_data"

const string AREA_WPS = "area_waypoints";

void main()
{
    string baseWPStr = "corwell_to_kingsbay_wp";
    int curWPInt = GetLocalInt(OBJECT_SELF, "curWP");

    // seed waypoints if uninitalized
    if(curWPInt == 0) {
        int i = 1;
        object areaWP = GetNearestObjectByTag(baseWPStr, OBJECT_SELF, i);
        while(areaWP != OBJECT_INVALID) {
            NWNX_Data_Array_PushBack_Obj(OBJECT_SELF, AREA_WPS, areaWP);
            i++;
            GetNearestObjectByTag(baseWPStr, OBJECT_SELF, i);
        }
        SetLocalInt(OBJECT_SELF, "curWP", 1);
    }

    object oPC = GetNearestPC();
    object curWP = NWNX_Data_Array_At_Obj(OBJECT_SELF, AREA_WPS, curWPInt);

    if(GetDistanceToObject(curWP) < 3.0) {
        SetLocalInt(OBJECT_SELF, "curWP", curWPInt + 1);
        curWP = NWNX_Data_Array_At_Obj(OBJECT_SELF, AREA_WPS, curWPInt + 1);
    }

    AssignCommand(OBJECT_SELF, ActionMoveToObject(curWP));
}
