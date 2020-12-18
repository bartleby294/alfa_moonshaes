#include "apts_inc_ptok"
#include "ats_inc_common"

//int BANK_PRIME_HASH = 20963;
int BANK_PRIME_HASH = 196613;
int BANK_VAULT_SIZE = 15;

void InitHash(object oStorableItem)
{
        int iHashNum = APTS_HashString(GetTag(oStorableItem), BANK_PRIME_HASH);
        PrintString(GetTag(oStorableItem)+" , "+IntToString(iHashNum));
        if(GetLocalString(GetModule(), "BANK_STORABLE_" + IntToString(iHashNum)) == "")
            SetLocalString(GetModule(), "BANK_STORABLE_" + IntToString(iHashNum), GetTag(oStorableItem));
        else
            PrintString("Hash collision: " + GetTag(oStorableItem));
}

void InitializeBankDemo()
{
//    PrintString("Initializing Bank");
//    object oItemBase = GetObjectByTag("BANK_ITEM_BASE");

//    object oStorableItem = GetFirstItemInInventory(oItemBase);
//    while(GetIsObjectValid(oStorableItem))
//    {
//        DelayCommand(0.0, InitHash(oStorableItem));
//        oStorableItem = GetNextItemInInventory(oItemBase);
//    }
}

void AddPersistentItem(object oPlayer, object oVault, object oItem)
{
    int i;
    string sDataString;
    int iQuantity;
    int iNumToStore;
    int iVaultCount = GetTokenInt(oPlayer, "vault_itemcount");
    int iItemHash;

    // Vault is full
    if(iVaultCount >= BANK_VAULT_SIZE)
    {
        AssignCommand(oPlayer, ActionDoCommand(SetCommandable(FALSE, oPlayer)));
        AssignCommand(oPlayer, ActionTakeItem(oItem, oVault));
        AssignCommand(oPlayer, ActionDoCommand(SetCommandable(TRUE, oPlayer)));
        FloatingTextStringOnCreature("You cannot place anymore items into your vault.", oPlayer);
        return;
    }
    if(ATS_IsItemNoDrop(oItem))
        return;

    AssignCommand(GetNearestObjectByTag("Banker"), SpeakString("", TALKVOLUME_SILENT_TALK));

    for(i = 1; i <= BANK_VAULT_SIZE; ++i)
    {
        // Slot is empty
        if(GetTokenInt(oPlayer, "vault_item_" + IntToString(i)) == 0)
        {
            iNumToStore = 0;
            PrintString(GetTag(oItem));
            iItemHash = APTS_HashString(GetTag(oItem), BANK_PRIME_HASH);
            if(GetLocalString(GetModule(), "BANK_STORABLE_" + IntToString(iItemHash)) == "")
            {
                AssignCommand(GetNearestObjectByTag("Banker"), SpeakString("This item seems to be unique. I cannot guarantee the safety of that item."));
                break;
            }
            sDataString = IntToString(iItemHash);
            iQuantity = GetNumStackedItems(oItem);
            if(iQuantity < 10)
                sDataString += "0";
            sDataString += IntToString(iQuantity);
            iNumToStore = StringToInt(sDataString);
            break;
        }
    }

    SetTokenInt(oPlayer, "vault_item_" + IntToString(i), iNumToStore);
    SetTokenInt(oPlayer, "vault_itemcount", iVaultCount + 1);
}

void RemovePersistentItem(object oPlayer, object oItem)
{
    int i;
    string sDataString;
    int iQuantity;
    int iNumToStore;
    int iVaultCount = GetTokenInt(oPlayer, "vault_itemcount");
    int iItemHash = APTS_HashString(GetTag(oItem), BANK_PRIME_HASH);

    sDataString = IntToString(iItemHash);
    iQuantity = GetNumStackedItems(oItem);
    if(iQuantity < 10)
        sDataString += "0";
    sDataString += IntToString(iQuantity);
    iNumToStore = StringToInt(sDataString);
    if(!GetIdentified(oItem))
        iNumToStore = -iNumToStore;

    for(i = 1; i <= BANK_VAULT_SIZE; ++i)
    {
        if(GetTokenInt(oPlayer, "vault_item_" + IntToString(i)) == iNumToStore)
        {
            DeleteTokenInt(oPlayer, "vault_item_" + IntToString(i));
            break;
        }
    }

    SetTokenInt(oPlayer, "vault_itemcount", iVaultCount - 1);
}


void MoveItemsToVault(object oMover, object oVault, int bDestroyMover = FALSE, int bTriggerVault = FALSE)
{
        object oItem = GetFirstItemInInventory(oMover);
        while(GetIsObjectValid(oItem))
        {
            AssignCommand(oMover, ActionGiveItem(oItem, oVault));
            oItem = GetNextItemInInventory(oMover);
        }
        if(bTriggerVault)
        {
            object oPC = GetLocalObject(oMover, "pc_obj");
            AssignCommand(oMover, ActionDoCommand(AssignCommand(oPC, DoPlaceableObjectAction(oVault, PLACEABLE_ACTION_USE))));
        }
        if(bDestroyMover)
            AssignCommand(oMover, ActionDoCommand(DestroyObject(oMover)));

}
void GrabItemsFromVault(object oMover, object oVault, object oPC, int bJumpToPC = FALSE)
{
        object oItem = GetFirstItemInInventory(oVault);
        while(GetIsObjectValid(oItem))
        {
            AssignCommand(oMover, ActionTakeItem(oItem, oVault));
            oItem = GetNextItemInInventory(oVault);
        }
        if(bJumpToPC)
            AssignCommand(oMover, ActionJumpToObject(oPC));

}
