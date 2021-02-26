#include "nw_i0_plot"
#include "_btb_util"

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

int DestroyWings(object curItem, int batwingsDestroyed, int batWingsTurnIn) {

    int batWingsLeftToDestory = batWingsTurnIn - batwingsDestroyed;
    int itemWingCnt = GetItemCharges(curItem);

    if(itemWingCnt < batWingsLeftToDestory) {
        DestroyObject(curItem);
        return batwingsDestroyed + itemWingCnt;
    } else {
        SetItemStackSize(curItem, itemWingCnt - batWingsLeftToDestory);
    }

    return 0;
}

void main() {

    int i;
    object oPC = GetPCSpeaker();
    int itemCnt = GetNumItems(oPC, sItemTag);
    int remainder = itemCnt % 5;
    int batWingsTurnIn = itemCnt - remainder;
    int healingSalves = batWingsTurnIn / 5;

    // Log the player and the payout.
    if(batWingsTurnIn > 0) {
        WriteTimestampedLogEntry("ITEM HAND IN: " + GetName(oPC)
            + " played by: " + GetPCPlayerName(oPC) + " turned in "
            + IntToString(batWingsTurnIn) + " " + sItemTag + "'s for "
            + IntToString(healingSalves) + " Healing Salves.");
    }

    for (i = 0; i < (batWingsTurnIn); i++) {
        GiveXPToCreature(oPC, getXpToGive(getXPForLevel(GetXP(oPC))));
    }

    // Remove all the objects
    int batwingsDestroyed = 0;
    object curItem = GetFirstItemInInventory(oPC);
    while(curItem != OBJECT_INVALID && batwingsDestroyed < batWingsTurnIn) {
        if(GetTag(curItem) == sItemTag){
            batwingsDestroyed =
                DestroyWings(curItem, batwingsDestroyed, batWingsTurnIn);
        }
        curItem = GetNextItemInInventory(oPC);
    }
}
