#include "nw_i0_plot"
#include "_btb_util"

int getXpToGive(int lvl) {
  switch (lvl) {
    case 1:
      return 20;
    case 2:
      return 10;
    case 3:
      return 5;
    case 4:
      return 2;
    default:
      return 1;
  }
  return 1;
}

void main() {
  object oPC = GetPCSpeaker();
  AddJournalQuestEntry("k010", 1, oPC, FALSE, FALSE, FALSE);
  //check inventory of oPC for oQuestItem and get iNumItems
  string sMark = "ITEM_TAG";
  int Corn = GetNumItems(oPC, "CopperBanditRing");
  int i;

  WriteTimestampedLogEntry("Corn Count: " + IntToString(Corn));

  for (i = 0; i < (Corn); i++) {
    GiveGoldToCreature(oPC, 5);
    GiveXPToCreature(oPC, getXpToGive(getXPForLevel(GetXP(oPC))));
  }

  // Remove all the corn
  object curItem = GetFirstItemInInventory(oPC);
  while(curItem != OBJECT_INVALID) {
    if(GetTag(curItem) == "CopperBanditRing"){
       DestroyObject(curItem);
    }
    curItem = GetNextItemInInventory(oPC);
  }
}
