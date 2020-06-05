void main()
{
    object oPC = GetLastUsedBy();
    object JumpWP = GetObjectByTag("_norheim_East_ropeWP");

    AssignCommand(oPC, ActionJumpToObject(JumpWP, FALSE));
}
