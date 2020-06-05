

void main()
{
     int nUser = GetUserDefinedEventNumber();
     if (nUser == 1002) // OnPerception event
     {
    object oCreature = GetLastPerceived();
    object oItem = GetFirstItemInInventory(oCreature);
    string sItem = GetTag(oItem);

 //object oWeapon = GetItemPossessedBy(OBJECT_SELF,"mob_weapon");

    string sBegin = GetStringLeft(sItem, 3);

    if(sBegin == "037")
    {
    ActionEquipItem(oItem, INVENTORY_SLOT_RIGHTHAND);
    }
    }
}

