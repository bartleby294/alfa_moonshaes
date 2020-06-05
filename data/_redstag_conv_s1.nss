void main()
{
    object oNPC = GetNearestObjectByTag("RedStagInnPatron", GetPCSpeaker(), 1);

    if(GetLocalInt(oNPC, "PosState") ==4)
    {
        AssignCommand(oNPC, ActionInteractObject(GetNearestObjectByTag("Chair_redstag")));
    }
}
