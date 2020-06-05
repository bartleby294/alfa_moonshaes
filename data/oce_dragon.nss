#include "NW_I0_GENERIC"
//#include "098dragon"

void main()
{
  if(GetBehaviorState(NW_FLAG_BEHAVIOR_SPECIAL))
  {
    DetermineSpecialBehavior();
  }
  else if(!GetSpawnInCondition(NW_FLAG_SET_WARNINGS))
  {
     DetermineCombatRound();
  }
  if(GetSpawnInCondition(NW_FLAG_END_COMBAT_ROUND_EVENT))
  {
    SignalEvent(OBJECT_SELF, EventUserDefined(1003));
  }

//george added for dragon flight

  if(!GetIsObjectValid(GetAttemptedAttackTarget()) && !GetIsObjectValid(GetAttemptedSpellTarget()))
    {
    //reset dragon flying localint and find a pc to eat
    SetLocalInt(OBJECT_SELF,"098dragonAI",0);
    //object oPC = GetNearestCreature(CREATURE_TYPE_REPUTATION,REPUTATION_TYPE_ENEMY);
    //if(!GetIsObjectValid(oPC))
    //{
    //FlyToPC(oPC);
    //}
    //else
    //{
    //effect eDis = EffectDisappear();
    //ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eDis,OBJECT_SELF);
    //return;
    //}
  }
}
