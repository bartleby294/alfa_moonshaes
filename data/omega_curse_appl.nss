#include "omega_include"
void main()
{
int nSTR, nDEX, nCON, nINT, nWIS, nCHR;

nSTR = GetLocalInt(oDM, "CURSE_STR");
nDEX = GetLocalInt(oDM, "CURSE_STR");
nCON = GetLocalInt(oDM, "CURSE_STR");
nINT = GetLocalInt(oDM, "CURSE_STR");
nWIS = GetLocalInt(oDM, "CURSE_STR");
nCHR = GetLocalInt(oDM, "CURSE_STR");

effect eVis = EffectVisualEffect(VFX_IMP_REDUCE_ABILITY_SCORE);
effect eCurse = EffectCurse(nSTR, nDEX, nCON, nINT, nWIS, nCHR );

//ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oMyTarget);
//ApplyEffectToObject(DURATION_TYPE_PERMANENT, eCurse, oMyTarget);
AssignCommand(GetPCSpeaker(), ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oMyTarget));
AssignCommand(GetPCSpeaker(), ApplyEffectToObject(DURATION_TYPE_PERMANENT, eCurse, oMyTarget));
}
