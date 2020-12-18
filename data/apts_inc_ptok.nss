/****************************************************
  Persistent Token Main Include Script
  apts_inc_ptok

  Last Updated: September 26, 2002

  ***Ambrosia Persistent Token System***
    Created by Mojo(Allen Sun)

  This script is the main include script and is
  needed to declare, set, and get token data.
  Include this script in any other script where you
  need access persistent token data.

****************************************************/
#include "apts_const_ptok"
#include "apts_inc_toksys"

/* Function Declarations */

// Call this to declare an integer token, the size is the number of token range
// to reserve and determines the max size of the integer.
// (Sizes are APTS_LARGE_INT, APTS_MEDIUM_INT and APTS_SMALL_INT)
// Large integers take up 3 slots, medium take up 2, and small take up 1
void DeclareTokenInt(string sVarName, int iSlotNum, int bSigned = TRUE, int iSize = 3);
// Call this to declare a boolean token. In addition to declaring a slot number,
// you must also declare a bit position between 0-10.  You can declare up to
// 11 booleans in one slot.
void DeclareTokenBool(string sVarName, int iSlotNum, int iBitNum);
// Call this to declare a float token. You need to declare a unique slot.
// Floats take up 3 slots.
void DeclareTokenFloat(string sVarName, int iSlotNum, int b22Bit = FALSE);
// Call this to declare a string token. You must declare the max string
// length you want.  2 slots are reserved for up to every 3 characters so
// a 16 letter tag requires 12 slots reserved.  To calculate the number
// of slots that get reserved, simply take the max string length, divide by 3,
// round up, and multiply by 2.
void DeclareTokenString(string sVarName, int iSlotNum, int iMaxStrLength);
// Call this to declare a location token. You need to declare a unique slot.
// There are two methods to save the area info in a location. One is by use
// of strings which requires more space.  The other is by use of special
// waypoints which must be added to each area.  Pass in TRUE for bCompressedMode
// if you wish to use the waypoint method in order to save slot space.
// You can also choose not to save the facing to save more space. Simply pass in
// FALSE for the bSaveFacing parameter.
// Finally, you can choose to not save the Z position of the location.
// For players, you do not need to save the Z location.
// To quickly calculate the number of slots needed for locations, simply start
// with 6 slots.
//      Add 20 slots if you are not using the compressed modes and waypoints.
//      Add 2 slots if you want to save the facing.
//      Add 2 slots if you want to save the Z Position.
void DeclareTokenLocation(string sVarName, int iSlotNum, int bCompressedMode = FALSE, int bSaveFacing = TRUE, int bSaveZPos = TRUE);

// Sets a token integer to a certain value
void SetTokenInt(object oPlayer, string sVarName, int iValue);
// Sets a token boolean to a certain value
void SetTokenBool(object oPlayer, string sVarName, int bValue);
// Sets a token float to a certain value
void SetTokenFloat(object oPlayer, string sVarName, float fValue);
// Sets a token string to a certain value
void SetTokenString(object oPlayer, string sVarName, string sValue);
// Sets a token location to a certain value
void SetTokenLocation(object oPlayer, string sVarName, location lValue);

// Gets the value from a token integer variable.  You can also
// force the value to be loaded directly from the token by setting the
// last parameter to TRUE.
int GetTokenInt(object oPlayer, string sVarName, int bLoadToken = FALSE);
// Gets the value from a token boolean variable.  You can also
// force the value to be loaded directly from the token by setting the
// last parameter to TRUE.
int GetTokenBool(object oPlayer, string sVarName, int bLoadToken = FALSE);
// Gets the value from a token float variable.  You can also
// force the value to be loaded directly from the token by setting the
// last parameter to TRUE.
float GetTokenFloat(object oPlayer, string sVarName, int bLoadToken = FALSE);
// Gets the value from a token string variable.  You can also
// force the value to be loaded directly from the token by setting the
// last parameter to TRUE.
string GetTokenString(object oPlayer, string sVarName, int bLoadToken = FALSE);
// Gets the value from a token location variable.  You can also
// force the value to be loaded directly from the token by setting the
// last parameter to TRUE.
location GetTokenLocation(object oPlayer, string sVarName, int bLoadToken = FALSE);

// Deletes a token integer variable
void DeleteTokenInt(object oPlayer, string sVarName);
// Deletes a token boolean variable
void DeleteTokenBool(object oPlayer, string sVarName);
// Deletes a token float variable
void DeleteTokenFloat(object oPlayer, string sVarName);
// Deletes a token string variable
void DeleteTokenString(object oPlayer, string sVarName);
// Deletes a token location variable
void DeleteTokenLocation(object oPlayer, string sVarName);

