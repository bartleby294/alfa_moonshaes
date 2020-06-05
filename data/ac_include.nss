//:://////////////////////////////////////////////////
//:: ALFA Animal Companions
//:: ac_include
//::
//:: Copyright (c) 2002 Floodgate Entertainment
//:://////////////////////////////////////////////////
//:: Created By Shawn "U'lias" Marcil for ALFA
//:: Created On: October 2, 2003
//:: Modified Date: November 3, 2003
//:://////////////////////////////////////////////////
/*

Description:    This include file contains the functions that make up the
                ALFA Animal Companion System.  It handles saving, updating,
                deleting, and restoring a PC's Animal Companion information.
*/

/******************************************************************************/
/* Includes                                                                   */
/******************************************************************************/

#include "alfa_constants"
#include "alfa_options"

// #include "x0_i0_henchman"
// Use a forward reference to avoid getting SoU includes everywhere.
// We need to do this because of f*$%king Jasperre's AI.  IF he ever
// comes out with a version that works correctly with SoU, you should be
// able to go back to the include.
void ClearAllDialogue(object oPC, object oNPC=OBJECT_SELF);

#include "hc_inc"

/******************************************************************************/
/* Constants                                                                  */
/******************************************************************************/
/** You may alter the following constant **/

//SWITCHES:
const int AC_DEBUG = FALSE;



/******************************************************************************/
/* Function Definitions                                                       */
/******************************************************************************/

// Returns the PC's effective druid level with regards to summoning an animal
// companion; a PC's ranger level counts as ranger level-6 effective druid levels
// - oPC
// Return Values: nDruidLevel
int AC_GetDruidLevel(object oPC);

// Returns a Environment string (flag) value depending on the environment
// - nEnvironment
// Return Values: sFlag (a 3 character string value)
string AC_GetEnvironmentFlag(int nEnvironment);

// Checks the current area for a waypoint with the "WP_ENVIRONMENT" tag prefix.
// If there isn't a waypoint found the the appropriate tag prefix then it returns
// "NoEnvironmentFlag".
// - oArea
// Return Values: sWaypointTag
string AC_GetEnviroWaypoint(object oArea);

// Obtains the nEnvironment value by way of calling the AC_GetEnviroWaypoint
// function or from the current area's tag (based on a 3 character flag)
// - oArea
// Return Values: nEnvironment
int AC_GetEnvironment(object oArea);

// Acquires the animal companion ResRef suffix to be added to the randomly
// selected base animal type's tag in order to spawn the appropriate level
// animal companion. The suffix is representive of druid level ranges.
// - nDruidLevel
// Return Values: nResRefSuffix
int AC_GetResRefSuffix(int nDruidLevel);

// Checks if the PC's new druid or ranger level will increment their level range
// with regards to replacing their animal companion with a higher HD version;
// - oPC
// - nDruidLevel
// Return Values: TRUE or FALSE
int AC_IsSameLevelRange(object oPC, int nDruidLevel);

// Obtains the number of items in a specified environment merchant's inventory
// - oMerchant
// Return Values: nNumInvItems
int AC_GetNumOfInventoryItems(object oMerchant);

// Assigns the animal companion's ResRef by factoring in the current area's
// environment flag, and randomly selecting an item in the appropriate merchant's
// inventory and examining its tag.
// - nEnvironment
// - nDruidLevel
// Return Values: sAnimalResRef
string AC_GetCompanionResRef(int nEnvironment, int nDruidLevel);

// Spawns the proscribed animal companion within a 20.0 meter radius around the
// PC druid
// - oPC
// - sAnimalResRef
// Return Values: oCompanion
object AC_SpawnInCompanion(object oPC, string sAnimalResRef);

// Gathers the general animal companion type's recall whistle item's ResRef by
// using the animal companion's ResRef and stripping away the PC druid's range
// level suffix.
// - sAnimalResRef
// Return Values: sItemResRef
string AC_GetItemString(string sAnimalResRef);

// Checks if PC has specific item based on its ResRef
// - oPC
// - sItemResRef
// Return Values: TRUE, FALSE
int AC_HasItem_ResRef(object oPC, string sItemResRef);

// Checks if the PC already has a Companion Whistle
// - oPC
// Return Values: TRUE, FALSE
int AC_HasWhistleItem(object oPC);

// Get the object possessed by oCreature with the Blueprint ResRef sItemResRef;
// ResRef alternative to BW's GetItemPossessedBy function
// - oPC
// - sItemResRef
// Return Values: oCompanionItem
// * Return value on error: OBJECT_INVALID
object AC_GetItemPossessedBy(object oPC, string sItemResRef);

// Destroys animal companion whistle item from PC's inventory, and removes the
// specific DB record
// - oPC
// Return Values: None
void AC_RemoveWhistleItem(object oPC);

