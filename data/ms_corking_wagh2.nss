#include "nwnx_data"
#include "_btb_util"
#include "ms_xp_util"
#include "ms_corking_wagco"

int getXpToGive(int lvl) {
  switch (lvl) {
    case 1:
      return 200;
    case 2:
      return 150;
    case 3:
      return 100;
    case 4:
      return 50;
    default:
      return 30;
  }
  return 1;
}

void main()
{
    object oPC = GetPCSpeaker();
    object wagon = GetObjectByTag("mstradewagon1");
    int contains = NWNX_Data_Array_Contains_Obj(wagon, WAGON_PLAYERS, oPC);

    if(contains == FALSE) {
        return;
    }

    GiveGoldToCreature(oPC, 100);
    GiveAndLogXP(oPC, getXpToGive(getXPForLevel(GetXP(oPC))),
                 "CORWELL WAGON ESCORT", "for escorting corn wagon to kingsbay.");

    int index = NWNX_Data_Array_Find_Obj(wagon, WAGON_PLAYERS, oPC);
    NWNX_Data_Array_Erase(NWNX_DATA_TYPE_OBJECT, wagon, WAGON_PLAYERS, index);
}