/////////////////////////////////////////////////////
// DeclareTokenInt                                 //
//      Call this to declare an integer token,     //
//      the size is the number of token range      //
//      to reserve and determines the max size of  //
//      the integer.                               //
// Returns: Nothing                                //
/////////////////////////////////////////////////////
void DeclareTokenInt(string sVarName, int iSlotNum, int bSigned = TRUE, int iSize = 3)
{
    // Check to make sure the slot number is within bounds
    if(iSlotNum < 1 || iSlotNum > CINT_MAX_SLOTS)
    {
        WriteTimestampedLogEntry("[APTS] DeclareTokenInt Error - Invalid Integer Token Slot Number Declaration");
        return;
    }
    else if((iSize + iSlotNum - 1) > CINT_MAX_SLOTS)
    {
        WriteTimestampedLogEntry("[APTS] DeclareTokenInt Error - Variable " +
                                 sVarName + "'s declaration has exceeded the max slot value.");
        return;
    }
    string sOldVarName = GetLocalString(GetModule(), "APTS_SLOTNAME_" + IntToString(iSlotNum));
    // Remove any other tokens that previously declared this slot
    if(sOldVarName != "")
    {
        APTS_RemoveOldDeclaration(sOldVarName);
    }
    SetLocalInt(GetModule(), "APTS_ITOK_" + sVarName + "_TYPE", APTS_TYPE_INT);
    SetLocalInt(GetModule(), "APTS_ITOK_" + sVarName + "_SLOT", iSlotNum);
    SetLocalInt(GetModule(), "APTS_ITOK_" + sVarName + "_SIGNED", bSigned);
    if(iSize > 0 && iSize <= 3)
        SetLocalInt(GetModule(), "APTS_ITOK_" + sVarName + "_SIZE", iSize);
    else
        SetLocalInt(GetModule(), "APTS_ITOK_" + sVarName + "_SIZE", 3);

    SetLocalString(GetModule(), "APTS_SLOTNAME_" + IntToString(iSlotNum), sVarName);
}

/////////////////////////////////////////////////////
// DeclareTokenBool                                //
//      Call this to declare a boolean token.      //
//      In addition to declaring a slot number,    //
//      you must also declare a bit position       //
//      between 0-9.                               //
// Returns: Nothing                                //
/////////////////////////////////////////////////////
void DeclareTokenBool(string sVarName, int iSlotNum, int iBitNum)
{
    // Check to make sure the slot number is within bounds
    if(iSlotNum < 1 || iSlotNum > CINT_MAX_SLOTS)
    {
        WriteTimestampedLogEntry("[APTS] DeclareTokenBool Error - Invalid Bool Token Slot Number Declaration");
        return;
    }
    // Check to make sure the bit position is within bounds
    else if(iBitNum < 0 ||iBitNum > CINT_BITS_PER_TOKEN)
    {
        WriteTimestampedLogEntry("[APTS] DeclareTokenBool Error - Invalid Bool Token Bit Number Declaration");
        return;
    }

    string sBoolName = "boolean" + IntToString(iSlotNum);
    DeclareTokenInt(sBoolName, iSlotNum, FALSE, 1);

    SetLocalInt(GetModule(), "APTS_ITOK_" + sVarName + "_TYPE", APTS_TYPE_BOOL);
    SetLocalInt(GetModule(), "APTS_ITOK_" + sVarName + "_SLOT", iSlotNum);
    SetLocalInt(GetModule(), "APTS_ITOK_" + sVarName + "_BIT", iBitNum);

}

/////////////////////////////////////////////////////
// DeclareTokenFloat                               //
//      Call this to declare a float token.        //
//      Floats take up 3 slots.                    //
// Returns: Nothing                                //
/////////////////////////////////////////////////////
void DeclareTokenFloat(string sVarName, int iSlotNum, int b22Bit = FALSE)
{
    // Check to make sure the slot number is within bounds
    if(iSlotNum < 1 || iSlotNum > CINT_MAX_SLOTS)
    {
        WriteTimestampedLogEntry("[APTS] DeclareTokenFloat Error - Invalid Float Token Slot Number Declaration");
        return;
    }
    else if(iSlotNum + 2 > CINT_MAX_SLOTS)
    {
        WriteTimestampedLogEntry("[APTS] DeclareTokenFloatError - Variable " +
                                 sVarName + "'s declaration has exceeded the max slot value.");
        return;
    }
    if(b22Bit)
    {
        DeclareTokenInt("float_int" + IntToString(iSlotNum), iSlotNum, FALSE, 2);
        SetLocalInt(GetModule(), "APTS_ITOK_" + sVarName + "_SIZE", 2);
    }
    else
    {
        DeclareTokenInt("float_int" + IntToString(iSlotNum), iSlotNum, FALSE, 3);
        SetLocalInt(GetModule(), "APTS_ITOK_" + sVarName + "_SIZE", 3);
    }
    SetLocalInt(GetModule(), "APTS_ITOK_" + sVarName + "_TYPE", APTS_TYPE_FLOAT);
    SetLocalInt(GetModule(), "APTS_ITOK_" + sVarName + "_SLOT", iSlotNum);
    SetLocalInt(GetModule(), "APTS_ITOK_" + sVarName + "_SIGNED", FALSE);
    SetLocalString(GetModule(), "APTS_SLOTNAME_" + IntToString(iSlotNum), sVarName);

}
/////////////////////////////////////////////////////
// DeclareTokenString                              //
//      Call this to declare a string token.       //
//      2 slots are reserved for up to every 3     //
//      characters.                                //
// Returns: Nothing                                //
/////////////////////////////////////////////////////
void DeclareTokenString(string sVarName, int iSlotNum, int iMaxStrLength)
{
    // Check to make sure the slot number is within bounds
    if(iSlotNum < 1 || iSlotNum > CINT_MAX_SLOTS)
    {
        WriteTimestampedLogEntry("[APTS] DeclareTokenString Error - Invalid String Token Slot Number Declaration");
        return;
    }

    // Get the number of slots required
    int iSlotSize = (iMaxStrLength / 3) << 1;
    if(iMaxStrLength % 3 > 0)
        iSlotSize += 2;

    if((iSlotSize + iSlotNum - 1) > CINT_MAX_SLOTS)
    {
        WriteTimestampedLogEntry("[APTS] DeclareTokenString Error - Variable " +
                                 sVarName + "'s declaration has exceeded the max slot value.");
        return;
    }

    string sOldVarName = GetLocalString(GetModule(), "APTS_SLOTNAME_" + IntToString(iSlotNum));
    // Remove any other tokens that previously declared this slot
    if(sOldVarName != "")
    {
        APTS_RemoveOldDeclaration(sOldVarName);
    }
    SetLocalInt(GetModule(), "APTS_ITOK_" + sVarName + "_TYPE", APTS_TYPE_STRING);
    SetLocalInt(GetModule(), "APTS_ITOK_" + sVarName + "_SLOT", iSlotNum);
    SetLocalInt(GetModule(), "APTS_ITOK_" + sVarName + "_SIZE", iSlotSize);
    SetLocalInt(GetModule(), "APTS_ITOK_" + sVarName + "_SIGNED", FALSE);
    SetLocalInt(GetModule(), "APTS_ITOK_" + sVarName + "_DATA", iMaxStrLength);

    SetLocalString(GetModule(), "APTS_SLOTNAME_" + IntToString(iSlotNum), sVarName);
}