// Destroys animal companion permanently or temporarily, and removes or updates
// the specific DB record; if the animal companion is removed permanently then
// it destroys the companion's whistle item from PC's inventory
// - oPC
// - oCompanion
// - bIsPermanent: TRUE or FALSE indicates whether the release of the animal
//                 companion is permanent or only temporary
// Return Values: None
void AC_ReleaseCompanion(object oPC, object oCompanion, int bIsPermanent=FALSE);

// Resets the animal companion's HPs according to its corresponding data in the DB
// - oPC
// - oCompanion
// - sString
// Return Values: None
void AC_SetCompanionHP(object oPC, object oCompanion, string sString);

// Initiates the specified animal companion to be created, adds the animal
// companion as the PC druid's henchman, determines the creation of the
// companion whistle item in the PC druid's inventory, and resets the animal
// companion's HPs when appropriate.
// - oPC
// - sAnimalResRef
// - bIsNewCompanion
// Return Values: None
void AC_ObtainAnimalCompanion(object oPC, string sAnimalResRef, int bIsNewCompanion=FALSE);

// Creates a new higher level version of the PC's animal companion on PC level-up
// if applicable
// - oPC
// - sRootResRef: the base string of an animal companion's ResRef
// - nTotalDamage: the total damaged sustained by the lower level version of
//                  the animal companion
// - nDruidLevel
// - lCompanionLoc: location of lower level version of animal companion
// Return Values: None
void AC_LevelUpAnimalCompanion(object oPC, string sRootResRef, int nTotalDamage, int nDruidLevel, location lCompanionLoc);

// Allows for the recall of the appropriate animal companion when applicable
// upon the PC druid activating the companion's whistle item
// - oPC
// - oCompanionItem
// Return Values: None
void AC_OnActivate(object oCompanionItem);

// Prevents PCs from dropping or removing the companion's whistle item from their
// person; detects items with  "_NODROP" or "_ND" (indicating NO DROP item) in
// their tag.
// - oItemLost
// - oPC
// Return Values: None
void AC_OnUnacquire(object oItemLost, object oPC);

// Handles PC druid's animal companion's level up when the PC levels up; retains
// the companion's current total sustained damage
// - oPC
// Return Values: None
void AC_OnLevelUp(object oPC);

// Handles the animal companion's permanent release and the deletion of the
// Companion Whistle from the PC's inventory upon the PC's death
// - oPC
// Return Values: None
void AC_OnPlayerDeath(object oPC);

/******************************************************************************/
/* NWScript Implementation                                                    */
/******************************************************************************/

int AC_GetDruidLevel(object oPC)
{
    int nDruidLevel = GetLevelByClass(CLASS_TYPE_DRUID, oPC);
    int nRangerLevel = GetLevelByClass(CLASS_TYPE_RANGER, oPC) - 5;

    // returns PC's ranger level if it is greater than their druid level
    if (nRangerLevel > nDruidLevel) return nRangerLevel;

    return nDruidLevel;
}

string AC_GetEnvironmentFlag(int nEnvironment)
{
    string sFlag;
    if (nEnvironment == AC_ENVIRO_UNDERDARK)
        sFlag = "_UG";
    else if (nEnvironment == AC_ENVIRO_FOREST)
        sFlag = "_FR";
    else if (nEnvironment == AC_ENVIRO_JUNGLE)
        sFlag = "_JN";
    else if (nEnvironment == AC_ENVIRO_MOUNTAINS)
        sFlag = "_MN";
    else if (nEnvironment == AC_ENVIRO_PLAINS)
        sFlag = "_PL";
    else if (nEnvironment == AC_ENVIRO_DESERT)
        sFlag = "_DS";
    else if (nEnvironment == AC_ENVIRO_ARCTIC)
        sFlag = "_AR";
    else if (nEnvironment == AC_ENVIRO_AQUATIC)
        sFlag = "_AQ";
    else if (nEnvironment == AC_ENVIRO_SWAMP)
        sFlag = "_SW";
    else if (nEnvironment == AC_ENVIRO_NONE)
        sFlag = "_NA";
    return sFlag;
}

string AC_GetEnviroWaypoint(object oArea)
{
    object oWaypoint = GetFirstObjectInArea(oArea);
    string sWPPrefix = "WP_ENVIRONMENT";
    string sWaypointTag;

    while(GetIsObjectValid(oWaypoint))
    {
        sWaypointTag = GetTag(oWaypoint);
        if (    (GetObjectType(oWaypoint) == OBJECT_TYPE_WAYPOINT) &&
                (GetStringLeft(sWaypointTag, 14) == sWPPrefix)  )
            break;
        else sWaypointTag = "NoEnvironmentFlag";
        oWaypoint = GetNextObjectInArea(oArea);
    }

    return sWaypointTag;
}

