#include "X0_I0_SPELLS"
#include "x2_inc_spellhook"

void main()
{
    object entered = GetEnteringObject();
    location spiderspawn = GetLocation(GetNearestObjectByTag("boo1"));
    effect spiderappear = EffectAppear();
    int i = (d2() + 4);
    int i2;

    if ((GetIsPC(entered) == TRUE) && (!GetLocalInt(OBJECT_SELF, "triggered1") == 1)) {

        while (i2 < i) {
            switch (Random(10)) {
            case 0:
                CreateObject(OBJECT_TYPE_CREATURE, "rn_spider_01", spiderspawn);
                break;
            case 1:
                CreateObject(OBJECT_TYPE_CREATURE, "rn_spider_01", spiderspawn);
                break;
            case 2:
                CreateObject(OBJECT_TYPE_CREATURE, "rn_spider_01", spiderspawn);
                break;
            case 3:
                CreateObject(OBJECT_TYPE_CREATURE, "tinyspider", spiderspawn);
                break;
            case 4:
                CreateObject(OBJECT_TYPE_CREATURE, "tinyspider001", spiderspawn);
                break;
            case 5:
                CreateObject(OBJECT_TYPE_CREATURE, "tinyspider002", spiderspawn);
                break;
            case 6:
                CreateObject(OBJECT_TYPE_CREATURE, "rn_spider_01", spiderspawn);
                break;
            case 7:
                CreateObject(OBJECT_TYPE_CREATURE, "rn_spider_02", spiderspawn);
                break;
            case 8:
                CreateObject(OBJECT_TYPE_CREATURE, "rn_spider_02", spiderspawn);
                break;
            case 9:
                CreateObject(OBJECT_TYPE_CREATURE, "rn_spider_02", spiderspawn);
                break;
            }
            i2++;
        }
        SetLocalInt(OBJECT_SELF, "triggered1", 1);

        if (!GetLocalInt(OBJECT_SELF, "webded") == 1) {
            int iSaveDC = ExecuteScriptAndReturnInt("alfa_savedc", OBJECT_SELF);

            //Declare major variables
            effect eWeb = EffectEntangle();
            effect eVis = EffectVisualEffect(VFX_DUR_WEB);
            effect eLink = EffectLinkEffects(eWeb, eVis);
            object oTarget = GetEnteringObject();

            // * the lower the number the faster you go
            int nSlow = 65 - (GetAbilityScore(oTarget, ABILITY_STRENGTH) * 2);
            if (nSlow <= 0) {
                nSlow = 1;
            }

            if (nSlow > 99) {
                nSlow = 99;
            }

            effect eSlow = EffectMovementSpeedDecrease(nSlow);

            {
                if (!GetHasFeat(FEAT_WOODLAND_STRIDE, oTarget) && (GetCreatureFlag(oTarget, CREATURE_VAR_IS_INCORPOREAL) != TRUE)) {

                    //Make a Fortitude Save to avoid the effects of the entangle.
                    if (!MySavingThrow(SAVING_THROW_REFLEX, oTarget, iSaveDC)) {
                        //Entangle effect and Web VFX impact
                        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oTarget, RoundsToSeconds(1));
                    }
                    SetLocalInt(OBJECT_SELF, "TriggerTrip", TRUE);
                    //Slow down the creature within the Web
                    ApplyEffectToObject(DURATION_TYPE_PERMANENT, eSlow, oTarget);
                }
            }
        }
    }
}
