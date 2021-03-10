#include "nw_i0_plot"
#include "_btb_util"
#include "ms_xp_util"

string sItemTag = "BatWing";

int getXpToGive(int lvl) {
  switch (lvl) {
    case 1:
      return 20;
    case 2:
      return 10;
    case 3:
      return 2;
    default:
      return 0;
  }
  return 0;
}

void main() {

    int i;
    object oPC = GetPCSpeaker();
    int itemCnt = GetNumItems(oPC, sItemTag);

    // Log the player and the payout.
    if(itemCnt > 0) {
        WriteTimestampedLogEntry("ITEM HAND IN: " + GetName(oPC)
            + " played by: " + GetPCPlayerName(oPC) + " turned in "
            + IntToString(itemCnt) + " " + sItemTag + "'s");
    }

    for (i = 0; i < (itemCnt); i++) {
        GiveGoldToCreature(oPC, 5);
        GiveAndLogXP(oPC, getXpToGive(getXPForLevel(GetXP(oPC))),
                     "BAT WING HAND IN", "for handing in bat wings.");
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
