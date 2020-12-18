void main()
{
    object PartyMember = GetFactionLeader(GetPCSpeaker());

    while(PartyMember != OBJECT_INVALID)
    {
      SetLocalInt(PartyMember, "rottmerchqgold", 2);
      PartyMember = GetNextFactionMember( PartyMember,TRUE);
    }
}
