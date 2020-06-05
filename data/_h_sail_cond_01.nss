int StartingConditional()
{

    // Inspect local variables

object captain = GetObjectByTag("Nord");

    if(GetLocalInt(captain, "HBEndFireOnce") == 1)
        return TRUE;

    return FALSE;
}
