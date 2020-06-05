int StartingConditional()
{
    object oPC = GetLocalObject(GetPCSpeaker(), "OMWandTarget");
    return ( GetIsPC(oPC) && !GetIsDM(oPC) && !GetIsDMPossessed(oPC) );
}
