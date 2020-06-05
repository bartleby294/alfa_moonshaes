void main()
{
    object PartyMember = GetFactionLeader(GetPCSpeaker());

    while(PartyMember != OBJECT_INVALID)
    {
      SetLocalInt(PartyMember, "rottmerchqgold", 1);
      PartyMember = GetNextFactionMember( PartyMember,TRUE);
    }
}
