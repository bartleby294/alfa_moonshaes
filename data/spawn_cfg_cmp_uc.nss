//
// Spawn Camp
//
// Spawn Group/Camp Merchant System v1.1
// by U'lias Clearmon (Shawn Marcil)
// Last Revised: September 29, 2004
//
// CampNumP
// CampNumC
// CampRadius
// CampTrigger
// CampTriggerScript
//
// RW                       : Random Walk
// SF                       : Spawn Facing Camp
// SG                       : Spawn Group
// LT000|A000|B000|C000     : Loot Table
//  LTn|An|Bn|Cn
//   : Loot Table
//   : Spawn Loot on Children from Table LT000 to LT999
//   : Loot Tables are Defined in 'spawn_cfg_loot'
//   : LT500 to LT999 currently reserved for merchant-based
//   : loot tables
//   : Optional Flag: A000
//   :   When using merchant-based loot tables, the percentage chance that
//   :   only 1 item will spawn.  Default is 50%. Values over 100% are truncated
//   :   to 100%
//   : Optional Flag: B000
//   :   When using merchant-based loot tables, the percentage chance that
//   :   2 items will spawn.  Default is 15%. Values over 100% are truncated
//   :   to 100%
//   : Optional Flag: C000
//   :   When using merchant-based loot tables, the percentage chance that
//   :   3 items will spawn.  Default is 05%. Values over 100% are truncated
//   :   to 100%

// CD000|T0                 : Corpse Decay
// PL0|T00                  : Placeable Trap Disabled
// DT000                    : Death Script
// RH000                    : Return Home
//
//
#include "spawn_funcs_uc"

object GetChildByTag(object oSpawn, string sChildTag);
object GetChildByNumber(object oSpawn, int nChildNum);
object GetSpawnByID(int nSpawnID);
void DeactivateSpawn(object oSpawn);
void DeactivateSpawnsByTag(string sSpawnTag);
void DeactivateAllSpawns();
void DespawnChildren(object oSpawn);
void DespawnChildrenByTag(object oSpawn, string sSpawnTag);
//
//

/* U'lias -- Spawn Camp Merchant System v1.1 -- Start */

string UC_GetSubLootFlag(object oCamp, string sGroupItemTag, int nSubPos)
{
    string sChar = GetStringUpperCase(GetSubString(sGroupItemTag, nSubPos, 1));
    string sSubLootFlag, sBSubFlag, sCSubFlag;
    int dfLootTable1ItemChance = GetLocalInt(GetModule(), "df_LootTable1ItemChance");
    int dfLootTable2ItemChance = GetLocalInt(GetModule(), "df_LootTable2ItemChance");
    int dfLootTable3ItemChance = GetLocalInt(GetModule(), "df_LootTable3ItemChance");
    int nProb1, nProb2, nProb3;

    if (sChar == "A") {
        sSubLootFlag = GetStringUpperCase(GetSubString(sGroupItemTag, nSubPos, 4));
        nProb1 = StringToInt(GetStringRight(sSubLootFlag, 3));
        SetLocalInt(oCamp, "f_LootTable1ItemChance", nProb1);

        nSubPos = nSubPos + 4;
        sChar = GetStringUpperCase(GetSubString(sGroupItemTag, nSubPos, 1));

        if (sChar == "B") {
            sBSubFlag = GetSubString(sGroupItemTag, nSubPos, 4);
            sSubLootFlag = sSubLootFlag + GetStringUpperCase(sBSubFlag);
            nProb2 = StringToInt(GetStringRight(sBSubFlag, 3));
            SetLocalInt(oCamp, "f_LootTable2ItemChance", nProb2);

            nSubPos = nSubPos + 4;
            sChar = GetStringUpperCase(GetSubString(sGroupItemTag, nSubPos, 1));

            if (sChar == "C") {
                sCSubFlag = GetSubString(sGroupItemTag, nSubPos, 4);
                sSubLootFlag = sSubLootFlag + GetStringUpperCase(sCSubFlag);
                nProb3 = StringToInt(GetStringRight(sCSubFlag, 3));
                SetLocalInt(oCamp, "f_LootTable3ItemChance", nProb3);
            } else {
                SetLocalInt(oCamp, "f_LootTable3ItemChance", dfLootTable3ItemChance);
            }
        } else {
            SetLocalInt(oCamp, "f_LootTable2ItemChance", dfLootTable2ItemChance);
            SetLocalInt(oCamp, "f_LootTable3ItemChance", dfLootTable3ItemChance);
        }
    } else {
        sSubLootFlag = "";
        SetLocalInt(oCamp, "f_LootTable1ItemChance", dfLootTable1ItemChance);
        SetLocalInt(oCamp, "f_LootTable2ItemChance", dfLootTable2ItemChance);
        SetLocalInt(oCamp, "f_LootTable3ItemChance", dfLootTable3ItemChance);
    }

    return sSubLootFlag;
}

