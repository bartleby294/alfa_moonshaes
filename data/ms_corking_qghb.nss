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
#include "nwnx_time"
#include "ms_corking_wagco"

void turnOnLight(object toTurnOn) {

    if(toTurnOn == OBJECT_INVALID) {
        return;
    }

    AssignCommand(toTurnOn, PlayAnimation(ANIMATION_PLACEABLE_ACTIVATE));
    effect eLight = EffectVisualEffect(VFX_DUR_LIGHT_YELLOW_20);
    ApplyEffectToObject(DURATION_TYPE_PERMANENT, eLight, toTurnOn);
}

void main()
{
    object oArea = GetArea(OBJECT_SELF);
    object wagon = GetObjectByTag("mstradewagon1");

    // if we are too far from wagon we shouldnt bother controling its state.
    float distanceToWagon = GetDistanceToObject(wagon);
    if(distanceToWagon > 10.0 || distanceToWagon == -1.0) {
        //WriteTimestampedLogEntry("ms_corking_qghb: too far away from wagon abort");
        return;
    }

    int lastWagon = GetCampaignInt("CORKING_WAGON", "CORKING_WAGON_TIME");

    if(GetLocalInt(wagon, WAGON_ESCORT_STATE) == WAGON_STATE_UNAVAILABLE) {
        WriteTimestampedLogEntry("ms_corking_qghb: wagon state unabailable");
        if(NWNX_Time_GetTimeStamp() - lastWagon > WAGON_DELAY_SECONDS) {
            WriteTimestampedLogEntry("ms_corking_qghb: wagon state available.");
            SetLocalInt(wagon, WAGON_ESCORT_STATE, WAGON_STATE_AVAILABLE);
            turnOnLight(GetObjectByTag("mstradeleaguesignal1"));
            turnOnLight(GetObjectByTag("mstradeleaguesignal2"));
        }
    }

    ExecuteScript("nw_c2_default1", OBJECT_SELF);
}
