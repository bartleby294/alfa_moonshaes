void main()
{
    object oPC = OBJECT_SELF;
    object chair = GetObjectByTag("_hchair3");
    object oItem = GetObjectByTag("_ale_stein");
    object oItem2 = GetObjectByTag("NW_WDBQS001");

    ActionMoveToObject(chair, FALSE,1.0f);
    DelayCommand(64.2, ActionUnequipItem(oItem2));
    DelayCommand(64.3, ActionEquipItem(oItem, INVENTORY_SLOT_RIGHTHAND));
    DelayCommand(67.4, ActionInteractObject(chair));
}
