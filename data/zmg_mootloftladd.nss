void ClearAndJump(object oTarget)
{
    ClearAllActions();
    JumpToObject(oTarget);
}


void main()
{
 object oPC = GetLastUsedBy();
 object oDest = GetObjectByTag("mootlofttrapdoor");
 AssignCommand(oPC, ClearAndJump(oDest));
}
