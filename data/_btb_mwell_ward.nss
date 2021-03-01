#include "_btb_util"

void main()
{
    object oPC = GetEnteringObject();

    // If were dm possesed stop AI.
    if(GetIsDMPossessed(oPC)) {
        return;
    }

    int DM_OVERRIDE = GetLocalInt(GetArea(oPC), "AllowMoonwellEnter");

    if(GetIsPC(oPC) == TRUE && DM_OVERRIDE == FALSE) {
        AssignCommand(oPC, PlaySound("as_mg_telepout1"));
        effect vfx = EffectVisualEffect(VFX_FNF_SOUND_BURST_SILENT);
        ApplyEffectToObject(DURATION_TYPE_INSTANT, vfx, oPC);
        location jumpTo = pickLoc(oPC, 5.0, 180.0);
        AssignCommand(oPC, ActionJumpToLocation(jumpTo));
    }
}
