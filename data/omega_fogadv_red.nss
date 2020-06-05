#include "omega_include"
void main()
{
string sString, sFull, sTest;

sString = GetLocalString(oDM, "ADVANCED_CONSTRUCT");

sFull = GetStringLeft(sString, 6);
SendMessageToAllDMs(sFull);
SetLocalString(oDM, "ADVANCED_CONSTRUCT", sFull + "RED");
sString = GetLocalString(oDM, "ADVANCED_CONSTRUCT");
//SendMessageToAllDMs(sString);
}
