#include "omega_include"
void main()
{
string sInventory = GetInventory(oMyTarget);
SendMessageToPC(oDM, sInventory);
SetCustomToken(6905, sInventory);

}
