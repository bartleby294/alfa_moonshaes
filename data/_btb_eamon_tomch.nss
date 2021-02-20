int StartingConditional()
{
    if(GetLocalInt(GetPCSpeaker(), "olTom") == 2) {
        return TRUE;
    }
    return FALSE;
}