int AC_GetEnvironment(object oArea)
{
    string sTag = AC_GetEnviroWaypoint(oArea);
    int nEnvironment;

    if (sTag == "NoEnvironmentFlag") sTag = GetStringUpperCase(GetTag(oArea));

    if (FindSubString(sTag, "_UG") > 0)
        nEnvironment = AC_ENVIRO_UNDERDARK;
    else if (FindSubString(sTag, "_FR") > 0)
        nEnvironment = AC_ENVIRO_FOREST;
    else if (FindSubString(sTag, "_JN") > 0)
        nEnvironment = AC_ENVIRO_JUNGLE;
    else if (FindSubString(sTag, "_MN") > 0)
        nEnvironment = AC_ENVIRO_MOUNTAINS;
    else if (FindSubString(sTag, "_PL") > 0)
        nEnvironment = AC_ENVIRO_PLAINS;
    else if (FindSubString(sTag, "_DS") > 0)
        nEnvironment = AC_ENVIRO_DESERT;
    else if (FindSubString(sTag, "_AR") > 0)
        nEnvironment = AC_ENVIRO_ARCTIC;
    else if (FindSubString(sTag, "_AQ") > 0)
        nEnvironment = AC_ENVIRO_AQUATIC;
    else if (FindSubString(sTag, "_SW") > 0)
        nEnvironment = AC_ENVIRO_SWAMP;
    else if (FindSubString(sTag, "_NA") > 0)
        nEnvironment = AC_ENVIRO_NONE;
    else if (gAC_DEFAULT_ENVIRONMENT != AC_ENVIRO_NONE)
        nEnvironment = gAC_DEFAULT_ENVIRONMENT;
    else nEnvironment = AC_ENVIRO_NONE;

    if (AC_DEBUG) SendMessageToPC(GetFirstPC(), "Area sTag = " + sTag);

    return nEnvironment;
}

int AC_GetResRefSuffix(int nDruidLevel)
{
    int nResRefSuffix;
    switch(nDruidLevel)
    {
        case 1: case 2: nResRefSuffix = 1; break;
        case 3: case 4: case 5: nResRefSuffix = 2; break;
        case 6: case 7: case 8: nResRefSuffix = 3; break;
        case 9: case 10: case 11: nResRefSuffix = 4; break;
        case 12: case 13: case 14: nResRefSuffix = 5; break;
        case 15: case 16: case 17: nResRefSuffix = 6; break;
        case 18: case 19: case 20: nResRefSuffix = 7; break;
    }
    return nResRefSuffix;
}

int AC_IsSameLevelRange(object oPC, int nDruidLevel)
{
    int nLevelRange = AC_GetResRefSuffix(nDruidLevel);
    int nOldLevelRange = AC_GetResRefSuffix(nDruidLevel - 1);

    if (nLevelRange == nOldLevelRange)
        return TRUE;

    if (AC_DEBUG)
    {
        SendMessageToPC(GetFirstPC(), "nLevelRange = " + IntToString(nLevelRange));
        SendMessageToPC(GetFirstPC(), "nOldLevelRange = " + IntToString(nOldLevelRange));
    }

    return FALSE;
}

int AC_GetNumOfInventoryItems(object oMerchant)
{
    object oMerchantItem = GetFirstItemInInventory(oMerchant);
    int nNumInvItems = 0;

    while (GetIsObjectValid(oMerchantItem))
    {
        nNumInvItems = nNumInvItems + 1; // inventory counter
        oMerchantItem = GetNextItemInInventory(oMerchant);
    }
    return nNumInvItems;
}

string AC_GetCompanionResRef(int nEnvironment, int nDruidLevel)
{
    object oMerchant, oInventoryItem;
    string sAnimalResRef, sItemTag;
    int nResRefSuffix = AC_GetResRefSuffix(nDruidLevel);
    string sFlag = GetStringLowerCase(AC_GetEnvironmentFlag(nEnvironment));
    string sMerchantTag = "ac_keeper" + sFlag + "_store";
    int nCountItems = 0;
    int nNumInvItems, nRandomItem;

    if (AC_DEBUG)
    {
        SendMessageToPC(GetFirstPC(), "nResRefSuffix = " + IntToString(nResRefSuffix));
        SendMessageToPC(GetFirstPC(), "sFlag = " + sFlag);
        SendMessageToPC(GetFirstPC(), "sMerchantTag = " + sMerchantTag);
    }

    oMerchant = GetObjectByTag(sMerchantTag);

    if (!GetIsObjectValid(oMerchant))
    {
        sAnimalResRef = "NoAC";
    }
    else
    {
        if (AC_DEBUG) SendMessageToPC(GetFirstPC(), "Merchant Valid = " + IntToString(GetIsObjectValid(oMerchant)));

        nNumInvItems = AC_GetNumOfInventoryItems(oMerchant);
        nRandomItem = Random(nNumInvItems) + 1;

        if (AC_DEBUG)
        {
            SendMessageToPC(GetFirstPC(), "nNumInvItems = " + IntToString(nNumInvItems));
            SendMessageToPC(GetFirstPC(), "nRandomItem = " + IntToString(nRandomItem));
        }

        oInventoryItem = GetFirstItemInInventory(oMerchant);

        while(GetIsObjectValid(oInventoryItem))
        {
            sItemTag = GetTag(oInventoryItem);
            nCountItems++;
            if (nCountItems == nRandomItem)
            {
                if (AC_DEBUG)
                {
                    SendMessageToPC(GetFirstPC(), "sItemTag = " + sItemTag);
                    SendMessageToPC(GetFirstPC(), "nCountItems = " + IntToString(nCountItems));
                }
                break;
            }
            oInventoryItem = GetNextItemInInventory(oMerchant);
        }

        sAnimalResRef = sItemTag + IntToString(nResRefSuffix);
    }

    return sAnimalResRef;
}

