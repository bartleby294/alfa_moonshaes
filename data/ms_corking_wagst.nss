#include "nwnx_time"
#include "ms_corking_wagco"

void turnOffLight(object toTurnOff) {

    if(toTurnOff == OBJECT_INVALID) {
        return;
    }

    AssignCommand(toTurnOff, PlayAnimation(ANIMATION_PLACEABLE_DEACTIVATE));
    effect eEffect = GetFirstEffect(toTurnOff);
    while (GetIsEffectValid(eEffect) == TRUE) {
        if (GetEffectType(eEffect) == EFFECT_TYPE_VISUALEFFECT) {
            RemoveEffect(toTurnOff, eEffect);
        }
        eEffect = GetNextEffect(toTurnOff);
    }
}

void main()
{
    object wagon = GetObjectByTag("mstradewagon1");
    SetLocalInt(wagon, WAGON_ESCORT_STATE, WAGON_STATE_IN_PROGRESS);

    SetCampaignInt("CORKING_WAGON", "CORKING_WAGON_TIME",
                   NWNX_Time_GetTimeStamp());

    turnOffLight(GetObjectByTag("mstradeleaguesignal1"));
    turnOffLight(GetObjectByTag("mstradeleaguesignal2"));
}

