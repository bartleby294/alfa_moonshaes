#include "nwnx_visibility"
#include "ms_xp_util"

void MyGetVector(object oPC){
    vector vAreaVec = GetPosition(oPC);
    SetCampaignVector("Location", "vAreaVec", vAreaVec, oPC);
    return;
}

void WaterCheck(object oArea, object oPC) {
    if(GetLocalInt(oArea, "AREA_UNDERWATER") == TRUE
        && GetLocalInt(oPC, "UNDERWATER") == TRUE) {
        ExecuteScript("vg_area_enter", OBJECT_SELF);
    } else if(GetMaster(oPC) != OBJECT_INVALID
                && GetLocalInt(oArea, "AREA_UNDERWATER") == TRUE) {
        ExecuteScript("vg_area_enter", OBJECT_SELF);
    }
}

void setVisibleObjets(object oPC) {
    int i = 1;
    object visibilObject = GetNearestObjectByTag("visableScenery", oPC, i);
    while(visibilObject != OBJECT_INVALID) {
        NWNX_Visibility_SetVisibilityOverride(oPC, visibilObject,
                                              NWNX_VISIBILITY_ALWAYS_VISIBLE);
        i++;
        visibilObject = GetNearestObjectByTag("visableScenery", oPC, i);
    }
}

void main() {
    object oArea = GetArea(OBJECT_SELF);
    object oPC = GetEnteringObject();
    int iFired = GetLocalInt(OBJECT_SELF, "setup");
    int iNumPlayers = 0;

    /************* This section fires for all players, NPCs, and DMs***********/
    if(iFired != 1) {
        SetLocalInt(oArea, "X2_L_WILD_MAGIC", 1);
        SetLocalInt(OBJECT_SELF, "setup", 1);
    }

    // WE NEED vg_area_enter BEFORE WE TURN THIS BACK ON!
    //WaterCheck(oArea, oPC);

    if(!GetIsPC(oPC)) {
        return;
    }

    setVisibleObjets(oPC);

    /*************** This section fires for all players, and DMs***************/

    if(GetEventScript(OBJECT_SELF, EVENT_SCRIPT_AREA_ON_HEARTBEAT) == "") {
      SetEventScript(OBJECT_SELF, EVENT_SCRIPT_AREA_ON_HEARTBEAT,
                                        "spawn_sample_hb");
    }

    // WE NEED dbhsc_oe_trapme BEFORE WE TURN THIS BACK ON!
    //if(GetLocalInt(oArea, "TRAPS") == 1){
    //    ExecuteScript("dbhsc_oe_trapme", OBJECT_SELF);
    //}

    if(GetIsDM(oPC)){
        return;
    }

  /**************** This section fires for ONLY Player characters**************/

    //Gold encumberance
    int iNewGold = GetGold(oPC);
    if ((GetLocalInt(oPC, "alfa_doa_gold") / 500) != (iNewGold/500)) {
        ExecuteScript("alfa_goldencum", oPC);
    }

    //New area exploration XP
    string sTrigTag = GetResRef(oArea);
    if((GetCampaignInt("ExploreXPDB", sTrigTag + GetName(oPC) + "Fired")!= TRUE)
            && GetIsPC(oPC)) {
        //Base 15xp for exploring a new area
        GiveAndLogXP(oPC, 15, "AREA EXPLORATION", "for exploring.");
        SendMessageToPC(oPC, "You have gained experience for finding a new area.");
        SetCampaignInt("ExploreXPDB", sTrigTag+GetName(oPC) + "Fired", TRUE);
    }

    WriteTimestampedLogEntry("AREA TRACKING: " + GetName(oPC) + " Traveled to: "
                             + GetName(oArea) + " resref: " + GetResRef(oArea));

    //Location tracking
    SetCampaignInt("Location", "updated", 2, oPC);
    SetCampaignLocation("Location", "last", GetLocation(oPC), oPC);
    SetCampaignString("Location", "Area", GetTag(oArea), oPC);
    DelayCommand(2.0, MyGetVector(oPC) );
}
