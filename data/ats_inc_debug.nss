/****************************************************
  Debug Script
  ats_inc_debug

  Last Updated: August 15 2002

  ***Ambrosia Tradeskill System***
    Created by Mojo(Allen Sun)

  This script contains debug output functions which
  can be turned on or off by a flag.
****************************************************/

int CINT_DEBUG_FLAG = FALSE;

void DEBUG_PrintString(string sDebugString)
{
    if(CINT_DEBUG_FLAG == FALSE)
        return;
    SendMessageToAllDMs(sDebugString);
    PrintString(sDebugString);
}

void DEBUG_PrintInteger(int iDebugInt)
{
    if(CINT_DEBUG_FLAG == FALSE)
        return;
    SendMessageToAllDMs(IntToString(iDebugInt));
    PrintInteger(iDebugInt);
}

void DEBUG_PrintFloat(float fDebugFloat)
{
    if(CINT_DEBUG_FLAG == FALSE)
        return;
    SendMessageToAllDMs(FloatToString(fDebugFloat));
    PrintFloat(fDebugFloat);
}
void DEBUG_PrintVector(vector vDebugVector)
{
    if(CINT_DEBUG_FLAG == FALSE)
        return;
    SendMessageToAllDMs("Vector.X: " + FloatToString(vDebugVector.x) + "     " +
                        "Vector.Y: " + FloatToString(vDebugVector.y));
    PrintVector(vDebugVector, TRUE);
}

void DEBUG_PrintObject(object oDebugObject)
{
    if(CINT_DEBUG_FLAG == FALSE)
        return;
    SendMessageToAllDMs(GetTag(oDebugObject));
    PrintObject(oDebugObject);
}

void DEBUG_SendMessageToPC(object oPlayer, string sDebugString)
{
    if(CINT_DEBUG_FLAG == FALSE)
        return;
    SendMessageToPC(oPlayer, sDebugString);
}

void DEBUG_SpeakString(string sSpeakString, int iTalkVolume = TALKVOLUME_TALK)
{
    if(CINT_DEBUG_FLAG == FALSE)
       return;
    SpeakString(sSpeakString, iTalkVolume);
}
