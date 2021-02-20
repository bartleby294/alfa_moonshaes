#include "_btb_craft_util"

void main()
{
    object oPC = GetEnteringObject();
    if(HasItem("moonwellwater", oPC) == TRUE) {
        AssignCommand(oPC,
                     ActionSpeakString("*The Moonwell Water starts to glow.*"));
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY,
                       EffectVisualEffect(VFX_DUR_LIGHT_WHITE_20), oPC, 120.0);

    }
}
