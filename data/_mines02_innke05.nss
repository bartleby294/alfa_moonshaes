int StartingConditional()
{

object InnKeep = GetObjectByTag("_mines_02_innkeeper");
    // if room is ocupied it = 1 if not 0
    if(GetLocalInt(InnKeep, "one") == 0 && GetLocalInt(InnKeep, "two") == 0
    && GetLocalInt(InnKeep, "three") == 0 && GetLocalInt(InnKeep, "four") == 0)
    return TRUE;

    else return FALSE;

}