object AC_SpawnInCompanion(object oPC, string sAnimalResRef)
{
    object oCompanion;
    vector vCenter, vNew;
    location lNew;
    float fX, fY, fZ;
    float fRadius = (20.0f);
    int i, nFound;

    vCenter = GetPosition(oPC);

    /* Pick a spot inside the XY circle of radius fRadius */
    nFound = FALSE;
    while (nFound != TRUE)
    {
        fX = (Random(200)/100.0 - 1.0) * fRadius;
        fY = (Random(200)/100.0 - 1.0) * fRadius;
        if (fX * fX + fY * fY <= fRadius * fRadius)
        {
            nFound = TRUE;
        }
    }

    vNew = vCenter + Vector(fX, fY, 0.0);
    // Gets PC location
    lNew = Location(GetArea(oPC), vNew, VectorToAngle(-1.0 * vNew));
    // create random spawned creature in radius around vegetation object
    oCompanion = CreateObject(OBJECT_TYPE_CREATURE, sAnimalResRef, lNew);
    return oCompanion;
}

string AC_GetItemString(string sAnimalResRef)
{
    string sItemResRef;
    int nLen = GetStringLength(sAnimalResRef);

    sItemResRef = GetStringLeft(sAnimalResRef, (nLen - 1));

    if (AC_DEBUG)
        SendMessageToPC(GetFirstPC(), "sItemResRef = " + sItemResRef );

    return sItemResRef;
}

int AC_HasItem_ResRef(object oPC, string sItemResRef)
{
    object oInvItem = GetFirstItemInInventory(oPC);
    object oContainerItem;
    int bHasItem = FALSE;

    if (AC_DEBUG) FloatingTextStringOnCreature("Checking inventory ...", oPC, FALSE);

    while (GetIsObjectValid(oInvItem)) // Examine all items in PC's inventory
    {
        // Check if item has specific Blueprint ResRef
        if(GetResRef(oInvItem) == sItemResRef)
        {
            if (AC_DEBUG) SendMessageToPC(oPC, "Found item in inventory!");
            bHasItem = TRUE; // Specific item found
            break; // Stop checking
        }

        if (GetHasInventory(oInvItem)) // Check if inventory is a storage item
        {
            if (AC_DEBUG) SendMessageToPC(oPC, "Checking container inventory ...");

            oContainerItem = GetFirstItemInInventory(oInvItem);
            // Examine all items in the storage item
            while (GetIsObjectValid(oContainerItem))
            {
                if(GetResRef(oContainerItem) == sItemResRef)
                {
                    if (AC_DEBUG) SendMessageToPC(oPC, "Found item in container!");
                    bHasItem = TRUE; // Specific item found
                    break; // Stop checking
                }
                oContainerItem = GetNextItemInInventory(oInvItem);
            }
        }
        if (bHasItem == TRUE) break; // Stop checking if specific item found

        oInvItem = GetNextItemInInventory(oPC);
    }
    if (bHasItem == TRUE) return TRUE;
    return FALSE;
}

int AC_HasWhistleItem(object oPC)
{
    object oInvItem = GetFirstItemInInventory(oPC);
    object oContainerItem;
    string sItemPrefix = "ac_";
    int bHasItem = FALSE;

    if (AC_DEBUG) FloatingTextStringOnCreature("Checking inventory ...", oPC, FALSE);

    while (GetIsObjectValid(oInvItem)) // Examine all items in PC's inventory
    {
        // Check if item has specific Blueprint ResRef prefix
        if(GetStringLeft(GetResRef(oInvItem), 3) == sItemPrefix)
        {
            if (AC_DEBUG) SendMessageToPC(oPC, "Found whistle in inventory!");
            bHasItem = TRUE; // whistle found
            break; // Stop checking
        }

        if (GetHasInventory(oInvItem)) // Check if inventory is a storage item
        {
            if (AC_DEBUG) SendMessageToPC(oPC, "Checking container inventory ...");

            oContainerItem = GetFirstItemInInventory(oInvItem);
            // Examine all items in the storage item
            while (GetIsObjectValid(oContainerItem))
            {
                if(GetStringLeft(GetResRef(oContainerItem), 3) == sItemPrefix)
                {
                    if (AC_DEBUG) SendMessageToPC(oPC, "Found whistle in container!");
                    bHasItem = TRUE; // whistle found
                    break; // Stop checking
                }
                oContainerItem = GetNextItemInInventory(oInvItem);
            }
        }
        if (bHasItem == TRUE) break; // Stop checking if specific item found
        oInvItem = GetNextItemInInventory(oPC);
    }
    if (bHasItem == TRUE) return TRUE;
    return FALSE;
}