/////////////////////////////////////////////////////
// DeclareTokenLocation                            //
//      Call this to declare a location token.     //
//      Pass in TRUE for bCompressedMode if you  //
//      wish to use the waypoint method in order   //
//      to save slot space. You can also choose not//
//      to save the facing to save more space.     //
//      Simply pass in FALSE for the bSaveFacing   //
//      parameter. Also, pass FALSE for the        //
//      bSaveZPos parameter if you don't want to   //
//      save the Z-position.  For player locations //
//      you do not really have to.                 //
// Returns: Nothing                                //
/////////////////////////////////////////////////////
void DeclareTokenLocation(string sVarName, int iSlotNum, int bCompressedMode = FALSE, int bSaveFacing = TRUE, int bSaveZPos = TRUE)
{
    // Check to make sure the slot number is within bounds
    if(iSlotNum < 1 || iSlotNum > CINT_MAX_SLOTS)
    {
        WriteTimestampedLogEntry("[APTS] DeclareTokenLocation Error - Invalid Location Token Slot Number Declaration");
        return;
    }
    int iSlotSize = 6;
    if(!bCompressedMode)
        iSlotSize += 20;
    if(bSaveZPos)
        iSlotSize += 2;
    if(bSaveFacing)
        iSlotSize += 2;

    if((iSlotSize + iSlotNum - 1) > CINT_MAX_SLOTS)
    {
        WriteTimestampedLogEntry("[APTS] DeclareTokenLocation Error - Variable " +
                                 sVarName + "'s declaration has exceeded the max slot value.");
        return;
    }

    string sOldVarName = GetLocalString(GetModule(), "APTS_SLOTNAME_" + IntToString(iSlotNum));
    // Remove any other tokens that previously declared this slot
    if(sOldVarName != "")
    {
        APTS_RemoveOldDeclaration(sOldVarName);
    }

    string sSlotString = IntToString(iSlotNum);

    int iData = 0;
    int iSlotOffset = 0;

    if(bCompressedMode)
    {
        iSlotOffset = 2;
        iData += 1;
        DeclareTokenInt("hash_value" + sSlotString, iSlotNum, FALSE, 2);
    }
    else
    {
        DeclareTokenString("area_string" + sSlotString, iSlotNum, 32);
        iSlotOffset = 22;
    }

    // Define floating point variables for position
    DeclareTokenFloat("xPos" + sSlotString, iSlotNum + iSlotOffset, TRUE);
    DeclareTokenFloat("yPos" + sSlotString, iSlotNum + iSlotOffset + 2, TRUE);

    if(bSaveZPos)
    {
        DeclareTokenFloat("zPos" + sSlotString, iSlotNum + iSlotOffset + 4, TRUE);
        iSlotOffset += 2;
        iData += 2;
    }
    if(bSaveFacing)
    {
        DeclareTokenFloat("facing" + sSlotString, iSlotNum + iSlotOffset + 4, TRUE);
        iData += 4;
    }
    SetLocalInt(GetModule(), "APTS_ITOK_" + sVarName + "_TYPE", APTS_TYPE_LOCATION);
    SetLocalInt(GetModule(), "APTS_ITOK_" + sVarName + "_SLOT", iSlotNum);
    SetLocalInt(GetModule(), "APTS_ITOK_" + sVarName + "_SIZE", iSlotSize);
    SetLocalInt(GetModule(), "APTS_ITOK_" + sVarName + "_SIGNED", FALSE);
    SetLocalInt(GetModule(), "APTS_ITOK_" + sVarName + "_DATA", iData);
    SetLocalString(GetModule(), "APTS_SLOTNAME_" + IntToString(iSlotNum), sVarName);

}
/////////////////////////////////////////////////////
// SetTokenInt                                     //
//      Sets a token integer to a certain value.   //
// Returns: Nothing                                //
/////////////////////////////////////////////////////
void SetTokenInt(object oPlayer, string sVarName, int iValue)
{
    int iSlotNum = GetLocalInt(GetModule(), "APTS_ITOK_" + sVarName + "_SLOT");
    int iType = GetLocalInt(GetModule(), "APTS_ITOK_" + sVarName + "_TYPE");
    int iNumToStore = iValue;
    int i;
    // Variable was not declared
    if(iSlotNum == 0)
    {
        WriteTimestampedLogEntry("[APTS] SetTokenInt Error - Token integer variable(" +
                                  sVarName + ") was not declared.");
    }
    else if(iType != APTS_TYPE_INT)
    {
        WriteTimestampedLogEntry("[APTS] SetTokenInt Error - Token variable(" +
                                  sVarName + ") is not declared as an integer.");
        return;
    }
    else
    {
        int iIntSize = GetLocalInt(GetModule(), "APTS_ITOK_" + sVarName + "_SIZE");
        int bSigned = GetLocalInt(GetModule(), "APTS_ITOK_" + sVarName + "_SIGNED");
        // Simple bounds checking
        if(!bSigned && iValue < 0)
            iNumToStore = 0;
        else
        {
            int iMaxSize = APTS_GetMaxSizeValue(iIntSize, bSigned);
            int iMinSize = APTS_GetMinSizeValue(iIntSize, bSigned);
            if(iValue > iMaxSize)
                iNumToStore = iMaxSize;
            else if(iValue < iMinSize)
                iNumToStore = iMinSize;
        }
        AssignCommand(oPlayer, ActionDoCommand(SetCommandable(FALSE, oPlayer)));
        // Add a delay between successive set calls
        AssignCommand(oPlayer, ActionWait(0.1));
        for(i = 0; i < iIntSize; ++i)
        {
            // Remove old tokens in the slots
            AssignCommand(oPlayer, ActionDoCommand(APTS_RemoveSlotTokens(oPlayer, iSlotNum + i)));
        }
        if(iNumToStore != 0)
        {
            // Create the new tokens
            AssignCommand(oPlayer, ActionDoCommand(DelayCommand(0.2, APTS_CreateSlotTokens(oPlayer, iNumToStore, iSlotNum, bSigned))));
        }
        AssignCommand(oPlayer, ActionDoCommand(SetCommandable(TRUE, oPlayer)));
    }

    // Store the value in a local variable as well
    SetLocalInt(oPlayer, sVarName, iNumToStore);
}

