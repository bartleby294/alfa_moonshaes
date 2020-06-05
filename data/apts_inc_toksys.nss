/****************************************************
  Persistent Token Helper Include Script
  apts_inc_toksys

  Last Updated: September 26, 2002

  ***Ambrosia Persistent Token System***
    Created by Mojo(Allen Sun)

  This script includes helper functions that are
  called by the accessor functions in the
  apts_inc_ptok script.

****************************************************/
/* Function Declarations */

// Gets the decimal value of a bit position
int APTS_GetBitValue(int iBitPos);
// Returns whether or not a specified binary bit of a number is set
int APTS_IsBitSet(int iNumber, int iBitPos);
// Gets the maximum value of iSize number of tokens
int APTS_GetMaxSizeValue(int iSize, int bSigned);
// Gets the minimum value of iSize number of tokens
int APTS_GetMinSizeValue(int iSize, int bSigned);
// Returns the number of tokens needed to store the number
int APTS_GetTokenSpace(int iNumber, int bSigned);
// Creates a token on the player and puts it in the token box
object APTS_CreateTokenOnPlayer(object oPlayer, int iSlot, int iType, int iValue);
// Converts a base ten number to any base and returns it as a string
string APTS_ConvertNumberToBaseString(int iNumber, int iBase);
// Gets the total integer value of tokens starting at a slot number
int APTS_GetTokenIntValue(object oPlayer, int iSlotNum, int iSize, int bSigned);
// Gets the value of the token at a certain slot
int APTS_GetSlotValue(object oPlayer, int iSlotNum, int bSigned);
// Converts an integer into a binary string
string APTS_IntToBinaryString(int iValue, int bAlignBit = 0);
// Converts a binary string into an integer
int APTS_BinaryStringToInt(string sBinary, int bSigned = TRUE);
// Converts a binarty string into a fractional value
float APTS_BinaryStringToDecimal(string sBinary);
// Calculates a number raised to a certain exponent
float APTS_Pow(float fValue, int iExp);
// Removes trailing zeroes in a binary string
string APTS_RemoveTrailingZeroes(string sBinary);
// Converts a floating point number into an integer representation using the
// 32-bit IEEE FP format
int APTS_FloatToIntRep(float fValue, int iSize);
// Converts an integer representation back into a floating point number
float APTS_IntRepToFloat(int iValue, int iSize);
// Removes all declaration information for a variable
void APTS_RemoveOldDeclaration(string sVarName);
// Converts a string of up to three characters into an medium integer
int APTS_ConvertThreeCharToInt(string sString);
// Converts a medium integer value into a three character string
string APTS_ConvertIntToThreeChar(int iMedValue);

/* Function Definitions */


string APTS_GetResRefFromTag(string sTag)
{
    return GetStringLowerCase(GetStringLeft(sTag, 16));
}

object APTS_FindItemInInventoryByTag(object oTarget, string sTag, int iNth = 0)
{
    int iCount = 0;
    object oCurrentObject = OBJECT_INVALID;

    if(GetHasInventory(oTarget) == FALSE)
        return oCurrentObject;

    oCurrentObject =  GetFirstItemInInventory(oTarget);

    while(GetIsObjectValid(oCurrentObject) == TRUE)
    {
        if(GetTag(oCurrentObject) == sTag)
        {
            if(iCount == iNth)
                return oCurrentObject;
            else
                ++iCount;
        }
        oCurrentObject = GetNextItemInInventory(oTarget);
    }
    return oCurrentObject;

}
int APTS_GetBitValue(int iBitPos)
{
    return FloatToInt(pow(2.0, IntToFloat(iBitPos)));
}

int APTS_IsBitSet(int iNumber, int iBitPos)
{
    return ((iNumber & APTS_GetBitValue(iBitPos)) > 0);
}