object AC_GetItemPossessedBy(object oPC, string sItemResRef)
{
    object oInvItem = GetFirstItemInInventory(oPC);
    object oCompanionItem, oContainerItem;
    int bHasItem = FALSE;

    if (AC_DEBUG) SendMessageToPC(oPC, "Checking inventory ...");

    while (GetIsObjectValid(oInvItem)) // Examine all items in PC's inventory
    {
        // Check if item has specific Blueprint ResRef
        if(GetResRef(oInvItem) == sItemResRef)
        {
            if (AC_DEBUG) SendMessageToPC(oPC, "Found item in inventory!");
            bHasItem = TRUE; // Specific item found
            oCompanionItem = oInvItem;
            break; // Stop checking
        }

        if (GetHasInventory(oInvItem)) // Check if inventory is a storage item
        {
            if (AC_DEBUG) SendMessageToPC(oPC, "Checking container inventory ...");

            oContainerItem = GetFirstItemInInventory(oInvItem);
            // Examine all items in the storage item
            while (GetIsObjectValid(oContainerItem))
            {
                if(GetResRef(oContainerItem) == sItemResRef)
                {
                    if (AC_DEBUG) SendMessageToPC(oPC, "Found item in container!");
                    bHasItem = TRUE; // Specific item found
                    oCompanionItem = oContainerItem;
                    break; // Stop checking
                }
                oContainerItem = GetNextItemInInventory(oInvItem);
            }
        }
        if (bHasItem == TRUE) break; // Stop checking if specific item found

        oInvItem = GetNextItemInInventory(oPC);
    }
    return oCompanionItem;
}

void AC_RemoveWhistleItem(object oPC)
{
    object oInvItem = GetFirstItemInInventory(oPC);
    object oContainerItem;
    string sItemPrefix = "ac_";
    int nDruidLevel = AC_GetDruidLevel(oPC);
    string sItemResRef, sAnimalResRef, sRootResRef, sString;
    int bHasItem = FALSE;

    if (AC_DEBUG) FloatingTextStringOnCreature("Checking inventory ...", oPC, FALSE);

    while (GetIsObjectValid(oInvItem)) // Examine all items in PC's inventory
    {
        sItemResRef = GetResRef(oInvItem);
        // Check if item has specific Blueprint ResRef prefix
        if(GetStringLeft(sItemResRef, 3) == sItemPrefix)
        {
            if (AC_DEBUG) SendMessageToPC(oPC, "Found whistle in inventory!");
            bHasItem = TRUE; // whistle found
            break; // Stop checking
        }

        if (GetHasInventory(oInvItem)) // Check if inventory is a storage item
        {
            if (AC_DEBUG) SendMessageToPC(oPC, "Checking container inventory ...");

            oContainerItem = GetFirstItemInInventory(oInvItem);
            // Examine all items in the storage item
            while (GetIsObjectValid(oContainerItem))
            {
                sItemResRef = GetResRef(oContainerItem);
                if(GetStringLeft(sItemResRef, 3) == sItemPrefix)
                {
                    if (AC_DEBUG) SendMessageToPC(oPC, "Found whistle in container!");
                    bHasItem = TRUE; // whistle found
                    oInvItem = oContainerItem;
                    break; // Stop checking
                }
                oContainerItem = GetNextItemInInventory(oInvItem);
            }
        }
        if (bHasItem == TRUE) break; // Stop checking if specific item found
        oInvItem = GetNextItemInInventory(oPC);
    }
    if (bHasItem == TRUE)
    {
        DestroyObject(oInvItem);
        sAnimalResRef = sItemResRef + IntToString(nDruidLevel);
        sRootResRef = AC_GetItemString(sAnimalResRef);
        sString = GetName(oPC) + sRootResRef;
        DeleteCampaignVariable("AC_Companion", sString, oPC);
    }
}

