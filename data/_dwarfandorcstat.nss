//::///////////////////////////////////////////////
//:: FileName _dwarfandorcstat
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Script Wizard
//:: Created On: 11/10/2005 11:42:52 AM
//:://////////////////////////////////////////////
int StartingConditional()
{

    // Inspect local variables
    object VarStore1 = GetObjectByTag("Dwarven_Mines02_var_store1");

    if(GetLocalInt(VarStore1, "SongState") == 1)
        return FALSE;

    return TRUE;
}