int APTS_GetTokenSpace(int iNumber, int bSigned)
{
    if(bSigned)
    {
        if(iNumber > CINT_MAX_SIGNED_TWO)
            return 3;
        else if(iNumber > CINT_MAX_SIGNED_ONE)
            return 2;
        else if(iNumber > 0)
            return 1;
        else if(iNumber == 0)
            return 0;
        else if(iNumber >= (-CINT_MAX_SIGNED_ONE-1))
            return 1;
        else if(iNumber >= (-CINT_MAX_SIGNED_TWO-1))
            return 2;
        else
            return 3;
    }
    else
    {
        if(iNumber > CINT_MAX_UNSIGNED_TWO)
            return 3;
        else if(iNumber > CINT_MAX_UNSIGNED_ONE)
            return 2;
        else if(iNumber > 0)
            return 1;
        else
            return 0;
    }
}
int APTS_GetMaxSizeValue(int iSize, int bSigned)
{
    if(bSigned)
    {
        switch(iSize)
        {
            case 0:
                return 0;
            case 1:
                return CINT_MAX_SIGNED_ONE;
            case 2:
                return CINT_MAX_SIGNED_TWO;
            case 3:
                return CINT_MAX_SIGNED_THREE;
            default:
                return MAX_INT;
        }
    }
    else
    {
        switch(iSize)
        {
            case 0:
                return 0;
            case 1:
                return CINT_MAX_UNSIGNED_ONE;
            case 2:
                return CINT_MAX_UNSIGNED_TWO;
            case 3:
                return CINT_MAX_UNSIGNED_THREE;
            default:
                return MAX_INT;
        }
    }
    return 0;
}
int APTS_GetMinSizeValue(int iSize, int bSigned)
{
    if(bSigned)
    {
        switch(iSize)
        {
            case 0:
                return 0;
            case 1:
                return (-CINT_MAX_SIGNED_ONE-1);
            case 2:
                return (-CINT_MAX_SIGNED_TWO-1);
            case 3:
                return (-CINT_MAX_SIGNED_THREE-1);
            default:
                return (-MAX_INT-1);
        }
    }
    return 0;
}
object APTS_CreateTokenOnPlayer(object oPlayer, int iSlot, int iType, int iValue)
{
    if(iValue <= 0)
        return OBJECT_INVALID;
    object oTokenBox = APTS_FindItemInInventoryByTag(oPlayer, APTS_TOKEN_BOX_TAG);
    if(!GetIsObjectValid(oTokenBox))
    {
        oTokenBox = CreateItemOnObject(APTS_GetResRefFromTag(APTS_TOKEN_BOX_TAG), oPlayer);
        if(!GetIsObjectValid(oTokenBox))
            return OBJECT_INVALID;
    }
    string sTokenTag = APTS_TOKEN_TAG + "_S";

    if(iSlot < 100)
        sTokenTag += "0";
    if(iSlot < 10)
        sTokenTag += "0";
    sTokenTag += (IntToString(iSlot) + "_");
    if(iType < 10)
        sTokenTag += "0";
    sTokenTag += IntToString(iType);
    string sTokenResRef = APTS_GetResRefFromTag(sTokenTag);

    int i = 1;
    object oToken = CreateItemOnObject(sTokenResRef, oTokenBox, iValue);
    // Token could not be created
    while(GetItemPossessor(oToken) == OBJECT_INVALID && GetIsObjectValid(oTokenBox))
    {
        DestroyObject(oToken);
        oToken = CreateItemOnObject(sTokenResRef, oTokenBox, iValue);
        oTokenBox = APTS_FindItemInInventoryByTag(oPlayer, APTS_TOKEN_BOX_TAG, i++);
    }
    if(GetItemPossessor(oToken) == OBJECT_INVALID)
    {
        DestroyObject(oToken);
        oTokenBox = CreateItemOnObject(APTS_GetResRefFromTag(APTS_TOKEN_BOX_TAG), oPlayer);
        if(!GetIsObjectValid(oTokenBox))
            return OBJECT_INVALID;
        oToken = CreateItemOnObject(sTokenResRef, oTokenBox, iValue);
    }
    SetLocalObject(oToken, "ats_obj_possessor", oPlayer);

    return oToken;

}
// Converts a base ten number to any base and returns it as a string
string APTS_ConvertNumberToBaseString(int iNumber, int iBase)
{
    string sRemainderString = "";
    int iQuotient = iNumber;
    int iRemainder;
    int iAddedZeroes;
    int i;

    while(iQuotient != 0)
    {
        iRemainder = abs(iQuotient % iBase);
        iAddedZeroes = GetStringLength(IntToString(CINT_NUMBER_BASE-1)) - GetStringLength(IntToString(iRemainder));
        sRemainderString = IntToString(iRemainder) + sRemainderString;
        for(i = 0; i < iAddedZeroes; ++i)
        {
            sRemainderString = "0" + sRemainderString;
        }
         iQuotient = iQuotient / iBase;
    }
    if(iNumber < 0)
        sRemainderString = "-" + sRemainderString;
    return sRemainderString;
}

