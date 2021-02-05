void ClearAndJump(object oTarget)
{
    ClearAllActions();
    JumpToObject(oTarget);
}


void main()
{
 object oPC = GetLastUsedBy();
 object oDest = GetObjectByTag("loftladder");
 AssignCommand(oPC, ClearAndJump(oDest));
}
