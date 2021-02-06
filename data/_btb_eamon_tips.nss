#include "nw_i0_plot"

void main(){
    int foundJunk = FALSE;
    int goldAmt = GetGold(OBJECT_SELF);
    object eamon = GetNearestObjectByTag("Eamon", OBJECT_SELF);
    object oInvObj = GetFirstItemInInventory(OBJECT_SELF);
    while (GetIsObjectValid(oInvObj) == TRUE) {
        foundJunk = TRUE;
        ActionGiveItem(oInvObj, GetLastClosedBy());
        oInvObj = GetNextItemInInventory(OBJECT_SELF);
    }

    if(foundJunk == TRUE && goldAmt > 0) {
        AssignCommand(eamon, SpeakString("Thank ye but just the coin if ye please."));
    } else if(foundJunk) {
        AssignCommand(eamon, SpeakString("Crowns ifn ye dont mind."));
    } else if(goldAmt) {
        AssignCommand(eamon, SpeakString("*smiles* Thank ye kindly."));
    }

    TakeGold(goldAmt, OBJECT_SELF);
}
