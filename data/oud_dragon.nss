//-------------------------------------------------------------------------------
//--------------------------098 Dragon Combat Script-----------------------------
//-------------------------------------------------------------------------------

// Dragon In Flight!
// Put this on your dragon's on user defined event
// Make sure the dragon's perception event is unflagged in their OnSpawn
// for pure hell on wheels action please use the script oce_dragon as well!

// the goal is to:
// 1) make it so dragons appear to FLY when they attack
//    not only will this look cool and give the dragon
//    a tactical advantage, but it will make  it impossible
//    for a player to attack from a vantage point (top of a cliff)
//    that is inaccessible to the dragon
// 2) attack the most dangerous (highest level) player in the group first and work your way down
// 3) allow the dragon the opportunity to flee if heavily wounded

#include "098dragon"

void main()
{
  int nUser = GetUserDefinedEventNumber();
  if (nUser == 1002)  // perception
  {
    if (GetLocalInt(OBJECT_SELF, "098dragonAI") != 1)
    {
      object oLastPerceived = GetLastPerceived();
      // chance of flying away if dragon has less than 10 percent of hit points
      if ((GetCurrentHitPoints() / GetMaxHitPoints()) * 100 < 10)
      {
        if (Random(100) < 20) // 20 percent chance the dragon will flee if heavily damaged
        {
          effect eDis = EffectDisappear();
          ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eDis,OBJECT_SELF);
          FloatingTextStringOnCreature("Dragon Is Flying Away!", oLastPerceived, TRUE);
          return;
        }
      }
      FlyToPC(oLastPerceived);
    }
  }
}
//-------------------------------------------------------------------------------
//--------------------------End of 098 Dragon Combat Script----------------------
//-------------------------------------------------------------------------------
