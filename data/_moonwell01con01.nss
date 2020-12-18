int StartingConditional()
{
    object PartyMember = GetPCSpeaker();
    int x = 0;
        while(PartyMember != OBJECT_INVALID)
        {
            x=x+1;
            PartyMember = GetNextFactionMember(PartyMember,TRUE);
        }

        if(x>2)
        {
         return FALSE;
        }

    return TRUE;
}
