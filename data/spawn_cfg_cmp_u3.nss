//
// Spawn Camp
//
// Spawn Group/Camp Merchant System v1.1
// by U'lias Clearmon (Shawn Marcil)
// Last Revised: September 26, 2004
//
// CampNumP
// CampNumC
// CampRadius
// CampTrigger
// CampTriggerScript
//
// RW       : Random Walk
// SF       : Spawn Facing Camp
// SG       : Spawn Group
// LT00     : Loot Table
// CD000|T0 : Corpse Decay
// PL0|T00  : Placeable Trap Disabled
// DT000    : Death Script
// RH000    : Return Home
//
//

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

int GetNumberOfGroupItems(object oNESSMerchant)
{
    // Count Items in Store Inventory
    object oItem = GetFirstItemInInventory(oNESSMerchant);
    int nCount = 0;

    while (GetIsObjectValid(oItem)) {
        nCount++ ;
        oItem = GetNextItemInInventory(oNESSMerchant);
    }

    return nCount;
}

/*  GetRandomItemTag

    Examines how many items are in the NESS merchant's inventory.
    Randomly selects an item from the inventory.
    Creates a key for the group item object that was randomly selected.
    Adds the item's Tag and ResRef together
*/
string GetRandomGroupItemTag(string sMerchantTag)
{
    // Get the Merchant Object
    object oNESSMerchant = GetObjectByTag(sMerchantTag);
    object oItem;
    string sRandomItemTag;
    int nCount, nRandom, i;

    if (CAMP_GROUP_DEBUG) {
        SendMessageToPC(GetFirstPC(), "GetRandomItemTag ---------------");
        SendMessageToPC(GetFirstPC(), "NESS Group Merchant Tag " + GetTag(oNESSMerchant));
        SendMessageToPC(GetFirstPC(), "NESS Group Merchant Name " + GetName(oNESSMerchant));
    }

    // check if the Merchant object is valid
    if (GetIsObjectValid(oNESSMerchant)) {
        // get the number of item in the Merchant's inventory
        nCount = GetNumberOfGroupItems(oNESSMerchant);

        if (CAMP_GROUP_DEBUG) SendMessageToPC(GetFirstPC(), "NESS Merchant has " +
                   IntToString(nCount) + " items.");

        // get a random number from 1 to the number of item in
        // Merchant's inventory
        nRandom = Random(nCount) + 1;

        if (CAMP_GROUP_DEBUG) SendMessageToPC(GetFirstPC(), "Random Merchant item selected = " +
                   IntToString(nRandom));

        // get the first group item object in the Merchant's inventory
        oItem = GetFirstItemInInventory(oNESSMerchant);

        if (CAMP_GROUP_DEBUG) SendMessageToPC(GetFirstPC(), "i = " + IntToString(1));

        // check if the random number chosen is greater than 1
        if (nRandom > 1) {
            // loop until the chosen random number has been reached
            for (i = 2; i <= nRandom ; i++) {
                if (CAMP_GROUP_DEBUG) SendMessageToPC(GetFirstPC(), "i = " + IntToString(i));
                // get the next group item object
                oItem = GetNextItemInInventory(oNESSMerchant);
            }
        }

        // get the Tag of item object that was randomly selected
        sRandomItemTag = GetTag(oItem);

        if (CAMP_GROUP_DEBUG) {
            SendMessageToPC(GetFirstPC(), "sRandomItemTag = " + sRandomItemTag);
            SendMessageToPC(GetFirstPC(), "ResRef of item selected is " + GetResRef(oItem));
        }
    } else {
        if (CAMP_GROUP_DEBUG) SendMessageToPC(GetFirstPC(), "Could not find merchant with Tag " +
                   GetStringUpperCase(sMerchantTag));
    }

    return sRandomItemTag;
}

void SetCampLeader(object oCamp, string sLeaderResRef)
{
    if (CAMP_GROUP_DEBUG) {
        SendMessageToPC(GetFirstPC(), "Setting CampC0 ---------------");
        SendMessageToPC(GetFirstPC(), "The Camp Leader chosen is " + sLeaderResRef);
    }

    // Set Creature 0 and Spawn Flags
    SetLocalString(oCamp, "CampC0", sLeaderResRef);
    SetLocalString(oCamp, "CampC0_Flags", "SP_RW_CD60_RH30");
}

int GetMaxNumberOfCreatures(string sMerchantTag, string sGroupItemTag)
{
    object oNESSCampMerchant = GetObjectByTag(GetStringUpperCase(sMerchantTag));
    object oItem;
    int nMaxNumberToSpawn = 0;

    // check that the Camp Merchant object is valid
    if (GetIsObjectValid(oNESSCampMerchant)) {
        if (CAMP_GROUP_DEBUG) SendMessageToPC(GetFirstPC(), "Got merchant for spawn value");

        // get first item in the merchant's inventory
        oItem = GetFirstItemInInventory(oNESSCampMerchant);

        // loop while the item found in the inventory is a valid object
        while (GetIsObjectValid(oItem)) {
            // check if the item Tag is the same as the Group Merchant Tag
            // that is being looked for
            if (GetTag(oItem) == sGroupItemTag) {
                // get the GP value of the item which indicates the maximum
                // number of creature spawns in the group
                nMaxNumberToSpawn = GetGoldPieceValue(oItem);
                break;
            }
            oItem = GetNextItemInInventory(oNESSCampMerchant);
        }

        if (nMaxNumberToSpawn == 0) {
            if (CAMP_GROUP_DEBUG) SendMessageToPC(GetFirstPC(), "Could not find item tag " +
                       sGroupItemTag);
        } else {
            if (CAMP_GROUP_DEBUG) SendMessageToPC(GetFirstPC(), "GP value of " + GetTag(oItem) + " is " +
                       IntToString(nMaxNumberToSpawn));
        }
    } else {
        if (CAMP_GROUP_DEBUG) SendMessageToPC(GetFirstPC(), "Could not find camp merchant " +
                   GetStringUpperCase(sMerchantTag));
    }

    return nMaxNumberToSpawn;
}

