#include "ms_treas_declare"

void main()
{
    //returns the item that was either added or removed to the inventory of OBJECT_SELF.
    object oItem = GetInventoryDisturbItem();
    //returns the creature that modified the owner's inventory.
    object oPC = GetLastDisturbed();
    //returns type of the event: added, removed, stolen.
    int disturbedType = GetInventoryDisturbType();

    // make sure its a pc interacting
    if(GetIsPC(oPC) != TRUE || GetIsDM(oPC) == TRUE) {
        return;
    }

    string actionType = "Unknown";
    if(INVENTORY_DISTURB_TYPE_REMOVED) {
        actionType = "Removed";
    } else if(INVENTORY_DISTURB_TYPE_ADDED) {
        actionType = "Added";
    } else if(INVENTORY_DISTURB_TYPE_STOLEN) {
        actionType = "Stole";
    }

    // Log what was taken.
    WriteTimestampedLogEntry("RANDOM TREASURE CHEST: " + GetName(oPC)
                             + " Played By: " + GetPCPlayerName(oPC)
                             + " With CD Key: " + GetPCPublicCDKey(oPC)
                             + " " + actionType + " " + GetName(oItem)
                             + " with tag: " + GetTag(oItem) + " worth "
                             + IntToString(GetGoldPieceValue(oItem))
                             + " in area " + GetName(GetArea(oPC)));

    // Check if its the last item if so destroy the chest and leave a chest item
    object treasure = GetFirstItemInInventory(OBJECT_SELF);
    if(treasure == OBJECT_INVALID) {
        string chestItemResRef = GetLocalString(OBJECT_SELF,
                                                MS_TREASURE_CHEST_ITEM_RESREF);
        if(chestItemResRef != "") {
            CreateObject(OBJECT_TYPE_ITEM, chestItemResRef,
                         GetLocation(OBJECT_SELF), TRUE);
        }
        DestroyObject(OBJECT_SELF, 0.2);
    }
}
