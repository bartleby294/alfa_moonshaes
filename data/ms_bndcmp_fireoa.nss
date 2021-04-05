#include "alfa_wealth_inc"
#include "nwnx_time"
#include "nw_o0_itemmaker"
#include "alfa_ms_config"
#include "_btb_util"
#include "nwnx_area"
#include "nwnx_regex"
#include "nwnx_data"
#include "ba_consts"
#include "ms_bndcmp_fireut"

void main()
{
    object oPC = GetLastAttacker();
    if(GetIsDM(oPC)) {
        writeToLog("DM Bash Destroyed Bandit Camp");
        object oArea = GetArea(OBJECT_SELF);
        DestroyCamp(oArea);
    }
}