void SetCampSpawns(object oCamp, string sCamp, string sGroupItemTag, int nNumberOfCreatures)
{
    string sGroupMerchantTag = "M_" + sGroupItemTag;
    int i;

    if (CAMP_GROUP_DEBUG) {
        SendMessageToPC(GetFirstPC(), "Setup Camp Merchant Spawns");
        SendMessageToPC(GetFirstPC(), "===========================");
        SendMessageToPC(GetFirstPC(), "sGroupMerchantTag  = " + sGroupMerchantTag);
        SendMessageToPC(GetFirstPC(), "Number of creatures to spawn in camp = " + IntToString(nNumberOfCreatures));
    }

    // loop for the number of creatures to spawn in the camp
    for (i = 1; i <= (nNumberOfCreatures - 1); i++) {
        // set up for obtaining a creature randomly from the assigned Group
        // Merchant's inventory
        // Setup for each Camp creature and their Group Spawn Flags
        SetLocalString(oCamp, "CampC" + IntToString(i), sGroupItemTag);
        SetLocalString(oCamp, "CampC" + IntToString(i) + "_Flags", "SP_SF_SG_CD60_RH");

        if (CAMP_GROUP_DEBUG) {
            SendMessageToPC(GetFirstPC(), "The creature chosen will be from the Group " + sGroupItemTag + ".");
            SendMessageToPC(GetFirstPC(), "CampC" + IntToString(i));
        }
    }
}

void SetCampSpawn(object oCamp, string sCamp, location lCamp)
{
     string sCampMerchantTag = "M_" + sCamp;
     string sGroupItemTag, sGroupMerchantTag;
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
         sGroupItemTag = GetRandomGroupItemTag(sCampMerchantTag);

        if (CAMP_GROUP_DEBUG) {
            SendMessageToPC(GetFirstPC(), "Camp Merchant's selected Group Item Tag = " + sGroupItemTag);
        }

        // check that the selected Group Item Tag and ResRef are not void of a value
        if (sGroupItemTag != "") {

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
            SetLocalString(oCamp, "CampTrigger", "C0");
            SetLocalInt(oCamp, "CampTriggerScript", 0);

            // check for a group spawn item
            if (GetStringLeft(GetStringUpperCase(sGroupItemTag), 4) == "NGM_")
                bIsGroup = TRUE;
            // check for a single creature item
            else bIsGroup = FALSE;

            if (CAMP_GROUP_DEBUG) {
                SendMessageToPC(GetFirstPC(), "bIsGroup = " + IntToString(bIsGroup));
            }

            if (bIsGroup == FALSE) {
                // setup for a single creature spawn camp
                SetLocalInt(oCamp, "CampNumC", 1);
                // setup the lone creature as camp leader
                SetCampLeader(oCamp, sGroupItemTag);

                if (CAMP_GROUP_DEBUG) SendMessageToPC(GetFirstPC(), "Solo camp spawn = " + sGroupItemTag);
            } else if (bIsGroup == TRUE) {
                // setup for a camp leader and a group of creatures
                // get the maximum number of items to spawn
                nMaxNumberToSpawn = GetMaxNumberOfCreatures(sCampMerchantTag, sGroupItemTag);
                // randomly get the number of creatures to spawn
                nCreatures = (Random(nMaxNumberToSpawn) + 1);

                if (CAMP_GROUP_DEBUG) {
                    SendMessageToPC(GetFirstPC(), "Create Camp Spawns from Group = " + sGroupItemTag);
                    SendMessageToPC(GetFirstPC(), "Spawn " + IntToString(nCreatures) + " creatures.");
                }

                // create Group Merchant Tag
                sGroupMerchantTag = "M_" + GetStringUpperCase(sGroupItemTag);

                // setup for a multiple creature spawn camp
                SetLocalInt(oCamp, "CampNumC", nCreatures);
                // get the group leader's ResRef randmly selected from the
                // Group Merchant's inventory (based on selected item's Tag)
                SetCampLeader(oCamp, GetRandomGroupItemTag(sGroupMerchantTag));

                // setup the group spawns
                SetCampSpawns(oCamp, sCamp, sGroupItemTag, nCreatures);
            }

        } else {
            if (CAMP_GROUP_DEBUG) SendMessageToPC(GetFirstPC(), "Could not find NESS Camp Merchant ["
                       + sCampMerchantTag + " ] for Camp: " + sCamp);

            // Write to log
            PrintString("Could not find NESS Camp Merchant ["
                + sCampMerchantTag + " ] for Camp: " + sCamp);
        }
    }
}
/* U'lias -- Spawn Camp Merchant System v1.1 -- End */

//void main (){}
