/****************************************************
  Common #include Script
  ats_inc_common

  Last Updated: August 2, 2002

  ***Ambrosia Tradeskill System***
    Created by Mojo(Allen Sun)

  This script contains basic functions needed by
  most other script files.

**************************************************/
#include "ats_inc_debug"
#include "ats_inc_persist"
#include "ats_inc_allowed"

/////////////////////////////////////////////////////
// ATS_GetResRefFromTag                            //
//      Converts a tag into a resref assuming tag  //
//      has the same name as resref.               //
// Returns: string - ResRef                        //
/////////////////////////////////////////////////////
string ATS_GetResRefFromTag(string sTag)
{
    return GetStringLowerCase(GetStringLeft(sTag, 16));
}

/////////////////////////////////////////////////////
// ATS_CreateItemOnPlayer                         //
//      Wrapper for CreateItemOnObject() so it can //
//      be used with DelayCommand()                //
// Returns: None                                   //
//          Check local object variable:           //
//          "ats_returnvalue_created_item" for the //
//          created object                         //
///////////////////////////////////////////////////
void ATS_CreateItemOnPlayer
(
string sItemTag,           // Tag of the item
object oPlayer,            // Player to create item on
int iStackSize = 1,        // Size of the item stack
int iDropToFloor = TRUE,   // Creates the item on the floor if inventory is full
)
{
    string sItemResRef = ATS_GetResRefFromTag(sItemTag);
    if ((GetStringRight(sItemTag,3)== "ARR") || (GetStringRight(sItemTag,3)== "arr"))
        iStackSize = 20;
// Following lines by GilronS for stacking issues with the craftable Throwing Axes
//    if (GetSubString(sItemTag, 6, 4) == "XXXX")
//        iStackSize = 50;
    if (GetStringUpperCase(GetSubString(sItemTag, 6, 4)) == "W036")
        iStackSize = 50;
    if (GetStringUpperCase(GetSubString(sItemTag, 6, 4)) == "W037")
        iStackSize = 50;
    if (GetStringUpperCase(GetSubString(sItemTag, 6, 4)) == "W038")
        iStackSize = 50;
    if (GetStringUpperCase(GetSubString(sItemTag, 6, 4)) == "W039")
        iStackSize = 50;
// End Stacking Code for Throwing Axes
    object oCreatedItem = CreateItemOnObject(sItemResRef, oPlayer, iStackSize);
//    if(GetItemPossessor(oCreatedItem) == OBJECT_INVALID && iDropToFloor == TRUE)
//    {
//        oCreatedItem = CreateObject(OBJECT_TYPE_ITEM, sItemResRef, GetLocation(oPlayer));
//    }
    SetLocalObject(oPlayer, "ats_returnvalue_created_item", oCreatedItem);
    SetLocalObject(oCreatedItem, "ats_obj_possessor", GetItemPossessor(oCreatedItem));
    if(GetItemHasItemProperty(oCreatedItem, ITEM_PROPERTY_CAST_SPELL) == TRUE)
        SetLocalInt(oCreatedItem, "ats_charges_fix", TRUE);
}

/////////////////////////////////////////////////////
// ATS_CreateItemInContainer                       //
//      Wrapper for CreateItemOnObject() so it can //
//      be used with DelayCommand()                //
// Returns: None                                   //
//          Check local object variable:           //
//          "ats_returnvalue_created_item" for the //
//          created object                         //
/////////////////////////////////////////////////////
void ATS_CreateItemInContainer
(
string sItemTag,           // Tag of the item
object oContainer,         // Container to create the item in
int iStackSize = 1,        // Size of the item stack
int iForceCreation = TRUE, // If container is full, the object is created on the owner
)
{
    string sItemResRef = ATS_GetResRefFromTag(sItemTag);

    object oCreatedItem = CreateItemOnObject(sItemResRef, oContainer, iStackSize);
    if(GetItemPossessor(oCreatedItem) == OBJECT_INVALID && iForceCreation == TRUE)
    {
        oCreatedItem = CreateItemOnObject(sItemResRef, GetItemPossessor(oContainer),
                                          iStackSize);
    }
    SetLocalObject(oContainer, "ats_returnvalue_created_item", oCreatedItem);
    SetLocalObject(oCreatedItem, "ats_obj_possessor", GetItemPossessor(oCreatedItem));
    if(GetItemHasItemProperty(oCreatedItem, ITEM_PROPERTY_CAST_SPELL) == TRUE)
        SetLocalInt(oCreatedItem, "ats_charges_fix", TRUE);
}
/////////////////////////////////////////////////////
// ATS_CreateObject                                //
//      Wrapper for CreateObject() so it can       //
//      be used with DelayCommand()                //
// Returns: None                                   //
/////////////////////////////////////////////////////
void ATS_CreateObject
(
int iObjectType,                // object type constant
string sTemplate,               // object resref
location lLocation,             // location of new object
int bUseAppearAnimation = FALSE // use animation
)
{
    object oObjectCreated = CreateObject(iObjectType, sTemplate, lLocation, bUseAppearAnimation);
    if(GetItemHasItemProperty(oObjectCreated, ITEM_PROPERTY_CAST_SPELL) == TRUE)
        SetLocalInt(oObjectCreated, "ats_charges_fix", TRUE);
    SetLocalObject(oObjectCreated, "ats_obj_possessor", GetItemPossessor(oObjectCreated));

}

