#include "_btb_ship_const"
#include "_btb_corwellship"
#include "nwnx_visibility"
#include "nwnx_area"
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

/*
 *  Set Ship visibilty and if ship is not inbound or in dock create blocker if
 *  it doesnt exist.
 */

void SetInBoundVisibility(string tag, object oPC, string blockerWPTag,
                   string blockerResRef, string newBlockerTag) {
    object ship = GetObjectByTag(tag);
    object blocker = GetObjectByTag(newBlockerTag);

    if(ship != OBJECT_INVALID) {
        //WriteTimestampedLogEntry("ms_cor_on_enter: Set Visible");
        NWNX_Visibility_SetVisibilityOverride(oPC, ship,
                                                NWNX_VISIBILITY_ALWAYS_VISIBLE);
    }
    if(ship == OBJECT_INVALID && blocker == OBJECT_INVALID) {
        //WriteTimestampedLogEntry("ms_cor_on_enter: Create blocker");
        object blockerWP = GetObjectByTag(blockerWPTag);
        CreateObject(OBJECT_TYPE_PLACEABLE, blockerResRef,
                     GetLocation(blockerWP), FALSE, newBlockerTag);
    }
}

void SetShipVisibility(object oPC) {
    SetInBoundVisibility(CARAVEL_INBOUND_TAG, oPC,
                         CARAVEL_INBOUND_WAYPOINT_TAG,
                         CARAVEL_INBOUND_BLOCKER_RES,
                         CARAVEL_INBOUND_BLOCKER_TAG);
    SetInBoundVisibility(CITY_SHIP_INBOUND_TAG, oPC,
                         CITY_SHIP_INBOUND_WAYPOINT_TAG,
                         CITY_SHIP_INBOUND_BLOCKER_RES,
                         CITY_SHIP_INBOUND_BLOCKER_TAG);
    SetInBoundVisibility(CARAVEL_OUTBOUND_TAG, oPC,
                         CARAVEL_OUTBOUND_WAYPOINT_TAG,
                         CARAVEL_OUTBOUND_BLOCKER_RES,
                         CARAVEL_OUTBOUND_BLOCKER_TAG);
    SetInBoundVisibility(CITY_SHIP_OUTBOUND_TAG, oPC,
                         CITY_SHIP_OUTBOUND_WAYPOINT_TAG,
                         CITY_SHIP_OUTBOUND_BLOCKER_RES,
                         CITY_SHIP_OUTBOUND_BLOCKER_TAG);
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

    object slipperyEel = GetObjectByTag("v49_slippery_eel_building");
    NWNX_Visibility_SetVisibilityOverride(oPC, slipperyEel,
                                          NWNX_VISIBILITY_ALWAYS_VISIBLE);


    // WE NEED vg_area_enter BEFORE WE TURN THIS BACK ON!
    //WaterCheck(oArea, oPC);

    if(!GetIsPC(oPC)) {
        return;
    }

    /*************** This section fires for all players, and DMs***************/
    // Check if Carvel is in dock or docking if it is make it visable.
    SetShipVisibility(oPC);

    if(GetEventScript(OBJECT_SELF, EVENT_SCRIPT_AREA_ON_HEARTBEAT) == "") {
      SetEventScript(OBJECT_SELF, EVENT_SCRIPT_AREA_ON_HEARTBEAT,
                                        "ms_cor_on_hb");
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

    //Location tracking
    SetCampaignInt("Location", "updated", 2, oPC);
    SetCampaignLocation("Location", "last", GetLocation(oPC), oPC);
    SetCampaignString("Location", "Area", GetTag(oArea), oPC);
    DelayCommand(2.0, MyGetVector(oPC) );
}
