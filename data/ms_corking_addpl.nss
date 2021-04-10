#include "nwnx_data"
#include "ms_corking_wagco"

void main()
{
    object oPC = GetPCSpeaker();
    object wagon = GetObjectByTag("mstradewagon1");
    NWNX_Data_Array_PushBack_Obj(wagon, WAGON_PLAYERS, oPC);
}
