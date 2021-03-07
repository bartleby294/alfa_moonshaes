#include "_btb_util"
#include "nwnx_visibility"

void ShutOffHeartbeat() {
    // If the area is still empty shut down heartbeat.
    if(GetFirstPCInArea(GetArea(OBJECT_SELF)) == OBJECT_INVALID) {
        //cleanup stuff on ground
        ExecuteScript("areacleanup");
        //Set the heartbeat script to blank, turning it off
        SetEventScript(OBJECT_SELF, EVENT_SCRIPT_AREA_ON_HEARTBEAT, "");
    }
    return;
}

void setVisibleObjets(object oPC) {
    int i = 1;
    object visibilObject = GetNearestObjectByTag("visableScenery", oPC, i);
    while(visibilObject != OBJECT_INVALID) {
        NWNX_Visibility_SetVisibilityOverride(oPC, visibilObject,
                                              NWNX_VISIBILITY_DEFAULT);
        i++;
        visibilObject = GetNearestObjectByTag("visableScenery", oPC, i);
    }
}

void main()
{
    object oPC = GetExitingObject();

    // WE NEED vg_area_enter BEFORE WE TURN THIS BACK ON!
    //remove them from being underwater
    //if(GetLocalInt(oPC, "UNDERWATER") == TRUE){
    //    ExecuteScript("vg_area_ext");
    //    SendMessageToPC(oPC, "AreaExit Detected you are underwater and is removing you from the water.");
    //}

    // If no one is left in the area flag shutting down the hb scripts in 9 mins
    if(GetFirstPCInArea(GetArea(OBJECT_SELF)) == OBJECT_INVALID) {
        DelayCommand(540.00, ShutOffHeartbeat());
    }

    setVisibleObjets(oPC);

    return;
}