string UC_GetCompleteLootFlag(object oCamp, string sGroupItemTag, string sLootFlag)
{
    string sCompleteLootFlag, sSubLootFlag;
    int nPos = FindSubString(sGroupItemTag, sLootFlag);
    int nLootTable;

    if (nPos > 0) {
        nLootTable = StringToInt(GetSubString(sGroupItemTag, nPos + 3, 3));

        if ( (nLootTable <= 999) && (nLootTable > 99) ) sCompleteLootFlag = sLootFlag + IntToString(nLootTable);
        else if ( (nLootTable <= 99) && (nLootTable > 9) ) sCompleteLootFlag = sLootFlag + "0" + IntToString(nLootTable);
        else sCompleteLootFlag = sLootFlag + "00" + IntToString(nLootTable);

        sSubLootFlag = UC_GetSubLootFlag(oCamp, sGroupItemTag, (nPos + 6));

        if (sSubLootFlag != "")
            sCompleteLootFlag = sCompleteLootFlag + sSubLootFlag;

    } else {
        sCompleteLootFlag = "";
    }

    if (CAMP_GROUP_DEBUG) {
        SendMessageToPC(GetFirstPC(), "sSubLootFlag being passed = " + sSubLootFlag);
        SendMessageToPC(GetFirstPC(), "sCompleteLootFlag being passed = " + sCompleteLootFlag);
    }

    return sCompleteLootFlag;
}

string UC_GetGroupMerchantTag(string sGroupItemTag, string sLootFlag)
{
    // ex. sGroupItemTag = NGM_GOBLINS_LOW_LT901A075
    string sGroupMerchantTag;
    int nPos = FindSubString(sGroupItemTag, sLootFlag);

    // get the Tag of the Group Item and leave out the loot table flag
    // if present ex. NGM_GOBLINS_LOW
    if (nPos > 0) sGroupMerchantTag = GetStringLeft(sGroupItemTag, nPos);
    else sGroupMerchantTag = sGroupItemTag;

    if (CAMP_GROUP_DEBUG)
        SendMessageToPC(GetFirstPC(), "The GroupMerchantTag is " + sGroupMerchantTag);

    return GetStringUpperCase(sGroupMerchantTag);
}

