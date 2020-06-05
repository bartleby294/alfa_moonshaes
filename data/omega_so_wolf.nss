#include "omega_include"
void main()
{
object oSoundBox = GetLocalObject(oDM, "SOUND_BOX");

   switch (Random(4))
   {
      case 0: AssignCommand ( oSoundBox, PlaySound("as_an_wolfhowl1"));
              break;
      case 1: AssignCommand ( oSoundBox, PlaySound("as_an_wolfhowl2"));
              break;
      case 2: AssignCommand ( oSoundBox, PlaySound("as_an_wolveshwl1"));
              break;
      case 3: AssignCommand ( oSoundBox, PlaySound("as_an_wolveshow2"));
              break;
   }
}