void APTS_CreateSlotTokens(object oPlayer, int iValue, int iSlot, int bSigned = TRUE )
{
    int iNumTokens = APTS_GetTokenSpace(iValue, bSigned);
    int i, iType;
    int iFieldValue;
    int iTokenSize;
    int bPlotFlag = TRUE;
    object oCreatedToken;

    string sBinaryString = APTS_IntToBinaryString(iValue, CINT_BITS_PER_TOKEN);

    for(i = 0; i < iNumTokens; ++i)
    {
        iFieldValue = APTS_BinaryStringToInt(GetStringRight(sBinaryString, CINT_BITS_PER_TOKEN), FALSE);
        if(sBinaryString == "" && bSigned)
        {
            // Create a special token to indicate a positive sign
            iFieldValue = CINT_TOKENS_FOR_BASE * 198;
        }

        sBinaryString = GetStringLeft(sBinaryString, GetStringLength(sBinaryString) - CINT_BITS_PER_TOKEN);

        for(iType = 0; iType < CINT_TOKENS_FOR_BASE; ++iType)
        {
            bPlotFlag = TRUE;

            // Find which token to use to store value
            if(iFieldValue <= ((iType+1) * 198))
            {

                iTokenSize = iFieldValue - (198 * iType);
                if(iTokenSize > 99)
                {
                    bPlotFlag = FALSE;
                    iTokenSize -= 99;
                }

                oCreatedToken = APTS_CreateTokenOnPlayer(oPlayer, iSlot + i, iType, iTokenSize);
                SetPlotFlag(oCreatedToken, bPlotFlag);
                break;
            }
        }

    }
}
void APTS_RemoveSlotTokens(object oPlayer, int iSlotNum)
{
    object oItem;
    string sPartialTokenTag = APTS_TOKEN_TAG + "_S";
    if(iSlotNum < 100)
        sPartialTokenTag += "0";
    if(iSlotNum < 10)
        sPartialTokenTag += "0";
    sPartialTokenTag += (IntToString(iSlotNum) + "_");

    oItem = GetFirstItemInInventory(oPlayer);
    while(GetIsObjectValid(oItem))
    {
        // Found a matching token to remove
        if(FindSubString(GetTag(oItem), sPartialTokenTag) == 0)
        {
            DestroyObject(oItem);
        }
        oItem = GetNextItemInInventory(oPlayer);
    }
}
int APTS_GetTokenIntValue(object oPlayer, int iSlotNum, int iSize, int bSigned)
{
    int iTotalValue = 0;
    int bFoundToken = FALSE;
    int iSlotValue;
    int i;

    for(i = iSize-1; i >= 0; --i)
    {
        iSlotValue = APTS_GetSlotValue(oPlayer, iSlotNum+i, FALSE);
        if(iSlotValue != 0)
        {
            if(bSigned)
            {
                if(iSlotValue == CINT_TOKENS_FOR_BASE * 198)
                    iSlotValue = 0;
                else if(bFoundToken == FALSE)
                    iSlotValue = APTS_GetSlotValue(oPlayer, iSlotNum+i, TRUE);
            }
            bFoundToken = TRUE;
            iTotalValue += (iSlotValue*FloatToInt(pow(IntToFloat(CINT_NUMBER_BASE), IntToFloat(i))));
        }
    }
    return iTotalValue;
}

int APTS_GetSlotValue(object oPlayer, int iSlotNum, int bSigned)
{
    string sItemTag;

    int iTokenType;
    int iFixedTokenType = -1;

    int iTokenValue = 0;
    int bFoundToken = FALSE;
    int bPlotFlag = FALSE;

    string sPartialTokenTag = APTS_TOKEN_TAG + "_S";
    if(iSlotNum < 100)
        sPartialTokenTag += "0";
    if(iSlotNum < 10)
        sPartialTokenTag += "0";
    sPartialTokenTag += (IntToString(iSlotNum) + "_");

    // Search through inventory looking for tokens
    object oItem = GetFirstItemInInventory(oPlayer);
    while(GetIsObjectValid(oItem))
    {
        sItemTag = GetTag(oItem);
        // Found a matching token
        if(FindSubString(sItemTag, sPartialTokenTag) == 0)
        {
            iTokenType = StringToInt(GetStringRight(sItemTag, 2));
            if(!bFoundToken)
            {
                iTokenValue = (198 * iTokenType) + GetNumStackedItems(oItem);

                bFoundToken = TRUE;
                iFixedTokenType = iTokenType;
                bPlotFlag = GetPlotFlag(oItem);
            }
            else if(iFixedTokenType == iTokenType)
            {
                iTokenValue += GetNumStackedItems(oItem);
                if(GetPlotFlag(oItem) == TRUE)
                    bPlotFlag = TRUE;
            }
            else
                DestroyObject(oItem);
        }
        oItem = GetNextItemInInventory(oPlayer);
    }

    if(iTokenValue > 0 && bPlotFlag == FALSE)
    {
           iTokenValue += 99;
    }

    // If Signed, convert to negative number by two's complement
    if(bSigned && (iTokenValue > APTS_GetBitValue(CINT_BITS_PER_TOKEN-1)-1))
        iTokenValue -= APTS_GetBitValue(CINT_BITS_PER_TOKEN);

    return iTokenValue;
}

