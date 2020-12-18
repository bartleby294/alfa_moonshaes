void main()
{
  object oClicker = GetClickingObject();
  object oStore = GetNearestObjectByTag("Store_081c1_kishmillo",OBJECT_SELF);
  object oTarget = GetTransitionTarget(OBJECT_SELF);
  location lLoc = GetLocation(oTarget);

    object oItem = GetFirstItemInInventory(oClicker);
    while(oItem != OBJECT_INVALID)
    {
        if(GetStringLeft(GetTag(oItem),4) == "twsi")
        {
            if(GetItemPossessedBy(oStore,GetTag(oItem)) == OBJECT_INVALID)
                CreateItemOnObject(GetResRef(oItem),oStore);
            DestroyObject(oItem);
        }
        oItem = GetNextItemInInventory(oClicker);
    }
    AssignCommand(oClicker,JumpToLocation(lLoc));
}
