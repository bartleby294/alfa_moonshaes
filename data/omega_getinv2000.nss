#include "omega_include"
void main()
{
string sInventory = GetInventory(GetLocalObject(GetPCSpeaker(), "OMWandTarget"), 2000);
//SendMessageToPC(oDM, sInventory);
SetCustomToken(6905, sInventory);

}
