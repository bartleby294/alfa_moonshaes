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
  int Corn = GetNumItems(oPC, "corn");
  int i;

  WriteTimestampedLogEntry("Corn Count: " + IntToString(Corn));

  for (i = 0; i < (Corn); i++) {
    GiveGoldToCreature(oPC, 5);
    WriteTimestampedLogEntry("PC LVL: " + IntToString(getXPForLevel(GetXP(oPC))));
    WriteTimestampedLogEntry("XP: " + IntToString(getXpToGive(getXPForLevel(GetXP(oPC)))));
    GiveXPToCreature(oPC, getXpToGive(getXPForLevel(GetXP(oPC))));
  }

  // Remove items from the player's inventory
  object oItemToTake = GetItemPossessedBy(oPC, "corn");
  while(GetIsObjectValid(oItemToTake)) {
    DestroyObject(oItemToTake);
    oItemToTake = GetItemPossessedBy(oPC, "corn");
  }
}
