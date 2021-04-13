#include "nw_i0_plot"
#include "_btb_dms_rsi_con"

void main(){

    // check if DM has toggled off custom scripts.
    int curState = GetLocalInt(GetArea(OBJECT_SELF), EAMON_STATE);
    if (curState == CONVERSATION_DM_DISABLED) {
        return;
    }

    int foundJunk = FALSE;
    int goldAmt = GetGold(OBJECT_SELF);
    object eamon = GetNearestObjectByTag("Eamon", OBJECT_SELF);
    object oInvObj = GetFirstItemInInventory(OBJECT_SELF);


    while (GetIsObjectValid(oInvObj) == TRUE) {
        if(GetBaseItemType(oInvObj) != BASE_ITEM_GOLD) {
            foundJunk = TRUE;
            ActionGiveItem(oInvObj, GetLastClosedBy());
        } else {
            DestroyObject(oInvObj);
        }
        oInvObj = GetNextItemInInventory(OBJECT_SELF);
    }

    if(foundJunk == TRUE && goldAmt > 0) {
        AssignCommand(eamon, SpeakString("Thank ye but just the coin if ye please."));
    } else if(foundJunk) {
        AssignCommand(eamon, SpeakString("Crowns ifn ye dont mind."));
    } else if(goldAmt) {
        AssignCommand(eamon, SpeakString("*smiles* Thank ye kindly."));
    }
}
