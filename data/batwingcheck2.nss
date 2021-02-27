//::///////////////////////////////////////////////
//:: FileName batwingcheck
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Script Wizard
//:: Created On: 0
//:://////////////////////////////////////////////
#include "nw_i0_tool"

int StartingConditional()
{
    int itemCnt = 0;
    object oItem = GetFirstItemInInventory(GetPCSpeaker());
    while (oItem != OBJECT_INVALID) {
        if(GetTag(oItem) == "BatWing") {
            itemCnt += GetItemStackSize(oItem);
        }
        oItem = GetNextItemInInventory(GetPCSpeaker());
    }

    // Make sure the PC speaker has at least 5 items in their inventory
    if(itemCnt >= 5) {
        return TRUE;
    }

    return FALSE;
}
