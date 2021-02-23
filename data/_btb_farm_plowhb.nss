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

void main()
{
    if(GetIsInCombat() == FALSE) {
        object followme = GetNearestObjectByTag("plowox", OBJECT_SELF);

        effect Walk2 = EffectMovementSpeedDecrease(44);
        ApplyEffectToObject(DURATION_TYPE_PERMANENT, Walk2, OBJECT_SELF);

        AssignCommand(OBJECT_SELF, ActionForceFollowObject(followme, 3.3));
    } else {
        ExecuteScript("nw_c2_default1", OBJECT_SELF);
    }
}
