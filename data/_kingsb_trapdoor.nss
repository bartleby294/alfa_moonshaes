void ClearAndJump(object oTarget)
{
    ClearAllActions();
    JumpToObject(oTarget);
}


void main()
{
 object oPC = GetLastUsedBy();
 object oDest = GetNearestObjectByTag("kingstowerdoor", OBJECT_SELF);
 AssignCommand(oPC, ClearAndJump(oDest));
}