string APTS_IntToBinaryString(int iValue, int iAlignBit = 0)
{
    string sHexString = IntToHexString(iValue);
    string sBinaryString = "";
    string sChar;
    int i;
    for(i = 2; i < 10; ++i)
    {
        sChar = GetSubString(sHexString, i, 1);
        if(sChar == "0")
            sBinaryString += "0000";
        else if(sChar == "1")
            sBinaryString += "0001";
        else if(sChar == "2")
           sBinaryString += "0010";
        else if(sChar == "3")
           sBinaryString += "0011";
        else if(sChar == "4")
           sBinaryString += "0100";
        else if(sChar == "5")
           sBinaryString += "0101";
        else if(sChar == "6")
           sBinaryString += "0110";
        else if(sChar == "7")
           sBinaryString += "0111";
        else if(sChar == "8")
           sBinaryString += "1000";
        else if(sChar == "9")
           sBinaryString += "1001";
        else if(sChar == "a")
           sBinaryString += "1010";
        else if(sChar == "b")
           sBinaryString += "1011";
        else if(sChar == "c")
           sBinaryString += "1100";
        else if(sChar == "d")
           sBinaryString += "1101";
        else if(sChar == "e")
           sBinaryString += "1110";
        else // F
           sBinaryString += "1111";
    }


    // Remove Leading Zeroes
    while(GetStringLeft(sBinaryString, 1) == "0")
    {
        sBinaryString = GetStringRight(sBinaryString, GetStringLength(sBinaryString) - 1);
    }
    if(iAlignBit > 0)
    {
        int iAddedZeroes = GetStringLength(sBinaryString) % iAlignBit;
        if(iAddedZeroes > 0)
            iAddedZeroes = iAlignBit - iAddedZeroes;
        // Fill with ones if negative
        if(iValue < 0)
        {
            for(i = 0; i < iAddedZeroes; ++i)
                sBinaryString = "1" + sBinaryString;
        }
        else  // Fill with zeroes
        {
            for(i = 0; i < iAddedZeroes; ++i)
                sBinaryString = "0" + sBinaryString;
        }

    }
    return sBinaryString;
}

int APTS_BinaryStringToInt(string sBinary, int bSigned = TRUE)
{
    int iNumBits = GetStringLength(sBinary);
    string sChar;
    int iTotal = 0;
    int i;
    for(i = iNumBits; i > 0; --i)
    {
        sChar = GetSubString(sBinary, iNumBits - i, 1);
        if(sChar == "1")
                iTotal += APTS_GetBitValue(i-1);
    }
    if(bSigned && (iTotal > APTS_GetBitValue(iNumBits-1)-1))
        iTotal -= APTS_GetBitValue(iNumBits);

    return iTotal;


}

