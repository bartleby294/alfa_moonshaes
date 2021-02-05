//::///////////////////////////////////////////////
//:: Name x2_def_heartbeat
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Default Heartbeat script
*/
//:://////////////////////////////////////////////
//:: Created By: Keith Warner
//:: Created On: June 11/03
//:://////////////////////////////////////////////
#include "nw_i0_plot"

void main()
{
    string baseWPStr = "cave_wisp_wp_";

    int atCurWp = FALSE;
    int pcAtCurWp = FALSE;

    int curWPNum = GetLocalInt(OBJECT_SELF, "cur_wp");
    int nextWPNum = curWPNum + 1;

    string curWPTag = baseWPStr + IntToString(curWPNum);
    string nextWPTag =baseWPStr + IntToString(nextWPNum);

    object curWP = GetObjectByTag(curWPTag);
    object nextWP = GetObjectByTag(nextWPTag);

    if(GetDistanceToObject(curWP) < 1.5) {
        atCurWp = TRUE;
        // We have arived and there are no more wps to move to.
        if(nextWP == OBJECT_INVALID) {
            DestroyObject(OBJECT_SELF, 3.0f);
        }
    }

    if(GetDistanceBetween(GetNearestPC(), curWP) < 5.0){
        pcAtCurWp = TRUE;
    }

    if(atCurWp && pcAtCurWp) {
        AssignCommand(OBJECT_SELF, ActionMoveToObject(nextWP, FALSE, 1.0));
        SetLocalInt(OBJECT_SELF, "cur_wp", nextWPNum);
    } else {
        AssignCommand(OBJECT_SELF, ActionMoveToObject(curWP, FALSE, 1.0));
    }
}
