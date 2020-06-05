#include "omega_include"
void main()
{
object oSoundBox = GetLocalObject(oDM, "SOUND_BOX");

switch (Random(7))
{
case 0: AssignCommand ( oSoundBox, PlaySound("as_wt_thundercl1"));
    break;

case 1: AssignCommand ( oSoundBox, PlaySound("as_wt_thundercl2"));
    break;

case 2: AssignCommand ( oSoundBox, PlaySound("as_wt_thundercl3"));
    break;

case 3:  AssignCommand ( oSoundBox, PlaySound("as_wt_thundercl4"));
    break;

case 4: AssignCommand ( oSoundBox, PlaySound("as_wt_thunderds1"));
    break;

case 5: AssignCommand( oSoundBox, PlaySound("as_wt_thunderds2"));
    break;

case 6: AssignCommand( oSoundBox, PlaySound("as_wt_thunderds3"));
    break;

}
}

