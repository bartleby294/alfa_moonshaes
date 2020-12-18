void main()
{
    object oPC = OBJECT_SELF;
    object chair = GetObjectByTag("_hchair2");
    object oItem = GetObjectByTag("_ale_stein");

    ActionMoveToObject(chair, FALSE,1.0f);
    DelayCommand(66.1, ActionInteractObject(chair));
    DelayCommand(63.6, ActionEquipItem(oItem, INVENTORY_SLOT_RIGHTHAND));
}
