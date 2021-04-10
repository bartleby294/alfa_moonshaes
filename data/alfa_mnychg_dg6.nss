#include "nw_i0_plot"

string sItemTag = "alfa_tradebar";

void main()
{
    int i;
    object oPC = GetPCSpeaker();
    int itemCnt = GetNumItems(oPC, sItemTag);

    // Log the player and the payout.
    if(itemCnt > 0) {

    }

    // Remove all the objects
    object curItem = GetFirstItemInInventory(oPC);
    while(curItem != OBJECT_INVALID) {
        if(GetTag(curItem) == sItemTag){
            int curItemStackSize = GetItemStackSize(curItem);
            if(curItemStackSize > 1) {
                SetItemStackSize(curItem, curItemStackSize - 1);
            } else {
                DestroyObject(curItem);
            }
            WriteTimestampedLogEntry("TRADEBAR HAND IN: " + GetName(oPC)
            + " played by: " + GetPCPlayerName(oPC) + " turned in "
            + IntToString(1) + " " + sItemTag + "'s");
            GiveGoldToCreature(oPC, 475);
            break;
        }
        curItem = GetNextItemInInventory(oPC);
    }
}
