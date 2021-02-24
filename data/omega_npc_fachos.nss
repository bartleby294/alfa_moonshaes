#include "omega_include"
void main()
{
int nFaction = GetLocalInt(oDM, "MULTI_FACTION");
     if (nFaction == FALSE)
    {
    ChangeToStandardFaction(oMyTarget,STANDARD_FACTION_HOSTILE);
    }
else if (nFaction == TRUE)
    {
        object oNPC = GetFirstObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_LARGE, lTargetLoc, TRUE, OBJECT_TYPE_CREATURE);
        while(GetIsObjectValid(oNPC))
        {
              ApplyEffectAtLocation ( DURATION_TYPE_INSTANT, EffectVisualEffect ( VFX_FNF_PWKILL), lTargetLoc);
              ChangeToStandardFaction(oNPC,STANDARD_FACTION_HOSTILE);

            oNPC = GetNextObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_LARGE, lTargetLoc, TRUE, OBJECT_TYPE_CREATURE);

            ChangeToStandardFaction(oNPC,STANDARD_FACTION_HOSTILE);
            ApplyEffectAtLocation ( DURATION_TYPE_INSTANT, EffectVisualEffect ( VFX_FNF_PWKILL), lTargetLoc);

        }
    }
}
