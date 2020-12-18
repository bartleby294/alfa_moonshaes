#include "nw_i0_generic"

void Kaboom(location lLoc, object oPC)
{
    object oCreature = GetFirstObjectInShape(SHAPE_SPHERE,20.0,lLoc,TRUE);;
    while(oCreature != OBJECT_INVALID)
    {
        if(!ReflexSave(oCreature,30-FloatToInt(GetDistanceBetweenLocations(lLoc,GetLocation(oCreature))),SAVING_THROW_TYPE_TRAP))
        {
            ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_FNF_GAS_EXPLOSION_FIRE),oCreature);
            ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectDamage(d4(5-FloatToInt(0.25*GetDistanceBetweenLocations(lLoc,GetLocation(oCreature)))),DAMAGE_TYPE_PIERCING),oCreature);
            SetIsTemporaryEnemy(oCreature,oPC,TRUE,300.0);
            SetIsTemporaryEnemy(oPC,oCreature,TRUE,300.0);
        }
        oCreature = GetNextObjectInShape(SHAPE_SPHERE,20.0,lLoc,TRUE);
    }
}

void main()
{
    location lLoc = GetItemActivatedTargetLocation();
    object oTarget = GetItemActivatedTarget();
    object oItem = GetItemActivated();
    string sItem = GetTag(oItem);

    int iOdds = d100() + GetSkillRank(SKILL_SET_TRAP,OBJECT_SELF);
    if(GetRacialType(OBJECT_SELF) == RACIAL_TYPE_GNOME)
        iOdds = iOdds + 5;
    if(iOdds <= 18)
    {
        ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectDamage(d6(),DAMAGE_TYPE_FIRE),OBJECT_SELF);
        FloatingTextStringOnCreature("It backfired!",OBJECT_SELF,FALSE);
    }
    else if(iOdds <= 36)
    {
        ApplyEffectAtLocation(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_FNF_SMOKE_PUFF),lLoc);
        FloatingTextStringOnCreature("It was a dud...",OBJECT_SELF,FALSE);
    }
    else if(sItem == "004INVMechanicalBadger")
    {
        CreateObject(OBJECT_TYPE_CREATURE,"mechanicalbadger",GetLocation(OBJECT_SELF),FALSE);
    }
    else if(sItem == "004INVPuppy")
    {
        CreateObject(OBJECT_TYPE_CREATURE,"annoyingpuppy",GetLocation(OBJECT_SELF),FALSE);
    }
    else if(sItem == "004INVRepellor")
    {
        ApplyEffectAtLocation(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_FNF_HOWL_ODD),lLoc);
        object oCreature = GetFirstObjectInShape(SHAPE_SPHERE,20.0,lLoc,TRUE);
        while(oCreature != OBJECT_INVALID)
        {
            if(oCreature != OBJECT_SELF)
            {
                AssignCommand(oCreature,ActionMoveAwayFromLocation(lLoc,TRUE,20.0));
                ApplyEffectToObject(DURATION_TYPE_TEMPORARY,EffectBeam(VFX_BEAM_ODD,OBJECT_SELF,BODY_NODE_CHEST),oCreature,0.5);
            }
            oCreature = GetNextObjectInShape(SHAPE_SPHERE,20.0,lLoc,TRUE);;
        }
    }
    else if(sItem == "004INVScattershot")
    {
        ApplyEffectAtLocation(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_FNF_SMOKE_PUFF),lLoc);
        DelayCommand(3.0,ApplyEffectAtLocation(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_FNF_SMOKE_PUFF),lLoc));
        DelayCommand(6.0,ApplyEffectAtLocation(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_FNF_SMOKE_PUFF),lLoc));
        DelayCommand(10.0,ApplyEffectAtLocation(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_FNF_GAS_EXPLOSION_FIRE),lLoc));
        DelayCommand(10.0,Kaboom(lLoc,OBJECT_SELF));
    }
    else if(sItem == "004INVGongofThunder")
    {
        ApplyEffectAtLocation(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_FNF_HOWL_MIND),lLoc);
        AssignCommand(OBJECT_SELF,PlaySound("as_cv_gongring2"));
        object oCreature = GetFirstObjectInShape(SHAPE_SPHERE,10.0,lLoc,TRUE);;
        while(oCreature != OBJECT_INVALID)
        {
            if(oCreature != OBJECT_SELF && !GetHasEffect(EFFECT_TYPE_DEAF,oCreature))
            {
                if(!FortitudeSave(oCreature,15,SAVING_THROW_TYPE_CHAOS))
                {
                    ApplyEffectToObject(DURATION_TYPE_TEMPORARY,EffectDazed(),oCreature,IntToFloat(d6(5)));
                    SetIsTemporaryEnemy(oCreature,OBJECT_SELF,TRUE,300.0);
                    SetIsTemporaryEnemy(OBJECT_SELF,oCreature,TRUE,300.0);
                }

            }
            oCreature = GetNextObjectInShape(SHAPE_SPHERE,10.0,lLoc,TRUE);
        }
        oCreature = GetFirstObjectInShape(SHAPE_SPHERE,30.0,lLoc,TRUE);;
        while(oCreature != OBJECT_INVALID)
        {
            if((oCreature != OBJECT_SELF)&& (GetHasEffect(EFFECT_TYPE_DEAF,oCreature) == FALSE))
            {
                ApplyEffectToObject(DURATION_TYPE_TEMPORARY,EffectDeaf(),oCreature,IntToFloat(d6(5)));
                SetIsTemporaryEnemy(oCreature,OBJECT_SELF,TRUE,300.0);
                SetIsTemporaryEnemy(OBJECT_SELF,oCreature,TRUE,300.0);
            }
            oCreature = GetNextObjectInShape(SHAPE_SPHERE,30.0,lLoc,TRUE);
        }
    }
    else if(sItem == "004INVResonator")
    {
        ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_FNF_HOWL_ODD),OBJECT_SELF);
        object oTrap = GetFirstObjectInShape(SHAPE_SPHERE,50.0,lLoc,TRUE,OBJECT_TYPE_TRIGGER);
        while(oTrap != OBJECT_INVALID)
        {
            if((GetIsTrapped(oTrap)) && (GetTrapDisarmDC(oTrap) <= 25))
            {
                AssignCommand(oTrap,PlaySound("as_sw_lever1"));
                DestroyObject(oTrap,2.5);
            }
            else if((GetIsTrapped(oTrap)) && (GetTrapDisarmDC(oTrap) > 28))
            {
                ApplyEffectAtLocation(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_FNF_SMOKE_PUFF),GetLocation(oTrap));
            }
            oTrap = GetNextObjectInShape(SHAPE_SPHERE,50.0,lLoc,TRUE,OBJECT_TYPE_TRIGGER);
        }
    }
}
