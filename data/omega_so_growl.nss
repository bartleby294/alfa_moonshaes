#include "omega_include"
void main()
{
object oSoundBox = GetLocalObject(oDM, "SOUND_BOX");

switch (Random(4))
{
case 0: AssignCommand ( oSoundBox, PlaySound("c_zombwar_bat1"));
    break;

case 1: AssignCommand ( oSoundBox, PlaySound("c_slaadwek_bat2"));
    break;

case 2: AssignCommand ( oSoundBox, PlaySound("c_slaadwek_bat2"));
    break;

case 3:  AssignCommand ( oSoundBox, PlaySound("c_slaadpow_bat1"));
    break;

}

}
