
#include "omega_include"
void main()
{
effect eEffect = EffectPoison(POISON_IRON_GOLEM);

object oNPC = GetFirstObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_LARGE, lTargetLoc, TRUE, OBJECT_TYPE_CREATURE);
        while(GetIsObjectValid(oNPC))
        {
              ApplyEffectAtLocation ( DURATION_TYPE_INSTANT, EffectVisualEffect ( VFX_FNF_GAS_EXPLOSION_ACID), lTargetLoc);
              ApplyEffectToObject(DURATION_TYPE_PERMANENT, eEffect, oMyTarget);

            oNPC = GetNextObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_LARGE, lTargetLoc, TRUE, OBJECT_TYPE_CREATURE);
              ApplyEffectToObject(DURATION_TYPE_PERMANENT, eEffect, oMyTarget);

        }
 }

