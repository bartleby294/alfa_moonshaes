#include "omega_include"
void main()
{
object oSoundBox = GetLocalObject(oDM, "SOUND_BOX");

switch (Random(5))
{
case 0: AssignCommand ( oSoundBox, PlaySound("c_werecat_bat2"));
    break;

case 1: AssignCommand ( oSoundBox, PlaySound("c_werecat_bat1"));
    break;

case 2: AssignCommand ( oSoundBox, PlaySound("c_catlion_bat1"));
    break;

case 3:  AssignCommand ( oSoundBox, PlaySound("c_catpanth_bat1"));
    break;

case 4: AssignCommand ( oSoundBox, PlaySound("c_cat_bat2"));
    break;
}

}

