void main()
{


  object oClicker = GetClickingObject();
  object oStore = GetNearestObjectByTag("Tavern",OBJECT_SELF);
  object oTarget = GetTransitionTarget(OBJECT_SELF);
  location lLoc = GetLocation(oTarget);

    object oItem = GetFirstItemInInventory(oClicker);
    while(oItem != OBJECT_INVALID)
    {
        if(GetStringLeft(GetTag(oItem),6) == "InnKey")
        {
            if(GetItemPossessedBy(oStore,GetTag(oItem)) == OBJECT_INVALID)
                CreateItemOnObject(GetResRef(oItem),oStore);
            DestroyObject(oItem);
        }
        oItem = GetNextItemInInventory(oClicker);
    }

  AssignCommand(oClicker,JumpToLocation(lLoc));
}

