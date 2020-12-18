int StartingConditional()
{

    // Inspect local variables
    object VarStore1 = GetObjectByTag("Dwarven_Mines02_var_store1");

    if(GetLocalInt(VarStore1, "MerchMoveState") == 1)
        return FALSE;

    return TRUE;
}
