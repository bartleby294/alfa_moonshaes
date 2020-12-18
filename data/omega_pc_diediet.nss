#include "omega_include"
void main()
{
object oDM = GetLastSpeaker();

string sDiety = GetLocalString(oDM, "dietyvar");
SetDeity(oMyTarget,sDiety);
//Preforming clean up
AssignCommand(GetObjectByTag("omega_dietyghost"), ActionSpeakString("Fare thee well"));
//DelayCommand(0.5, DestroyObject(GetObjectByTag("omega_dietyghost"), 0.0));
DestroyObject( GetLocalObject(oDM, OMW_DEITY_MASTER_LO), 0.5);
DeleteLocalObject(oDM, OMW_DEITY_MASTER_LO);
DeleteLocalString(oDM, "dietyvar");
}
