#include "nw_i0_plot"
#include "nwnx_data"

const string AREA_WPS = "area_waypoints";

int getShouldStop() {

    int isInCombat = GetIsInCombat();
    int isPCTooFar = TRUE;
    int isWagonStopped = GetLocalInt(OBJECT_SELF, "waggonStopped");
    float distanceToPC = GetDistanceToObject(GetNearestPC());

    if(distanceToPC < 15.0 && distanceToPC > 0.0) {
        WriteTimestampedLogEntry(" * PC near waggon");
        isPCTooFar = FALSE;
    } else if (distanceToPC < 0.0) {
        if(d3() == 1) {
            int speakChoice = d6();
            if(speakChoice == 1) {
                SpeakString("Whats the hold up?");
            } else if(speakChoice == 2) {
                SpeakString("We moven soon?");
            } else if(speakChoice == 3) {
                SpeakString("Somethin in the road?");
            } else if(speakChoice == 4) {
                SpeakString("I aint got all day!");
            } else if(speakChoice == 5) {
                SpeakString("Wha are yer legs tired?");
            } else if(speakChoice == 6) {
                SpeakString("We ready?");
            }
        }
    }

    if(isInCombat || isPCTooFar || isWagonStopped) {
        return TRUE;
    }

    return FALSE;
}

void main()
{
    if(GetIsDMPossessed(OBJECT_SELF)) {
        return;
    }

    if(getShouldStop() == TRUE) {
        ClearAllActions(TRUE);
        WriteTimestampedLogEntry(" * ShouldStop");
        return;
    }

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
