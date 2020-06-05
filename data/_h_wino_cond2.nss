int StartingConditional()
{
    object Wino = GetObjectByTag("Wino");

    if(GetLocalInt(Wino, "storystate") != 1 && GetLocalInt(Wino, "poststory") != 1)
    return TRUE;
    else
    return FALSE;
}