/////////////////////////////////////////////////////
// SetTokenBool                                    //
//      Sets a token boolean to a certain value.   //
// Returns: Nothing                                //
/////////////////////////////////////////////////////
void SetTokenBool(object oPlayer, string sVarName, int bValue)
{
    int iSlotNum = GetLocalInt(GetModule(), "APTS_ITOK_" + sVarName + "_SLOT");
    int iBitPos = GetLocalInt(GetModule(), "APTS_ITOK_" + sVarName + "_BIT");

    // Variable was not declared
    if(iSlotNum == 0)
    {
        WriteTimestampedLogEntry("[APTS] SetTokenBool Error - Token boolean variable(" +
                                  sVarName + ") was not declared.");
    }
    // Slot is not declared as a boolean
    else if(GetLocalInt(GetModule(), "APTS_ITOK_" + sVarName + "_TYPE") != APTS_TYPE_BOOL)
    {
        WriteTimestampedLogEntry("[APTS] SetTokenBool Error - Token variable(" +
                                  sVarName + ") is not declared as a boolean.");
        return;
    }
    else
    {
        int iTokenValue = GetTokenInt(oPlayer,GetLocalString(GetModule(), "APTS_SLOTNAME_" + IntToString(iSlotNum)));

        if(bValue != FALSE)
        {
            if(APTS_IsBitSet(iTokenValue, iBitPos) == FALSE)
                iTokenValue += APTS_GetBitValue(iBitPos);
        }
        else
        {
            if(APTS_IsBitSet(iTokenValue, iBitPos) == TRUE)
                iTokenValue -= APTS_GetBitValue(iBitPos);
        }
        // Create the new integer token representing 10 booleans
        SetTokenInt(oPlayer,GetLocalString(GetModule(), "APTS_SLOTNAME_" + IntToString(iSlotNum)), iTokenValue);
    }

    // Store the value in a local variable as well
    SetLocalInt(oPlayer, sVarName, bValue);
}