void UC_SetCampSpawns(object oCamp, string sCamp, string sGroupMerchantTag, string sCompleteLootFlag, int nNumberOfCreatures)
{
    object oSpawn = GetLocalObject(GetModule(), "spawnobject");
    DeleteLocalObject(GetModule(), "spawnobject");

    int nProb1 = GetLocalInt(oCamp, "f_LootTable1ItemChance");
    int nProb2 = GetLocalInt(oCamp, "f_LootTable2ItemChance");
    int nProb3 = GetLocalInt(oCamp, "f_LootTable3ItemChance");
    SetLocalInt(oSpawn, "f_LootTable1ItemChance", nProb1);
    SetLocalInt(oSpawn, "f_LootTable2ItemChance", nProb2);
    SetLocalInt(oSpawn, "f_LootTable3ItemChance", nProb3);

    if (CAMP_GROUP_DEBUG) {
        SendMessageToPC(GetFirstPC(), "End nProb1 = " + IntToString(nProb1));
        SendMessageToPC(GetFirstPC(), "End nProb2 = " + IntToString(nProb2));
        SendMessageToPC(GetFirstPC(), "End nProb3 = " + IntToString(nProb3));
    }

    string sCampFlags = "SP_SF_SG_CD60_RH" + sCompleteLootFlag;
    int i;

    if (CAMP_GROUP_DEBUG) {
        SendMessageToPC(GetFirstPC(), "Setup Camp Merchant Spawns");
        SendMessageToPC(GetFirstPC(), "===========================");
        SendMessageToPC(GetFirstPC(), "sGroupMerchantTag  = " + sGroupMerchantTag);
        SendMessageToPC(GetFirstPC(), "Number of creatures to spawn in camp = " + IntToString(nNumberOfCreatures));
        SendMessageToPC(GetFirstPC(), "sCampFlags are " + sCampFlags);
    }

    // loop for the number of creatures to spawn in the camp
    for (i = 0; i < nNumberOfCreatures; i++) {
        // set up for obtaining a creature randomly from the assigned Group
        // Merchant's inventory
        // Setup for each Camp creature and their Group Spawn Flags
        SetLocalString(oCamp, "CampC" + IntToString(i), sGroupMerchantTag);
        SetLocalString(oCamp, "CampC" + IntToString(i) + "_Flags", sCampFlags);

        if (CAMP_GROUP_DEBUG) {
            SendMessageToPC(GetFirstPC(), "CampC" + IntToString(i));
            SendMessageToPC(GetFirstPC(), "A creature will be chosen from the Group Merchant " + sGroupMerchantTag + ".");
        }
    }
}

