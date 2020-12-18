void main()
{
    object item = GetFirstItemInInventory();
    while( GetIsObjectValid( item ) )
    {
        if((GetTag(item) != "ALFA_PC_Corpse") && (GetTag(item) != "alfa_004"))
            DestroyObject( item );
        item = GetNextItemInInventory();
    }
}