/////////////////////////////////////////////////////
//  SetTokenFloat                                  //
//      Sets a token float to a certain value.     //
// Returns: Nothing                                //
/////////////////////////////////////////////////////
void SetTokenFloat(object oPlayer, string sVarName, float fValue)
{
    int iSlotNum = GetLocalInt(GetModule(), "APTS_ITOK_" + sVarName + "_SLOT");
    int iType = GetLocalInt(GetModule(), "APTS_ITOK_" + sVarName + "_TYPE");
    int iSize = GetLocalInt(GetModule(), "APTS_ITOK_" + sVarName + "_SIZE");

    int iNumToStore = APTS_FloatToIntRep(fValue, iSize);
    // Variable was not declared
    if(iSlotNum == 0)
    {
        WriteTimestampedLogEntry("[APTS] SetTokenFloat Error - Token float variable(" +
                                  sVarName + ") was not declared.");
    }
    else if(iType != APTS_TYPE_FLOAT)
    {
        WriteTimestampedLogEntry("[APTS] SetTokenFloat Error - Token variable(" +
                                  sVarName + ") is not declared as a float.");
        return;
    }
    else
        SetTokenInt(oPlayer, "float_int" + IntToString(iSlotNum), iNumToStore);
    // Store the value in a local variable as well
    SetLocalFloat(oPlayer, sVarName, fValue);
}
/////////////////////////////////////////////////////
//  SetTokenString                                 //
//      Sets a token string to a certain value.    //
// Returns: Nothing                                //
/////////////////////////////////////////////////////
void SetTokenString(object oPlayer, string sVarName, string sValue)
{
    int iSlotNum = GetLocalInt(GetModule(), "APTS_ITOK_" + sVarName + "_SLOT");
    int iSlotSize = GetLocalInt(GetModule(), "APTS_ITOK_" + sVarName + "_SIZE");
    int iType = GetLocalInt(GetModule(), "APTS_ITOK_" + sVarName + "_TYPE");
    int iMaxStrLength = GetLocalInt(GetModule(), "APTS_ITOK_" + sVarName + "_DATA");

    // Variable was not declared
    if(iSlotNum == 0)
    {
        WriteTimestampedLogEntry("[APTS] SetTokenString Error - Token string variable(" +
                                  sVarName + ") was not declared.");
    }
    else if(iType != APTS_TYPE_STRING)
    {
        WriteTimestampedLogEntry("[APTS] SetTokenString Error - Token variable(" +
                                  sVarName + ") is not declared as a string.");
        return;
    }
    else
    {
        int i;
        string sSubString = "";
        string sStringToStore = GetStringLeft(sValue, iMaxStrLength);
        int iStringRep = 0;
        // Gets the number of medium integers needed to represent the string
        int iMedIntCount = iSlotSize >> 1;

        AssignCommand(oPlayer, ActionDoCommand(SetCommandable(FALSE, oPlayer)));
        // Add a delay between successive set calls
        AssignCommand(oPlayer, ActionWait(0.1));
        // Remove old tokens occupying slots
        for(i = 0; i < iSlotSize; ++i)
            AssignCommand(oPlayer, ActionDoCommand(APTS_RemoveSlotTokens(oPlayer, iSlotNum+i)));
        for(i = 0; i < iMedIntCount; ++i)
        {
            sSubString = GetSubString(sStringToStore, (i*3), 3);
            if(sSubString == "")
                break;
            iStringRep = APTS_ConvertThreeCharToInt(sSubString);
            // Create the new tokens
            AssignCommand(oPlayer, ActionDoCommand(DelayCommand(0.2, APTS_CreateSlotTokens(oPlayer, iStringRep, iSlotNum+(i*2), FALSE))));
        }
    }
        AssignCommand(oPlayer, ActionDoCommand(SetCommandable(TRUE, oPlayer)));
    // Store the value in a local variable as well
    SetLocalString(oPlayer, sVarName, sValue);
}

/////////////////////////////////////////////////////
//  SetTokenLocation                               //
//      Sets a token location to a certain value.  //
// Returns: Nothing                                //
/////////////////////////////////////////////////////
void SetTokenLocation(object oPlayer, string sVarName, location lValue)
{
    int iSlotNum = GetLocalInt(GetModule(), "APTS_ITOK_" + sVarName + "_SLOT");
    int iType = GetLocalInt(GetModule(), "APTS_ITOK_" + sVarName + "_TYPE");
    int iSlotSize = GetLocalInt(GetModule(), "APTS_ITOK_" + sVarName + "_SIZE");
    int iData = GetLocalInt(GetModule(), "APTS_ITOK_" + sVarName + "_DATA");

    int bCompressedMode = APTS_IsBitSet(iData, 0);
    int bSaveFacing  = APTS_IsBitSet(iData, 1);
    int bSaveZPos = APTS_IsBitSet(iData, 2);

    // Variable was not declared
    if(iSlotNum == 0)
    {
        WriteTimestampedLogEntry("[APTS] SetTokenLocation Error - Token location variable(" +
                                  sVarName + ") was not declared.");
    }
    else if(iType != APTS_TYPE_LOCATION)
    {
        WriteTimestampedLogEntry("[APTS] SetTokenLocation Error - Token variable(" +
                                  sVarName + ") is not declared as a location.");
        return;
    }
    else
    {
        string sAreaTag = GetTag(GetAreaFromLocation(lValue));
        vector vPos = GetPositionFromLocation(lValue);
        float fFacing = GetFacingFromLocation(lValue);
        string sSlotString = IntToString(iSlotNum);

        //AssignCommand(oPlayer, ActionDoCommand(SetCommandable(FALSE, oPlayer)));
        // Add a delay between successive set calls
        AssignCommand(oPlayer, ActionWait(0.1));
        int i;
        if(bCompressedMode)
        {
            int iHashValue = APTS_HashAreaTag(sAreaTag, CINT_PRIME_HASH);
            string sHashVar = "hash_value" + IntToString(iSlotNum);
            AssignCommand(oPlayer, ActionDoCommand(SetTokenInt(oPlayer, sHashVar,iHashValue)));
        }
        else
        {
            string sStringVar = "area_string" + IntToString(iSlotNum);
            AssignCommand(oPlayer, ActionDoCommand(SetTokenString(oPlayer, sStringVar, sAreaTag)));
        }

        AssignCommand(oPlayer, ActionDoCommand(SetTokenFloat(oPlayer, "xPos" + sSlotString, vPos.x)));
        AssignCommand(oPlayer, ActionDoCommand(SetTokenFloat(oPlayer, "yPos" + sSlotString, vPos.y)));
        if(bSaveZPos)
            AssignCommand(oPlayer, ActionDoCommand(SetTokenFloat(oPlayer, "zPos" + sSlotString, vPos.z)));
        if(bSaveFacing)
            AssignCommand(oPlayer, ActionDoCommand(SetTokenFloat(oPlayer, "facing" + sSlotString, fFacing)));
        //AssignCommand(oPlayer, ActionDoCommand(SetCommandable(TRUE, oPlayer)));

    }
    // Store the value in a local variable as well
    SetLocalLocation(oPlayer, sVarName, lValue);
}

