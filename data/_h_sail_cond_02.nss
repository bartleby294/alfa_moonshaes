int StartingConditional()
{

    // Inspect local variables

object captain = GetObjectByTag("Sailor1");

    if(GetLocalInt(captain, "HBEndFireOnce") == 1)
        return TRUE;

    return FALSE;
}
