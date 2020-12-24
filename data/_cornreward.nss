#include "nw_i0_plot"
#include "_btb_util"

void main() {
  object oPC = GetPCSpeaker();
  AddJournalQuestEntry("k010", 1, oPC, FALSE, FALSE, FALSE);
  //check inventory of oPC for oQuestItem and get iNumItems
  string sMark = "ITEM_TAG";
  int Corn = GetNumItems(oPC, "corn");
  int i;

  for (i = 0; i < (Corn); i++) {
    GiveGoldToCreature(oPC, 5);
    switch (getXPForLevel(GetXP(oPC))) {
        case 1:	GiveXPToCreature(oPC, 20);
        case 2: GiveXPToCreature(oPC, 10);
        case 3:	GiveGoldToCreature(oPC, 5);
        case 4:	GiveXPToCreature(oPC, 2);
        default:	GiveXPToCreature(oPC, 1);
    }
  }

  // Remove items from the player's inventory
  object oItemToTake = GetItemPossessedBy(oPC, "corn");
  while(GetIsObjectValid(oItemToTake)) {
    DestroyObject(oItemToTake);
    oItemToTake = GetItemPossessedBy(oPC, "corn");
  }
}
