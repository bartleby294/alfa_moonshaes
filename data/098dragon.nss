// create new function that allows dragons to FLY to PCs

void FlyToPC(object oTarget = OBJECT_INVALID);

void FlyToPC(object oTarget = OBJECT_INVALID)
{
  if(GetIsObjectValid(oTarget))
  {
    SetLocalInt(OBJECT_SELF, "098dragonAI", 1);
    object oStrongestPC = GetFactionStrongestMember(oTarget, TRUE);
    // won't fly if closer than 10 meters to target, targets party's most powerful member
    // IF the party member is in the area
    if ((GetDistanceToObject(oStrongestPC) > 10.0) && (GetTag(GetArea(oStrongestPC))) == (GetTag(GetArea(OBJECT_SELF))))
    {
      ClearAllActions();
      location locPC = GetLocation(oStrongestPC);
      effect eDisApp = EffectDisappearAppear(locPC);
      ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eDisApp,OBJECT_SELF, 3.5);
      effect eShakeScreen = EffectVisualEffect(VFX_FNF_SCREEN_SHAKE, FALSE);
      DelayCommand(0.5,FloatingTextStringOnCreature("Dragon In Flight!", oTarget, TRUE));
      DelayCommand(3.5,ApplyEffectAtLocation(DURATION_TYPE_TEMPORARY, eShakeScreen, locPC, 1.0f));
      DelayCommand(4.0,ActionAttack(oStrongestPC));
    }
    // if the most powerful member of the party is not in the area
    // attack the currently targeted creature
    else if (GetDistanceToObject(oTarget) > 10.0)
    {
      ClearAllActions();
      location locPC = GetLocation(oTarget);
      effect eDisApp = EffectDisappearAppear(locPC);
      ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eDisApp,OBJECT_SELF, 3.5);
      effect eShakeScreen = EffectVisualEffect(VFX_FNF_SCREEN_SHAKE, FALSE);
      DelayCommand(0.5,FloatingTextStringOnCreature("Dragon In Flight!", oTarget, TRUE));
      DelayCommand(3.5,ApplyEffectAtLocation(DURATION_TYPE_TEMPORARY, eShakeScreen, locPC, 1.0f));
      DelayCommand(4.0,ActionAttack(oTarget));
    }
    else
      ActionAttack(oTarget);
  }
}
