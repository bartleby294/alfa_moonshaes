#include "alfa_overrides_i"
#include "omega_include"
void main()
{

if (GetIsSkillSuccessful(oMyTarget, SKILL_TUMBLE, 20))
 {
FloatingTextStringOnCreature("You trip wile running but maintain your footing, keeping you from falling. Better slow down.", oMyTarget);
}
else
{
effect eEffect;
eEffect = EffectKnockdown();
ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eEffect, oMyTarget, 4.0f);

eEffect = EffectDamage(1, DAMAGE_TYPE_BLUDGEONING, DAMAGE_POWER_NORMAL);
ApplyEffectToObject(DURATION_TYPE_INSTANT, eEffect, oMyTarget);
FloatingTextStringOnCreature("You tripped wile running, hurting your self. Ouch", oMyTarget);
 }
}