void AC_ReleaseCompanion(object oPC, object oCompanion, int bIsPermanent)
{
    object oCompanionItem;
    string sAnimalResRef = GetResRef(oCompanion);
    string sItemResRef;
    int nDruidLevel = AC_GetDruidLevel(oPC);
    string sRootResRef = AC_GetItemString(sAnimalResRef);
    string sString = GetName(oPC) + sRootResRef;

    if (AC_DEBUG)
    {
        SendMessageToPC(oPC, "Releasing companion ...");
        SendMessageToPC(oPC, "oPC = " + IntToString(GetIsObjectValid(oPC)));
        SendMessageToPC(oPC, "oCompanion = " + IntToString(GetIsObjectValid(oCompanion)));
        SendMessageToPC(oPC, "sAnimalResRef = " + sAnimalResRef);
        SendMessageToPC(oPC, "sRootResRef = " + sRootResRef);
        SendMessageToPC(oPC, "sString = " + sString);
        SendMessageToPC(oPC, "bIsPermanent = " + IntToString(bIsPermanent));
    }

    if(GetIsObjectValid(oCompanion))
    {
        // Clear dialogue events
        ClearAllDialogue(oPC, oCompanion);
        ClearAllActions();
        // check if releasing animal companion is permanent
        if (bIsPermanent == TRUE)
        {
            if (AC_DEBUG) SendMessageToPC(oPC, "Permanently relased.");

            // destroy the companion whistle item from PC's inventory
            oCompanionItem = AC_GetItemPossessedBy(oPC, sRootResRef);

            if (AC_DEBUG)
            {
                SendMessageToPC(oPC, "oCompanionItem = " + IntToString(GetIsObjectValid(oCompanionItem)));
            }

            DestroyObject(oCompanionItem, 0.0);

            SetPlotFlag(oCompanion, FALSE);
            SetImmortal(oCompanion, FALSE);
            SetIsDestroyable(TRUE, FALSE, FALSE);
            DeleteCampaignVariable("AC_Companion", sString, oPC);
        }
        // Release Animal Companion
        RemoveHenchman(oPC, oCompanion);
        AssignCommand(oCompanion, ActionMoveAwayFromObject(oPC, TRUE, 30.0));
        DestroyObject(oCompanion, 5.0);
    }
}

void AC_SetCompanionHP(object oPC, object oCompanion, string sString)
{
    int nDBCompanionHP = GetCampaignInt("AC_Companion", sString, oPC);
    int nMaxCompanionHP = GetMaxHitPoints(oCompanion);
    int nTotalDamage = nMaxCompanionHP - nDBCompanionHP;
    effect eDamage = EffectDamage(nTotalDamage, DAMAGE_TYPE_MAGICAL, DAMAGE_POWER_PLUS_FIVE);

    if (AC_DEBUG)
    {
        SendMessageToPC(oPC, "nDBCompanionHP = " + IntToString(nDBCompanionHP));
        SendMessageToPC(oPC, "nMaxCompanionHP = " + IntToString(nMaxCompanionHP));
        SendMessageToPC(oPC, "nTotalDamage = " + IntToString(nTotalDamage));
    }
    ApplyEffectToObject(DURATION_TYPE_INSTANT, eDamage, oCompanion);
}

void AC_ObtainAnimalCompanion(object oPC, string sAnimalResRef, int bIsNewCompanion)
{
    object oCompanion = AC_SpawnInCompanion(oPC, sAnimalResRef);
    object oCompanionItem;
    string sItemResRef;
    int nDruidLevel = AC_GetDruidLevel(oPC);
    string sString = GetName(oPC) + AC_GetItemString(sAnimalResRef);
    int nDBCompanionHP = GetCampaignInt("AC_Companion", sString, oPC);

    AddHenchman(oPC, oCompanion);
    SetCommandable(TRUE, oCompanion);

    if (AC_DEBUG)
    {
        SendMessageToPC(oPC, "CurrentHitPoints = " + IntToString(GetCurrentHitPoints(oCompanion)));
    }

    if (bIsNewCompanion == FALSE)
    {
        if (AC_DEBUG) SendMessageToPC(oPC, "This is not a new companion.");

        if (nDBCompanionHP == 0)
            SetCampaignInt("AC_Companion", sString, GetMaxHitPoints(oCompanion), oPC);
        else
            AC_SetCompanionHP(oPC, oCompanion, sString);
    }

    sItemResRef = AC_GetItemString(sAnimalResRef);

    if (!AC_HasItem_ResRef(oPC, sItemResRef))
    {
        oCompanionItem = CreateItemOnObject(sItemResRef, oPC);
        SendMessageToPC(oPC, "Your heart has proven to be true. You have befriended a " + GetName(oCompanion) + ".");
    }
    AssignCommand(oCompanion, ActionForceMoveToObject(oPC, TRUE, 2.0));
}

