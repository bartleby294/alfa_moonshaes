#include "omega_include"
void main()
{
object oSoundBox = GetLocalObject(oDM, "SOUND_BOX");

    AssignCommand (oSoundBox, PlaySound("as_na_leafmove2"));
}

