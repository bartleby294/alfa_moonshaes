
void main()
{
object oDM = GetLastSpeaker();
object oMyTarget = GetLocalObject(oDM, "OMWandTarget");
location lTargetLoc = GetLocalLocation(oDM, "OMWandLoc");
location lDMLoc = GetLocation (oDM);
int nRandom;
float fRandom;
effect eEffect;
object oCaster;
AssignCommand ( oDM, ApplyEffectAtLocation ( DURATION_TYPE_INSTANT, EffectVisualEffect ( VFX_FNF_SOUND_BURST), lTargetLoc));
   }
