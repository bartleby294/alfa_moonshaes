/****************************************************
  Persistent Data Wrapper Script
  ats_inc_persist

  Last Updated: July 15, 2002

  ***Ambrosia Tradeskill System***
    Created by Mojo(Allen Sun)

  This script contains wrapper functions for a
  persistent data solution. Right now, it just
  wraps the GetLocal and SetLocal functions.
***************************************************/

#include "rr_persist"

int ATS_GetPersistentInt(object oObject, string sVarName)
{
    return GPI(oObject, sVarName);
}
float ATS_GetPersistentFloat(object oObject, string sVarName)
{
    return GPF(oObject, sVarName);
}
location ATS_GetPersistentLocation(object oObject, string sVarName)
{
    return GPLoc(oObject, sVarName);
}
string  ATS_GetPersistentString(object oObject, string sVarName)
{
    return GPStr(oObject, sVarName);
}
object ATS_GetPersistentObject(object oObject, string sVarName)
{
    return GetLocalObject(oObject, sVarName);
}

void ATS_SetPersistentInt(object oObject, string sVarName, int nValue)
{
    SPI(oObject, sVarName, nValue);
}
void ATS_SetPersistentFloat(object oObject, string sVarName, float fValue)
{
    SPF(oObject, sVarName, fValue);
}
void ATS_SetPersistentLocation(object oObject, string sVarName, location lValue)
{
    SPLoc(oObject, sVarName, lValue);
}
void  ATS_SetPersistentString(object oObject, string sVarName, string sValue)
{
    SPStr(oObject, sVarName, sValue);
}

void ATS_SetPersistentObject(object oObject, string sVarName, object oValue)
{
    SetLocalObject(oObject, sVarName, oValue);
}


