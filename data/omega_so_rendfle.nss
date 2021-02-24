#include "omega_include"
void main()
{
object oSoundBox = GetLocalObject(oDM, "SOUND_BOX");
AssignCommand ( oSoundBox, PlaySound("c_ghoul_bat2"));
}
