//
// Spawn Groups
//
// Spawn Group/Camp Merchant System v1.1
// by U'lias Clearmon (Shawn Marcil)
// Last Revised: September 26, 2004
//
// nChildrenSpawned
// : Number of Total Children ever Spawned
//
// nSpawnCount
// : Number of Children currently Alive
//
// nSpawnNumber
// : Number of Children to Maintain at Spawn
//
// nRandomWalk
// : Walking Randomly? TRUE/FALSE
//
// nPlaceable
// : Spawning Placeables? TRUE/FALSE
//
//

int ParseFlagValue(string sName, string sFlag, int nDigits, int nDefault);
int ParseSubFlagValue(string sName, string sFlag, int nDigits, string sSubFlag, int nSubDigits, int nDefault);
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


int GetNumberOfItems(object oNESSMerchant)
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
string GetRandomItemTag(string sMerchantTag)
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
        nCount = GetNumberOfItems(oNESSMerchant);

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

string SpawnGroup(object oSpawn, string sTemplate)
{
    // Initialize
    string sRetTemplate;

    // Initialize Values
    int nSpawnNumber = GetLocalInt(oSpawn, "f_SpawnNumber");
    int nRandomWalk = GetLocalInt(oSpawn, "f_RandomWalk");
    int nPlaceable = GetLocalInt(oSpawn, "f_Placeable");
    int nChildrenSpawned = GetLocalInt(oSpawn, "ChildrenSpawned");
    int nSpawnCount = GetLocalInt(oSpawn, "SpawnCount");

//
// Only Make Modifications Between These Lines
// -------------------------------------------

/* U'lias -- Spawn Camp Merchant System v1.1 -- Start */

    object oNESSGroupMerchant, oItem;
    string sGroupMerchantTag = "M_" + GetStringUpperCase(sTemplate);
    int nCount, nRandom, i;

    if (CAMP_GROUP_DEBUG) {
        SendMessageToPC(GetFirstPC(), "sTemplate being passed = " + sTemplate);
    }

    if (GetStringLeft(GetStringUpperCase(sTemplate), 4) == "NGM_") {

        if (CAMP_GROUP_DEBUG) {
            SendMessageToPC(GetFirstPC(), "sTemplate has Group Merchant Tag prefix.");
            SendMessageToPC(GetFirstPC(), "Get Group Merchant Spawns");
            SendMessageToPC(GetFirstPC(), "===========================");
        }
        // get the randomly selected creature's ResRef
        sRetTemplate = GetRandomItemTag(sGroupMerchantTag);
    }

/* U'lias -- Spawn Camp Merchant System v1.1 -- End */

    // cr_militia
    if (sTemplate == "cr_militia")
    {
        switch(d2(1))
        {
            case 1:
            sRetTemplate = "cr_militia_m";
            break;
            case 2:
            sRetTemplate = "cr_militia_f";
            break;
        }
    }
    //

    // pg_guard
    if (sTemplate == "pg_guard")
    {
        switch(d2(1))
        {
            case 1:
            sRetTemplate = "pg_guard_m";
            break;
            case 2:
            sRetTemplate = "pg_guard_f";
            break;
        }
    }
    //

    // Goblins
    if (sTemplate == "goblins_low")
    {
        if (d2(1) == 1)
        {
            sRetTemplate = "NW_GOBLINA";
        }
        else
        {
            sRetTemplate = "NW_GOBLINB";
        }
    }
    //

    // Goblins and Boss
    if (sTemplate == "gobsnboss")
    {
        int nIsBossSpawned = GetLocalInt(oSpawn, "IsBossSpawned");
        if (nIsBossSpawned == TRUE)
        {
            // Find the Boss
            object oBoss = GetChildByTag(oSpawn, "NW_GOBCHIEFA");

            // Check if Boss is Alive
            if (oBoss != OBJECT_INVALID && GetIsDead(oBoss) == FALSE)
            {
                // He's alive, spawn a Peon to keep him Company
                sRetTemplate = "NW_GOBLINA";
            }
            else
            {
                // He's dead, Deactivate Camp!
                SetLocalInt(oSpawn, "SpawnDeactivated", TRUE);
            }
        }
        else
        {
            // No Boss, so Let's Spawn Him
            sRetTemplate = "NW_GOBCHIEFA";
            SetLocalInt(oSpawn, "IsBossSpawned", TRUE);
        }
    }
    //

    // Scaled Encounter
    if (sTemplate == "scaledgobs")
    {
        // Initialize Variables
        int nTotalPCs;
        int nTotalPCLevel;
        int nAveragePCLevel;
        object oArea = GetArea(OBJECT_SELF);

        // Cycle through PCs in Area
        object oPC = GetFirstObjectInArea(oArea);
        while (oPC != OBJECT_INVALID)
        {
            if (GetIsPC(oPC) == TRUE)
            {
                nTotalPCs++;
                nTotalPCLevel = nTotalPCLevel + GetHitDice(oPC);
            }
            oPC = GetNextObjectInArea(oArea);
        }
        if (nTotalPCs == 0)
        {
            nAveragePCLevel = 0;
        }
        else
        {
            nAveragePCLevel = nTotalPCLevel / nTotalPCs;
        }

        // Select a Creature to Spawn
        switch (nAveragePCLevel)
        {
            // Spawn Something with CR 1
            case 1:
                sRetTemplate = "cr1creature";
            break;
            //

            // Spawn Something with CR 5
            case 5:
                sRetTemplate = "cr5creature";
            break;
            //
        }
    }
    //

    // Pirates and Boss
    if (sTemplate == "pirates")
    {
        // Delay the Spawn for 45 Minutes
        if (GetLocalInt(oSpawn, "DelayEnded") == FALSE)
        {
            if (GetLocalInt(oSpawn, "DelayStarted") == FALSE)
            {
                // Start the Delay
                SetLocalInt(oSpawn, "DelayStarted", TRUE);
                DelayCommand(20.0, SetLocalInt(oSpawn, "DelayEnded", TRUE));
            }
            sRetTemplate = "";
            return sRetTemplate;
        }
        int nIsBossSpawned = GetLocalInt(oSpawn, "IsBossSpawned");
        if (nIsBossSpawned == TRUE)
        {
            // Find the Boss
            object oBoss = GetChildByTag(oSpawn, "NW_GOBCHIEFA");

            // Check if Boss is Alive
            if (oBoss != OBJECT_INVALID && GetIsDead(oBoss) == FALSE)
            {
                // He's alive, spawn a Peon to keep him Company
                sRetTemplate = "NW_GOBLINA";
            }
            else
            {
                // He's dead, Deactivate Camp!
                SetLocalInt(oSpawn, "SpawnDeactivated", TRUE);
            }
        }
        else
        {
            // No Boss, so Let's Spawn Him
            sRetTemplate = "NW_GOBCHIEFA";
            SetLocalInt(oSpawn, "IsBossSpawned", TRUE);
        }
    }
    //

    // Advanced Scaled Encounter
    if (sTemplate == "advscaled")
    {
        //Initalize Variables
        int nTotalPCs;
        int nTotalPCLevel;
        int nAveragePCLevel;
        object oArea = GetArea(OBJECT_SELF);

        //Cycle through PCs in area
        object oPC = GetFirstObjectInArea(oArea);
        while (oPC != OBJECT_INVALID)
        {
            if (GetIsPC(oPC) == TRUE)
            {
                nTotalPCs++;
                nTotalPCLevel = nTotalPCLevel + GetHitDice(oPC);
            }
        oPC = GetNextObjectInArea(oArea);
        }
        if (nTotalPCs == 0)
        {
            nAveragePCLevel = 0;
        }
        else
        {
            nAveragePCLevel = nTotalPCLevel / nTotalPCs;
        }

        //Select a Creature to Spawn
        switch (nAveragePCLevel)
        {
            //Spawn Something with CR 1
            case 1:
                switch (d6())
                {
                    case 1: sRetTemplate = "cr1example1";
                    case 2: sRetTemplate = "cr1example2";
                    case 3: sRetTemplate = "cr1example3";
                    case 4: sRetTemplate = "cr1example4";
                    case 5: sRetTemplate = "cr1example5";
                    case 6: sRetTemplate = "cr1example6";
                }
            break;
        }
    }
    //

    // Encounters
    if (sTemplate == "encounter")
    {
        // Declare Variables
        int nCounter, nCounterMax;
        string sCurrentTemplate;

        // Retreive and Increment Counter
        nCounter = GetLocalInt(oSpawn, "GroupCounter");
        nCounterMax = GetLocalInt(oSpawn, "CounterMax");
        nCounter++;

        // Retreive CurrentTemplate
        sCurrentTemplate = GetLocalString(oSpawn, "CurrentTemplate");

        // Check CounterMax
        if (nCounter > nCounterMax)
        {
            sCurrentTemplate = "";
            nCounter = 1;
        }

        if (sCurrentTemplate != "")
        {
            // Spawn Another CurrentTemplate
            sRetTemplate = sCurrentTemplate;
        }
        else
        {
            // Choose New CurrentTemplate and CounterMax
            switch (Random(2))
            {
                // Spawn 1-4 NW_DOGs
                case 0:
                sRetTemplate = "NW_DOG";
                nCounterMax = Random(4) + 1;
                break;
            }
            // Record New CurrentTemplate and CounterMax
            SetLocalString(oSpawn, "CurrentTemplate", sRetTemplate);
            SetLocalInt(oSpawn, "CounterMax", nCounterMax);
        }

        // Record Counter
        SetLocalInt(oSpawn, "GroupCounter", nCounter);
    }
    //

    //
    if (sTemplate == "kobolds")
    {
        int nKobold = Random(6) + 1;
        sRetTemplate = "NW_KOBOLD00" + IntToString(nKobold);
    }
    //


// -------------------------------------------
// Only Make Modifications Between These Lines
//
    return sRetTemplate;
}