string ATS_GetUniquePlayerID(object oPlayer)
{
    return ("ATS_PID_" + GetPCPlayerName(oPlayer) + GetName(oPlayer));

}

/////////////////////////////////////////////////////
// ATS_GetTradeskill                               //
//      Returns the skill value of a particular    //
//      tradeskill of a player                     //
// Returns: int - current skill value              //
/////////////////////////////////////////////////////
int ATS_GetTradeskill
(
object oPlayer,         // player to get tradeskill value from
string sTradeSkillType  // name of the tradeskill
)
{
    string sVarName = "ats_skillvalue_" + sTradeSkillType;
    return ATS_GetPersistentInt(oPlayer, sVarName);

}

/////////////////////////////////////////////////////
// ATS_GetTagBaseType                              //
//      Gets an item's base tag which consists of  //
//      four characters within the tag.            //
// Returns: String - Base Tag                      //
/////////////////////////////////////////////////////
string ATS_GetTagBaseType(object oTargetObject)
{
    string sObjectTag = GetTag(oTargetObject);
    // Return the 4 character substring 6 characters into the tag
    return GetSubString(sObjectTag, 6, 4);
}

/////////////////////////////////////////////////////
// ATS_GetCraftTag                                 //
//      Gets an item's craft tag from an object    //
// Returns: String - Craft Tag                     //
/////////////////////////////////////////////////////
string ATS_GetCraftTag(object oTargetObject)
{
    string sObjectTag = GetTag(oTargetObject);
    return GetStringLeft(sObjectTag, 10);

}


object ATS_FindItemInInventoryByTag(object oTarget, string sTag, int iNth = 0)
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

object ATS_FindItemInInventoryByBaseTag(object oTarget, string sBaseTag, int iNth = 0)
{
    int iCount = 0;
    object oCurrentObject = OBJECT_INVALID;

    if(GetHasInventory(oTarget) == FALSE)
        return oCurrentObject;

    oCurrentObject =  GetFirstItemInInventory(oTarget);

