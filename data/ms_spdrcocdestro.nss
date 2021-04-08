void main()
{
    object obj = OBJECT_SELF;

    if ( !GetHasInventory(obj) ) {
        return;
    }

    // Destroy the items in the main inventory.
    object oItem = GetFirstItemInInventory(obj);
    while ( oItem != OBJECT_INVALID ) {
        DestroyObject(oItem);
        oItem = GetNextItemInInventory(obj);
    }
}
