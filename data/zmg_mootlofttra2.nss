void ClearAndJump(object oTarget)
{
    ClearAllActions();
    JumpToObject(oTarget);
}


void main()
{
 object oPC = GetLastUsedBy();
 object oDest = GetObjectByTag("mootloftladder");
 AssignCommand(oPC, ClearAndJump(oDest));
}