void SetCampSpawn(object oCamp, string sCamp, location lCamp)
{
    object oRandomGroupItem;
    string sLootFlag = "_LT";
    string sGroupItemTag, sGroupMerchantTag, sCompleteLootFlag;
    int bIsGroup = FALSE;
    int nCreatures = 0;
    int nMaxNumberToSpawn = 0;

    if (CAMP_GROUP_DEBUG) {
        SendMessageToPC(GetFirstPC(), "sCamp being passed = " + sCamp);
    }

    // check that the sCamp is a valid Camp Merchant Tag by looking for
    // the NCM_ prefix
    if (GetStringLeft(GetStringUpperCase(sCamp), 4) == "NCM_") {

        if (CAMP_GROUP_DEBUG) {
            SendMessageToPC(GetFirstPC(), "sCamp has Camp Merchant Tag prefix.");
            SendMessageToPC(GetFirstPC(), "Get Camp Merchant Spawns");
            SendMessageToPC(GetFirstPC(), "===========================");
        }

         // get the a random group item's Tag selected from the
         // Camp Merchant's inventory
         oRandomGroupItem = UC_GetRandomItem(sCamp);
         sGroupItemTag = GetTag(oRandomGroupItem);

        if (CAMP_GROUP_DEBUG) {
            SendMessageToPC(GetFirstPC(), "Camp Merchant's selected Group Item Tag = " + sGroupItemTag);
        }

        // check that the selected item is a Group Item
        if (GetStringLeft(GetStringUpperCase(sGroupItemTag), 4) == "NGM_") {

/* From NESS -- U'lias replaced with code below
            // Set Number of Placeables
            SetLocalInt(oCamp, "CampNumP", 2);
---------- */
            // Set Number of Placeables
            SetLocalInt(oCamp, "CampNumP", 1);

            // Set Placeable 0 to be Camp Center
            SetLocalString(oCamp, "CampCenter", "P0");
            // Set Radius of Camp
            SetLocalFloat(oCamp, "CampRadius", 5.0);

/* From NESS -- U'lias replaced with code below
            // Set Placeable 0 and Spawn Flags
            // First Placeable always Spawns at Center of Camp
            // If CampCenter Is Not Set
            SetLocalString(oCamp, "CampP0", "plc_campfrwspit");
            SetLocalString(oCamp, "CampP0_Flags", "SP_SF");

            // Set Placeable 1 and Spawn Flags
            SetLocalString(oCamp, "CampP1", "plc_chest1");
            SetLocalString(oCamp, "CampP1_Flags", "SP_PL3T80P30");
---------- */
            // Set Placeable 0 and Spawn Flags
            // First Placeable always Spawns at Center of Camp
            // If CampCenter Is Not Set
            SetLocalString(oCamp, "CampP0", "ness_inv_obj");
            SetLocalString(oCamp, "CampP0_Flags", "SP_SF");

            // Set Creature 0 to be Trigger
            // Script 00 : Kill him and the Camp Despawns
//            SetLocalString(oCamp, "CampTrigger", "C0");
//            SetLocalInt(oCamp, "CampTriggerScript", 0);

            // get the maximum number of items to spawn
            nMaxNumberToSpawn = GetGoldPieceValue(oRandomGroupItem);
            // randomly choose the number of creatures to spawn
            nCreatures = (Random(nMaxNumberToSpawn) + 1);

            // check for a group spawn Group Item
            if (nCreatures > 1)
                bIsGroup = TRUE;
            // check for a solo creature Group Item
            else bIsGroup = FALSE;

            // get the complete loot flag from the Tag of the random Group
            // item selected from the Camp Merchant's inventory
            sCompleteLootFlag = UC_GetCompleteLootFlag(oCamp, sGroupItemTag, sLootFlag);

            // get the Group Merchant where the creatures will be randomly
            // selected from
            sGroupMerchantTag = UC_GetGroupMerchantTag(sGroupItemTag, sLootFlag);

            if (CAMP_GROUP_DEBUG) {
                SendMessageToPC(GetFirstPC(), "bIsGroup = " + IntToString(bIsGroup));
                SendMessageToPC(GetFirstPC(), "sCompleteLootFlag = " + sCompleteLootFlag);
                SendMessageToPC(GetFirstPC(), "nMaxNumberToSpawn = " + IntToString(nMaxNumberToSpawn));
            }

            if (bIsGroup == FALSE) {
                // setup for a single creature spawn camp
                SetLocalInt(oCamp, "CampNumC", 1);
                // setup the invis object as camp leader
                // Set Creature 0 and Spawn Flags
//                SetLocalString(oCamp, "CampC0", "ness_inv_obj");
//                SetLocalString(oCamp, "CampC0_Flags", "SP");

                // setup a single creature group spawn
                UC_SetCampSpawns(oCamp, sCamp, sGroupMerchantTag, sCompleteLootFlag, 1);

                if (CAMP_GROUP_DEBUG) SendMessageToPC(GetFirstPC(), "Solo camp spawn from Group = " + sGroupMerchantTag);

            } else if (bIsGroup == TRUE) {
                // setup for a camp leader and a group of creatures

                if (CAMP_GROUP_DEBUG) {
                    SendMessageToPC(GetFirstPC(), "Create Camp Spawns from Group = " + sGroupMerchantTag);
                    SendMessageToPC(GetFirstPC(), "Setting up to spawn " + IntToString(nCreatures) + " creatures.");
                }

                // setup for a multiple creature spawn camp
                SetLocalInt(oCamp, "CampNumC", nCreatures);

                // setup the invis object as camp leader
                // Set Creature 0 and Spawn Flags
     //           SetLocalString(oCamp, "CampC0", "ness_inv_obj");
     //           SetLocalString(oCamp, "CampC0_Flags", "SP");

                // setup the group spawns
                UC_SetCampSpawns(oCamp, sCamp, sGroupMerchantTag, sCompleteLootFlag, nCreatures);
            }
        } else {
            if (CAMP_GROUP_DEBUG) SendMessageToPC(GetFirstPC(), "Could not find NESS Camp Merchant ["
                       + "M_" + sCamp + " ] for Camp: " + sCamp);

            // Write to log
            PrintString("Could not find NESS Camp Merchant ["
                + "M_" + sCamp + " ] for Camp: " + sCamp);
        }
    }
}
/* U'lias -- Spawn Camp Merchant System v1.1 -- End */

//void main (){}
