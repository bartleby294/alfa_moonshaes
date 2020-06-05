int StartingConditional()
{

    // Inspect local variables
    if(!(GetLocalInt(GetObjectByTag("_h_Ham_butch"), "deercount") >= 15))
        return FALSE;

    return TRUE;
}
