/*** PC has Placeable Trigger (Key) Item
    - for Conversation Text Appears When
    By: Ulias (Shawn Marcil)     Last Modified: September 22, 2004

    Description
    ---------------
    Checks to see that the PC has a required trigger item
    (a placeable object key) to display the conversation line
    that this script is attached to.

    Requirements
    ---------------
    The placeable object (ie. bookshelf) that the current conversation
    belongs to must have _PK#### (ie. _PK0001) in its tag.

    The placeable object key (the item that the PC is required
    to have in their inventory in order for this script's associated
    conversation line to display) must have its tag exactly in the
    format pKey_R_PK#### (ie. pKey_R_PK0001 or pKey_PK0001) so that the
    4 digit number following the "_PK" flag matches the corresponding placeable object's
    "_PK" flag number. Omitting the "_R" flag means that the item is not
    reusable and it is destroyed once it is successfully used.

    Note: PK stands for Placeable (object) Key
**/
const int DEBUG = FALSE;

int StartingConditional()
{
    object oPC = GetPCSpeaker();
    object oItem;
    string sPlaceableTag = GetTag(OBJECT_SELF);
    string sDoorKeyTagSuffix, sPlaceableTagSuffix, sTag;
    int bKeyFound = FALSE;
    // find "_PK" flag
    int nPKPosition = FindSubString(sPlaceableTag, "_PK");
    int nRPosition;

    // get the value associated with the "_PK" flag
    sPlaceableTagSuffix = GetSubString(sPlaceableTag, (nPKPosition + 3), 4);

    if (DEBUG) {
        SendMessageToPC(oPC, "Placeable Key Check ---------");
        SendMessageToPC(oPC, "oPC: " + GetName(oPC));
        SendMessageToPC(oPC, "sPlaceableTag: " + sPlaceableTag);
        SendMessageToPC(oPC, "nPKPosition: " + IntToString(nPKPosition));
        SendMessageToPC(oPC, "sPlaceableTagSuffix: " + sPlaceableTagSuffix);
        SendMessageToPC(oPC, "Need for pkey: " + "pkey_(R)_PK" + sPlaceableTagSuffix);
        SendMessageToPC(oPC, GetName(oPC)+ "'s inventory ---------");
    }

    // check if the PC has an item with the same "_PK" flag in its tag as
    // the placeable object
    oItem = GetFirstItemInInventory(oPC);
    while (GetIsObjectValid(oItem)) {
        sTag = GetTag(oItem);
        if (DEBUG) SendMessageToPC(oPC, "sTag: " + sTag);
        if (    (sTag == ("pkey_PK" + sPlaceableTagSuffix)) ||
                (sTag == ("pkey_R_PK" + sPlaceableTagSuffix)) ) {
                bKeyFound = TRUE;
                break;
        }
        oItem = GetNextItemInInventory(oPC);
    }

    if (DEBUG) {
        SendMessageToPC(oPC, "bKeyFound: " + IntToString(bKeyFound) + " (0=FALSE, 1=TRUE)");
        SendMessageToPC(oPC, "Find _R: " + IntToString(FindSubString(sTag, "_R_")));
    }
    // if the PC has a valid item that is a placeable key
    if (bKeyFound == TRUE) {
        SetCustomToken(7770001, GetName(oItem));
        // check that the item is not Reusable (look for "_R_" flag)
        // and destroy it
        if (FindSubString(sTag, "_R_") == -1) DestroyObject(oItem);
        return TRUE;
    } else return FALSE;
}