float APTS_BinaryStringToDecimal(string sBinary)
{
    int iLength = GetStringLength(sBinary);
    int i;

    float fTotal = 0.0;
    float fDivider = 1.0;

    for(i = 0; i < iLength; ++i)
    {
        fDivider /= 2.0;
        if(GetSubString(sBinary, i, 1) == "1")
            fTotal += fDivider;
    }
    return fTotal;
}
float APTS_Pow(float fValue, int iExp)
{
    int i;
    float fTotal = 1.0;

    if(iExp < 0)
    {
        fTotal = 1.0;
        for(i = 0; i < -iExp; ++i)
        {
            fTotal /= fValue;
        }
    }
    else
    {
        for(i = 0; i < iExp; ++i)
        {
            fTotal *= fValue;
        }
    }
    return fTotal;
}
string APTS_RemoveTrailingZeroes(string sBinary)
{
    string sTruncString = sBinary;

    while(GetStringRight(sTruncString, 1) == "0")
    {
        sTruncString = GetStringLeft(sTruncString, GetStringLength(sTruncString) - 1);
    }
    return sTruncString;

}
int APTS_FloatToIntRep(float fValue, int iSize)
{
    if(fValue == 0.0)
        return 0;
    float fAbsValue = fabs(fValue);

    string sFloatString = FloatToString(fAbsValue);
    string sIntPartBinary = "";
    int iMantissaSize;
    int iExpOffset;
    int iExpSize;

    if(iSize == 2)
    {
        iMantissaSize = 15;
        iExpOffset = 31;
        iExpSize = 6;
    }
    else if(iSize == 3)
    {
        iMantissaSize = 23;
        iExpOffset = 127;
        iExpSize = 8;
    }

    while(GetStringLeft(sFloatString, 1) == " ")
    {
        sFloatString = GetStringRight(sFloatString, GetStringLength(sFloatString) - 1);
    }
    // Get Integer part
    sFloatString = GetStringLeft(sFloatString, FindSubString(sFloatString, "."));
    float fIntPart = StringToFloat(sFloatString);

    float fDiv = fIntPart;
    while(fDiv >= 1.0)
    {
        sFloatString = FloatToString(fDiv);
        while(GetStringLeft(sFloatString, 1) == " ")
        {
            sFloatString = GetStringRight(sFloatString, GetStringLength(sFloatString) - 1);
        }

        sFloatString = GetStringLeft(sFloatString, FindSubString(sFloatString, "."));
        if(StringToInt(GetStringRight(sFloatString, 1)) % 2 == 1)
            sIntPartBinary = "1" + sIntPartBinary;
        else
            sIntPartBinary = "0" + sIntPartBinary;

        fDiv = StringToFloat(sFloatString);
        fDiv /= 2.0;
    }

    int iExp = 0;

    float fDecimalPart = fAbsValue - fIntPart;
    string sFloatBinary;

    int i;

    // Remove the leading "1"
    string sMantissa = GetStringRight(sIntPartBinary,  GetStringLength(sIntPartBinary) - 1);
    while(GetStringLength(sMantissa) < iMantissaSize)
    {
        fDecimalPart *= 2;
        if(fDecimalPart >= 1.0)
        {
            sMantissa += "1";
            fDecimalPart -= 1;
        }
        else
        {
            if(GetStringLength(sMantissa) > 0 || GetStringLength(sIntPartBinary) > 0)
                sMantissa += "0";
            else
                iExp -= 1;
        }
    }

    if(GetStringLength(sIntPartBinary) > 0)
        iExp = GetStringLength(sIntPartBinary) - 1;

    sMantissa = GetStringLeft(sMantissa, iMantissaSize);

    sFloatBinary = IntToString(fValue < 0.0);
    sFloatBinary += (APTS_IntToBinaryString(iExp + iExpOffset, iExpSize) + sMantissa);

    return APTS_BinaryStringToInt(sFloatBinary);
}

float APTS_IntRepToFloat(int iValue, int iSize)
{
    if(iValue == 0)
        return 0.0;
    int iMantissaSize;
    int iExpOffset;
    int iExpSize;
    string sBinaryString;

    if(iSize == 2)
    {
        iMantissaSize = 15;
        iExpOffset = 31;
        iExpSize = 6;
        sBinaryString = APTS_IntToBinaryString(iValue, 22);
        sBinaryString = GetStringRight(sBinaryString, 22);
    }
    else if(iSize == 3)
    {
        iMantissaSize = 23;
        iExpOffset = 127;
        iExpSize = 8;
        sBinaryString = APTS_IntToBinaryString(iValue, 32);
    }
    string sExpPart = GetSubString(sBinaryString, 1, iExpSize);
    string sMantissaPart = GetSubString(sBinaryString, iExpSize+1, iMantissaSize);

    int iExp;
    int iIntPart;
    float fDecPart;
    float fResult;


    iExp = APTS_BinaryStringToInt(sExpPart, FALSE) - iExpOffset;

    if(iExp < iMantissaSize)
    {
        if(iExp >= 0)
        {
            iIntPart = APTS_BinaryStringToInt(GetStringLeft("1" + sMantissaPart, iExp + 1), FALSE);
            sMantissaPart = GetStringRight(sMantissaPart, iMantissaSize - iExp);
        }
        else
        {
            iIntPart = 0;
            int i;
            for(i = 0; i < -iExp; ++i)
            {
                sMantissaPart = "0" + sMantissaPart;
            }
        }

        fDecPart = APTS_BinaryStringToDecimal(APTS_RemoveTrailingZeroes(sMantissaPart));
        fResult = iIntPart + fDecPart;
    }
    else
    {
        iIntPart = 1;
        fDecPart = APTS_BinaryStringToDecimal(APTS_RemoveTrailingZeroes(sMantissaPart));
        fResult = iIntPart + fDecPart;
        fResult *= APTS_Pow(2.0, iExp);
    }
    if(GetStringLeft(sBinaryString, 1) == "1")
        fResult = -fResult;
    return fResult;
}

