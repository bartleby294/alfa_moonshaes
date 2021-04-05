#include "ba_consts"
#include "nwnx_data"
#include "_btb_ban_util"

void DestoyInventory(object obj)
{
    if ( !GetHasInventory(obj) ) {
        return;
    }

    // Destroy the items in the main inventory.
    object oItem = GetFirstItemInInventory(obj);
    while ( oItem != OBJECT_INVALID ) {
        DestroyObject(oItem);
        oItem = GetNextItemInInventory(obj);
    }

    if(GetObjectType(obj) == OBJECT_TYPE_CREATURE) {
        // Destroy equipped items.
        int nSlot = 0;
        while (nSlot < NUM_INVENTORY_SLOTS) {
            DestroyObject(GetItemInSlot(nSlot, obj));
            ++nSlot;
        }
        AssignCommand(obj, TakeGoldFromCreature(GetGold(obj), obj, TRUE));
    }
}

void DestroyCamp(object oArea){
    int arraySize = NWNX_Data_Array_Size(NWNX_DATA_TYPE_OBJECT, OBJECT_SELF,
                                         BANDIT_UUID_ARRAY);
    int i = 0;
    while(i < arraySize) {

        if(i > 100) {
            writeToLog("WARNING: NEW LIMITER REACHED!!!");
            return;
        }
        object oBandit = NWNX_Data_Array_At_Obj(OBJECT_SELF, BANDIT_UUID_ARRAY,
                                                i);
        if(oBandit != OBJECT_INVALID) {
            writeToLog("| Destroying: " + GetTag(oBandit));
            DestoyInventory(oBandit);
            DestroyObject(oBandit, 0.1 * i);
        }
        i++;
    }
}
