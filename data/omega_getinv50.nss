#include "omega_include"
void main()
{
string sInventory = GetInventory(GetLocalObject(GetPCSpeaker(), "OMWandTarget"), 50);
//SendMessageToPC(oDM, sInventory);
SetCustomToken(6905, sInventory);

}
