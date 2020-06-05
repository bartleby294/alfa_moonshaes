#include "nw_i0_2q4luskan"

int StartingConditional()
{

    // Inspect local variables
    object VarStore1 = GetObjectByTag("Dwarven_Mines02_var_store1");
    object Gaurd = GetObjectByTag("ThaneGaurd2");
    float dist = GetDistanceBetween(Gaurd, GetPCSpeaker());

    if(GetLocalInt(VarStore1, "MerchMoveState") == 1 || GetLocalInt(VarStore1, "GaurdState") == 1 || dist > 5.0)
        return FALSE;

    return TRUE;
}
