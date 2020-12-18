#include "nw_i0_generic"

void main()
{
    object oPC = GetItemActivator();
    object oItem = GetItemActivated();
    object oTarget = GetItemActivatedTarget();
    location lTarget = GetLocation(oTarget);
    string sItem = GetTag(oItem);
    string sName = GetName(oItem);
    location lLoc = GetItemActivatedTargetLocation();
    string sRef = GetResRef(oItem);
    object oCreature;
    int iDur;
    effect eEffect;
    int iTemp = 0;

    if(GetDistanceBetween(oPC,oTarget) < IntToFloat(3*GetAbilityScore(oPC,ABILITY_STRENGTH)))
    {
        if(sItem == "004GRENBamsmack")
        {
            ApplyEffectAtLocation(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_FNF_GAS_EXPLOSION_FIRE),lLoc);
            oCreature = GetFirstObjectInShape(SHAPE_SPHERE,RADIUS_SIZE_MEDIUM,lLoc,TRUE);;
            while((oCreature != OBJECT_INVALID) && (oCreature != oPC))
            {
                if(!FortitudeSave(oCreature,15,SAVING_THROW_TYPE_SPELL))
                {
                    ApplyEffectToObject(DURATION_TYPE_TEMPORARY,EffectDeaf(),oCreature,RoundsToSeconds(d6()));
                }
                if(GetIsReactionTypeNeutral(oPC,oCreature))
                {
                    SetIsTemporaryEnemy(oCreature,oPC);
                    SetIsTemporaryEnemy(oPC,oCreature);
                }
                oCreature = GetNextObjectInShape(SHAPE_SPHERE,RADIUS_SIZE_MEDIUM,lLoc,TRUE);;
            }
            DestroyObject(oItem);
        }
        else if(sItem == "004GRENSleepingGas")
        {
            ApplyEffectAtLocation(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_FNF_GAS_EXPLOSION_MIND),lLoc);
            oCreature = GetFirstObjectInShape(SHAPE_SPHERE,RADIUS_SIZE_SMALL,lLoc,TRUE);
            while(oCreature != OBJECT_INVALID)
            {
                if(!FortitudeSave(oCreature,15,SAVING_THROW_TYPE_SPELL))
                {
                    ApplyEffectToObject(DURATION_TYPE_TEMPORARY,EffectSleep(),oCreature,RoundsToSeconds(d6()));
                }
                if(GetIsReactionTypeNeutral(oPC,oCreature))
                {
                    SetIsTemporaryEnemy(oCreature,oPC);
                    SetIsTemporaryEnemy(oPC,oCreature);
                }

                oCreature = GetNextObjectInShape(SHAPE_SPHERE,RADIUS_SIZE_SMALL,lLoc,TRUE);;
            }
            DestroyObject(oItem);
        }
        else if(sItem == "004GRENMancatcher")
        {
            if(oTarget != OBJECT_INVALID)
            {
                if(TouchAttackRanged(oTarget,TRUE))
                {
                    if(!ReflexSave(oTarget,15))
                        iDur = d3(2);
                    else
                        iDur = d3();
                    ApplyEffectToObject(DURATION_TYPE_TEMPORARY,EffectParalyze(),oTarget,RoundsToSeconds(iDur));
                    ApplyEffectToObject(DURATION_TYPE_TEMPORARY,EffectVisualEffect(VFX_DUR_WEB),oTarget,RoundsToSeconds(iDur));
                }
                if(GetIsReactionTypeNeutral(oPC,oTarget))
                {
                    SetIsTemporaryEnemy(oTarget,oPC);
                    SetIsTemporaryEnemy(oPC,oTarget);
                }
                DestroyObject(oItem);
            }
            else
                FloatingTextStringOnCreature("You must target an object.",oPC,FALSE);
        }
        else if(sItem == "004GRENPotionOfFireBreath")
        {
            if(oTarget != OBJECT_INVALID)
            {
                iDur = d6(3);
                if(ReflexSave(oTarget,12))
                    iDur = iDur/2;
                DelayCommand(0.5,ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectDamage(iDur,DAMAGE_TYPE_FIRE,DAMAGE_POWER_NORMAL),oTarget));
                DelayCommand(0.5,ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_COM_HIT_FIRE),oTarget));
                if(GetIsReactionTypeNeutral(oPC,oTarget))
                {
                    SetIsTemporaryEnemy(oTarget,oPC);
                    SetIsTemporaryEnemy(oPC,oTarget);
                }
                DestroyObject(oItem);
            }
            else
                FloatingTextStringOnCreature("You must target an object.",oPC,FALSE);
        }
        else if(sItem == "004GRENThievingMarbles")
        {
            oCreature = GetFirstObjectInShape(SHAPE_SPHERE,RADIUS_SIZE_SMALL,lLoc,TRUE);
            while(oCreature != OBJECT_INVALID)
            {
                if(!ReflexSave(oCreature,12,SAVING_THROW_TYPE_TRAP))
                {
                    if(!ReflexSave(oCreature,12,SAVING_THROW_TYPE_TRAP))
                        ApplyEffectToObject(DURATION_TYPE_TEMPORARY,EffectKnockdown(),oCreature,RoundsToSeconds(1));
                    else ApplyEffectToObject(DURATION_TYPE_TEMPORARY,EffectMovementSpeedDecrease(50),oCreature,RoundsToSeconds(1));
                }
                if(GetIsReactionTypeNeutral(oPC,oCreature))
                {
                    SetIsTemporaryEnemy(oCreature,oPC);
                    SetIsTemporaryEnemy(oPC,oCreature);
                }
                oCreature = GetNextObjectInShape(SHAPE_SPHERE,RADIUS_SIZE_SMALL,lLoc,TRUE);;
            }
            DestroyObject(oItem);
        }
        else if(sItem == "004GRENDazzler")
        {
            ApplyEffectAtLocation(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_FNF_IMPLOSION),lLoc);
            object oCreature = GetFirstObjectInShape(SHAPE_SPHERE,RADIUS_SIZE_LARGE,lLoc,TRUE);;
            while((oCreature != OBJECT_INVALID) && (oCreature != oPC))
            {
                if(!WillSave(oCreature,12,SAVING_THROW_TYPE_FEAR))
                {
                    ApplyEffectToObject(DURATION_TYPE_TEMPORARY,EffectFrightened(),oCreature,RoundsToSeconds(d6()));
                }
                if(GetIsReactionTypeNeutral(oPC,oCreature))
                {
                    SetIsTemporaryEnemy(oCreature,oPC);
                    SetIsTemporaryEnemy(oPC,oCreature);
                }
                oCreature = GetNextObjectInShape(SHAPE_SPHERE,RADIUS_SIZE_LARGE,lLoc,TRUE);;
            }
            DestroyObject(oItem);
        }
        else if(sItem == "004GRENStinkbomb")
        {
            ApplyEffectAtLocation(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_FNF_GAS_EXPLOSION_GREASE),lLoc);
            object oCreature = GetFirstObjectInShape(SHAPE_SPHERE,RADIUS_SIZE_LARGE,lLoc,TRUE);;
            while(oCreature != OBJECT_INVALID)
            {
                if(!FortitudeSave(oCreature,12,SAVING_THROW_TYPE_POISON))
                {
                    ApplyEffectToObject(DURATION_TYPE_TEMPORARY,EffectDazed(),oCreature,RoundsToSeconds(d6()));
                }
                if(GetIsReactionTypeNeutral(oPC,oCreature))
                {
                    SetIsTemporaryEnemy(oCreature,oPC);
                    SetIsTemporaryEnemy(oPC,oCreature);
                }
                oCreature = GetNextObjectInShape(SHAPE_SPHERE,RADIUS_SIZE_LARGE,lLoc,TRUE);;
            }
            DestroyObject(oItem);
        }
        else if(sItem == "004GRENFlashpellet")
        {
            ApplyEffectAtLocation(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_FNF_GAS_EXPLOSION_FIRE),lLoc);
            object oCreature = GetFirstObjectInShape(SHAPE_SPHERE,RADIUS_SIZE_LARGE,lLoc,TRUE);;
            while(oCreature != OBJECT_INVALID)
            {
                if(!ReflexSave(oCreature,15,SAVING_THROW_TYPE_SPELL))
                {
                    ApplyEffectToObject(DURATION_TYPE_TEMPORARY,EffectAttackDecrease(1,ATTACK_BONUS_MISC),oCreature,RoundsToSeconds(d6()));
                }
                if(GetIsReactionTypeNeutral(oPC,oCreature))
                {
                    SetIsTemporaryEnemy(oCreature,oPC);
                    SetIsTemporaryEnemy(oPC,oCreature);
                }
                oCreature = GetNextObjectInShape(SHAPE_SPHERE,RADIUS_SIZE_LARGE,lLoc,TRUE);;
            }
            DestroyObject(oItem);
        }
        else if(sItem == "004GRENGlowpowder")
        {
            ApplyEffectAtLocation(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_FNF_GAS_EXPLOSION_GREASE),lLoc);
            object oCreature = GetFirstObjectInShape(SHAPE_SPHERE,RADIUS_SIZE_COLOSSAL,lLoc,TRUE);;
            while(oCreature != OBJECT_INVALID)
            {
                int iDur = d6();
                ApplyEffectToObject(DURATION_TYPE_TEMPORARY,EffectSkillDecrease(SKILL_HIDE,2),oCreature,RoundsToSeconds(iDur));
                ApplyEffectToObject(DURATION_TYPE_TEMPORARY,EffectSkillDecrease(SKILL_MOVE_SILENTLY,2),oCreature,RoundsToSeconds(iDur));
                if(GetIsReactionTypeNeutral(oPC,oCreature))
                {
                    SetIsTemporaryEnemy(oCreature,oPC);
                    SetIsTemporaryEnemy(oPC,oCreature);
                }
                oCreature = GetNextObjectInShape(SHAPE_SPHERE,RADIUS_SIZE_COLOSSAL,lLoc,TRUE);;
            }
            DestroyObject(oItem);
        }
        else if(sItem == "004GRENWitchweedStick")
        {
            ApplyEffectAtLocation(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_FNF_SMOKE_PUFF),lLoc);
            object oCreature = GetFirstObjectInShape(SHAPE_CUBE,RADIUS_SIZE_GARGANTUAN,lLoc,TRUE);;
            while(oCreature != OBJECT_INVALID)
            {
                if(!WillSave(oCreature,15,SAVING_THROW_TYPE_SPELL))
                {
                    ApplyEffectToObject(DURATION_TYPE_TEMPORARY,EffectSkillDecrease(SKILL_CONCENTRATION,4),oCreature,RoundsToSeconds(d6()));
                }
                if(GetIsReactionTypeNeutral(oPC,oCreature))
                {
                    SetIsTemporaryEnemy(oCreature,oPC);
                    SetIsTemporaryEnemy(oPC,oCreature);
                }
                oCreature = GetNextObjectInShape(SHAPE_CUBE,RADIUS_SIZE_GARGANTUAN,lLoc,TRUE);;
            }
            DestroyObject(oItem);
        }
    }
    else
        FloatingTextStringOnCreature("Your reach isn't that good.",oPC,FALSE);
}


  /*****************************************************/