/////////////////////////////////////////////////////
// GetTokenInt                                     //
//      Gets the value from a token integer        //
//      variable.                                  //
// Returns: int - Value of the token integer       //
/////////////////////////////////////////////////////
int GetTokenInt(object oPlayer, string sVarName, int bLoadToken = FALSE)
{
    int iReturnVal = GetLocalInt(oPlayer, sVarName);

    if(bLoadToken || iReturnVal == 0)
    {
        int iSlotNum = GetLocalInt(GetModule(), "APTS_ITOK_" + sVarName + "_SLOT");
        int bSigned = GetLocalInt(GetModule(), "APTS_ITOK_" + sVarName + "_SIGNED");
        int iSize = GetLocalInt(GetModule(), "APTS_ITOK_" + sVarName + "_SIZE");
        int iType = GetLocalInt(GetModule(), "APTS_ITOK_" + sVarName + "_TYPE");

        if(iType != APTS_TYPE_INT)
        {
            WriteTimestampedLogEntry("[APTS] GetTokenInt Error - Token variable(" +
                                    sVarName + ") is not an integer.");
            return 0;
        }
        else
            return APTS_GetTokenIntValue(oPlayer, iSlotNum, iSize, bSigned);
    }
    else
        return iReturnVal;
}

/////////////////////////////////////////////////////
// GetTokenBool                                    //
//      Gets the value from a token boolean        //
//      variable.                                  //
// Returns: int - Value of the token boolean       //
/////////////////////////////////////////////////////
int GetTokenBool(object oPlayer, string sVarName, int bLoadToken = FALSE)
{
    int iReturnVal = GetLocalInt(oPlayer, sVarName);
    if(bLoadToken || iReturnVal == 0)
    {
        int iSlotNum = GetLocalInt(GetModule(), "APTS_ITOK_" + sVarName + "_SLOT");
        int iBitPos = GetLocalInt(GetModule(), "APTS_ITOK_" + sVarName + "_BIT");
        int iSlotValue = APTS_GetSlotValue(oPlayer, iSlotNum, FALSE);
        int iType = GetLocalInt(GetModule(), "APTS_ITOK_" + sVarName + "_TYPE");

        if(iType != APTS_TYPE_BOOL)
        {
            WriteTimestampedLogEntry("[APTS] GetTokenBool Error - Token variable(" +
                                    sVarName + ") is not a boolean.");
            return 0;
        }
        else
            return APTS_IsBitSet(iSlotValue, iBitPos);
    }
    else
        return iReturnVal;
}

