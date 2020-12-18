int StartingConditional()
{
    object Wino = GetObjectByTag("Wino");

    if(GetLocalInt(Wino, "poststory") == 1)
    return TRUE;
    else
    return FALSE;
}