    while(GetIsObjectValid(oCurrentObject) == TRUE)
    {
        if(ATS_GetTagBaseType(oCurrentObject) == sBaseTag)
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
/////////////////////////////////////////////////////
// ATS_CapitalizeString                            //
//      Capitalizes the first letter of a string   //
// Returns: string - capitalized string            //
/////////////////////////////////////////////////////
string ATS_CapitalizeString(string sStringToCap)
{
    string sTempString = GetStringLeft(sStringToCap, 1);
    sTempString = GetStringUpperCase(sTempString);
    sTempString = sTempString + GetStringRight(sStringToCap, GetStringLength(sStringToCap) - 1);
    return sTempString;
}

void ATS_RemoveAllInstances(string sTag)
{
    int iNum = 0;
    object oObjectToDestroy = GetObjectByTag(sTag, iNum++);


    while(oObjectToDestroy != OBJECT_INVALID)
    {
        DestroyObject(oObjectToDestroy);
        oObjectToDestroy = GetObjectByTag(sTag, iNum++);
    }

}

void ATS_RemoveAllInstancesOnPlayer(object oPlayer, string sTag)
{
    int iNum = 0;
    object oObjectToDestroy = GetObjectByTag(sTag, iNum++);


    while(oObjectToDestroy != OBJECT_INVALID)
    {
        if(GetItemPossessor(oObjectToDestroy) == oPlayer)
            DestroyObject(oObjectToDestroy);
        oObjectToDestroy = GetObjectByTag(sTag, iNum++);
    }

}

string ATS_CraftToItemTag(string sCraftTag, string sQuality, string sMaterialType)
{
    return (GetStringLeft(sCraftTag, 10) + "_" + sQuality + "_" + sMaterialType);
}

int ATS_IsItemNoDrop(object oItem)
{
    string sUpperTag = GetStringUpperCase(GetTag(oItem));
    if(FindSubString(sUpperTag, "_NOD") > 0 || FindSubString(sUpperTag, "NODROP") > 0)
        return TRUE;
    else if (GetLocalInt(oItem,"ats_nodrop"))  // added by richterm to try and fix
        return TRUE;                           // bags with NODROP items in them
    else                                       // the flag was set in ats_inc_nodrop but
        return FALSE;                          // wass never checked
}

int ATS_IsItemResource(object oItem)
{
    if(GetStringLeft(GetTag(oItem), 5) == "ATS_R")
        return TRUE;
    else
        return FALSE;
}

int ATS_GetItemDurability(object oItem)
{
    return GetLocalInt(oItem, "ats_durability");
}

void ATS_SetItemDurability(object oItem, int iDurability)
{
    SetLocalInt(oItem, "ats_durability", iDurability);
}

void ATS_DecreaseItemDurability(object oItem, int iAmount)
{
    ATS_SetItemDurability(oItem, ATS_GetItemDurability(oItem) - iAmount);
}

int ATS_GetItemMaxDurability(object oItem)
{
    string sItemTag = GetTag(oItem);
    int iStringIndex = FindSubString(sItemTag, "_DUR");
    if(iStringIndex == -1)
        return 0;

    string sParsedString = GetSubString(sItemTag, iStringIndex + 4,
                                        GetStringLength(sItemTag) - iStringIndex - 4);
    iStringIndex = FindSubString(sParsedString, "_");
    if(iStringIndex <= 0)
    {
        return StringToInt(sParsedString);
    }
    else
    {
        return StringToInt(GetStringLeft(sParsedString, iStringIndex));
    }

}


/////////////////////////////////////////////////////
// ATS_BreakItem                                   //
//      Wrapper function to destroy an item and    //
//      display text that it was broken            //
// Returns: none                                   //
/////////////////////////////////////////////////////
void ATS_BreakItem
(
object oItemToBreak,    // item to destroy
float fDelay = 0.5      // delay in seconds to destroy
)
{

    string sArrayName = "durability_" + GetTag(oItemToBreak);
    object oItemPossessor = GetItemPossessor(oItemToBreak);
    string sItemName = GetName(oItemToBreak);

    DestroyObject(oItemToBreak, fDelay);
    AssignCommand(GetModule(), DelayCommand(fDelay, FloatingTextStringOnCreature("Your " + sItemName +
        " has broken.", oItemPossessor, FALSE)));

}
/////////////////////////////////////////////////////
// ATS_StrTok                                      //
//      Mimics the C string function strtok()      //
// Returns: string - string token                  //
//                   returns "" if end of string   //
/////////////////////////////////////////////////////
string ATS_StrTok
(
string sString,     // String to tokenize(send in "" to continue with previous
                    // string)
string sDelimeter   // Delimiter string
)
{
    string sStringToTok;
    if(sString == "")
        sStringToTok = GetLocalString(GetModule(), "ats_strtok_string");
    else
        sStringToTok = sString;

    int iTokenEndPos = FindSubString(sStringToTok, sDelimeter);
    if(iTokenEndPos == -1 || sDelimeter == "")
    {
        SetLocalString(GetModule(), "ats_strtok_string", "");
        return sStringToTok;
    }
    else
    {
        int iStringLength = GetStringLength(sStringToTok);
        int iDelimeterLength = GetStringLength(sDelimeter);

        SetLocalString(GetModule(), "ats_strtok_string",
                   GetStringRight(sStringToTok, iStringLength - iTokenEndPos - iDelimeterLength));
        return GetStringLeft(sStringToTok, iTokenEndPos);
    }
}

int ATS_GetIsVowel(string sChar)
{
    string sLowerChar = GetStringLowerCase(sChar);
    if(sLowerChar == "a" || sLowerChar == "e" || sLowerChar == "i" || sLowerChar == "o" || sLowerChar == "u")
        return TRUE;
    else
        return FALSE;
}

// Function borrowed from NWN Spawn System by Palor
location ATS_GetRandomLocationNearObject(object oNearObject, int iMaxDistance)
{

  vector vNewPos = GetPosition(oNearObject);
  object oArea = GetArea(oNearObject);
  float fX, fY;
  float fMaxY;
  float fRadius = IntToFloat(iMaxDistance);
  fX = (Random(200)/100.0 - 1.0) * fRadius;
  fMaxY = sqrt(fRadius*fRadius-fX*fX);
  fY = (Random(200)/100.0 - 1.0) * fMaxY;
  vNewPos += Vector(fX, fY, 0.0);
  location lNewLoc = Location(oArea, vNewPos, VectorToAngle(-1.0 * vNewPos));
  return lNewLoc;
}


