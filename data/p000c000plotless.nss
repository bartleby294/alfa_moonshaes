int StartingConditional()
{
	return GetLocalInt(OBJECT_SELF, "p000began") && !GetLocalInt(GetPCSpeaker(), "p000state");
}
