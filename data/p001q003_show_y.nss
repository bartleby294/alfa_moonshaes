int StartingConditional()
{
	int nShow = OBJECT_INVALID != GetItemPossessedBy(GetPCSpeaker(), "SignedHammerstaadPact");
	return nShow;
}