void AC_LevelUpAnimalCompanion(object oPC, string sRootResRef, int nTotalDamage, int nDruidLevel, location lCompanionLoc)
{
    object oCompanion, oCompanionItem;
    string sAnimalResRef, sResRefSuffix, sString, sItemResRef;
    int nDBCompanionHP, nMaxCompanionHP, nCurrentHP;

    sResRefSuffix = IntToString(AC_GetResRefSuffix(nDruidLevel));
    sAnimalResRef = sRootResRef + sResRefSuffix;
    // create higher level version of PC's animal companion
    oCompanion = CreateObject(OBJECT_TYPE_CREATURE, sAnimalResRef, lCompanionLoc);

    if (GetIsObjectValid(oCompanion))
    {
        if (AC_DEBUG) SendMessageToPC(oPC, "This is a higher level companion.");

        AddHenchman(oPC, oCompanion);
        SetCommandable(TRUE, oCompanion);

        sString = GetName(oPC) + sRootResRef;
        nMaxCompanionHP = GetMaxHitPoints(oCompanion); // companion's max HPs

        if (nTotalDamage == 0)
            SetCampaignInt("AC_Companion", sString, nMaxCompanionHP, oPC);
        else
        {
            nCurrentHP = nMaxCompanionHP - nTotalDamage;
            // replace higher level version animal companion's HP data with the
            // lower level version of the animal companion's HPs in the database
            SetCampaignInt("AC_Companion", sString, nCurrentHP, oPC);
            // apply lower level version of the animal companion's sustained HP
            // damage to the higher level version companion
            AC_SetCompanionHP(oPC, oCompanion, sString);
        }
        if (AC_DEBUG)
        {
            SendMessageToPC(oPC, "nDruidLevel = " + IntToString(nDruidLevel));
            SendMessageToPC(oPC, "sRootResRef = " + sRootResRef);
            SendMessageToPC(oPC, "sResRefSuffix = " + sResRefSuffix);
            SendMessageToPC(oPC, "sAnimalResRef = " + sAnimalResRef);
            SendMessageToPC(oPC, "oCompanion = " + IntToString(GetIsObjectValid(oCompanion)));
            SendMessageToPC(oPC, "sString = " + sString);
            SendMessageToPC(oPC, "nCurrentHP = " + IntToString(nCurrentHP));
        }
    }
    else
    {
        SendMessageToPC(oPC, "Animal Companion - Level Up Error!");
        SendMessageToPC(oPC, "Please report this error to the local server DM.");
    }
}

void AC_OnActivate(object oCompanionItem)
{
    object oPC = GetItemActivator();

    object oCompanion = GetAssociate(ASSOCIATE_TYPE_HENCHMAN, oPC);
    string sItemResRef = GetResRef(oCompanionItem);
    string sAnimalResRef;
    int nDruidLevel = AC_GetDruidLevel(oPC);
    // Check that the PC doesn't have an animal companion already
    if (!GetIsObjectValid(oCompanion))
    {
        sAnimalResRef = sItemResRef + IntToString(AC_GetResRefSuffix(nDruidLevel));
        SendMessageToPC(oPC, "You blow your whistle and wait for your animal companion to heed your call.");
        DelayCommand(10.0, AC_ObtainAnimalCompanion(oPC, sAnimalResRef, FALSE));
    }
    else // PC has an animal companion already
    {
        if (AC_DEBUG) SendMessageToPC(oPC, "oCompanion = " + IntToString(GetIsObjectValid(oCompanion)));

        SendMessageToPC(oPC, "You blow your whistle and nothing happens since you already have your animal companion nearby.");
    }

}

void AC_OnUnacquire(object oItemLost, object oPC)
{
    string sItemTag = GetTag(oItemLost);
    string sItemResRef = GetResRef(oItemLost);
    string sNoDropItem1 = "_NODROP";
    string sNoDropItem2 = "_ND";

    if (GetIsObjectValid(oItemLost))
    {
        // Examines item's tag for a substring match; the item's tag is converted
        // to all uppercase prior to the match attempt
        if (    (FindSubString(GetStringUpperCase(sItemTag), sNoDropItem1) > 0) ||
                (FindSubString(GetStringUpperCase(sItemTag), sNoDropItem2) > 0)  )
        {
            SendMessageToPC(oPC, GetName(oItemLost) + " is a No Drop item and thus cannot removed from your person.");
            SetPlotFlag(oItemLost, FALSE);
            DestroyObject(oItemLost); // Destroy the item that was unacquired.
            // Create the dropped item back in the PC's inventory if they do not
            // already have another instance of the same item.
            if (!AC_HasItem_ResRef(oPC, sItemResRef)) CreateItemOnObject(sItemResRef, oPC);
        }
        else // If the unacquired item was not identified as a No Drop item
        {
            if (AC_DEBUG) FloatingTextStringOnCreature("The item unacquired was not a No Drop item.", oPC, FALSE);
        }
    }
}

