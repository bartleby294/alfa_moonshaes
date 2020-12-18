int StartingConditional()
{
    object oPC = GetPCSpeaker();

    if(GetLocalInt(oPC, "mines02Innkeeper") == 1)
    return TRUE;

    else return FALSE;
}

