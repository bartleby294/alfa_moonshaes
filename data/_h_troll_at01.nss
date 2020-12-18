void main()
{
    object oTarget = GetObjectByTag("_h_trollext01");
    object oPC =  GetLastUsedBy();

    AssignCommand(oPC, ActionJumpToObject(oTarget, TRUE));

}