/////////////////////////////////////////////////////
// GetTokenFloat                                   //
//      Gets the value from a token float          //
//      variable.                                  //
// Returns: float - Value of the token float       //
/////////////////////////////////////////////////////
float GetTokenFloat(object oPlayer, string sVarName, int bLoadToken = FALSE)
{
    float fReturnVal = GetLocalFloat(oPlayer, sVarName);

    if(bLoadToken || fReturnVal == 0.0)
    {
        int iSlotNum = GetLocalInt(GetModule(), "APTS_ITOK_" + sVarName + "_SLOT");
        int iSize = GetLocalInt(GetModule(), "APTS_ITOK_" + sVarName + "_SIZE");
        int iType = GetLocalInt(GetModule(), "APTS_ITOK_" + sVarName + "_TYPE");

        if(iType != APTS_TYPE_FLOAT)
        {
            WriteTimestampedLogEntry("[APTS] GetTokenFloat Error - Token variable(" +
                                    sVarName + ") is not a float.");
            return 0.0;
        }
        else
            return APTS_IntRepToFloat(GetTokenInt(oPlayer, "float_int" + IntToString(iSlotNum)), iSize);
    }
    else
        return fReturnVal;
}
/////////////////////////////////////////////////////
// GetTokenString                                  //
//      Gets the value from a token string         //
//      variable.                                  //
// Returns: string - Value of the token string     //
/////////////////////////////////////////////////////
string GetTokenString(object oPlayer, string sVarName, int bLoadToken = FALSE)
{
    string sReturnVal = GetLocalString(oPlayer, sVarName);

    if(bLoadToken || sReturnVal == "")
    {
        int iSlotNum = GetLocalInt(GetModule(), "APTS_ITOK_" + sVarName + "_SLOT");
        int iSlotSize = GetLocalInt(GetModule(), "APTS_ITOK_" + sVarName + "_SIZE");
        int iType = GetLocalInt(GetModule(), "APTS_ITOK_" + sVarName + "_TYPE");

        if(iType != APTS_TYPE_STRING)
        {
            WriteTimestampedLogEntry("[APTS] GetTokenString Error - Token variable(" +
                                    sVarName + ") is not a string.");
            return "";
        }
        else
        {
            int iMedIntCount = iSlotSize >> 1;
            int i;
            int iMedValue;  // value of the medium integer
            sReturnVal = "";

            for(i = 0; i < iMedIntCount; ++i)
            {
                iMedValue = APTS_GetTokenIntValue(oPlayer, iSlotNum+(i*2), 2, FALSE);
                if(iMedValue != 0)
                {
                    sReturnVal += APTS_ConvertIntToThreeChar(iMedValue);
                }
            }
        }
    }   // end if

    return sReturnVal;
}
/////////////////////////////////////////////////////
// GetTokenLocation                                //
//      Gets the value from a token location       //
//      variable.                                  //
// Returns: location - Value of the token location //
/////////////////////////////////////////////////////
location GetTokenLocation(object oPlayer, string sVarName, int bLoadToken = FALSE)
{
    location lReturnVal = GetLocalLocation(oPlayer, sVarName);

    if(bLoadToken || GetPositionFromLocation(lReturnVal) == Vector())
    {
        int iSlotNum = GetLocalInt(GetModule(), "APTS_ITOK_" + sVarName + "_SLOT");
        int iSize = GetLocalInt(GetModule(), "APTS_ITOK_" + sVarName + "_SIZE");
        int iType = GetLocalInt(GetModule(), "APTS_ITOK_" + sVarName + "_TYPE");
        int iData = GetLocalInt(GetModule(), "APTS_ITOK_" + sVarName + "_DATA");

        int bCompressedMode = APTS_IsBitSet(iData, 0);
        int bSaveFacing  = APTS_IsBitSet(iData, 1);
        int bSaveZPos = APTS_IsBitSet(iData, 2);

        if(iType != APTS_TYPE_LOCATION)
        {
            WriteTimestampedLogEntry("[APTS] GetTokenLocation Error - Token variable(" +
                                    sVarName + ") is not a location.");
        }
        else
        {
            object oArea;
            vector vPos;
            float fFacing;
            string sSlotString = IntToString(iSlotNum);
            int i = 0;

            if(bCompressedMode)
            {
                int iHashValue = APTS_GetTokenIntValue(oPlayer, iSlotNum, 2, FALSE);
                oArea = GetArea(GetObjectByTag("APTS_AREA_LOCATE", ++i));
                while(GetIsObjectValid(oArea) && APTS_HashAreaTag(GetTag(oArea), CINT_PRIME_HASH) != iHashValue)
                {
                    oArea = GetArea(GetObjectByTag("APTS_AREA_LOCATE", ++i));
                }
            }
            else
                oArea = GetObjectByTag(GetTokenString(oPlayer, "area_string" + sSlotString));

            vPos.x = GetTokenFloat(oPlayer, "xPos" + sSlotString);
            vPos.y = GetTokenFloat(oPlayer, "yPos" + sSlotString);
            if(bSaveZPos)
                vPos.z = GetTokenFloat(oPlayer, "zPos" + sSlotString);
            else
                vPos.z = 0.0f;

            if(bSaveFacing)
                fFacing = GetTokenFloat(oPlayer, "facing" + sSlotString);
            else
                fFacing = 0.0f;

            lReturnVal = Location(oArea, vPos, fFacing);
        }
    }
    return lReturnVal;
}

/////////////////////////////////////////////////////
//  DeleteTokenInt                                 //
//      Deletes a token integer variable.          //
// Returns: Nothing                                //
/////////////////////////////////////////////////////
void DeleteTokenInt(object oPlayer, string sVarName)
{
    int iSlotNum = GetLocalInt(GetModule(), "APTS_ITOK_" + sVarName + "_SLOT");
    int iIntSize = GetLocalInt(GetModule(), "APTS_ITOK_" + sVarName + "_SIZE");
    int iType = GetLocalInt(GetModule(), "APTS_ITOK_" + sVarName + "_TYPE");

    // Variable was not declared
    if(iSlotNum == 0)
    {
        WriteTimestampedLogEntry("[APTS] DeleteTokenInt Error - Token integer variable(" +
                                  sVarName + ") was not declared.");
        return;
    }
    else if(iType != APTS_TYPE_INT)
    {
        WriteTimestampedLogEntry("[APTS] DeleteTokenInt Error - Token variable(" +
                                sVarName + ") is not an integer.");
        return;
    }
    int i;
    for(i = 0; i < iIntSize; ++i)
    {
        // Remove old tokens in the slots
        APTS_RemoveSlotTokens(oPlayer, iSlotNum + i);
    }
    DeleteLocalInt(oPlayer, sVarName);
}

