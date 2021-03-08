//::///////////////////////////////////////////////
//:: Default On Damaged
//:: NW_C2_DEFAULT6
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    If already fighting then ignore, else determine
    combat round
*/
//:://////////////////////////////////////////////
//:: Created By: Preston Watamaniuk
//:: Created On: Oct 16, 2001
//:://////////////////////////////////////////////

void main()
{
    object oCreature = GetFirstObjectInShape(SHAPE_SPHERE,20.0,GetLocation(OBJECT_SELF),TRUE);
    ApplyEffectAtLocation(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_FNF_GAS_EXPLOSION_ACID),GetLocation(OBJECT_SELF));
    while(oCreature != OBJECT_INVALID)
    {
        if(oCreature != OBJECT_SELF){
        if(!ReflexSave(oCreature,30-FloatToInt(GetDistanceBetweenLocations(GetLocation(OBJECT_SELF),GetLocation(oCreature))),SAVING_THROW_TYPE_TRAP))
        {
            AssignCommand(oCreature,ActionSpeakString("*Struck by acid*"));
            ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectDamage(d6(5-FloatToInt(0.25*GetDistanceBetweenLocations(GetLocation(OBJECT_SELF),GetLocation(oCreature)))),DAMAGE_TYPE_ACID),oCreature);
        }
        }
        oCreature = GetNextObjectInShape(SHAPE_SPHERE,20.0,GetLocation(OBJECT_SELF),TRUE);
    }
    DestroyObject(OBJECT_SELF);
}
