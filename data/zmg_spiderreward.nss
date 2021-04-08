#include "nw_i0_plot"
#include "_btb_util"
#include "ms_xp_util"

string sItemTag = "004_rn_spidergland";

int getXpToGive(int lvl) {
  switch (lvl) {
    case 1:
      return 20;
    case 2:
      return 10;
    case 3:
      return 8;
    case 4:
      return 3;
    default:
      return 1;
  }
  return 1;
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
        GiveGoldToCreature(oPC, 10);
        GiveAndLogXP(oPC, getXpToGive(getXPForLevel(GetXP(oPC))), "SPIDER SILK",
                     "for handing in spider silk.");
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
