#include "nw_i0_plot"

string sItemTag = "alfa_tradebar";

void main()
{
    int i;
    object oPC = GetPCSpeaker();
    int itemCnt = GetNumItems(oPC, sItemTag);

    // Log the player and the payout.
    if(itemCnt > 0) {
        WriteTimestampedLogEntry("TRADEBAR HAND IN: " + GetName(oPC)
            + " played by: " + GetPCPlayerName(oPC) + " turned in "
            + IntToString(itemCnt) + " " + sItemTag + "'s");
    }

    for (i = 0; i < (itemCnt); i++) {
        GiveGoldToCreature(oPC, 475);
    }

    // Remove all the objects
    object curItem = GetFirstItemInInventory(oPC);
    while(curItem != OBJECT_INVALID) {
        if(GetTag(curItem) == sItemTag){
            DestroyObject(curItem);
        }
        curItem = GetNextItemInInventory(oPC);
    }
}

