// Include for death, to speed it up.

// Returns True if the specific int is there.
int GetSpawnInCondition(int nCondition);
// This will destroy the body, if still dead.
void DeathCheck();
// This will delete all things, local things, and un-droppable items, before they fade out.
void DeleteAllThings();
// Used in DeleteAllThings.
void ClearSlot(int iSlotID);
// This is for the spawn in conditions.
int NW_FLAG_DEATH_EVENT                     = 0x00020000;

int GetSpawnInCondition(int nCondition)
{
    int nPlot = GetLocalInt(OBJECT_SELF, "NW_GENERIC_MASTER");
    if(nPlot & nCondition)
    {
        return TRUE;
    }
    return FALSE;
}

void DeathCheck()
{
    if(GetIsObjectValid(GetArea(OBJECT_SELF)))// Trying to not crash limbo.
    {
        if(GetIsDead(OBJECT_SELF) && GetLocalInt(OBJECT_SELF, "IS_DEAD") > 0)
        {
            DeleteLocalInt(OBJECT_SELF, "IS_DEAD");
            DeleteAllThings();
            SetIsDestroyable(TRUE, FALSE, FALSE);
            DestroyObject(OBJECT_SELF);
        }
        DeleteLocalInt(OBJECT_SELF, "IS_DEAD");
    }
    else
    {
        DelayCommand(60.0, DeathCheck());
    }
}

void ClearSlot(int iSlotID)
{
    object oItem = GetItemInSlot(iSlotID);
    if (GetIsObjectValid(oItem) && !GetDroppableFlag(oItem))
        DestroyObject(oItem);
}

void DeleteAllThings()
{
    // Destroy all equipped slots - 0 to 17
    int iSlotID;
    for (iSlotID = 0; iSlotID < 18; iSlotID++)
    {
        ClearSlot(iSlotID);
    }
    // Destroy all inventory items
    object oItem = GetFirstItemInInventory();
    while(GetIsObjectValid(oItem))
    {
        if (!GetDroppableFlag(oItem))
            DestroyObject(oItem);
        oItem = GetNextItemInInventory();
    }
    // Delete all locals that should exsist, or may exsist, from my AI things.
    DeleteLocalObject(OBJECT_SELF, "TO_ATTACK");
    DeleteLocalObject(OBJECT_SELF, "TO_FLEE");
    DeleteLocalInt(OBJECT_SELF, "NW_GENERIC_DRAGONS_BREATH");
    DeleteLocalInt(OBJECT_SELF, "AI_WING_BUFFET");
    DeleteLocalInt(OBJECT_SELF, "NW_GENERIC_MASTER");
    DeleteLocalInt(OBJECT_SELF, "AI_MORALE");
    DeleteLocalInt(OBJECT_SELF, "AI_INTELLIGENCE");
    DeleteLocalInt(OBJECT_SELF, "AI_HEALING_ALLIES_PERCENT");
    DeleteLocalInt(OBJECT_SELF, "AI_CORPSE_DESTROY_TIME");
    DeleteLocalInt(OBJECT_SELF, "AI_ANIMATIONS");
    DeleteLocalInt(OBJECT_SELF, "ROUNDS_UNTIL_SPELL_TRIGGER_RELEASE");
    DeleteLocalInt(OBJECT_SELF, "AI_SPELL_TRIGGERS");
    DeleteLocalFloat(OBJECT_SELF, "RANGE_TO_MOVE_TO");
    // Time stop has up to 25
    int iCnt = 1;
    int iLast = GetLocalInt(OBJECT_SELF, "TIME_STOP_LAST_" + IntToString(iCnt));
    while(iCnt < 25 && iLast != 0)
    {
        DeleteLocalInt(OBJECT_SELF, "TIME_STOP_LAST_" + IntToString(iCnt));
        iCnt++;
        iLast = GetLocalInt(OBJECT_SELF, "TIME_STOP_LAST_" + IntToString(iCnt));
    }
}
