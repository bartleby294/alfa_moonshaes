#include "omega_include"
void main()
{

AssignCommand(GetObjectByTag("omega_dietyghost"), ActionSpeakString("Fare thee well"));
DelayCommand(0.5, DestroyObject(GetObjectByTag("omega_dietyghost"), 0.0));
}
