int StartingConditional()
{

    // Inspect local variables

object captain = GetObjectByTag("ShipsCaptain");

    if(GetLocalInt(captain, "HBEndFireOnce") == 1)
        return TRUE;

    return FALSE;
}
