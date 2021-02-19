#include "X0_I0_SPELLS"
#include "x2_inc_spellhook"

void main()
{
 object entered = GetEnteringObject();
 location spiderspawn = GetLocation(GetNearestObjectByTag("boo1"));
 effect spiderappear = EffectAppear();
 int i = (d2() + 4);
 if ((GetIsPC(entered) == TRUE) &&
    (GetLocalInt(OBJECT_SELF, "triggered1") == 0))
    {
        CreateObject(OBJECT_TYPE_CREATURE, "rn_spider_05", spiderspawn, TRUE);
    }

    if (GetLocalInt(OBJECT_SELF, "triggered1") == 0)
    {
        SetLocalInt(OBJECT_SELF, "triggered1", 1);
    }

    AssignCommand(GetNearestObjectByTag("rn_spider_05"), SetFacing(0.0));

    int iSaveDC = ExecuteScriptAndReturnInt("alfa_savedc", OBJECT_SELF);

    //Declare major variables
    effect eWeb = EffectEntangle();
    effect eVis = EffectVisualEffect(VFX_DUR_WEB);
    effect eLink = EffectLinkEffects(eWeb, eVis);
    object oTarget = GetEnteringObject();

    // * the lower the number the faster you go
    int nSlow = 65 - (GetAbilityScore(oTarget, ABILITY_STRENGTH)*2);
    if (nSlow <= 0)
    {
        nSlow = 1;
    }

    if (nSlow > 99)
    {
        nSlow = 99;
    }

    effect eSlow = EffectMovementSpeedDecrease(nSlow);

    {
         if(!GetHasFeat(FEAT_WOODLAND_STRIDE, oTarget) &&(GetCreatureFlag(oTarget, CREATURE_VAR_IS_INCORPOREAL) != TRUE) )
        {

                //Make a Fortitude Save to avoid the effects of the entangle.
                if(!MySavingThrow(SAVING_THROW_REFLEX, oTarget, iSaveDC))
                {
                    //Entangle effect and Web VFX impact
                    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oTarget, RoundsToSeconds(1));
                }
                SetLocalInt(OBJECT_SELF, "TriggerTrip", TRUE);
                //Slow down the creature within the Web
                ApplyEffectToObject(DURATION_TYPE_PERMANENT, eSlow, oTarget);

        }

    }


}
