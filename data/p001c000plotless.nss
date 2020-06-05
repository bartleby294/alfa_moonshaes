int StartingConditional()
{
	return GetLocalInt(OBJECT_SELF, "p001began") && !GetLocalInt(GetPCSpeaker(), "p001state");
}
