#include "nwnx_player"
#include "nwnx_consts"
#include "nwnx_object"
#include "ms_rest_consts"
#include "_btb_util"

void SetRestAnimation(object oPC) {
    int sleepStyle = GetLocalInt(oPC, "sleep_style");
    if(sleepStyle == 0) {
        sleepStyle =
            NWNX_Consts_TranslateNWScriptAnimation(ANIMATION_LOOPING_DEAD_BACK);
    }
    NWNX_Player_SetRestAnimation(oPC, sleepStyle);
}

/*
 * Return if our area is on the dont rest list
 */
int GetOverRideDisallowRest(string areaResRef) {
    return FALSE;
}

/*
 * Return if our area is on the rest list
 */
int GetOverRideAllowRest(string areaResRef) {
    return FALSE;
}

/**
 * Any wilderness area that doesn't have resting triggers in it will be flagged
 * as restable.
 *
 * Any area called out on the allowed rest area list will also be marked as
 * called out.
 */

void SetDefaultRestState(object oArea){

    string areaResRef = GetResRef(oArea);

    if(GetOverRideDisallowRest(areaResRef)){
        SetCampaignInt(REST_DATABASE, areaResRef, 0);
        WriteTimestampedLogEntry("SET RESTING: rest state for " + areaResRef
                                 + " = " + IntToString(0));
        return;
    } else if(GetOverRideAllowRest(areaResRef)){
        SetCampaignInt(REST_DATABASE, areaResRef, 1);
        WriteTimestampedLogEntry("SET RESTING: rest state for " + areaResRef
                                 + " = " + IntToString(1));
        return;
    }


    int isWilderness = GetIsAreaNatural(oArea);

    int areaHasRestingTag = FALSE;
    if(AreaContainsObjectWithTag(SLEEPING_ZONE_FREE, oArea)) {
        areaHasRestingTag = TRUE;
    } else if(AreaContainsObjectWithTag(SLEEPING_ZONE_LOW, oArea)) {
        areaHasRestingTag = TRUE;
    }  else if(AreaContainsObjectWithTag(SLEEPING_ZONE_MIDDLE, oArea)) {
        areaHasRestingTag = TRUE;
    } else if(AreaContainsObjectWithTag(SLEEPING_ZONE_UPPER, oArea)) {
        areaHasRestingTag = TRUE;
    } else if(AreaContainsObjectWithTag(SLEEPING_ZONE_HIGH, oArea)) {
        areaHasRestingTag = TRUE;
    }

    if(isWilderness == AREA_NATURAL && areaHasRestingTag == FALSE) {
         SetCampaignInt(REST_DATABASE, areaResRef, 1);
         WriteTimestampedLogEntry("SET RESTING: rest state for " + areaResRef
                                 + " = " + IntToString(1));
    } else {
        SetCampaignInt(REST_DATABASE, areaResRef, 0);
        WriteTimestampedLogEntry("SET RESTING: rest state for " + areaResRef
                                 + " = " + IntToString(0));
    }
}

string GetRestTriggerType(object oPC) {

    object szf = GetNearestObjectByTag(SLEEPING_ZONE_FREE, oPC);
    object szl = GetNearestObjectByTag(SLEEPING_ZONE_LOW, oPC);
    object szm = GetNearestObjectByTag(SLEEPING_ZONE_MIDDLE, oPC);
    object szu = GetNearestObjectByTag(SLEEPING_ZONE_UPPER, oPC);
    object szh = GetNearestObjectByTag(SLEEPING_ZONE_HIGH, oPC);

    if(NWNX_Object_GetPositionIsInTrigger(szf, GetPosition(oPC))) {
        return SLEEPING_ZONE_FREE;
    }

    if(NWNX_Object_GetPositionIsInTrigger(szl, GetPosition(oPC))) {
        return SLEEPING_ZONE_LOW;
    }

    if(NWNX_Object_GetPositionIsInTrigger(szm, GetPosition(oPC))) {
        return SLEEPING_ZONE_MIDDLE;
    }

    if(NWNX_Object_GetPositionIsInTrigger(szu, GetPosition(oPC))) {
        return SLEEPING_ZONE_UPPER;
    }

    if(NWNX_Object_GetPositionIsInTrigger(szh, GetPosition(oPC))) {
        return SLEEPING_ZONE_HIGH;
    }

    return "";
}

int RestingAllowed(object oPC) {
    int restState = GetCampaignInt(REST_DATABASE, GetResRef(GetArea(oPC)));
    WriteTimestampedLogEntry("RESTING: rest state for "
                              + GetResRef(GetArea(oPC)) + " = "
                              + IntToString(restState));

    if(restState == RESTING_DM_DISABLED) {
        return FALSE;
    }

    if(restState == RESTING_DM_ENABLED) {
        return TRUE;
    }

    string restTriggerType = GetRestTriggerType(oPC);
    if(restState == RESTING_DISALLOWED && restTriggerType == "") {
        return FALSE;
    }

    return TRUE;
}

// Place holders for things like weather damage if no tent/fire and rain/snow
void RestHazards(object oPC) {

}

// Place holder for things like tents/fires and inn qualities
void RestPerks(object oPC) {
    int nHD=GetHitDice(oPC);
    float healMultiplier = 0.0;
    string triggerType = GetRestTriggerType(oPC);
    if(triggerType == SLEEPING_ZONE_MIDDLE) {
        healMultiplier = 0.5;
    } else if(triggerType == SLEEPING_ZONE_UPPER) {
        healMultiplier = 0.75;
    } else if(triggerType == SLEEPING_ZONE_HIGH) {
        healMultiplier = 1.0;
    }
    int healAmount = FloatToInt(healMultiplier * IntToFloat(nHD));
    ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectHeal(healAmount), oPC);
}


