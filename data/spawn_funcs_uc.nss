// spawn_funcs_uc
//
// Spawn Group/Camp Merchant System v1.1
// by U'lias Clearmon (Shawn Marcil)
// Last Revised: September 29, 2004

const int CAMP_GROUP_DEBUG = FALSE; // added for debugging for Spawn Group/Camp
                                    // Merchant System v1.1
                                    // by U'lias Clearmon (Shawn Marcil)

int UC_GetNumberOfItems(object oNESSMerchant)
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

/*  GetRandomItemObject

    Examines how many items are in the NESS merchant's inventory.
    Randomly selects an item from the inventory.
*/
object UC_GetRandomItem(string sMerchantTag)
{
    // Get the Merchant Object
    object oNESSMerchant = GetObjectByTag("M_" + sMerchantTag);
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
        nCount = UC_GetNumberOfItems(oNESSMerchant);

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

    return oItem;
}
