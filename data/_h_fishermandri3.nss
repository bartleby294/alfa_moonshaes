void main()
{
    object oPC = OBJECT_SELF;
    object chair = GetObjectByTag("_hchair1");
    object oItem = GetObjectByTag("_ale_stein");
    object oItem2 = GetObjectByTag("_lantern01");

    ActionMoveToObject(chair, FALSE,1.0f);
    DelayCommand(65.7, ActionInteractObject(chair));
    DelayCommand(64.9, ActionEquipItem(oItem, INVENTORY_SLOT_RIGHTHAND));
    DelayCommand(62.0, ActionUnequipItem(oItem2));
}
