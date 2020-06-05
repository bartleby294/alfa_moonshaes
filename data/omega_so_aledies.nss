#include "omega_include"
void main()
{
object oSoundBox = GetLocalObject(oDM, "SOUND_BOX");


switch (Random(7))
{
case 0: AssignCommand ( oSoundBox, PlaySound("as_pl_shriekm3"));
    break;

case 1: AssignCommand ( oSoundBox, PlaySound("as_pl_screamm5"));
    break;

case 2: AssignCommand ( oSoundBox, PlaySound("as_pl_screamm4"));
    break;

case 3:  AssignCommand ( oSoundBox, PlaySound("as_pl_screamm3"));
    break;

case 4: AssignCommand ( oSoundBox, PlaySound("as_pl_screamm2"));
    break;

case 5: AssignCommand( oSoundBox, PlaySound("as_pl_screamm1"));
    break;

case 6: AssignCommand( oSoundBox, PlaySound("as_pl_ailingm4"));
    break;

}
}
