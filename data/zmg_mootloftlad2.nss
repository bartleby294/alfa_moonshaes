void ClearAndJump(object oTarget)
{
    ClearAllActions();
    JumpToObject(oTarget);
}


void main()
{
 object oPC = GetLastUsedBy();
 object oDest = GetObjectByTag("mootlofttrapdoor2");
 AssignCommand(oPC, ClearAndJump(oDest));
}
