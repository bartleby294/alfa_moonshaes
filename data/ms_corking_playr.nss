#include "nwnx_data"
#include "ms_corking_wagco"

void main()
{
    object oPC = GetPCSpeaker();
    object wagon = GetObjectByTag("mstradewagon1");
    int index = NWNX_Data_Array_Find_Obj(wagon, WAGON_PLAYERS, oPC);
    NWNX_Data_Array_Erase(NWNX_DATA_TYPE_OBJECT, wagon, WAGON_PLAYERS, index);
}

