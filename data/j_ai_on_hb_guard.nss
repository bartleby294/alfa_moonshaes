// On Heartbeat
// Removed stupid stuff, special behaviour, sleep.
// Also, note please, I removed waypoints and day/night posting from this.
// It can be re-added if you like, but it does reduce heartbeats.
// -Working- Best possible.
#include "j_inc_heartbeat"

void main()
{
      ExecuteScript("theft_heart_grd",OBJECT_SELF);
 /*
    if(GetSpawnInCondition(NW_FLAG_FAST_BUFF_ENEMY))
    {
        if(TalentAdvancedBuff(40.0))
        {
            SetSpawnInCondition(NW_FLAG_FAST_BUFF_ENEMY, FALSE);
            return;
        }
    }
    if(GetSpawnInCondition(TRACK_DAY_NIGHT))
    {
        // Set an INT, 2 is night, 1 is day.
        if(GetIsDay() || GetIsDawn())
        {
            if(GetLocalInt(OBJECT_SELF, "IS_DAY") != TRUE)
                SetLocalInt(OBJECT_SELF, "IS_DAY", TRUE);
        }
        else
        {
            if(GetLocalInt(OBJECT_SELF, "IS_DAY") > 0)
                DeleteLocalInt(OBJECT_SELF, "IS_DAY");
        }
    }

    if(!GetIsPostOrWalking())
    {
        if(GetLocalInt(OBJECT_SELF, AI_ANIMATIONS) > 0)
        {
            // If it can see an enemy, no animations.
            // If there are no PC's, no animations (as they are the only ones who see them!)
            object oEnemy = GetNearestCreature(CREATURE_TYPE_REPUTATION, REPUTATION_TYPE_ENEMY, OBJECT_SELF, 1, CREATURE_TYPE_PERCEPTION, PERCEPTION_SEEN);
            object oPC = GetNearestCreature(CREATURE_TYPE_PLAYER_CHAR, PLAYER_CHAR_IS_PC);
            if(GetIsObjectValid(oPC) && (GetArea(oPC) == GetArea(OBJECT_SELF)) && !GetIsObjectValid(oEnemy))
            {
                if(!GetIsInCombat())
                {
                    if(!IsInConversation(OBJECT_SELF))
                    {
                        SpeakString("[AI] " + GetName(OBJECT_SELF) + " [AREA] " + GetName(GetArea(OBJECT_SELF)) + " [Action] Playing Animations", TALKVOLUME_SILENT_TALK);
                        WriteTimestampedLogEntry("[AI] " + GetName(OBJECT_SELF) + " [AREA] " + GetName(GetArea(OBJECT_SELF)) + " [Action] Playing Animations");
                        PlayAnimations();
                    }
                }
            }
        }
    }
    if(GetSpawnInCondition(NW_FLAG_HEARTBEAT_EVENT))
    {
        SignalEvent(OBJECT_SELF, EventUserDefined(1001));
    }
    */
}
