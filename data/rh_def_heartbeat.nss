/*******************************************************************************
Script:     Default NPC OnHeartbeat script modified for Hour-based Waypoints
Filename:   rh_def_heartbeat
Modifier:   Thomas J. Hamman (Rhone)

These changes were made from the original nw_c2_default1:

1.  Waypoint related section of code replaced with code for hour-based
    waypoints.

2.  Section of code for running ambient animations has been changed to check
    for the local nAmbientAnimations variable instead of the SpawnIn condition.
*******************************************************************************/

#include "NW_I0_GENERIC"
#include "RH_INC_HRWPOINTS"

void main()
{
    if(GetSpawnInCondition(NW_FLAG_FAST_BUFF_ENEMY))
    {
        if(TalentAdvancedBuff(40.0))
        {
            SetSpawnInCondition(NW_FLAG_FAST_BUFF_ENEMY, FALSE);
            return;
        }
    }

    //If nDay has been set, and it's not equal to the current day/night status,
    //check to see if the NPC has new waypoints/posts to walk.
    if (GetLocalInt(OBJECT_SELF, "nDayPoints")) {
        int nDay;
        if (GetIsDay() || GetIsDawn())
            nDay = 1;
        else
            nDay = 2;
        if (GetLocalInt(OBJECT_SELF, "nDayPoints") != nDay)
            SignalEvent(OBJECT_SELF, EventUserDefined(2000));
    }

    //If nLastHourChecked hasn't been set for the NPC, then he's probably not
    //walking hour-based waypoints and we don't do anything else.  If it is
    //checked, and it's not equal to the current hour, we check to see if there
    //are new waypoints.  nLastHourChecked will end up being set to the current
    //hour so OnHearbeat knows not to bother checking for new waypoints again
    //until the next hour.
    int nHour = GetTimeHour();
    int nLastHourChecked = GetLocalInt(OBJECT_SELF, "nLastHourChecked");

    if (GetLocalInt(OBJECT_SELF, "nStartedWaypoints") && nHour != nLastHourChecked
       && !GetIsInCombat(OBJECT_SELF) && !IsInConversation(OBJECT_SELF)) {
        string sWalker = GetTag(OBJECT_SELF);
        object oNewWP;
        object oNewPost;
        while (nHour != nLastHourChecked) {
            oNewWP = GetObjectByTag("WP_" + PosIntTo2DigitString(nHour) + "_" + sWalker + "_01");
            oNewPost = GetObjectByTag("POST_" + PosIntTo2DigitString(nHour) + "_" + sWalker);
            if (GetIsObjectValid(oNewWP) || GetIsObjectValid(oNewPost)) {
                nHour = GetTimeHour();
                nLastHourChecked = nHour;
            } else {
                nHour--;
                if (nHour < 0)
                    nHour = 23;
            }
        }
        if (GetIsObjectValid(oNewWP) || GetIsObjectValid(oNewPost))
            SignalEvent(OBJECT_SELF, EventUserDefined(2000));
        else
            SetLocalInt(OBJECT_SELF, "nLastHourChecked", GetTimeHour());
    }

    if(!GetHasEffect(EFFECT_TYPE_SLEEP))
    {
        if(GetLocalInt(OBJECT_SELF, "nAmbientAnimations"))
        {
            if(!GetIsObjectValid(GetAttemptedAttackTarget()) && !GetIsObjectValid(GetAttemptedSpellTarget()))
            {
                if(!GetIsObjectValid(GetNearestCreature(CREATURE_TYPE_REPUTATION, REPUTATION_TYPE_ENEMY, OBJECT_SELF, 1, CREATURE_TYPE_PERCEPTION, PERCEPTION_SEEN)))
                {
                    if(!GetBehaviorState(NW_FLAG_BEHAVIOR_SPECIAL) && !IsInConversation(OBJECT_SELF))
                    {
                        if(GetLocalInt(OBJECT_SELF, "nAmbientAnimations") == 1)
                        {
                            PlayMobileAmbientAnimations();
                        }
                        else if(GetIsEncounterCreature() &&
                        !GetIsObjectValid(GetNearestCreature(CREATURE_TYPE_REPUTATION, REPUTATION_TYPE_ENEMY, OBJECT_SELF, 1, CREATURE_TYPE_PERCEPTION, PERCEPTION_SEEN)))
                        {
                            PlayMobileAmbientAnimations();
                        }
                        else if(GetLocalInt(OBJECT_SELF, "nAmbientAnimations") == 2 &&
                           !GetIsObjectValid(GetNearestCreature(CREATURE_TYPE_REPUTATION, REPUTATION_TYPE_ENEMY, OBJECT_SELF, 1, CREATURE_TYPE_PERCEPTION, PERCEPTION_SEEN)))
                        {
                            PlayImmobileAmbientAnimations();
                        }
                    }
                    else
                    {
                        DetermineSpecialBehavior();
                    }
                }
                else
                {
                    //DetermineCombatRound();
                }
            }
        }
    }
    else
    {
        if(GetSpawnInCondition(NW_FLAG_SLEEPING_AT_NIGHT))
        {
            effect eVis = EffectVisualEffect(VFX_IMP_SLEEP);
            if(d10() > 6)
            {
                ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, OBJECT_SELF);
            }
        }
    }

    if(GetSpawnInCondition(NW_FLAG_HEARTBEAT_EVENT)) {
        SignalEvent(OBJECT_SELF, EventUserDefined(1001));
    }
}