void AC_OnLevelUp(object oPC)
{
    object oCompanion = GetAssociate(ASSOCIATE_TYPE_HENCHMAN, oPC);
    string sAnimalResRef = GetResRef(oCompanion);
    int nDruidLevel = AC_GetDruidLevel(oPC);
    int bIsSameLevelRange = AC_IsSameLevelRange(oPC, nDruidLevel);
    string sRootResRef = AC_GetItemString(sAnimalResRef);
    string sString = GetName(oPC) + sRootResRef;
    // obtain companion HPs from DB
    int nDBCompanionHP = GetCampaignInt("AC_Companion", sString, oPC);
    int nMaxCompanionHP = GetMaxHitPoints(oCompanion); // companion's max HPs
    // old companion's total sustained damage
    int nTotalDamage = nMaxCompanionHP - nDBCompanionHP;
    location lCompanionLoc = GetLocation(oCompanion);

    if (AC_DEBUG)
    {
        SendMessageToPC(oPC, "oCompanion = " + IntToString(GetIsObjectValid(oCompanion)));
        SendMessageToPC(oPC, "sAnimalResRef = " + sAnimalResRef);
        SendMessageToPC(oPC, "nDruidLevel = " + IntToString(nDruidLevel));
        SendMessageToPC(oPC, "sString = " + sString);
        SendMessageToPC(oPC, "nDBCompanionHP = " + IntToString(nDBCompanionHP));
    }
    // check if the PC's new level doesn't change their animal companion level
    // range, their druid level (including ranger level) is higher than zero,
    // and they have a valid animal companion
    if (    (!bIsSameLevelRange) && (nDruidLevel > 0) &&
            (GetIsObjectValid(oCompanion))   )
    {
        if (AC_DEBUG) SendMessageToPC(oPC, "Level Up Companion!");

        // Clear animal companion dialogue events
        ClearAllDialogue(oPC, oCompanion);
        ClearAllActions();
        // Destroy current animal companion
        SetPlotFlag(oCompanion, FALSE);
        SetImmortal(oCompanion, FALSE);
        SetIsDestroyable(TRUE, FALSE, FALSE);
        RemoveHenchman(oPC, oCompanion);
        DestroyObject(oCompanion, 0.0);
        // Create a new higher level version of the PC's animal companion
        AC_LevelUpAnimalCompanion(oPC, sRootResRef, nTotalDamage, nDruidLevel, lCompanionLoc);
    }
}

void AC_OnPlayerDeath(object oPC)
{
    object oCompanion, oItem, OContainerItem;
    string sString, sItemResRef, sAnimalResRef;
    int nHasWhistleItem = AC_HasWhistleItem(oPC); // check if PC has a whistle
    int nPlayerState = GPS(oPC); // check PC state
    int nDruidLevel, bDeletedItem;

    if ( GetIsPC(oPC) == TRUE
    && GetIsPlayableRacialType(oPC) == TRUE )
    {
        oCompanion = GetAssociate(ASSOCIATE_TYPE_HENCHMAN, oPC);

        // Check if PC has an animal companion and is "subdued"
        if (    (GetIsObjectValid(oCompanion)) &&
            (nPlayerState == PWS_PLAYER_STATE_SUBDUED)  )
        {
            // Release animal companion temporarily
            AC_ReleaseCompanion(oPC, oCompanion, FALSE);
        }
        // Check if PC has an animal companion (PC has died)
        else if (GetIsObjectValid(oCompanion))
        {
            // Release animal companion permanently
            AC_ReleaseCompanion(oPC, oCompanion, TRUE);
        }
        // Check if the PC has a companion whistle (hence does not have an
        // animal companion) and is not "subdued"
        else if (   (nHasWhistleItem) &&
                    (nPlayerState != PWS_PLAYER_STATE_SUBDUED)  )
        {
            // Find and destroy the companion whistle from PC's inventory
            oItem = GetFirstItemInInventory(oPC);
            while (GetIsObjectValid(oItem))
            {
                sItemResRef = GetResRef(oItem);
                if (GetStringLeft(sItemResRef, 3) == "ac_")
                {
                    sString = GetName(oPC) + sItemResRef;
                    DeleteCampaignVariable("AC_Companion", sString, oPC);
                    DestroyObject(oItem);
                    break;
                }
                if (GetHasInventory(oItem))
                {
                    OContainerItem = GetFirstItemInInventory(oItem);
                    while (GetIsObjectValid(OContainerItem))
                    {
                        sItemResRef = GetResRef(OContainerItem);
                        if (GetStringLeft(sItemResRef, 3) == "ac_")
                        {
                            sString = GetName(oPC) + sItemResRef;
                            DeleteCampaignVariable("AC_Companion", sString, oPC);
                            DestroyObject(OContainerItem);
                            bDeletedItem = TRUE;
                            break;
                        }
                        OContainerItem = GetNextItemInInventory(oItem);
                    }
                }
                if (bDeletedItem == TRUE) break;
                oItem = GetNextItemInInventory(oPC);
            }
        }
    }
}

//void main()