/////////////////////////////////////////////////////
//  DeleteTokenBool                                //
//      Deletes a token boolean variable.          //
// Returns: Nothing                                //
/////////////////////////////////////////////////////
void DeleteTokenBool(object oPlayer, string sVarName)
{
    int iSlotNum = GetLocalInt(GetModule(), "APTS_ITOK_" + sVarName + "_SLOT");
    int iBitPos = GetLocalInt(GetModule(), "APTS_ITOK_" + sVarName + "_BIT");

    int iTokenValue = GetTokenInt(oPlayer,GetLocalString(GetModule(), "APTS_SLOTNAME_" + IntToString(iSlotNum)));
    int iType = GetLocalInt(GetModule(), "APTS_ITOK_" + sVarName + "_TYPE");

    // Variable was not declared
    if(iSlotNum == 0)
    {
        WriteTimestampedLogEntry("[APTS] DeleteTokenBool Error - Token boolean variable(" +
                                  sVarName + ") was not declared.");
        return;
    }
    else if(iType != APTS_TYPE_BOOL)
    {
        WriteTimestampedLogEntry("[APTS] DeleteTokenBool Error - Token variable(" +
                                sVarName + ") is not a boolean.");
        return;
    }
    if(APTS_IsBitSet(iTokenValue, iBitPos) == TRUE)
    {
        iTokenValue -= APTS_GetBitValue(iBitPos);
        SetTokenInt(oPlayer,GetLocalString(GetModule(), "APTS_SLOTNAME_" + IntToString(iSlotNum)), iTokenValue);
    }
    DeleteLocalInt(oPlayer, sVarName);
}

/////////////////////////////////////////////////////
//  DeleteTokenFloat                               //
//      Deletes a token float variable.            //
// Returns: Nothing                                //
/////////////////////////////////////////////////////
void DeleteTokenFloat(object oPlayer, string sVarName)
{
    int iSlotNum = GetLocalInt(GetModule(), "APTS_ITOK_" + sVarName + "_SLOT");
    int iType = GetLocalInt(GetModule(), "APTS_ITOK_" + sVarName + "_TYPE");

    // Variable was not declared
    if(iSlotNum == 0)
    {
        WriteTimestampedLogEntry("[APTS] DeleteTokenFloat Error - Token float variable(" +
                                  sVarName + ") was not declared.");
        return;
    }
    else if(iType != APTS_TYPE_FLOAT)
    {
        WriteTimestampedLogEntry("[APTS] DeleteTokenFloat Error - Token variable(" +
                                sVarName + ") is not a float.");
        return;
    }
    // Remove old tokens in the slots
    DeleteTokenInt(oPlayer, "float_int" + IntToString(iSlotNum));
    DeleteLocalFloat(oPlayer, sVarName);
}
/////////////////////////////////////////////////////
//  DeleteTokenString                              //
//      Deletes a token string variable.           //
// Returns: Nothing                                //
/////////////////////////////////////////////////////
void DeleteTokenString(object oPlayer, string sVarName)
{
    int iSlotNum = GetLocalInt(GetModule(), "APTS_ITOK_" + sVarName + "_SLOT");
    int iType = GetLocalInt(GetModule(), "APTS_ITOK_" + sVarName + "_TYPE");
    int iSlotSize = GetLocalInt(GetModule(), "APTS_ITOK_" + sVarName + "_SIZE");

    // Variable was not declared
    if(iSlotNum == 0)
    {
        WriteTimestampedLogEntry("[APTS] DeleteTokenString Error - Token string variable(" +
                                  sVarName + ") was not declared.");
        return;
    }
    else if(iType != APTS_TYPE_STRING)
    {
        WriteTimestampedLogEntry("[APTS] DeleteTokenString Error - Token variable(" +
                                sVarName + ") is not a string.");
        return;
    }
    // Remove old tokens in the slots
    int i;
    for(i = 0; i < iSlotSize; ++i)
        APTS_RemoveSlotTokens(oPlayer, iSlotNum+i);
    DeleteLocalString(oPlayer, sVarName);
}
/////////////////////////////////////////////////////
//  DeleteTokenLocation                            //
//      Deletes a token location variable.         //
// Returns: Nothing                                //
/////////////////////////////////////////////////////
void DeleteTokenLocation(object oPlayer, string sVarName)
{
    int iSlotNum = GetLocalInt(GetModule(), "APTS_ITOK_" + sVarName + "_SLOT");
    int iSize = GetLocalInt(GetModule(), "APTS_ITOK_" + sVarName + "_SIZE");
    int iType = GetLocalInt(GetModule(), "APTS_ITOK_" + sVarName + "_TYPE");

    // Variable was not declared
    if(iSlotNum == 0)
    {
        WriteTimestampedLogEntry("[APTS] DeleteTokenLocation Error - Token location variable(" +
                                  sVarName + ") was not declared.");
        return;
    }
    else if(iType != APTS_TYPE_LOCATION)
    {
        WriteTimestampedLogEntry("[APTS] DeleteTokenLocation Error - Token variable(" +
                                sVarName + ") is not a location.");
        return;
    }
    // Remove old tokens in the slots
    int i;
    for(i = 0; i < iSize; ++i)
        APTS_RemoveSlotTokens(oPlayer, iSlotNum+i);
    DeleteLocalLocation(oPlayer, sVarName);
}







