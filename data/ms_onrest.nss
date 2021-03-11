#include "nwnx_player"
#include "nwnx_consts"
#include "nwnx_object"
#include "ms_rest_consts"

void SetRestAnimation(object oPC) {
    int sleepStyle = GetLocalInt(oPC, "sleep_style");
    if(sleepStyle == 0) {
        sleepStyle =
            NWNX_Consts_TranslateNWScriptAnimation(ANIMATION_LOOPING_DEAD_BACK);
    }
    NWNX_Player_SetRestAnimation(oPC, sleepStyle);
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
