void main()
{
    int MAX_ITEM_VALUE = 300;

    object oItem = GetFirstItemInInventory();
    while (GetIsObjectValid(oItem))
    {
        if(GetGoldPieceValue(oItem) > MAX_ITEM_VALUE)
        {
            DestroyObject(oItem);
        }

        oItem = GetNextItemInInventory();
    }
}
