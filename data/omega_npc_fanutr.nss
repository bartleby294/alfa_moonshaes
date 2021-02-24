#include "omega_include"
void main()
{
int nFaction = GetLocalInt(oDM, "MULTI_FACTION");
     if (nFaction == FALSE)
    {
object oTarget = GetObjectByTag ("omega_neutralfdrone");
ChangeFaction(oMyTarget,oTarget);
    }
else if (nFaction == TRUE)
    {
        object oNPC = GetFirstObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_LARGE, lTargetLoc, TRUE, OBJECT_TYPE_CREATURE);
        while(GetIsObjectValid(oNPC))
        {
              ApplyEffectAtLocation ( DURATION_TYPE_INSTANT, EffectVisualEffect ( VFX_FNF_PWKILL), lTargetLoc);
              ChangeFaction(oNPC,oNPC);

            oNPC = GetNextObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_LARGE, lTargetLoc, TRUE, OBJECT_TYPE_CREATURE);

            ChangeFaction(oMyTarget,oNPC);
            ApplyEffectAtLocation ( DURATION_TYPE_INSTANT, EffectVisualEffect ( VFX_FNF_PWKILL), lTargetLoc);

        }
    }
}
