void ClearAndJump(object oTarget)
{
    ClearAllActions();
    JumpToObject(oTarget);
}


void main()
{
 object oPC = GetClickingObject();
 object oDest = GetObjectByTag("koartstoreladder");
 AssignCommand(oPC, ClearAndJump(oDest));
}
