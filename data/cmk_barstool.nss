void main()
{
    object oPC = GetLastUsedBy();
    object oBar = GetNearestObjectByTag("Bartender",oPC);
    object oChair = OBJECT_SELF;

    if(!GetIsObjectValid(GetSittingCreature(oChair)))
    {
        AssignCommand(oPC,ActionSit(oChair));
    }

}
