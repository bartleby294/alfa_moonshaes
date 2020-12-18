// Modified: 2006/1/29  ç i p h é r
// Added checks for item stack size changes and support for destroying items from
// pchest inventories (to minimize lag)
// Modified: 2006/1/19  ç i p h é r
// Added garbage collection to optimize database usage and avoid doing "db wipes".
// Packing is required to restore unused Bioware db space and must be done offline
// using nwn\utils\DataPack.exe on a windows system.

// Remember to keep the tag short! Variablenames can be a maximum of 32 characters!

void main()
{
    string sAreaResRef = GetResRef(GetArea(OBJECT_SELF));
    string sDatabase = sAreaResRef;//"tb_el_persistantchests";
    string sTag = GetTag(OBJECT_SELF);
    string sVarName;

    object obj = GetFirstItemInInventory();;
    object bag;

    while( obj != OBJECT_INVALID )
    {
        if( GetHasInventory( obj ) )
        {
            bag = obj;
            obj = GetFirstItemInInventory(bag);
            while( obj != OBJECT_INVALID )
            {
                SetLocalInt(obj, "bagged", TRUE);
                obj = GetNextItemInInventory(bag);
            }
        }
        obj = GetNextItemInInventory();
    }

    int i = 0; int iMax = GetCampaignInt(sDatabase, sTag + "_n");
    object oLocal, oItem = GetFirstItemInInventory();

    while (oItem != OBJECT_INVALID)
    {
        sVarName = sTag + "_" + IntToString(i);
        oLocal = GetLocalObject(OBJECT_SELF, sVarName);

        // ignore all items stored within a container as these are automatically
        // handled by the StoreCampaignObject function
        // make sure the item is new or its quantity has changed (stack size)
        // at 150ms per store, it's best to avoid storing unchanged data
        if ((!GetLocalInt(oItem, "bagged")) &&
            (oLocal != oItem || GetNumStackedItems(oLocal) != GetNumStackedItems(oItem)))
        {
            StoreCampaignObject(sDatabase, sVarName, oItem);
            SetLocalObject(OBJECT_SELF, sVarName, oItem);
        }
        if (!GetLocalInt(oItem, "bagged"))
        {
            i++;
        }
        else
        {
            DeleteLocalInt(oItem, "bagged");
        }
        // uncomment the following in order to destroy & recreate items in persistent containers
        // this may prove useful in cutting down lag in the event a great number of
        // items are spawned in persistent containers OnOpen, hording a substantial
        // amount of memory in the process; the tradeoff is system performance in having
        // to recreate the items every time the container is opened, but this may be few
        // and far between in relation to the amount of time these items sit idle.
        // DestroyObject(oItem);
        // DeleteLocalInt(OBJECT_SELF, "iFirstOpen");
        oItem = GetNextItemInInventory();
    }
    SetCampaignInt(sDatabase, sTag + "_n", i);

    // garbage collection - purge remaining unused data
    while (i < iMax)
    {
        sVarName = sTag + "_" + IntToString(i);

        // free unused memory
        DeleteLocalObject(OBJECT_SELF, sVarName);

        // mark extraneous items for deletion
        // this data will only clear by "packing" the database externally
        DeleteCampaignVariable(sDatabase, sVarName);

        i++;
    }
    if(GetLockKeyRequired(OBJECT_SELF)){
      SetLocked(OBJECT_SELF, TRUE);
    }
}