void APTS_RemoveOldDeclaration(string sVarName)
{
    if(GetLocalInt(GetModule(), "APTS_ITOK_" + sVarName + "_TYPE") == APTS_TYPE_BOOL)
    {
        string sBoolName = "boolean" + IntToString(GetLocalInt(GetModule(), "APTS_ITOK_" + sVarName + "_SLOT"));
        APTS_RemoveOldDeclaration(sBoolName);
    }

    else if(GetLocalInt(GetModule(), "APTS_ITOK_" + sVarName + "_TYPE") == APTS_TYPE_LOCATION)
    {
        string sSlotString = IntToString(GetLocalInt(GetModule(), "APTS_ITOK_" + sVarName + "_SLOT"));
        APTS_RemoveOldDeclaration("area_string" + sSlotString);
        APTS_RemoveOldDeclaration("xPos" + sSlotString);
        APTS_RemoveOldDeclaration("yPos" + sSlotString);
        APTS_RemoveOldDeclaration("zPos" + sSlotString);
        APTS_RemoveOldDeclaration("facing" + sSlotString);

    }
    DeleteLocalInt(GetModule(), "APTS_ITOK_" + sVarName + "_SLOT");
    DeleteLocalInt(GetModule(), "APTS_ITOK_" + sVarName + "_SIZE");
    DeleteLocalInt(GetModule(), "APTS_ITOK_" + sVarName + "_SIGNED");
    DeleteLocalInt(GetModule(), "APTS_ITOK_" + sVarName + "_BIT");
    DeleteLocalInt(GetModule(), "APTS_ITOK_" + sVarName + "_TYPE");
    DeleteLocalInt(GetModule(), "APTS_ITOK_" + sVarName + "_DATA");
}

int APTS_ConvertThreeCharToInt(string sString)
{
    int i;
    string sChar;
    string sIntRep = "";
    int iValue;

    for(i = 0; i < 3; ++i)
    {
        // Gets a single character of the string
        sChar = GetSubString(sString, i, 1);
        if(sChar == "")
            break;
        // Converts the character into an integer by use of a lookup table
        iValue = FindSubString(APTS_CHAR_TABLE, sChar)+1;
        if(iValue < 10)
            sIntRep += "0";
        sIntRep += IntToString(iValue);
    }
    return StringToInt(sIntRep);
}

string APTS_ConvertIntToThreeChar(int iMedValue)
{
    string sResultString = "";
    string sIntRep = IntToString(iMedValue);
    int i;
    int iValue;

    for(i = 0; i < 3; ++i)
    {
        // Only get the first character if the string is odd sized
        if(i == 0 && (GetStringLength(sIntRep)%2 == 1))
        {
            iValue = StringToInt(GetSubString(sIntRep, 0, 1));
        }
        else
            iValue = StringToInt(GetSubString(sIntRep, i*2, 2));

        sResultString += GetSubString(APTS_CHAR_TABLE, iValue-1, 1);
    }
    return sResultString;
}

int APTS_HashAreaTag(string sTag, int iPrimeNum)
{
// Roating hash function
    int iHash, i;
    int iLength = GetStringLength(sTag);
    string sChar;

    iHash = iLength;

    for (i=0; i < iLength; ++i)
    {
        sChar = GetSubString(sTag, i, 1);
        iHash = (iHash<<8)^(iHash>>24)^(FindSubString(APTS_CHAR_TABLE, sChar)+1);
    }
    return (iHash % iPrimeNum);
}


int APTS_HashString(string sString, int iPrimeNum)
{
    return APTS_HashAreaTag(sString, iPrimeNum);

}
