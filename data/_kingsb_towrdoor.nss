void ClearAndJump(object oTarget)
{
    ClearAllActions();
    JumpToObject(oTarget);
}


void main()
{
 object oPC = GetLastUsedBy();
 object oDest = GetNearestObjectByTag("kingstowertrapdoor", OBJECT_SELF);
 AssignCommand(oPC, ClearAndJump(oDest));
}
